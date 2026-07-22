Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A31C4451C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LvYpLTIo6wS7r7AdNLS+0GRxWdHoF1y3DxHVo5kCrhk=; b=mu/YbEreqZf/4nougeH/Sb+KRa
	huim1QOAmRmpUBWbSmbEDsaRmkzwztrjw0DBC2zx6HdB0yZXCf3Ii7Zk/BcIdTz+4ZzGJNMqC7Ewp
	7VMmqCsMBtcGEoAWKarXpwjz7fkCVKI8SDcv6kXATOlnwNi0RfMLHNVMVHtBPPm7ghQr6INcq0PDY
	p/70LX9Ho4UQizUVQnddHmmqm3cUdu3xEdVuec+WyMXMvRtaImv9azq8XC1VbZoBmEH7CuioO2BtR
	mx208LtXHQqMX6VZ/PXJpim+cJkTXPOrsS9ARWxWoN7XQxJq67Kb9XVFKsyosHdZgSw7lo+c0mumN
	ywQLwL1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmSsf-0000000BKRN-2fpx;
	Wed, 22 Jul 2026 09:04:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmSsX-0000000BKPR-1lyy
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 09:04:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7355568D37; Wed, 22 Jul 2026 11:04:29 +0200 (CEST)
Date: Wed, 22 Jul 2026 11:04:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: changfengnan <changfengnan@bytedance.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	axboe <axboe@kernel.dk>, sagi <sagi@grimberg.me>,
	"andriy.shevchenko" <andriy.shevchenko@intel.com>,
	"gang.cao" <gang.cao@intel.com>, "jun.i.jin" <jun.i.jin@intel.com>,
	"jun1.zeng" <jun1.zeng@intel.com>,
	"liang.a.fang" <liang.a.fang@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>, tglx <tglx@kernel.org>,
	"yong.hu" <yong.hu@intel.com>, guzebing@bytedance.com
Subject: Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
Message-ID: <20260722090428.GA30753@lst.de>
References: <20260715075703.15578-1-jun1.zeng@intel.com> <20260715075703.15578-2-jun1.zeng@intel.com> <allEmTmXCFosxIOr@kbusch-mbp> <20260720150539.GB17986@lst.de> <20260721083739.69676-1-changfengnan@bytedance.com> <al-MJGguFULZhYDO@kbusch-mbp> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.1b934443.ec75.4a64.b2bc.6f822eb9e4bb@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.1b934443.ec75.4a64.b2bc.6f822eb9e4bb@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_020437_614411_78761D47 
X-CRM114-Status: GOOD (  22.68  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 22, 2026 at 10:22:11AM +0800, changfengnan wrote:
> 
> > From: "Keith Busch"<kbusch@kernel.org>
> > Date:  Tue, Jul 21, 2026, 23:11
> > Subject:  Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
> > To: "Fengnan Chang"<changfengnan@bytedance.com>
> > Cc: <hch@lst.de>, <andriy.shevchenko@intel.com>, <axboe@kernel.dk>, <gang.cao@intel.com>, <jun.i.jin@intel.com>, <jun1.zeng@intel.com>, <liang.a.fang@intel.com>, <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <tglx@kernel.org>, <yong.hu@intel.com>, <guzebing@bytedance.com>
> > On Tue, Jul 21, 2026 at 04:37:39PM +0800, Fengnan Chang wrote:
> > > @@ -1618,6 +1748,8 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
> > >                   * the cqe requires a full read memory barrier
> > >                   */
> > >                  dma_rmb();
> > > +                if (sq_head)
> > > +                        *sq_head = le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].sq_head);
> > 
> > This is the wrong criteria to determine the outstanding depth. The spec
> > allows the controller to move this forward after it has read an entry.
> > The commands may still be in progress, so the depth of future
> > completions to expect can't depend on this value.
> > 
> > But in general, I agree with the spirit of where this is going.
> 
> Thanks for your feedback.  I’d like to hear more opinions from others. 
> If this is the right direction, I’ll continue to improve this patch.
> 
> Hi Jens, Christoph, Sagi: 
> what do you think?

Yes, this is a useful idea, please continue with it if you can.


