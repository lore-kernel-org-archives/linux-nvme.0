Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE5FC004D4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 07:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7fAxybDGipH02vputEuYiufbK7FziGeQOCUU7EzR338=; b=HPFoiTNaqKEWwLN9JgaMfKcOf6
	tI7Qxsp7E/bWjFsxA6Jeexhs6BskFkA35uuAMKy1QjiJZ6IVo9waHnlsud/m4QBPP4N4NrUglAbrh
	KhrYwYGRZDywgzdSzHWTiO19MBOYgIjZEuwuHH8GzLILcs6tebalXYugrgyYNs4v2vSAyf9glG4YZ
	yPH014W41Jk5h/rLVKz78Ph5vo/ner5VJB6ib0nIK6pzYcsYEvJCaoYGG01v7mXxxT2Abkm/fuNnj
	n2rsx8k2n+O24+hgXXaQjaHkS0a1NXYKcRFml5pfhXxfzX03C9U3YJt8ELuRUXRjOc4lqrPFzRUaI
	jlyMoFIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI325-00HH9z-CX; Wed, 18 Jan 2023 07:38:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI2x2-00HEwG-Mq
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 07:33:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DE2067373; Wed, 18 Jan 2023 08:33:31 +0100 (CET)
Date: Wed, 18 Jan 2023 08:33:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] nvme-pci: fix timeout request state check
Message-ID: <20230118073330.GA27048@lst.de>
References: <20230118052244.741505-1-kbusch@meta.com> <20230118053306.GA24817@lst.de> <Y8eJJ/9qo9c7jzLT@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8eJJ/9qo9c7jzLT@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_233340_924401_DFBBD78B 
X-CRM114-Status: GOOD (  15.62  )
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

On Tue, Jan 17, 2023 at 10:52:39PM -0700, Keith Busch wrote:
> We're actually not batching here (no IOB in the timeout context), so we
> are either:
> 
>   a. calling nvme_pci_complete_rq() inline with the cqe
>   b. racing with smp ipi or softirq
> 
> If case (a), we will always see IDLE. If (b), we are racing and may see
> either COMPLETED or IDLE, so we have to check that it's not either of
> those. Since there's only one other state (STARTED) that was guaranteed
> prior to entering the timeout handler, we can just make sure it's not
> that one after the poll to know if abort escalation is needed.

The point is still that "started" is the wrong check here and relies
on an implementation detail.  I think we're better off with an explicit
IDLE check and a big fat comment.

