From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Feb 2016 05:29:16 +0000
Subject: [PATCH 1/2] NVMe: Make surprise removal work again
In-Reply-To: <BJXPR01MB199DD66107F6C2D86BB3F83E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
 <BJXPR01MB199DDC40C3949335FD70DEBE0DE0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <B58D82457FDA0744A320A2FC5AC253B93D3D7E57@fmsmsx104.amr.corp.intel.com>
 <20160202011752.GB4679@localhost.localdomain>
 <BJXPR01MB199DD66107F6C2D86BB3F83E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <20160202052915.GA6696@localhost.localdomain>

On Tue, Feb 02, 2016@02:41:53AM +0000, Wenbo Wang wrote:
> Is it confirmed that blk_cleanup_queue has returned? It is likely the driver stuck in del_gendisk.

Yes, the entire driver's remove completes, which includes
blk_cleanup_queue and del_gendisk.

I don't know what the task is waiting for, but recall this worked
before. Might bisect.
