From: jsmart2021@gmail.com (James Smart)
Date: Wed, 27 Sep 2017 08:40:54 -0700
Subject: [PATCH] nvmet_fc: Reduce work_q count
In-Reply-To: <20170927083813.qbm5un7m7z2uamxt@linux-x5ow.site>
References: <20170927040958.5981-1-jsmart2021@gmail.com>
 <20170927083813.qbm5un7m7z2uamxt@linux-x5ow.site>
Message-ID: <4e34dfe9-ead4-aa61-bd71-0561fba6d14a@gmail.com>

On 9/27/2017 1:38 AM, Johannes Thumshirn wrote:
> On Tue, Sep 26, 2017@09:09:58PM -0700, James Smart wrote:
>> Instead of a work_q per controller queue, use a global workqueue.
> 
> Could you be a bit more specific on why you want to use one global
> nvme-fc workqueue?
> 
> Thanks,
> 	Johannes
> 

Based on the recommendation from Christoph:
http://lists.infradead.org/pipermail/linux-nvme/2017-May/010388.html

This patch has gone through several itterations with the last 
recommendation being the single work_q.

-- james
