Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A7BD65C7E
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 12:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7UOuG5Zwz3TO8LLif2nDNcChNKIJvAuTVAxlwC2o73I=; b=45D9mGVrwgiqLSW2rEfoGEo9qR
	s80D47NVLG0Mco/qpy8awO03VOtVYC05RNETho1mdB/mHAYE0fRrygWDG+qhVt7nSkh2V96TMlSAe
	3ydmCPMxknAGBhPxL4iDOxeqj4MQ7a/lI+4iGS721O4LvijmFpPW26JkamuFVFd6J63GjF3I5vl4O
	GXa6zrVmiZeGs6wf2V+XkfouiwkSctoNWjCglMmxkTyUDiXc4iECJcALzTh3DjwYZL1u1sEoupBKP
	rkdRF7zOlnIa6LygbAaLd4OTWTwwY4OxlpwRRF4O+2Tmj7a0KXRfocwdpyh6edDG3kyQDmYWZwuVJ
	QKyMv8sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYWs-00000009paK-2XFa;
	Thu, 14 Nov 2024 12:00:54 +0000
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYAq-00000009kvb-0Riw
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 11:38:09 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-43151e4ef43so4083715e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 03:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731584285; x=1732189085; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UOuG5Zwz3TO8LLif2nDNcChNKIJvAuTVAxlwC2o73I=;
        b=pB+ey/lIj5zcH+yDXLllBa6idUqPCNZoNuoVC8hajHrqqJ7kSE/e8QvFDBW7gsWEtI
         WowmEGo3z9+LzaV/nMrdyelBQ4GQ1YBhEa/4ikQJzini60JvN0cA+XPAFwgAgcnDrc/n
         qZSfilrv+x+VxKlUQy/7S6iYEGZpfO6EQ1mqhEBIZA+Et3mouqTX8H65EHisBAov017e
         yQRVcLZFiZh9w390MJdGAajZiKeKNqeMpVzUPn9z2mrfiVWvXac8LE5/1HRDOCl6bpRN
         VH4XO73ueMk6APuvylX15XkXZqEya3xwP9/XoSN31Id2HAU0oi9Z3yYNyeTMV1b1it9t
         PyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731584285; x=1732189085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UOuG5Zwz3TO8LLif2nDNcChNKIJvAuTVAxlwC2o73I=;
        b=YM1IqdilFDm929us2c0/AspEsjzuRJ15ObLnExc8a5p0nOnXl2sssqp82yS7RxuLN3
         v7bDo/8nLALfHU+REZ/FF9+rYl6YpnX05KfBEKpmVJFsNmVBc1G2GzT88JMifWeMDu5+
         WtJD3OYVytr5vrNKASxZTMqOAM0cwOrsDVZ1BGpmZ6aMlCZ5I0MwfWv/ub5DJHbhdt3J
         gPk+9miyKJco0k/W5fLo0f0FKNNn5b1d5RNKusfHNr1WxDaV9RWdPUS4GWYi9XhmIdKl
         WKi6VLc2Bq9OvQnKk3s9wQS9JxN91sW5+/g87TYGNFeipIf44p4Y0xWzm+4x6/M9N3I2
         7Xrw==
X-Forwarded-Encrypted: i=1; AJvYcCWiQsZkQj5EnkVb6y7m4OquelIG7uirnXb0p6JjuQz44MXXJiFGV3I6cWiGv0F3zVlvhjRG42Opm5sO@lists.infradead.org
X-Gm-Message-State: AOJu0Yxvlx4Oben1uQBaYVldtvG9cUHinRViHTBgC0s+DL2ULl13BWb6
	RGS1iOcMmzlQYEWI9WWZtqjOlFoNlEBJlNSwpITimVOfdT7UvW7pgXQ+t7zGnY4q4SeG3a5H9mj
	+XiA5BeQu5g==
X-Google-Smtp-Source: AGHT+IFFuS3vadEpxbm9rE3t6WRaBQwyUrb+92pbfldDrubUMoJSwgzEUU8T5UR1u6/5/h9itok/LJf9zGPJ7w==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:600c:3ca0:b0:430:57f2:5b0c with SMTP
 id 5b1f17b1804b1-432d4a98b02mr347995e9.2.1731584285504; Thu, 14 Nov 2024
 03:38:05 -0800 (PST)
Date: Thu, 14 Nov 2024 11:38:03 +0000
In-Reply-To: <20241112195053.3939762-1-bob.beckett@collabora.com>
Mime-Version: 1.0
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241114113803.3571128-1-panikiel@google.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: bob.beckett@collabora.com
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_033808_193718_CFC435CA 
X-CRM114-Status: GOOD (  15.78  )
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

Hi all,

I've been tracking down an issue that seems to be related (identical?) to
this one, and I would like to propose a different fix.

I have a device with the aforementioned NVMe-eMMC bridge, and I was
experiencing nvme read timeouts after updating the kernel from 5.15 to
6.6. Doing a kernel bisect, I arrived at the same dma pool commit as
Robert in the original thread.

After trying out some changes in the nvme-pci driver, I came up with the
same fix as in this thread: change the alignment of the small pool to
512. However, I wanted to get a deeper understanding of what's going on.

After a lot of analysis, I found out why the nvme timeouts were happening:
The bridge incorrectly implements PRP list chaining.

When doing a read of exactly 264 sectors, and allocating a PRP list with
offset 0xf00, the last PRP entry in that list lies right before a page
boundary.  The bridge incorrectly (?) assumes that it's a pointer to a
chained PRP list, tries to do a DMA to address 0x0, gets a bus error,
and crashes.

When doing a write of 264 sectors with PRP list offset of 0xf00,
the bridge treats data as a pointer, and writes incorrect data to
the drive. This might be why Robert is experiencing fs corruption.

So if my findings are right, the correct quirk would be "don't make PRP
lists ending on a page boundary".

Changing the small dma pool alignment to 512 happens to fix the issue
because it never allocates a PRP list with offset 0xf00. Theoretically,
the issue could still happen with the page pool, but this bridge has
a max transfer size of 64 pages, which is not enough to fill an entire
page-sized PRP list.

Robert, could you check that the fs corruption happens only after
transfers of size 257-264 and PRP list offset of 0xf00? This would
confirm my theory.

