From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 17:00:12 +0000
Subject: [PATCH for-4.5 07/13] NVMe: Requeue requests on suspended queues
In-Reply-To: <BJXPR01MB19918E58636267AE304ACC1E0A80@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-8-git-send-email-keith.busch@intel.com>
 <BJXPR01MB19918E58636267AE304ACC1E0A80@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <20160211170012.GE11908@localhost.localdomain>

On Thu, Feb 11, 2016@04:47:31PM +0000, Wenbo Wang wrote:
> If adding synchronize_rcu and blk_sync_queue, I guess this is not needed.

That was to sync IO tasks to make sure they saw the h/w cxt STOPPED
flag. We still need to restart those queues at some point to flush queued
requests to completion, and this patch is just prepping for that.

I used "blk_queue_dying" in a previous patch series. I went going back
and forth on using that criteria. SCSI has device states, so trying to
apply those ideas to namespaces.
