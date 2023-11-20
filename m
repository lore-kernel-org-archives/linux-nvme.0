Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D387C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmRQatz/2MNzry3AZL0CwnaOlVvVOm554dCjKuJTOe0=; b=KxfN8OrOCQiWx9njJ5SS/HYWpb
	g7kN94AtGO43WWm4ezFqe4/IWl4cGszbvx9qLs5GWr6CzNe/OmtM+g9hX6vATLtCLVI66KV7MIak0
	RSFkY0xtEiviwUc4+kz010Tx2+mC1/C9BPzidtFcya1pqYieo+GwNTE0pcFelH1cE8jS5K3wGlBZi
	cos2/qQraGR9wxqZvI8K9A5/OXP3qzTy4hYiGhX/fsLv3YUsl1U2ur/tNksR/DTYzzjMyjBF+8I/K
	NYZHmbbJYc14OrqBRi/jHXtdZ+WPrn7mPMupl0viAQuN4xsXyLxwXF/Q/hlW2bBRDA13w2BZOI3bi
	72XL2ZpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r55F6-00CHKx-33;
	Mon, 20 Nov 2023 14:27:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r55Em-00CHGB-1G
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 14:27:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC8336732A; Mon, 20 Nov 2023 15:26:48 +0100 (CET)
Date: Mon, 20 Nov 2023 15:26:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Minh Hoang <mh2022@meta.com>
Subject: Re: [PATCH] nvme: ensure reset state check ordering
Message-ID: <20231120142648.GA7139@lst.de>
References: <20231027180752.2527653-1-kbusch@meta.com> <20231030132738.GB21741@lst.de> <0e19bd16-a544-457e-aecd-70b7ff6433cc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e19bd16-a544-457e-aecd-70b7ff6433cc@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_062656_793322_BDDAD9A5 
X-CRM114-Status: GOOD (  13.75  )
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

On Mon, Nov 20, 2023 at 03:53:59PM +0200, Sagi Grimberg wrote:
>
>>> From: Keith Busch <kbusch@kernel.org>
>>>
>>> A different CPU may be setting the ctrl->state value while flushing the
>>> reset work, so ensure proper barriers to prevent reading a stale state.
>>> Reading the wrong state can report unexpected ENETRESET errors when
>>> everything was successful.
>>
>> smp_load_acquire needs to be paired with a smp_store_release.
>>
>> We should either always hold the lock or use WRITE_ONCE/READ_ONCE
>
> which lock?

in this case: ctrl->lock.

