Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256E0CAC582
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Sep 2025 18:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=azaY819Deh5pUbCRAwMj+JkZb7rn9xmL1tkkd8jfW24=; b=y6+qvf4FluNKDPeLTv0B1PG/Z/
	WtbrVx1Y0y7W7LI1KMM02oFTABHrv+RqYB3w+SkuSlvzIA72xVuyW+UOnXFloPKIYg1kaNA2WQTQ4
	4H+kXnDewTsjspBxOK+mLwE7RerLOsCQECJzByb8reC4btAuZJ8ql3DgAA7C2xvUsX5PdY3k5RFAl
	5RJJ9kWxcbrrF6CbjYnNNOPsmZnvdlrz43MDQAuDt0QHpjGZqDiTJNMIdcD9DJA8l+Yx5CVs2HfdZ
	5Fc56wZ2fuCJJxfbzImuU5Nugu79wHOtBTtFTk8QieBPD8mzAXjVO4IMnfQuMTsazWdUd3+Jo29tB
	Cb7cvVJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw30c-00000009OfH-1gM0;
	Tue, 09 Sep 2025 18:24:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw30b-00000009OdQ-1MQo
	for linux-nvme@bombadil.infradead.org;
	Tue, 09 Sep 2025 18:24:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=azaY819Deh5pUbCRAwMj+JkZb7rn9xmL1tkkd8jfW24=; b=diBltklPZSn3wpDf9H+kvK6zG1
	GvLkr40BbeHPUyEVBEgSAkU6uv25rluR/Ct4TZI+aPZKUTP9LJKVrKIZT/WB5V8Q8DieC1ZX7/Tlv
	prSfweHDLPr6neAGcSFMWQwI/UTn4pZNB5W4BbFx1WDgHAiwknP7cR/eK6ZvEdiNO5tCIVso9zBCu
	i1MnKM4fgbkoYhPWSGLqL5Oak0wldIgagovwU8nmYeob2VVoT56ofKXLi0GrRA7hvcofM3sndgegv
	o/+AD9JQ6vOLSsRTqnbQk8lOB3NrknxKhH8cK4XvSAtd561i4QFD0/aj1lMQFBQ1hQZzUQ7Vre75P
	JXMZFeDQ==;
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw1Jy-00000005RCl-1qnc
	for linux-nvme@lists.infradead.org;
	Tue, 09 Sep 2025 16:35:56 +0000
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3f664c47a1cso60562785ab.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 Sep 2025 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757435752; x=1758040552; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azaY819Deh5pUbCRAwMj+JkZb7rn9xmL1tkkd8jfW24=;
        b=XYdOhYJo3/pCTeoxjyWZXc330O4/t4fWo66OXf5ryth5B8yEhnpOyGscw7x/5tJdDE
         u0zLGV/K4lO5qO20Oh/PbloKaO8o2OCU450TZgrqwfoS9t0vXVJTRwHfe9URbZ8xGL6/
         RNzuS+wykGCeY5hC+p7kl4ZE/lVs8m+7AdsM6HHWmFlIg5yD22rHBeKRRMoBUmZY1wYr
         zM9x6cnK9ESeHa2scC3yy+51MygARq3hdi0XKL5kb5Qk4UQHeAGIVY7z1R4gTI1sMHd2
         0emuMwm1EQEFgQ58pZTqGg5HLkx42TQETm1FzapGWzo5lb9RnZT3/wpk0hPjPP1XuvXY
         CFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435752; x=1758040552;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azaY819Deh5pUbCRAwMj+JkZb7rn9xmL1tkkd8jfW24=;
        b=mCC/vCMZK6ytSeEjt8ikz1fgO2HyxXYLQPiGxBtUslYRU408PsYBcfxNZqo6e+Ohm0
         un2qq63EctmPWvxcDoB6B1cEHS1PjQuKu4fmATufuJjnoK+5TpmjWB31l+zqGLuGQdNg
         Bnp2qqCh2Ix65RRn+VV8czAs1pJWxTtpPBgB2ZKbLDN7mIbILxxpxLcltRIdWsPxETkq
         MNI43rdwrs/gpdgYKtCbdcOh/nZSCDOz3f1+LSQCOTW4u6M68mAFFCZ0ZO+lBdwef4IG
         ObCRN+g7iF5S3K9qpVqm1NqRmDv2fg3/D40S+pIIi5el7ooofnuN/RxeeZqS75H6iuMH
         s5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQ1vBqaSZmRCFwEGhw64hSedKO8jEw5ZKk/ks+7MmaOmwwVjVORVlbFiM/8O8zDz1WMFxZmQJFDQG1@lists.infradead.org
