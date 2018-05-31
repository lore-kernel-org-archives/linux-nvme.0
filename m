From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 12:26:56 +0300
Subject: [PATCH 3/5] nvme: call nvmf_create_ctrl before checking for
 duplicate assignment
In-Reply-To: <20180515075221.4ppaxdvbosy36ltk@linux-x5ow.site>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-4-jthumshirn@suse.de> <20180515075055.GB23659@lst.de>
 <20180515075221.4ppaxdvbosy36ltk@linux-x5ow.site>
Message-ID: <1b2cdac6-4dbd-261b-0ae9-b9768f972f0d@grimberg.me>


>> In general it seems like fc loop needs to offload any I/O to a workqueue
>> just like nvme-loop does, but even then I can't see how that is going to
>> cause an issue in this area.
> 
> Hmm I'll be looking into it.

FWIW, I agree it should do that as well.
