From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 02:10:35 +0300
Subject: [PATCH] nvme: avoid hang on inaccessible paths
In-Reply-To: <20180530125452.GA2763@lst.de>
References: <20180530111637.22223-1-hare@suse.de>
 <20180530121241.GA1850@lst.de> <20180530143020.50a299b8@pentland.suse.de>
 <20180530125452.GA2763@lst.de>
Message-ID: <35d5d780-b1c2-d176-639b-b41106e3e980@grimberg.me>


> And I guess this where the real issue starts.  We should not do block
> I/O under nvmf_dev_mutex.
> 
> James has some work on asynchronous connects pending for FC, so I guess
> we could look into generalizing that and always exectute the real connect
> work in a different thread.

I still need to ramp up on the ANA patches, but I'd prefer moving
create_ctrl outside of nvmf_dev_mutex instead of having it async.
