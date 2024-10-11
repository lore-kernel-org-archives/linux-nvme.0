Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E54CFC618
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 08:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2t2kE0C2zRWWJnB1mmimU4BADOT84K3YPS+1PPbtJIk=; b=gU4BTX/Lpvyx6zurbybl3WWWXJ
	T0tzf0eRsLPnUWwLwFkUtnGMeXDdrAy84Tx/oQEMm6Up54RE6g+pMn8Qou8hUVcg21wikIov9i4h5
	g3xc79DVeLH93psAXNzDrqNa2mqkG80kDsJbpzw4m5NFk2AIxAI1Wbu+/BY4Iqk92NuVw2WV+Tkct
	ORYkJzFP+9cPSmI68ohF1wfvwKYmlxul8K+PRAM57ENDVvSZ4d6rxiVo8ANuJEyxx/KLcAUWcxkql
	Uu96DZ7U24z6NxdcS2fu1vtdKxUhbuyDn6P7SkM7BUPs2xLQKMLqfcM94TJtiGTeEpFdUdx5xzrkL
	qTqoo2fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szAjI-0000000FeLd-3cqw;
	Fri, 11 Oct 2024 08:10:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szAiN-0000000FeFh-0OUo
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 08:09:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6EBC8227AB3; Fri, 11 Oct 2024 10:09:25 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:09:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix cns check
Message-ID: <20241011080925.GE2749@lst.de>
References: <20241009214035.3851406-1-kbusch@meta.com> <20241010075633.GB7525@lst.de> <Zwfuqf_PAP06GG1-@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwfuqf_PAP06GG1-@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_010935_298573_8C89CB66 
X-CRM114-Status: GOOD (  20.20  )
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

On Thu, Oct 10, 2024 at 09:11:37AM -0600, Keith Busch wrote:
> It's not going to return anything useful. The 1.1 compliant controller
> truncates Command Set Specific ID Ctrl (CNS 06h) to just two bits (2h),
> believing the host requested the a namespace list, and the host will
> think the success means it has different identification data.
> 
> I was only thinking about this because of the rotational media patches
> were using the same criteria that would let a 1.1 complaint controller
> see another Identify that will have a truncated CNS.

Ok, I finally understand what you are doing now, I as just beeing
stupid before (and maybe the commit log didn't help enough, but I don't
want to shift blame :)).

So yes, something like this is probably fine.  But maybe we'll want to
struture it in a way that is easier to read instead of having two
helpers to decide which CNS value is supported.  Maybe something
like:

static bool nvme_identify_cns_allowed(struct nvme_ctrl *ctrl, u8 cns)
{
	switch (ctrl->vs) {
	default:
		/*
		 * Starting with NVMe 1.2 the CNS field occupies a full
		 * byte.
		 */
		return true;
	case NVME_VS(1, 1, 0):
		/*
		 * NVMe 1.1 expanded the CNS value to two bytes, which
		 * means values larger than that could get truncated
		 * and treated as an incorrect value.
		 *
		 * Qemu implemented 1.0 behavior for controllers claiming
		 * 1.1 compliance, so they need to be quirked here.
		 */
		if (!(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS))
			return !(cns & ~0x02);
		fallthrough;
	case NVME_VS(1, 0, 0):
		/*
		 * NVMe 1.0 only used a single for the CNS value.
		 * (That's where the name comes from:
		 *  Controller or Namespace Structure)
		 */
		return !(cns & ~0x01);
	}
}

