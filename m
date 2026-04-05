Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90704E64019
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2026 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DShwsFfuiYCMrn3K4etN1h9yvssJ5Zz+2dg4zhc0vIY=; b=e8YzEyC4v/CdXLigGlWEBmKVSz
	6zVYgrGyJTTLlV9ZDuQfUkZtJVbRjmlVkRRATYI7znX/CEbRXpuCzC3kUA9jOuYFBU8URlAv3fU7P
	lGGL1cnhYyDSvUmtkIpWPquLPPztTavL9v33VZGG8OKHIOQkYDm5q9xz4uxhiu343MX415zkEK13V
	YKXjZZOTsUhPEPkmCFUJ5I6oiNdb/feBHM/HGlJHKhVddE+Exr9Mt1L9ZB0eMmMxzzZ9SeLOeumMq
	RnIks+uDqKpMRq8M2Lhn3bhfJFU5xQ12oOcB1PpXZF3k9oskDp1/OW6wFbRlHv7tZLBmIwJEco8pF
	KNCq+x4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9LfS-00000004ABT-2O47;
	Sun, 05 Apr 2026 11:29:26 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9LfP-00000004AAV-2wuA
	for linux-nvme@lists.infradead.org;
	Sun, 05 Apr 2026 11:29:24 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-b9825ba7f9dso668103666b.0
        for <linux-nvme@lists.infradead.org>; Sun, 05 Apr 2026 04:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388562; cv=none;
        d=google.com; s=arc-20240605;
        b=CTHMTH04r0qRMnk1voviUTHkUo0N/fieputyWpucECuncEElLIPSjcg/aEe78cFwd+
         SLYM2t0Mnx7he9J8SBqRlGYLjCg97KJ0Q8GhH3sdLMIrXMdq2OInSwRxL2JumA1Ra6N4
         9qMll5fW5Ob384MGo9ZLBXA77Gcz6XMVo4u5yzSwsVjfiuanRBOOI76krVhZIx4ihypB
         VJKzLf85M107//pIaKdepICWavWmcnFFTIIogRMB3vK2LLhKiFuBcPGZ0JGTfkFLw9WF
         aXAm8goY49se5CVdRq/lZ4q4Sqg3ubBWI2K5ZRpG1RzlximIqN+347xSCRXpz5Fs8eu1
         lbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DShwsFfuiYCMrn3K4etN1h9yvssJ5Zz+2dg4zhc0vIY=;
        fh=K4EFF/bHXdvvkjJTB5QlSm+rMnB9QlHc7c8Y8r0P9ew=;
        b=EoKFPfQVqxWMyrGARV2uq2pUv1k43oayXL3netiUeouAfgGDVA9L9TOOwlLOHw5q/h
         +K1ZnawWQ+OwHu2fpxs44UuEVnc9MX4GN4ocCfR8UCew8p+XY/r7c5z35I4usU1LToM8
         a4ijx7BMJAEmM2E+3kgLa4Hy47YR2HWVakUUbuYzV22MWiumNI0ac0ARTFkRzNVhGxsl
         NbSBWF95psYJvi25vlEHRWUuw0/eDcbC1Zz1nS7+Zib7yHVbQCMRCSpTZB3BnPyMbky/
         hD+Ja0lidOTLn10rXPmdw9GRpYqUkhjbdgoVDCWW3p+o1Ji+RWIEqcsx/6wE6bJqWZve
         YrMg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388562; x=1775993362; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DShwsFfuiYCMrn3K4etN1h9yvssJ5Zz+2dg4zhc0vIY=;
        b=VCP8BP6aYvvqnNuzPtvhqsUB631IE1aD2/zWRo/bIqHZBm1D+IJUsdgxUQlvDqbMHX
         uY9LIPE5HRBAtgzdAgLHfmGm0Q95gbUElIL8cVXwFRt1N1KpPf2OyvkxBcqfGZcL2Nvi
         kmvKQPLNAsuh44mF/DGP78aYUtte5K3lNxAyaV3rOoBS/IH2fnMrBNGmOQexSRTq/wQH
         mLAfifn99uHwonrebLWxIdC2u7PjBixt3jYUqANiTmFv0RLu1sC+vrXDuyWElPOx+J3l
         MHJykMlSnuUYRjEbAKItjxT9u9C3M56kHSLM1B0gWrtdNchsusvjiEBPJFJd/1U1xFfd
         1LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388562; x=1775993362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DShwsFfuiYCMrn3K4etN1h9yvssJ5Zz+2dg4zhc0vIY=;
        b=PL8U2NLPB25TyorslR0qVfxekXqnlDCzOx7AKUcPbHPEIe/aqZUm4bGXKkrxYwqTZ9
         bkoXGu8gmXbwrFc+IF/XNhHZcuYAPGXlhHykxhMReMQDcnPP0Gw1rkMl+OtYzHF7ywoX
         tX5UtLQSIXnSXZEztbJwVb1R07zWr2WlWrxdoVg4O2S+/iT/5QJ/TTLn5jxZCovcXAve
         HYV6YqAZYPUkzYGE2zGUYVzJEAsIYRpY0m7aTvNspu3CnvkuWNYAAHjcqC+l+2kwxhC7
         sK2wwD1NmDgfxltjnjGOq2tCBbr8xkD2HoQ2XjdihfSSQJXJpMT6/eLY2bkKOOLgkB0U
         n5jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBsYd6oiyAo865pufdhH52QOn4VO/2O9n461DqJ0EaFBC1kx7mwHEv6xelSJ+jyYYs3TfA+DGf4V5n@lists.infradead.org
