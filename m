From: zhangweiping@didichuxing.com (weiping zhang)
Date: Fri, 14 Jul 2017 17:57:10 +0800
Subject: [PATCH] nvme: add wrapper for nvme ctrl register r/w
In-Reply-To: <20170712120152.GD4115@linux-x5ow.site>
References: <20170629172624.GA17319@localhost.didichuxing.com>
 <20170712072018.GA5739@lst.de>
 <ad43c2ae-c3af-351d-7a58-0f2f35e79d30@grimberg.me>
 <20170712115547.GA11085@lst.de>
 <20170712120152.GD4115@linux-x5ow.site>
Message-ID: <20170714095654.GA23834@bogon.didichuxing.com>

On Wed, Jul 12, 2017@02:01:52PM +0200, Johannes Thumshirn wrote:
> On Wed, Jul 12, 2017@01:55:47PM +0200, Christoph Hellwig wrote:
> > Mostly because it's a little shorter and we're only going to get
> > more and more of these calls.  In the end I don't feel strongly
> > and we can just skip the patch for now and reconsider it once
> > we have more register read/write calls.
> 
> I'm in favour of the patch as well. It hides the transport specific
> implementation details quite good.
> 
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> -- 
> Johannes Thumshirn                                          Storage
> jthumshirn at suse.de                                +49 911 74053 689

Hi Sagi,

Johannes has reviewed this patch, do you want include this patch ?

--
Weiping
