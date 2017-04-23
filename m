From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 23 Apr 2017 14:49:43 +0300
Subject: [PATCH v2 0/4] arbitrary sg lists support
In-Reply-To: <20170423103439.GC14088@mtr-leonro.local>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492101079.5176.9.camel@sandisk.com>
 <c52b5ce7-5346-419d-26f2-0d4d45d20471@grimberg.me>
 <20170423103439.GC14088@mtr-leonro.local>
Message-ID: <d697d360-99ca-c3ed-08e2-b89cc50a15b0@grimberg.me>


>> I'm concerned about the fact that the SRP issue wasn't resolved. There
>> might be a bug hiding there.
>>
>> Max, Leon, my recollection was that the error syndrome you saw with SRP
>> described "too much sgls for a single mr". If this is true, then I still
>> think we need a different device capability for it.
>
> I don't remember that Max succeeded to reproduce it.

You said Artemy was on this issue:
https://www.spinics.net/lists/linux-rdma/msg46390.html

and I asked you a question that will help clear things up but
never received an answer:
https://www.spinics.net/lists/linux-rdma/msg46394.html
