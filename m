From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 6 Jun 2017 09:20:15 +0200
Subject: [PATCH v3 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170606071928.GA15539@lst.de>
References: <20170602094536.25775-1-jthumshirn@suse.de>
 <20170602094536.25775-4-jthumshirn@suse.de> <20170605053119.GA19480@lst.de>
 <8b65ecd4-280a-e1a0-266d-c263f5eaba00@suse.de>
 <20170606071928.GA15539@lst.de>
Message-ID: <e0ceb513-e62f-db12-9dea-8b98802fadcb@suse.de>

On 06/06/2017 09:19 AM, Christoph Hellwig wrote:
> Can you rebase on top of the new uuid_t type and the plain uuid_*
> prefixed helpers here:
> 
> http://git.infradead.org/users/hch/uuid.git/shortlog/refs/heads/for-next
> 
> I'll declare that branch stable soon and don't want to introduce
> more users of the old types.  Thanks!

Sure


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
