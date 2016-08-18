From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Aug 2016 10:01:57 +0300
Subject: nvme/rdma initiator stuck on reboot
In-Reply-To: <075901d1f899$e5cc6f00$b1654d00$@opengridcomputing.com>
References: <043901d1f7f5$fb5f73c0$f21e5b40$@opengridcomputing.com>
 <2202d08c-2b4c-3bd9-6340-d630b8e2f8b5@grimberg.me>
 <073301d1f894$5ddb81d0$19928570$@opengridcomputing.com>
 <7c4827ff-21c9-21e9-5577-1bd374305a0b@grimberg.me>
 <075901d1f899$e5cc6f00$b1654d00$@opengridcomputing.com>
Message-ID: <e2e04664-c374-3745-ecf3-f49ca7a3addf@grimberg.me>


>> Can this be related due to the fact that we use a signle-threaded
>> workqueue for delete/reset/reconnect? (delete cancel_sync the active
>> reconnect work...)
>>
>> Does this untested patch help?
>
> That seems to do it!

Is this a formal tested-by?
