From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 23 Apr 2017 16:35:52 +0300
Subject: [PATCH v2 0/4] arbitrary sg lists support
In-Reply-To: <a3264968-2d9e-bda5-1f23-74da248cf4d5@grimberg.me>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492101079.5176.9.camel@sandisk.com>
 <c52b5ce7-5346-419d-26f2-0d4d45d20471@grimberg.me>
 <20170423103439.GC14088@mtr-leonro.local>
 <d697d360-99ca-c3ed-08e2-b89cc50a15b0@grimberg.me>
 <20170423121254.GD14088@mtr-leonro.local>
 <a3264968-2d9e-bda5-1f23-74da248cf4d5@grimberg.me>
Message-ID: <9a9668fa-87a7-e730-27e2-8a2b3e7fbc36@mellanox.com>



On 4/23/2017 3:28 PM, Sagi Grimberg wrote:
>
>> i asked and didn't get answer too.
>> https://www.spinics.net/lists/linux-rdma/msg46407.html
>
> OK, I suppose that the question was to Laurence, but I'll try
> to answer.
>
> We can't really say, this reproduced for 4M transfers, which iSER
> does not support without a applying higher max_sectors modparam.
> But even with that, its a different code path as SRP unlike iSER
> can use multiple MRs for a single transaction.
>
> So short answer, can't say...

I actually answered here:
https://www.spinics.net/lists/linux-rdma/msg46412.html

Sagi,
As you mentioned the IO path is different in SRP and iSER so IMO we 
should start with SRP debugging. NVMf is similar to iSER (and not SRP) 
and that's why I think we can apply this patchset.
If you want to wait till we debug SRP issue it's fine, but I can't repro 
it in my lab so it can take longer.

Lourance,
maybe you can update your FW to the latest CX4 from our site and try to 
repro this issue ?

thanks,
Max.
