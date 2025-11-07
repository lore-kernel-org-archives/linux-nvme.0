Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8775CCFA13
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Nov 2025 01:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QWqJnsp4EvW5NsB0ZoZZ38wCK4yHD8qklQbwS0U9mKY=; b=ct1+xmjxHExx7pm2BKtuAKE9eJ
	Xgh4K47io4wIIbDBEtfwIGwtIOVwW0UuiHC7KwR60i+MCRjpaa9aHXEpgIO8hHSgqLGNy9UXGhjup
	yfMEaRM2QsSWp2IkQo3UMYr3jfS/BsgDlXiXYWseCBnZHMtOwf0f8IlaQ5XoR1aE/JFdoumliOGlK
	FltAaNJPn9EyInLMF5YvpehMaUlFTAvpBfSO9mJV/gQkhR9Gotg1zVmvS0rY1R63R+iszgyp3BmvS
	HcQF4IOOk2JVpN++RVvORYyL/mymXyCH7Oc7V2eNiCmAr76X6E7K3jK+fmkVEzTNA7uirPopvs0m6
	s3UJZadA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHB27-0000000GUT1-1ESE;
	Fri, 07 Nov 2025 01:12:55 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHB24-0000000GURV-1CmN
	for linux-nvme@lists.infradead.org;
	Fri, 07 Nov 2025 01:12:53 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4eba6e28d06so1208341cf.2
        for <linux-nvme@lists.infradead.org>; Thu, 06 Nov 2025 17:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762477971; x=1763082771; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWqJnsp4EvW5NsB0ZoZZ38wCK4yHD8qklQbwS0U9mKY=;
        b=wSpwD/fowAloJd0dYIjb7/C5DWpgIVSIjJ0sL1cByFS4iDJwVqaHYXSuf64vP/ZaUu
         GuY7huqql5VlgJfOhntrqRicJj/7/FXawCYzoqw2Hsb+m3NYypHI40hYQ/mebm2O9B5e
         FiIKZXZvFM6rGkPX7PT+6Gm8gW6J7MlK0erERfcfJIsdg+iAG+7qzPKWJYiWiV0952lz
         4yR2UXymYEReRGz8/ng3WVXmIIExL7k7d5l91j2R1ftOPRUdXvQxU/+LZxu1YqDOW3/j
         imxGhg4Hw2rAIVOHXKNvwGCZtPQ8x4INb8OP8xXlYoR9+KdarNDu4dBrdFhlosUE3TRQ
         cPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477971; x=1763082771;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QWqJnsp4EvW5NsB0ZoZZ38wCK4yHD8qklQbwS0U9mKY=;
        b=FAFDF5dHy2GHoJKAXSqt8DjLO+07iEBYHd6Qn1qBmB7u/GcikRoOp1u4NA4HDBeN4M
         60cjL9VZmhgcGLrViPquMRNCgdqb22iiBJ8FS2rIiKdwbEVtvjr4XTFgb4NmydmWLB4k
         YjbQ5vFdRrJNCEOPN3lnOx/LirmHVF9Kc+/5rU51ookx/HX/uQFq0abE2pG/eXXKxXfl
         mQIJSdmhESdA8Xhld3KRD+QfYHC8etFtdW8X8gSyrRmPbPG6dz7A6XJe8/NmUaJ0Sxu1
         5/8QJVqZcQ2qTtyYB/LU6LZWskAB9+dB/Y7NVBb07CwO9VBUn8Jqnu9M5TfDhq/qjcFg
         QFnA==
X-Forwarded-Encrypted: i=1; AJvYcCV99F1AfUPlcqOntJXydqewRPbsJx5jnzPfS4ew6uT5PiKppa69VugTmTXogSL8ukuv7gtDIEoBmSUa@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8n7KCHR37Jkqkg8BAal0AKLxSNgJTcSD4rL3wODpxEbzElva2
	FUBdKwF1wti4wGh7qPxmO36VHpbP5xLZziaam015DCCtdwuNjM2FaUs1Rn2g8zCn9c8=
X-Gm-Gg: ASbGncstBjwRbIGGkHZuVhlPNU50Ag//HQeQH7+LpyY/WrTzAEK5CVHLzMkcJzwszBw
	iztndYlmFvVE250QehRAQ8iW6dQPaJKGf9/eLRHvbQ54zTY0a1Ky1T8jbskdZfiVt8RLDMufmok
	d/MSU6Q2eEa0GacXn/GDHXAT8nuahq2NsxcKHu02k1Fb2UzNPeiAIc/5ZwF8/XhBHVzSKEmo5fP
	yDkbZYDKBdI4Vu81QfNPYPXIh3a57vvASMYhJ8N2PCAzeXq9y1d6rCP7wBolceKvS3jixQyA947
	jOVCth9HQq634KW3SFlKA0aYL67mS3HsbCQsWflHuHJYYcyRZ0B9eW4POHVZOIuLGzNi2R0kKuc
	ZxOHE+aEWSe3SYYWOOcz91iLUO6ZR6kHAykC6gC/soBgyehssfb8sIxzioRZP8dQJ56zXFYE=
X-Google-Smtp-Source: AGHT+IGNXhFRusyfcqPZnRs/xowsTaaRiEB+Y3/HUpSQ552W130CtgBm5ZhdeFImdQj8FqUNsa7yqQ==
X-Received: by 2002:ac8:5704:0:b0:4e2:e58a:57e1 with SMTP id d75a77b69052e-4ed94988f21mr16234581cf.37.1762477971052;
        Thu, 06 Nov 2025 17:12:51 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed813b79cesm27827041cf.23.2025.11.06.17.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:12:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>
In-Reply-To: <20251014150456.2219261-1-kbusch@meta.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
Subject: Re: [PATCHv5 0/2] block, nvme: removing virtual boundary mask
 reliance
Message-Id: <176247796912.15650.4766342820181408947.b4-ty@kernel.dk>
Date: Thu, 06 Nov 2025 18:12:49 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_171252_332457_3637E914 
X-CRM114-Status: UNSURE (   6.48  )
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


On Tue, 14 Oct 2025 08:04:54 -0700, Keith Busch wrote:
> Previous version here:
> 
>   https://lore.kernel.org/linux-block/20251007175245.3898972-1-kbusch@meta.com/
> 
> The purpose is to allow optimization decisions to happen per IO, and
> flexibility to utilize unaligned buffers for hardware that supports it.
> 
> [...]

Applied, thanks!

[1/2] block: accumulate memory segment gaps per bio
      commit: 2f6b2565d43cdb5087cac23d530cca84aa3d897e
[2/2] nvme: remove virtual boundary for sgl capable devices
      commit: bc840b21a25a50f00e2b240329c09281506df387

Best regards,
-- 
Jens Axboe




