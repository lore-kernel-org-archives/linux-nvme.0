Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5705C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 21:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=De70A128M136BzcvUcDhFvWwtReZNa93TwdWArPgNw0=; b=0RjcOqgDBBxEzp7NUM2yx/jiQG
	SCJ+BlXAjlxgi18wyW7a3516lxgA/+CEZ0aZnlr/XCrB++UPEc8C6hpV3DO3QpPie3lvrF8jiEjST
	iosf53aIlvH4Ir1avLh8hu3iblG9Bz17OXJTeTNMx+p2GvXCXa6sOx71n0kJej/50znISYzrP8SEE
	XAEz+Nv9+VGzY25zvzFMnqD1ksb1ZddEFofjge+2tuNc0MGbYxsvaA11QIGT1nIorM2Uj5NzLz0SV
	gye/FyCibh68HFiGJ6pHmvlYjKHA42SWhmHEtvtZ7Zz8BHrM7yyF90C9jKItPDQT09Q4qT53t5Vej
	yfklhFPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0rW0-005wPw-5k; Mon, 13 Jun 2022 21:22:28 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0rVv-005wNQ-NP
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 21:22:25 +0000
Received: by mail-pj1-x1035.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so10024611pjo.0
        for <linux-nvme@lists.infradead.org>; Mon, 13 Jun 2022 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=De70A128M136BzcvUcDhFvWwtReZNa93TwdWArPgNw0=;
        b=wMhSJPuYIysiFwTN0rrpT3P9RK3mKPf/aUbDCs2PEUQJWku7YD57LLGZE58wmDZrAr
         OEJfJz50T181/f6I0fCF7BCxiM2g5aiiufxhqIjQo4BBlhmh6+kS9D7wUFsHYhmt8+Av
         cPRUO1F1tQ9KOMD0zYmhZdMTbxqxs/V6F2DT8qZv3jSqdXHMwZEowWjrDwYUu7RgpcA2
         dPLZFSNQfA7omcbet+DMlaIQRA2r/kXrpP/JuoL9RW/Dhwy81iguXw0f9NsTuqpa+lgo
         gZz8xcTlcsA2Q+OxolRv2BEHk6RNnHIe6Gqq3p5NuAgB9Gu3Dfjwyk24NGhs6ZW0M17B
         n5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=De70A128M136BzcvUcDhFvWwtReZNa93TwdWArPgNw0=;
        b=CNTyeylXKreYm3Psq6XGbVpL7VQNmJ9i56TyBMJsWSZhfiSUMqfTbztJ4KsmYuJlv1
         5KWrdRJT89tx2TLdo1AAKwxESdV5QoLXNLqFS79XYQzfrKWOvzdC5aPDP0SKF/Py4hug
         Am53Gk9VaipNwDNAJdTsLrTrQfEQIfujP1BOI3jkefuMoagg2ASqgCqm1mACF0viWHYJ
         Wai+CD8k0QddfwfMwOlhVA4OpxMyZ2QZosnzZFfa/8i4sgy4Uf6lNXRmwm1rMU0dlxKa
         TLnf2DJISEZmZawgEN7bQFc2IvcYYULUFqV/tPPoivKm/6AjnLfcyB+V7U+yRId6tFYd
         AFJw==
X-Gm-Message-State: AJIora+OEZK2NdsoThDDWbRVBNPMAW+lzw/gE8U61UfR6FJIEa4zC2iY
	fStZeCYQpOztt/v0P0Bix9CCD143yqBHmVQZ
X-Google-Smtp-Source: AGRyM1sPSnFY+821fUYw3RfnTBageuTpEriPGizdyessVR1YgznLprR3pLTNMc9iVpLL2eNsdqp13A==
X-Received: by 2002:a17:902:d48b:b0:167:770b:67d with SMTP id c11-20020a170902d48b00b00167770b067dmr901304plg.162.1655155339407;
        Mon, 13 Jun 2022 14:22:19 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b0015e9d4a5d27sm5605697plb.23.2022.06.13.14.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:22:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@fb.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: bvanassche@acm.org, ebiggers@kernel.org, damien.lemoal@opensource.wdc.com, Kernel-team@fb.com, pankydev8@gmail.com, kbusch@kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
Subject: Re: [PATCHv6 00/11] direct-io dma alignment
Message-Id: <165515533813.6829.11794160430022485799.b4-ty@kernel.dk>
Date: Mon, 13 Jun 2022 15:22:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_142224_032161_2C7808AF 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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

On Fri, 10 Jun 2022 12:58:19 -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The previous version is available here:
> 
>   https://lore.kernel.org/linux-block/Yp4qQRI5awiycml1@kbusch-mbp.dhcp.thefacebook.com/T/#m0a93b6392038aad6144e066fb5ada2cbf316f78e
> 
> Changes from the previous are all trivial changes:
> 
> [...]

Applied, thanks!

[01/11] block: fix infinite loop for invalid zone append
        commit: 1180b55c93f6b060ad930db151fe6d2b425f9215
[02/11] block/bio: remove duplicate append pages code
        commit: 7a2b81b95a89e578343b1c944ddd64d1b14ee49a
[03/11] block: export dma_alignment attribute
        commit: 5f507439f051daaa1e3273ff536afda3ad1f1505
[04/11] block: introduce bdev_dma_alignment helper
        commit: 24b10a6e0bc22619535b0ed982b7735910981661
[05/11] block: add a helper function for dio alignment
        commit: 8a39418810a65f0bcbe559261ef011fe0e298eeb
[06/11] block/merge: count bytes instead of sectors
        commit: 4ff782f24a4cad4b033d0f4f6e38cd50e0d463b0
[07/11] block/bounce: count bytes instead of sectors
        commit: 4b5310470e72d77c9b52f8544b98aa8cf77d956f
[08/11] iov: introduce iov_iter_aligned
        commit: ab7c0c3abb2e5fa15655e4b87bb7b937ca7e18c3
[09/11] block: introduce bdev_iter_is_aligned helper
        commit: 72230944b7a53280c1f351a0d5cafed12732ec21
[10/11] block: relax direct io memory alignment
        commit: 84f970d415ef4d048e664ac308792eb93d0152fc
[11/11] iomap: add support for dma aligned direct-io
        commit: 40e11e7a6cc74f11b5ca23ceefec7c84af5c4c73

Best regards,
-- 
Jens Axboe



