Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A46C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 17:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UHk1di8BEB651ihVPCyM3zvM1FisZma9BYsYRsXSoqc=; b=1aOqOnc/t3eKrq4zCh1IFn8Uf5
	CFndccz2Yl8nYhWjfjzVjWHqaaTFPRVWqKvl0N5JqSr7LMYfSB4R5OtS+1OZaiah58ThBO4rK4EWs
	ljJTEPObf/KxeNgFL4KWXatl6vqPZ51e4qDf0jLKMtT57zu2/c2DvxZihcXwl6Vyam6vsYHQ+0H/x
	qLRBTT+CPZJ8y2SX9FmImIdi7sV4W6ysaUsN1iVPllqevZ1J0tr8eGsENNLdXhRC/518y0HieyPv7
	Y9hYXtbRncyu3VihVOapPl3Bbk48hRjeGN3/dRQB/BcHCKG2eQMbku9qOOg/6SE89iBgNjYAt1LQY
	95iKXNLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9oyF-0000000ARBe-0orc;
	Tue, 29 Apr 2025 17:42:15 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9oyC-0000000ARB0-3ZFq
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 17:42:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C191AA4BBA0;
	Tue, 29 Apr 2025 17:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F008AC4CEE3;
	Tue, 29 Apr 2025 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745948531;
	bh=quar4LJeCruYrX9mBAaOzHlPxFGeSLXNozfLVYsglV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzNKVNu2gMHClOAN448Tz1U/PliJnckepyn8YPpt4E6jjZ05Iu06qj0XV8NZVzODe
	 GfejOtPBsNklyJ/o3rEmE5VSLydln2y5/VhK+ym+Gp5enTPZI06g5/OCc1wCJStdcC
	 RNdP7gN8nNKXwbYRVIhl2vGC/b2De68yaKSdJl8RqMdjkoRFifC+X9WCXSFQiiOV57
	 W0gilylwxillM+HNkIsM4uX/Jea4x+DzkuMa02oy4Vken+sTRPFGM1p0h5W8mgPsYy
	 USq7bOkXjJi2vByjZAmc9BhJ1+tAVczcTmnFwXvOoObjKkry+Ih/41Rbe09BAgFdRk
	 ndleoLsspNeFA==
Date: Tue, 29 Apr 2025 10:42:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alistair Francis <alistair23@gmail.com>, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvme-tcp: select tls config when tcp tls is enabled
Message-ID: <aBEPcVursIG8fab6@kbusch-mbp>
References: <20250424101333.2908504-1-alistair.francis@wdc.com>
 <20250429125505.GA13574@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429125505.GA13574@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_104212_946522_5DE508DA 
X-CRM114-Status: GOOD (  13.84  )
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

On Tue, Apr 29, 2025 at 02:55:05PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 24, 2025 at 08:13:33PM +1000, Alistair Francis wrote:
> > Ensure that TLS support is enabled in the kernel when
> > NVME_TARGET_TCP_TLS is enabled. This allows TLS secure channels to be
> > used out of the box.
> 
> How did the code even build before this?

The nvme tls code doesn't appear to use any symbols that depend on
CONFIG_TLS, so I guess it would compile but wouldn't work at runtime. ?