X-Gm-Message-State: AOJu0YzfDHsy9C0BABgjpJQqRC4b5rDkpUFAszw4/B36KFuOz4iWufMa
	jPVaWEM702m4cLlx8a1E6PjoFFTbZOnjtZbj5dlH8PQVHFH/879Bd/38P3j2lOOO7f5Kt/X71IP
	ocUwwZ75vjKoKXNP1op4EdqKc9SAagg==
X-Gm-Gg: AeBDieutgXYGoBLw7i2a1IJruDSQyfNFLkHJkirJvL1m569MjB7CsKGOJoj2WcAhbtZ
	KNIHory0V2gjYyJOGDuq9j/d4RdHjXHVFBHrMDbs8CbOQLU5iemCnFZM5d+1LwA7grlnoFCE36o
	6K0EIrKZkxYsG6leG1bV76wvie9TL1cpZeagC6jDLgdG0DJtsSbcQypkOHfsLna6Uq31ZyG4WmH
	vz7iQUyXE411kchfeZ4BdF/Vb5nwIlObS0rAK1ijAhaAIjoDaULckRK/3phwJhLFRNStEPui41a
	A8UWCYU8eagkuumIsI0Vu26sebSo9SVnaT5Wu6sg93zrGvCWKaYRM2sB1Cp6sas9nItRsA==
X-Received: by 2002:a17:907:96a0:b0:b97:b149:4e72 with SMTP id
 a640c23a62f3a-b9c4713a360mr613633166b.28.1775388561627; Sun, 05 Apr 2026
 04:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-4-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-4-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:58:43 +0530
X-Gm-Features: AQROBzBzw9s6pxMkbcgpTMX5W8n4QANeXDJvCU5tpcGpnilon7LOxG0WvSR_FnA
Message-ID: <CACzX3At16V+ZLqoWh4UNEJ6p60x94x66HxzTtPUuJ+KWxs4AXQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] bio-integrity-fs: pass data iter to bio_integrity_verify()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_042923_757994_5A337D72 
X-CRM114-Status: UNSURE (   8.10  )
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

> bio_integrity_verify() expects the passed struct bvec_iter to be an
> iterator over bio data, not integrity. So construct a separate data
> bvec_iter without the bio_integrity_bytes() conversion and pass it to
> bio_integrity_verify() instead of bip_iter.

Good catch!
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