X-Gm-Message-State: AOJu0Yxg6clVaHXVSDEGhAb6MuYMtE+mQib2HlXjhBjDt5uwuYxgBWku
	4yzQgOd4gIYLjiVPiKqd3wsei8QUbCcnmXlErlYygJPwXcewbqp1qDTzgcX0fYDmDjI=
X-Gm-Gg: ASbGncsEkR1JUNufY/YFSGQz+QfzchdqPRdHxgxuoOrPIUMpczEceAPJQ3uCz0GpVM4
	6zrh5qUBAfQc1nj2YcgHXXpzj7rC2FD57oxpTp/6s/KaXcLkfN0keaTyD7pSUo0PTlgBb2wwrC+
	YqqPWJ3u43aWnNAh/0BTK+IeRNzNuHTjbfzjxdcRv3OdbbjwXBvo5DHC6021AIrBr/zlzNO82Js
	7JEjx4D8tzjkiDkJhz/EUa60TUQjpm3say44+VUp7Qre0c/I8eTsq4RMCKgT5V1EZmoGJ54K7wC
	TFw3MytGKAqcd64pKemd253zK5r5gun7Lwo4M2vG2lhfqviMEKVWNgQ8iQ5Qfn63fpNgcdBwoF2
	5hUCdRkVTIs+cBg==
X-Google-Smtp-Source: AGHT+IG1zg6oATQHP0eeaq/wYWBcuVXnvSltFI3aE5ecyguQfrwrGPn0865GKjPXMogjDW+mtYZcsA==
X-Received: by 2002:a05:6e02:17cc:b0:405:b792:32dd with SMTP id e9e14a558f8ab-405b79233b5mr107028745ab.16.1757435751532;
        Tue, 09 Sep 2025 09:35:51 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31cc4esm9921243173.50.2025.09.09.09.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:35:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, martin.petersen@oracle.com, leon@kernel.org, 
 Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20250903193317.3185435-1-kbusch@meta.com>
References: <20250903193317.3185435-1-kbusch@meta.com>
Subject: Re: [PATCHv3 0/2] blk-mq-dma: p2p cleanups and integrity fixup
Message-Id: <175743575084.122061.9156524850167958252.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 10:35:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_173554_707731_193B2A28 
X-CRM114-Status: UNSURE (   9.40  )
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


On Wed, 03 Sep 2025 12:33:15 -0700, Keith Busch wrote:
> This series moves the p2p dma tracking from the caller to the block
> layer, and makes it possible to actually use p2p for metadata payloads.
> 
> v2 had a mistake when CONFIG_BLK_DEV_INTEGRITY was not enabled, and this
> update fixes that.
> 
> Keith Busch (2):
>   blk-integrity: enable p2p source and destination
>   blk-mq-dma: bring back p2p request flags
> 
> [...]

Applied, thanks!

[1/2] blk-integrity: enable p2p source and destination
      commit: 05ceea5d3ec9a1b1d6858ffd4739fdb0ed1b8eaf
[2/2] blk-mq-dma: bring back p2p request flags
      commit: d57447ffb5fadffdba920f2fb933296fb6c5ff57

Best regards,
-- 
Jens Axboe




