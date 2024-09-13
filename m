Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492A0FC6171
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mrB+Hmxb4QK/8HwYBDkHB2XlWD05YJZL1QKZ9ghv1bE=; b=hI7S8/C3Wx+mgrwWJNCsUl0Y0v
	fpqH+yt9UD1Q+URNdxotsj/DgcWcko0GhdkUVQDrY3PhgH4bszNCeRRrKeg0/Uw+4V8DCU/1lCao/
	9wC3HS9RQrdoFB2knDed2PTTmYzBwlCSFWNTogrAjw1O6b6S/KvkBTT5+ZO5S31AEGcbfXDHfm6Xo
	wuNsyN9edSVavkThtVcAakpc4+ozCYF6z+cjVDxmdVU3mkPAzmXttu4kel6PEL1TZQzv2OPiOWh/n
	2ktPJZHn62DIgatVvKysT6yUCnMn/8asHdq54YIMdp5+GtET7/GgFfZhujS8ESo3wPnrXwG4AJE7o
	pfoD+OWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spBB9-0000000Gpgf-1UMO;
	Fri, 13 Sep 2024 18:37:59 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spBB6-0000000GpfU-22Ra
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 18:37:58 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso971065a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726252675; x=1726857475; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrB+Hmxb4QK/8HwYBDkHB2XlWD05YJZL1QKZ9ghv1bE=;
        b=tnnEDBKuX96Kkg34YurtbUE6nz2Qo7klQ9/Mu0ncqhXq3E10NoXUsJA541mOf/+KwX
         Se1rBP6GRI6D9V6CtretCz2uoaxCYz24U1nlea3RBwuo4yDAr5BrDIZ1xCSBT79um84I
         kOFkdKNZ5X/doz4TB6+WzlCHc8omnLHuliLuJIfSnUsYB0B0ei78sMevy1dWvKDUrewi
         GjDcD987kxxQYQbC8KxEWW9CR+L+TWpGFHf8piCX6dcG5x6mjJNCSG+6C/opOA6t1IuP
         Dd296V+xxhwZ6QF3oHnDxlCi4jpjgTvXj0yTeusbPpkj1zjLH2Pdvjo9ps/YsezfcxMR
         frBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726252675; x=1726857475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrB+Hmxb4QK/8HwYBDkHB2XlWD05YJZL1QKZ9ghv1bE=;
        b=jIWhcZRSVquRId6+06dNur6Bb2/B2SSSLFX+VX5YNOCkDopXdc4fV7UYZT6gnJ8G6Q
         Yaxx4WjJG0lyFYlqtDrjNgkJtZhcu5q49vCZwdP8FqGoOLbcIHhAxFOUiJ41hN98V6WV
         TEA1xsQAMfYMrE/7YXupRjYA1FRv4njkcAe/VOie4450FG4YMTbQrLx1cfmKTNVNElFw
         3RihnmSgyfC36IIMYqrpWcDNuINe834ydZzLR4fbU8VXOHeugCYIUNsj5Q+PKdJd8yAO
         rsq276xQKh+n0wmu+XORHp7kZnNi4Bo20UU31aGNtBH4eYVKUaSmu7+vtMMlqQCAdXBK
         fZug==
X-Forwarded-Encrypted: i=1; AJvYcCVO3QZNo0zOAPaWkqYcbfipVspaNiOkCSjjtWBipUi+Meb1a43MXoUzTCZxoOyXYiTsA46ybUUNooIl@lists.infradead.org
X-Gm-Message-State: AOJu0Yxn/gIUhLgfIIErISLVpu7ElwdVsvVaDOoUqcns9XPFDGXq+rTZ
	idflJ/8w21aZX9I3PQ8evqXdUCCSn8nzJ6Z9F3A2eFBUXByWz9wrSk4Ia6Rop2trargocmsl4QP
	G
X-Google-Smtp-Source: AGHT+IGe+5/MHKnKQqg9KZuy2B2Mce1EGZNmzHsE22Siu2vIa7Q6z+h4KwKtvGrKJiIR8wXMxfcUiQ==
X-Received: by 2002:a17:90a:fd81:b0:2d8:ad96:6ef4 with SMTP id 98e67ed59e1d1-2dbb9ee0f71mr5231548a91.28.1726252674647;
        Fri, 13 Sep 2024 11:37:54 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9caafb9sm2144057a91.24.2024.09.13.11.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 11:37:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 Keith Busch <kbusch@meta.com>
Cc: sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20240913182854.2445457-1-kbusch@meta.com>
References: <20240913182854.2445457-1-kbusch@meta.com>
Subject: Re: [PATCHv5 0/9] block integrity merging and counting
Message-Id: <172625267354.693477.10856158382526407856.b4-ty@kernel.dk>
Date: Fri, 13 Sep 2024 12:37:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_113756_828216_CD7E2D10 
X-CRM114-Status: UNSURE (   7.56  )
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


On Fri, 13 Sep 2024 11:28:45 -0700, Keith Busch wrote:
> Some fixes and cleanups to counting integrity segments when metadata is
> used. This addresses merging issues when integrity data is present.
> 
> Changes from v3:
> 
>   Dropped the trivial nr_integerity_segments helper
> 
> [...]

Applied, thanks!

[1/9] blk-mq: unconditional nr_integrity_segments
      commit: 2b018086143d638de8d67ae5be6e8c1afb413193
[2/9] blk-mq: set the nr_integrity_segments from bio
      commit: 9c297eced59817f461be33e4c241820c5be4bcc1
[3/9] blk-integrity: properly account for segments
      commit: d148d7503456556859c7e4d354115215d8fb5016
[4/9] blk-integrity: consider entire bio list for merging
      commit: 0d7cb52fe417dde4bc9e8d01fadd8c0ec69612cd
[5/9] block: provide a request helper for user integrity segments
      commit: d2c5b1faccd5ef6352456f817e941945d3b3fe62
[6/9] scsi: use request to get integrity segments
      commit: 27c3785e94f003c664d9d867fbd62d1494546876
[7/9] nvme-rdma: use request to get integrity segments
      commit: f4330766bc0d14b5eb9459e616060d697e7b128e
[8/9] block: unexport blk_rq_count_integrity_sg
      commit: db5197b554fcb8fde0182af65e8e94bec414e342
[9/9] blk-integrity: improved sg segment mapping
      commit: b712a8c0be4d50cbeffe24b9af96921f28b6f939

Best regards,
-- 
Jens Axboe




