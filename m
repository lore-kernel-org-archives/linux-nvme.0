From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 04 Oct 2017 21:08:57 -0400
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <20171004071312.GA21143@lst.de> (Christoph Hellwig's message of
 "Wed, 4 Oct 2017 09:13:12 +0200")
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-4-git-send-email-hare@suse.de>
 <20171002164218.GA11886@lst.de>
 <ece83015-0def-8e36-5645-7be00be95c40@suse.de>
 <20171003115506.GC24650@lst.de>
 <bd388bdf-25ac-8b25-f832-ba1316a64dc4@suse.de>
 <20171004061533.GA20131@lst.de>
 <19dbdf11-86c4-b6ea-a18c-a78fcae822d5@suse.de>
 <20171004071312.GA21143@lst.de>
Message-ID: <yq1poa2wgd2.fsf@oracle.com>


Christoph,

> The only other option I could think of would be to turn names around:
> make /dev/nvmeX (chardev) and /dev/nvmeXnY the per-subsystem devices
> that are multipathed if available.  We'd then need new devices for the
> invdividual controllers.

I like that approach.

-- 
Martin K. Petersen	Oracle Linux Engineering
