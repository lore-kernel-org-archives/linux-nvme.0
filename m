From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Tue, 9 Feb 2016 11:22:04 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <20160208150132.GA25111@localhost.localdomain>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203144123.GB23910@localhost.localdomain>
 <BJXPR01MB1992FFD0706FCD368F5AD16E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203163808.GC23910@localhost.localdomain>
 <BJXPR01MB19916231021454BD8731EBDE0D30@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160208150132.GA25111@localhost.localdomain>
Message-ID: <BJXPR01MB199E172F7B186281D1C7179E0D60@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

In most cases, rcu read lock is just a preempt_disable, which is what get_cpu does. I don't see any risk.

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Monday, February 8, 2016 11:02 PM
To: Wenbo Wang
Cc: Jens Axboe; Wenbo Wang; linux-kernel at vger.kernel.org; linux-nvme at lists.infradead.org; Wenwei.Tao
Subject: Re: [PATCH] NVMe: do not touch sq door bell if nvmeq has been suspended

On Sat, Feb 06, 2016@02:32:24PM +0000, Wenbo Wang wrote:
> Keith,
> 
> Is the following solution OK?
> synchronize_rcu guarantee that no queue_rq is running concurrently with device disable code. Together with your another patch (adding blk_sync_queue), both sync/async path shall be handled correctly.
> 
> Do you think synchronize_rcu shall be added to blk_sync_queue?

I was nearly going to suggest the same last week, but it feels wrong since no one takes rcu_read_lock in the path we're trying to sychronoize. Is this safe if the task is interrupted?
