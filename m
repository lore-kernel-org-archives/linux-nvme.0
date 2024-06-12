Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B749C27C77
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 17:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hksk4wAbIz8bSZzaWxnZT/zZszVoyi90hMirDssVrE4=; b=uF5bYihxaRguxpQYXMff4mizBf
	5pmcG16OexnRPvij6pjGsTKSj7HiY2a4K5C9JLcbENNPjgpIt1/j2g5Zf6S/xl1P9RZvOej+YGENl
	vazblQpzcyVt7c281ro0hmQ050EQ0H7/PBcLXiz7sTBaRjOy/Lj+ZN5ISb079jvGmY3K7Dv+baED2
	dgnj/EFH+m4QFyGjqUeFIxHLqS9toU6gJg9mEjcY9cgoIedS/Bfgk6CivlK/Fr2P0TWsouwjs+0Ja
	TvrGQYWW4wBBhKcu90R3DTLyewp0lRTlKARCz5G9K9/0RNABZn5iZ3nGX1GLG+jz7cwV89SZcCMXu
	MeSQtBwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHRLZ-0000000DTTq-2Wes;
	Wed, 12 Jun 2024 17:01:17 +0000
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHRLV-0000000DTRh-09VJ
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 17:01:15 +0000
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5bae827df63so7725eaf.3
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jun 2024 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718211669; x=1718816469; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hksk4wAbIz8bSZzaWxnZT/zZszVoyi90hMirDssVrE4=;
        b=nuT1bT1zVMKudEI1r6D98VV2WIlzRWmkNlaAjchjmj4qT36dXn9c5jQZ85Z0Ipm2Od
         B9YWHaRPzOjRB9f3FohEMlEBX1zsp8ctgz8e9BqPWni1ZewsXaQ8jK7ZaPa7hb6NHBpG
         v0bBPOqTlzfeT535vA1f9qiE+Yvs7BP3dIfaTOStvlHLiYF8lMrNb7iolVhzeGFe7chQ
         SNamnbk5l6w0Xt8kd1TOVgNUENOlHvHW1HLnCvfzfBk1wrJjouQKefa3ewXBM4LSThGe
         QpiZFMYW2jJO2vKUAULclptKT2c70YTD77Dzf0k4n6DOCUYbFRPjk2A2LabdVIxmbVrn
         HW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211669; x=1718816469;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hksk4wAbIz8bSZzaWxnZT/zZszVoyi90hMirDssVrE4=;
        b=oUCIK8PTg/4JYk3VzCGDJsGjSiFq9mlZHhBenUHq5XlhoaG/TBYTUhnQJ92YVHn1hx
         jbuW9BxUQ/5SF0VqOu2MdeaDJYK2fdptwNZaA1Yq5Dr34UZxfzffV64YJHY/zJKUfOFr
         H3t+pHwtV5kiOf7zL/e3uSkjaR91yr7wWO2fGuP7/jAp9deFP/U/daRvohlWAr6nVpnc
         oFHeFrspyp2y06NBFWhHe0vU5zXIj2Mnxx8uLoQwaBwQGwiyG5oZss/7sG5x0zdTsKbO
         1eByCyWy+PVfy1RF4RZr/UhtnzC+dnY0iDt+M59nAnpEDCJkf4sQy8eqpBzXV9qE1rig
         o64g==
X-Gm-Message-State: AOJu0YwVlfuj4UmwWNPxwBiXEVoBMNasUym2KUrJMxvGROJfrz0/VrxU
	+Q+AgoASlv0qxM0yEbAGh8EpA4lbEe9A5jkqFCqrgax/wFAWQZWhWIb4gGS7qaE=
X-Google-Smtp-Source: AGHT+IEShVwbkX8uANOzA7Y6++m3AdDkF7i2edh/ZcjLmOq4mCjGmcRKppMnpDEeIrhOSy7IAhNZyw==
X-Received: by 2002:a4a:a5ca:0:b0:5ba:e11d:a2ae with SMTP id 006d021491bc7-5bb3b9f4ef7mr2474760eaf.1.1718211667997;
        Wed, 12 Jun 2024 10:01:07 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba977e03d5sm2464036eaf.22.2024.06.12.10.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 10:01:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240610111144.14647-1-anuj20.g@samsung.com>
References: <CGME20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7@epcas5p1.samsung.com>
 <20240610111144.14647-1-anuj20.g@samsung.com>
Subject: Re: [PATCH v3] block: unmap and free user mapped integrity via
 submitter
Message-Id: <171821166696.49890.9778377661533135590.b4-ty@kernel.dk>
Date: Wed, 12 Jun 2024 11:01:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_100113_108417_423BED5A 
X-CRM114-Status: UNSURE (   8.35  )
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


On Mon, 10 Jun 2024 16:41:44 +0530, Anuj Gupta wrote:
> The user mapped intergity is copied back and unpinned by
> bio_integrity_free which is a low-level routine. Do it via the submitter
> rather than doing it in the low-level block layer code, to split the
> submitter side from the consumer side of the bio.
> 
> 

Applied, thanks!

[1/1] block: unmap and free user mapped integrity via submitter
      commit: e038ee6189842e9662d2fc59d09dbcf48350cf99

Best regards,
-- 
Jens Axboe




