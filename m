From: hch@lst.de (Christoph Hellwig)
Date: Fri, 8 Feb 2019 09:42:16 +0100
Subject: [PATCH 1/1] nvme: add get-feature to admin cmds tracer
In-Reply-To: <f973dcd6-3455-449d-bf5b-117647d04b12@mellanox.com>
References: <1548947610-9330-1-git-send-email-maxg@mellanox.com>
 <20190131161108.GA20811@localhost.localdomain>
 <63c08f3a-a109-9441-df53-6a65b1db9ab9@mellanox.com>
 <bcbfb9ea-88ff-d8c7-22ba-8f1df7104930@suse.de>
 <f973dcd6-3455-449d-bf5b-117647d04b12@mellanox.com>
Message-ID: <20190208084216.GA23155@lst.de>

On Thu, Feb 07, 2019@12:28:07PM +0200, Max Gurtovoy wrote:
>> I'm open for both sides, but we're already decoding a bunch of commands
>> in the kernel and so does the SCSI tracing, so I don't see a compelling
>> reason to stop it now.
>
> Yup, I also think we shouldn't throw all cmd decoding from kernel and we 
> can add more decoding incrementally as I did in this commit.
>
> Sagi/Christoph,
>
> what is your standing in this topic ? should I send V2 ?

I don't really care.  We clearly have command decoding in the trace
points, so adding a little more won't hurt, but I'm also not sure
we really need it.
