Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AC4CEDDA4
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQ78+4Iv7/9m7K3mIUDUoCxA5c8+qMyI6jUz8yEoaP4=; b=oK5Ehg517y8B5iGx5Uum9N1tD6
	nkFo2jvGHmQ6XoAEJneKbZzB9m3OwqE3ushd8v4BoHJBHh2ZKU4m8HgsRizOEdFlNOxvS4sp4PlJd
	XSgz1fZGBugSgeN5iWwBvB1CxxZzNfqeKjkf3pCJFAIh/TSQfUzYz+35weI1jG2wLKXVXg4fk7272
	iQo4ydtBLodeJU98mWv8a7RGZUvrTjtUpcqaolWmmpZbeNxFb0WJVB2WJ4kbX05/JRTpcgZkf3IoC
	Ymuz22mHCZxzG2kGQtbXuRKxUfnmkRcjf4ztdT+a/Z2d/aJlsRw4ayFovM+ZVnh7JJRt/PXtHudsd
	i9kADUrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syY7E-00000009gaN-0G2g;
	Wed, 09 Oct 2024 14:56:40 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syY7B-00000009gZw-00iE
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 14:56:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 246C2A43FCA;
	Wed,  9 Oct 2024 14:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06566C4CECD;
	Wed,  9 Oct 2024 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728485795;
	bh=VRU+FuIHtHFwHpslUJLbxF3s4z/fvcd2THOG7jtM6Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBQPSSQuGXnhNouT2yHeXSNQ3z68kVKRH7uuaFD7KzOyLBYx9UqO8lsAest8Y2QpK
	 q6yK271Lq2I/K58I1REoRaY8fagwLLh/RVPmS3DAEbgHswUmwK4R6v9ov/58EY8Tyh
	 eqf+lzmJftOlPwNuGsrdsRp+2Ln/LvvJbWIKHAQBZ6Ex6Fc3yA6uhXbc03USVuqy1Y
	 ST70OEqKJAItLvKjJ8ArrpfaAjbaJMx7LgiHTBxXClAWwgscZsnT1NM3OqIEgla6KR
	 W1xZLPCWfUsVbXoCy5d2+UeTzC7TNpxTyJmi9k0y9JUY8TxY2tO/UXroAoXjHFRD58
	 CR8TiTGtLvCHA==
Date: Wed, 9 Oct 2024 08:56:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>, dlemoal@kernel.org,
	cassel@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
Message-ID: <ZwaZoJayzu6XZom1@kbusch-mbp>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-2-m@bjorling.me>
 <20241009074611.GB16181@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009074611.GB16181@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_075637_222056_E02021FA 
X-CRM114-Status: GOOD (  15.17  )
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

On Wed, Oct 09, 2024 at 09:46:11AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 04:55:02PM +0200, Matias Bjørling wrote:
> > However, the independent namespace data structure
> > is mandatory for devices that implement features from the 2.0+
> > specification. Therefore, we can check this data structure first. If
> > unavailable, retrieve the generic attributes from the NVM command set
> > identify namespace data structure.
> 
> I'm not a huge fan of this.  For pre-2.0 controllers this means
> we'll now send a command that will fail most of them time.  And for
> all the cheap low-end consumer device I'm actually worried that they'll
> get it wrong and break something.

We already send identify commands that we expect may break on pre-2.0
controllers: the Identify NS Descriptor List.

We have other quirks for disabling specific identifications (ex:
nvme_ctrl_limited_cns, NVME_QUIRK_NO_NS_DESC_LIST) in case something
really break certain identifies. But I think anything >= 1.3 should be
fine: the CNS handling is well defined from that point onward, so we
shouldn't make anything harder than necessary from assuming someone got
identication this wrong.

The only pain I can think of is that some controllers increment their
error log count, and SMART tools creates unnecessary alerts for that.

