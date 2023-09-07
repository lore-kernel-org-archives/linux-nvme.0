Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC81EC873D
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Sep 2023 15:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UKY2rcR6pqYeElA283vLyTmRyYLiCdcO9R4UBcnE0pU=; b=HS48CJeMt9xDoxE9vMb9Jn+1kL
	qPTjS6SHlPg2IvbqGHfmak8W+rUg+xqJC5NIWrzVNK1vc98GqJ/Er0tS00bFi5IvZPyz2ZSwMWDOY
	yDGFKKeGNzZzdWZ4VcvGuo/kOXqCqbnJv1UjUC2c/EkTtisFdPsxRY7AZEaNg+dwXb0T6Cyekj9mH
	DIg/NrczW0cDWv5EgYubtLvon87/hLUnjpGhl6TxvsWRmdN/REmv4qbb2XTRaPhMoadVJ/8VeebkZ
	rNHNmmPrH2A1D5jgY5Xj0Juszaq5oHn/myhVLeh/WTGjgR2BkzpcgNpVkwu/dEuC2XRknznLnQsTK
	9iKlBbuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeH8k-00CJGi-0Q;
	Thu, 07 Sep 2023 15:41:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeH8e-00CJFt-0H
	for linux-nvme@lists.infradead.org;
	Thu, 07 Sep 2023 15:41:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B66726125B;
	Thu,  7 Sep 2023 15:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F471C116B7;
	Thu,  7 Sep 2023 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694101302;
	bh=zePQdjSjpAxHSlG2N1mjiwP8rP/tzCKfSbAd9oQ6Whw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9sc8ylv5PC3Fa2MHN441gSLzenPZ75yZ17Ocgqqeh/ncVZm7JYfPUuUbjKKjZtca
	 dJqKnkC/u+GpvQ1VGD9IR8s5lBxpOFWWDWPbZ9ehQw52LuFMMW/ql7S2JfeuyLLoQi
	 pTaPBNVm02vqXoKvKGRJfTqLv29atzTzsD4W/FqfrHE1yKWH40BOAmh5ONJKSGCAK3
	 FKwUO4eHnuNV2ldy1NVdNGqvGmg3fO1BU2foMb3yIRSeJ/AWi3mUx9vbxk0ZIKlreu
	 Ju6Mwm1pLzuAkHHSaFn9oKhkhkOqlUWENH4Fz6RugMaQWnHvrYTJUHX2rUA2PLUioa
	 cxEJtePsL7KaA==
Date: Thu, 7 Sep 2023 09:41:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough
 metadata
Message-ID: <ZPnvM3kNSHVA8x6Y@kbusch-mbp>
References: <20230814070213.161033-1-joshi.k@samsung.com>
 <CGME20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9@epcas5p3.samsung.com>
 <20230814070213.161033-2-joshi.k@samsung.com>
 <ZPH5Hjsqntn7tBCh@kbusch-mbp>
 <20230905051825.GA4073@green245>
 <ZPduqCASmcNxUUep@kbusch-mbp>
 <20230906154815.GA23984@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906154815.GA23984@green245>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_084148_187316_993636C2 
X-CRM114-Status: GOOD (  14.00  )
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

On Wed, Sep 06, 2023 at 09:18:15PM +0530, Kanchan Joshi wrote:
> Would you really prefer to have nvme_add_user_metadata() changed to do
> away with allocation and use userspace meta-buffer directly?

I mean, sure, if it's possible. We can avoid a costly copy if the user
metabuffer is aligned and physically contiguous.

> Even with that route, extended-lba-with-short-unaligned-buffer remains
> unhandled. That will still require similar checks that I would like
> to avoid but cannnot.
> 
> So how about this -

There's lots of bad things you can do with this interface. Example,
provide an unaligned single byte user buffer and send an Identify
command.

We never provided opcode decoding sanity checks before because it's a
bad maintenance burden, adds performance killing overhead, couldn't
catch all the cases anyway due to vendor specific and future opcodes,
and harms the flexibility of the interface. The burden is usually on the
user for these kinds of priviledged interfaces: if you abuse it, "you
get to keep both pieces" territory.

