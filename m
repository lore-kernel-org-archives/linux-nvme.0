Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63064606A319
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LSDhmw03;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=uTCWLf2t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CcN6V0kVf6Aq31J0RAqWWkvpV1VAcbfbB6YKV5xFzr4=; b=LSDhmw03KnP9gd
	WImBmQKnSQp7XJAi85Vplhs8x6xzcqKgE9X7TVCYTmkLgrajX/Te1fLmoKNdWGdzTqKY24ZWJVzRV
	qz+CptHy6iP3uqWdVSKOhfL4XIAJkO4fDkPWnYpBLkgIFdI+ghEitt3H0fJVyxildhLReeRywBwCu
	glKvebUHAmof2In9kRtnigHjS8BWhy7N5hhkmkMhfnGrmi6lidpHoaNMC9aJtREhcicY+IcSFWaT4
	lWjRRGV/aM4SwKt1n9pTpuMswWku5K80JiwOydt6Un8TIb4mVKDPkiii6gkMZ46iUl2XO3Mv58aLs
	AdQBP7HpO8gcEVBxFSXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJs6V-0000000E57v-0Fu9;
	Thu, 22 Oct 2026 12:41:07 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJs6R-0000000E57D-3rI2
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 12:41:05 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso1075516a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792672863; x=1793277663; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CcN6V0kVf6Aq31J0RAqWWkvpV1VAcbfbB6YKV5xFzr4=;
        b=uTCWLf2tS15lxjP41kGKhH4zTx23McrMXRq0v6+JMWI1bWabZ1FigkMbrHBpI4TqIa
         2vvI52tkjRgFKiVLx55Y9yLX1HJgro8ugN16OFWfpF8C61Xf39UY1kS42wYh2uTvdWtv
         xJ6Z1Pxd3u/34PwFAvaNbiRrvaFctlJzkHTWQD5PY1GhndHQYhYf1hZ9SWSfxU7cIYMe
         1QsMhfU0W7W64MVfegDZfTlkeu5+tiOeQTOSOtsJcbJcRWRzYQ03LX6ZBqqJXw8MdtS8
         OOUOBfSeCblR5E5Clej1yYwWKMqeOFPonTBtmMIgMkERLNhapRSEXsrTBZhFPDSeMpOx
         Lorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672863; x=1793277663;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcN6V0kVf6Aq31J0RAqWWkvpV1VAcbfbB6YKV5xFzr4=;
        b=r+3QnSLCie35tRWQYgqkpvPeawpyWz7XeMSb4IRcro9xT7LEGkwbmTmoG+yYWKop3i
         kJiNKPPkHz1ITjbdCmmBQsoMwtveu1BfJC+zRnnM5ckglO+8/SRXfjqqxi2IuqWF0q2V
         3eX8p5KCLWkkQVxODSLtWqwuOJeu0Q25THRnEWbwrA6kRDTElKavvx3Qn2CjVp0fC4KX
         5KrCK/wbIgjz3Y255eHZqdU9uAxZUq0LSi0U8bbIYvywkaV9WNCZEv3INkHwR+RfCG1H
         VCRp4AjllroWiaayjlAMBONiTCh1ev2pTXNie8AAEzEwl4ZFNTmpAQOZw/irtzX5TwYq
         Tdig==
X-Forwarded-Encrypted: i=1; AKwUvBzgFSFrp2QNVSExzi2bkYzq+dbIaSd9xuCvJqmYp27ZJWONVN79X/T5WOl0+45tpkXrYhuI8PKhMWSM@lists.infradead.org
X-Gm-Message-State: AFq9FYIlIR6uxQbNXb5r67W6UKfsCbyQTQ7pAN8ysfxyT0RREl9vP/e2
	DrjNEL7RXHCyV4F1/6ph3ROFPBbjXADxQclR5jy6BRZzQag5IGZ00FwhbeLXA3blu/o=
X-Gm-Gg: AYBFou2Yv/OqVnBCXvtrcc8pjDtrDAJLZIYeRlThU559R0c1mU2a8w8dq0EtJGPc24A
	yWcVXpqqxTpf2O6+Ra33hH8QGmX5OJDrEgK0X0L5njVA957BELgBhMbFr7PnWRlKVRvKDrsuNsJ
	YTHyYfYZ8MshGuuEeoe7I1Avh0NrhL41c62oHJZZdGCuXpe1bSZjg2C2Ib1nhm6jmI8PtUc9i1H
	8ajeqTVXt6k3EnWW+SSsBxqp9rTWZhZRWcyWb04EZlJ/VePEKwWLIPY0ByxorDpcijKJldQo/CV
	XBs59dCJfOlo5lRCqT0LRQhNBz+JiQFwa+8No2du/PlW7GbD6M+6C5sKa5GIsojDfks2dsO1FbT
	xOch5XrVCMj+jarEZtnFFhYOJpJNuX/qdrJsHBKPYd/Qe6OkBRQ35zStM2wbQLGuZKIxcK5UL/4
	jH/9U6GvgO0BhU3EtTan5cxuQypwxh7wqXTu8pK2SDGsXdYNPJ7FP61476GsYBFrne5onTTQydV
	mvM3jhGMfQRzFC981w5XxS+0IqStGo/OwPY0/W9N7xhuR0TR6nz+iFB9ELqyILIj75bMeNaRE95
	KyacbM7ddSYqODok6wMiy2TIMYTLpSAZ8990fM4=
X-Received: by 2002:a17:90b:3c12:b0:3ac:b7b9:6484 with SMTP id 98e67ed59e1d1-3ad86d57f66mr3763863a91.45.1792672862598;
        Thu, 22 Oct 2026 05:41:02 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85f4b103sm4484148a91.3.2026.10.22.05.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:41:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 asml.silence@gmail.com, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20261021184658.644645-1-kbusch@meta.com>
References: <20261021184658.644645-1-kbusch@meta.com>
Subject: Re: [PATCH 0/2] block, nvme: minor fixes to dma-buf support
Message-Id: <179267286175.3853015.14808759833206340958.b4-ty@b4>
Date: Thu, 22 Oct 2026 06:41:01 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_054104_245045_28285F9A 
X-CRM114-Status: GOOD (  10.79  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 21 Oct 2026 11:46:56 -0700, Keith Busch wrote:
> Just a couple minor fixes. I wish I could say I caught the first one
> myself, but no, I prompted an LLM to look at it.
> 
> I am assuming changing the bi_offset type to accomodate large offsets
> isn't acceptable as the bvec_iter's size appears to be packed to be
> small. I think there's a path to accepting larger offsets through
> bi_idx, but the patch proposed here is a safer quick fix.
> 
> [...]

Applied, thanks!

[1/2] block: reject dma-bufs larger than 4GiB
      commit: bcbd808652e127a704c21fa44d908eb56cbcda03
[2/2] nvme-pci: detach dma-bufs only on removal
      commit: fd13f31ac62abac4df2166bb0a6fbff53b288e0c

Best regards,
-- 
Jens Axboe




