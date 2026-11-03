Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6B6083605
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IuVSoIvB;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Jv/3SvVO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mQHIItj+qvoGznmNDSAc+oLyoddjsgyl65N2G457jxQ=; b=IuVSoIvBxJocvQ
	sKvxIVxFmm5SapKxcNU6vqjWBCLWwngsudkoSf6wvxMxzBuCkxCgZr+oTLQZ87GlaA8YpGb3Bzzol
	vggZ/gOzBS8oHGDm3gWd8FYfILKmbhu/0NP7qcmcibcVkxr75C5+SsM/ocHY/zYjRSIoTBlLpXgnr
	tZtvkrtU2vQ/gvZ9HEY0Ab6FZv/RSfSEDZ5vYVPc7HIHVQ76cYvVR4bwA19Mnxu9HmdKsdrTWrfIn
	YHj4KQIpYBWROpGo1aCtGSB8h+u3ae6reloAVoh2QXmjToOiNN8ZhwhcZk272Xe8Z86LMoSIv26R7
	8yEqTfaqbTGkKGf5cU2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFXl-00000002j2e-0PgS;
	Tue, 03 Nov 2026 14:31:21 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFXf-00000002j16-2UEp
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 14:31:20 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1ae18eb9b69so3126869c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 06:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716274; x=1794321074; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQHIItj+qvoGznmNDSAc+oLyoddjsgyl65N2G457jxQ=;
        b=Jv/3SvVOWiKI3/FHvFW5EdMV+q2aX7Elp2yWT8PGtRi4LCxJbybdRwRjj8n2u31BwT
         N2F5c94DntvSIPhO29ZMD1fhd1tRhKToUjPw+XBoDYjQHG7lx4ZsbQd9SbiIFoQUTCLY
         WbDOneRXcpn4ezTXjSXZ3Pb6ATCaMxlYHhpZaFIlWE2vbwPw2UPEG0atU47myPL9HJ8i
         vATn1PcnnfU8DtHaZsZqNdV8ZZswZkBP65tqX9g7sy+bHmBowO2NWBJJ0Z17Jst0LmMv
         L36N/xwcU1vcTQcDKNShZD0JVT/rVfvjkuXJ3vbHB2fgxjlj9kSjM/5Xh+ulJ/ThYRoT
         EPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716274; x=1794321074;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQHIItj+qvoGznmNDSAc+oLyoddjsgyl65N2G457jxQ=;
        b=T26PgJcV1fnFIYGPR987qIFW3PhclYoUToC8980fxbAP80qE9BVyHDSczr2CoXorMg
         KPVeyFK7Aiy1QmWCnTSqC4IQvPGEokn4tUhOA3YLVeZn3c7+x0KIQNsF4pgG4SIdbYNK
         UXxZSW5MjMSwYrKiwQimLd+DFqphjp5vu1j9/qCWcd1WyqCWrJPfpWyn3dZbu9MXHFsp
         W1qJJmSHMeuiwf2VvfZYazb1rg+BBjXlHZiPRPEUJsSy2kfJC6D6P9QpVM5zb1/Cktyx
         vsa8maIae6x2O8MLImpJMZ4wXUmXsd0RlRXAUQhKa2PBDEUgdQV3D60i6WKLSmro/lwN
         XG/Q==
X-Forwarded-Encrypted: i=1; AKwUvBynMGoRevg9K/BazRk6feQHJ+Ve3E99g5rltFT9OSxs7RAaNiaSXOozSe4227U7Yw3E/FxNAuu3UAD3@lists.infradead.org
X-Gm-Message-State: APuU4Z+3JcNR5WDkTpR8SOd2ms4uXq5nezGePDNsSdY1EPtkAumUp29+
	NVZrGLjlsefdBWEFER+5IkthIR/oWdslWMtysuQ7TInwvg8E0QfFTSbbteO1Rm42LPo=
X-Gm-Gg: AYBFou3kBtsyHJxrh6Nkw2W3jSli3e2Pl/XMPEgsl8Nc85ea425Jpho5nDw1GIW6+59
	6TaRsR19mnvEJrLMP5ER0ho+eRt/JtE0pV/ifBLIxkfFYTmdSwyVrmw/Y4U/MWM/oSNMTPHGGaI
	MM8NN3Q6r2VUbxOVeH6XwvqoQ5ji/RDf2jbpuOxEkmjyRfCTM2luc52TSVfb2qsQ/wXNcLHqdrY
	vXXcZ6eXBvsZ+FBXiMvf4CzFbXKwha5XQS/cwv4Iw6JE/QFh+k5ZB3Se+SqvwFK4TfMv1FIbYvC
	qny7TkPZHWU8bh1DI7ntLQM2+ayKtO9F+VzX1mEdOGUeC7LF9eooJ9PGSpYYa7e1KM9BhatD+Mx
	70RPk0VBHi7Ozquc6X4uoIaDbKZWb8PE+2ItnBFdruP2UmxyJRpJ8Blh55aMCj8uku9DDdJj34Z
	p2t2cuOOucd1h/7mU1SaSbh9hnAQANiVngECYeJvX2lBtbi3AacSKm+9pZp0o36e+Dw6uXpXzky
	nsKprPq0QzSbmedUK3LYj7Pv4KWdVbObsa5LHa+1rBnQbGYSLUAMNuTgfGMbO6s/4Z/8F364S0L
	zamxadYrDK+FA9OVQRcRm3xoMBLU7xwKZGKJ9FSN5jUI+kyesnd/gUzLoSEbwYrpSlJHZ+DbH3Y
	5V83GPUGCzlL9
X-Received: by 2002:a05:7022:3a03:b0:152:9e88:daaa with SMTP id a92af1059eb24-1ac5f181628mr22731309c88.36.1793716273870;
        Tue, 03 Nov 2026 06:31:13 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, Kyle Bader <kbader@redhat.com>
Cc: Kyle Bader <kbader@ibm.com>, Anuj Gupta <anuj20.g@samsung.com>, 
 Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>, Tushar Gohad <tushar.gohad@intel.com>, 
 linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Martin K. Petersen" <mkp@kernel.org>
In-Reply-To: <20261029155821.2983229-1-kbader@redhat.com>
References: <20261029155821.2983229-1-kbader@redhat.com>
Subject: Re: [PATCH v2] block: only fail dma-buf bios that need block layer
 PI
Message-Id: <179371627250.3691261.14418388073265426531.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:12 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_063115_640308_2ACF0721 
X-CRM114-Status: GOOD (  10.98  )
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
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 29 Oct 2026 15:58:21 +0000, Kyle Bader wrote:
> All dma-buf (P2P) I/O to a device with integrity data is rejected
> today, at registration and in blk_mq_submit_bio(). Only a bio for which
> the block layer generates or verifies PI needs that. The block layer
> then walks the bio_vecs, and a dma-buf bio has none.
> 
> Reject only those bios, and remove the check at registration. Then a
> submitter that attaches its own PI, for example with
> IORING_RW_ATTR_FLAG_PI, can do dma-buf I/O to such a device.
> 
> [...]

Applied, thanks!

[1/1] block: only fail dma-buf bios that need block layer PI
      commit: d734b6433b2fd248bc25a2ea1fa60c34b40ba15c

Best regards,
-- 
Jens Axboe




