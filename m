Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31680CCFA1A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 08:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRgudIymazOk2utu/3m2CJjnAQ90SxLXkszEmWDO6wQ=; b=1VsOtghoe1cSnAA3BDCcW4Pu/2
	fxVEqRg7FXknm7IkahY7ywLHaw+8sRyfoyqG+DVrB7FK/IKgHw/pCCx2fhWb/BXddUnX8hsB1b0jZ
	dZqMfvZ+i/8/dZJrHH7T1f8ndNV3DwzrmhNxZePZ77W+Wmr4PRq58KNB/zrvXdrthymXAjDoq1cON
	/EiZnYE0j599cB6ZRm4JvFXNMVy4JIjVbYND/rnCI7NA4JukHnBFfYa1ZGEIabYEtqGMM8BDxIaxP
	FFzNZQsAbLc35HMnyad7sH/LlrZQ2srVcayo1nwkMG3wThC1PYgI6jQ3s7TWvmqEn8An5mTjOhyeW
	q75xwMzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ6H0-00000008MQi-1erf;
	Wed, 12 Nov 2025 08:32:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ6Gy-00000008MPG-1zio
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 08:32:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF2F1227A88; Wed, 12 Nov 2025 09:32:03 +0100 (CET)
Date: Wed, 12 Nov 2025 09:32:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Alistair Francis <alistair23@gmail.com>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
Message-ID: <20251112083203.GA7838@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-4-alistair.francis@wdc.com> <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de> <CAKmqyKO=W2+5ZBudWhN_L1choupte9vzJBEoxVeZ-vNHykeR0Q@mail.gmail.com> <20251112070256.GA5276@lst.de> <c7679208-c963-4fdd-a038-a91ccda0a075@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7679208-c963-4fdd-a038-a91ccda0a075@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_003212_652914_ADC42274 
X-CRM114-Status: GOOD (  14.49  )
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

On Wed, Nov 12, 2025 at 08:21:41AM +0100, Hannes Reinecke wrote:
>
> 'tls_configured_key' prints out the value of
> ctrl->opts->tls_key, ie the key passed in from the 'connect'
> string. Normally this value will be empty,
> as the 'connect' command will pick up the TLS key from
> the keyring automatically.
>
> 'tls_key' prints out the value of
> ctrl->tls_pskid, ie the value of the _negotiated_ key.
>
> So why is 'tls_configured_key' key the better option?
> Personally I think that 'tls_key' is more 'natural',
> as we want to replace the negotiated key, not the
> configured key ...

I've not even looked into what is better, but accepting anything
without validity checking tends to always bite us later.


