Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2E8C44529
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FYnEpm9v0G/lVuR4rZTj+1KLTE5h9epDTFOEUQYssKQ=; b=GzskJiqsyFSoXP6Za8oVeggdKt
	twZd8TNjZkBXUZ5KXrmygXaqTZoDDnXh8UR2sti0eHQ8PjstplZdDisQgCzjJX85VcDwktKWWmcv6
	IMMQA1RSOQhT8o6PistyV07hDPLef5oQhz0+IP+mRnRcC/2lIhahPCAz13uk5MJE3ZJ2qRiuUpTlF
	4ucNO5vxm5XAhjGlwVbzoNL3rcJSs9lg3EdwEuoYZ0SxTs1b5SZu6U/HfEZcLFN7wQJJe6w8eoNWL
	/2ZbFx3ZV1W14c+fdsBsPW671zX/kU4bPSq5YbIJKSWTZ4dd7qEgOMHxncqlaicGPBwhrvImOQdEx
	KpQjW0dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmC8A-00000009kxz-3qzj;
	Tue, 21 Jul 2026 15:11:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmC89-00000009kxI-2gfd
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 15:11:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 661F443C78;
	Tue, 21 Jul 2026 15:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAD81F00A3D;
	Tue, 21 Jul 2026 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784646697;
	bh=FYnEpm9v0G/lVuR4rZTj+1KLTE5h9epDTFOEUQYssKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R9OWAVTEG/M5V6quVfi/FKXThTlKlY62+FNTYYt20lnbuHnyaXpb3q/lg7SlA7UaD
	 S2qSPH9XDCc6F2VdXyBe5BaW+oicsrdUWaYb81ZEl5nn6XP2Q+OCDBki/Jt7PKKzRa
	 vOl9Aqk6TyWmc8UMNEPhWm7ow/AFRjWnDxnu3qOaqrnWfjGPH70rFt0nC2SGlOoy1L
	 g+uv2O7WRIyabEIe9LmhJn5ZjDIAsXCibayBe/CUFWujvQDUXWRDDCet7vI3sioPWs
	 e92Zf8NJ29bwYUq+gu4zO+cngMhEPRJqUMRRADo9lZPQeY22Ny2QUYfgqetK0VtDLH
	 WAtpgR2/jV1Qw==
Date: Tue, 21 Jul 2026 09:11:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: hch@lst.de, andriy.shevchenko@intel.com, axboe@kernel.dk,
	gang.cao@intel.com, jun.i.jin@intel.com, jun1.zeng@intel.com,
	liang.a.fang@intel.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tglx@kernel.org,
	yong.hu@intel.com, guzebing@bytedance.com
Subject: Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
Message-ID: <al-MJGguFULZhYDO@kbusch-mbp>
References: <20260715075703.15578-1-jun1.zeng@intel.com>
 <20260715075703.15578-2-jun1.zeng@intel.com>
 <allEmTmXCFosxIOr@kbusch-mbp>
 <20260720150539.GB17986@lst.de>
 <20260721083739.69676-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721083739.69676-1-changfengnan@bytedance.com>
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

On Tue, Jul 21, 2026 at 04:37:39PM +0800, Fengnan Chang wrote:
> @@ -1618,6 +1748,8 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
>  		 * the cqe requires a full read memory barrier
>  		 */
>  		dma_rmb();
> +		if (sq_head)
> +			*sq_head = le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].sq_head);

This is the wrong criteria to determine the outstanding depth. The spec
allows the controller to move this forward after it has read an entry.
The commands may still be in progress, so the depth of future
completions to expect can't depend on this value.

But in general, I agree with the spirit of where this is going.

For MSI, you can make use of the INTMS/INTMC NVMe registers to make this
even more efficient. Your patch disables the irq at the cpU level, but
the device is still emitting those messages for no reason.

