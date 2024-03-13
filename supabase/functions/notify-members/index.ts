// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.
import {createClient} from 'npm:@supabase/supabase-js@2.39.6';
import {JWT} from 'npm:google-auth-library@9.6.3';



interface Announcement {
  id:number
  title:string
  content:string
}

interface WebhookPayload {
  type : 'INSERT'
  table:string
  record:Announcement
  schema:"public",
  old_record:null | Announcement
}

const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
)
Deno.serve(async (req) => {
    
    const payload:WebhookPayload = await req.json();

    const {default:serviceAccount} = await import('../service-account.json' , {with:{type:'json'}})
    const accessToken = await getAccessToken(serviceAccount.client_email , serviceAccount.private_key)
   
    
    const res = await fetch(`https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`, 
    {
      method:'POST' , 
      headers:
      {
        'Content-Type':'application/json',
        'Authorization':`Bearer ${accessToken}`
      },
      body: JSON.stringify({
        message:{
          topic : "all",
          notification : {
            title:payload.record.title,
            body:payload.record.content
          },
          data:{
            id : payload.record.id.toString()
          }

        }
      }
      )
}
  )
  const resData = await res.json()

  if(res.status < 200 || 299 < res.status){
    throw resData
  }
  return new Response(
    JSON.stringify(payload.record),
    { headers: { "Content-Type": "application/json" } },
  )
})

const getAccessToken = (clientEmail:string , privateKey:string) : Promise<string> => {
  return new Promise((resolve, reject)=>{
    const jwtClient = new JWT({
      email:clientEmail,
      key:privateKey,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging']
    })
    jwtClient.authorize((err , token)=>{
      if(err) {
        reject(err)
        return
      }
      console.log(token);
      
      resolve(token!.access_token!)
    })
  })
}


