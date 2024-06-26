Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDA3C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 17:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3XGCtOCJzu3sWWTw6fOCW1iSwvOqe10347VxboXl1UI=; b=Os2o8xccrq0U5j30gDbQdO2CdT
	MSRZ6V77/V3iEjA79INNhibbj5D0LvqYjBk2pIQCrEt6t84rEg2vhtTo/RldElVxuvh8/UOgNasja
	Jg7EcwnWdzDNxwbVv5ASQ9rqqxTT9wVgJYeBS38A1DWNaVVECDlFuRHFmPX4bbMSDWcq/5MNMG3R3
	tTKx4wrB70GmqpkmrvxqON3FUYagxKoBGwA4XTW6GkhYjWAO1rnBHp5EPWuDHUKpMLc2XfyPzojTn
	IKAJUyZtK09XiqTawPjuJ4WYZF2oBPPoJu26R47aD4qXe503pK8mpByvmk5Al3NNe53DHjI3eCUA8
	hDKE/dsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMWMj-00000007kWp-1WHU;
	Wed, 26 Jun 2024 17:23:29 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMWMg-00000007kWI-0ybR
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 17:23:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2C931CE2BF0;
	Wed, 26 Jun 2024 17:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD26C116B1;
	Wed, 26 Jun 2024 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719422603;
	bh=kxM1rzXSM3apA5h4Q/eu9A9wQfIY40O7JKkfcPhJV3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/qi2/GqYvcuAcBQtiC6zuLgWhZKJiytzdol82KuxYy9UKwG6b0VgbI4xZnJoZFcE
	 btj9JT7Go8wkvARY4ep5ysQvPs296jULQmv4EFJxszCIuws7HFVwqz1uSpKDV8NtyY
	 QKS5/yOEfWKMpBlHV/3t7wQb1QUhqU5ApTlkv/AhKh/6bvKmohmYI1whN22yveVLzZ
	 0vD7p/+/nUycern/GYGtbPGWLHAhX4qs4PWKe+3vsGAVQ/cmzzrVQOwyp9kcUTmBiQ
	 yZ+AAghWqTJvYQNm1bnVptZUksToM77LsQzmhLhrZRrwPR5q6kGZKG17b51w++RgwV
	 tDKHbXkn7C1pQ==
Date: Wed, 26 Jun 2024 10:23:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: Remove __counted_by from
 nvmet_fc_tgt_queue.fod[]
Message-ID: <20240626172320.GB50752@fedora-macbook-air-m2>
References: <20240529-drop-counted-by-fod-nvmet-fc-tgt-queue-v1-1-286adbc25943@kernel.org>
 <20240626170605.GA66745@fedora-macbook-air-m2>
 <ZnxNnFxTQCcPWhQM@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnxNnFxTQCcPWhQM@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_102326_483093_ABB87557 
X-CRM114-Status: GOOD (  11.74  )
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

On Wed, Jun 26, 2024 at 11:19:24AM -0600, Keith Busch wrote:
> On Wed, Jun 26, 2024 at 10:06:05AM -0700, Nathan Chancellor wrote:
> > Ping? This is still relevant and I don't think this is a compiler bug
> > that would justify withholding this change.
> 
> Sorry, I misunderstood the discussion to "wait" on this. Queued up in
> nvme-6.10 now.

No worries, thanks a lot for the quick response!

Cheers,
Nathan

