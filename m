From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 6 Jun 2018 12:32:21 +0300
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180605044222.GA29384@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com>
 <20180605044222.GA29384@lst.de>
Message-ID: <4203e888-df87-efd6-f61a-24b43fb710e2@grimberg.me>


>> We plan to implement all the fancy NVMe standards like ANA, but it
>> seems that there is still a requirement to let the host side choose
>> policies about how to use paths (round-robin vs least queue depth for
>> example).  Even in the modern SCSI world with VPD pages and ALUA,
>> there are still knobs that are needed.  Maybe NVMe will be different
>> and we can find defaults that work in all cases but I have to admit
>> I'm skeptical...
> 
> The sensible thing to do in nvme is to use different paths for
> different queues.

Huh? different paths == different controllers so this sentence can't
be right... you mean that a path selector will select a controller
based on the home node of the local rdma device connecting to it and
the running cpu right?
