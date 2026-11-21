Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA518606A320
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=h1VJTgsD;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F0o7haJQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=frozdrDM24Ydlq+8LMNupUA76B/2Yy0U0uY6WHToTZ8=; b=h1VJTgsDFxpK4i
	BTnN/9cvzLkmCDE9ZOVkUoWUd6UwwcouLsAXbJbwJuUBf8LeHnsjZMBn2L6lAqF42Z8OBAsLdYTrF
	1DbnQM38FkrVwl9k2T8fUXWELsc37tCxmOjvJZJ3ZBjFSU+b81af31dfpSfvtL2Vt8vDZwZgoWkPc
	S5jn89ake4FKHmPjtXdJYFBaUwIWRXoPOi1+HrDfVLThNB9TGQ9m2BYI2eQNGEB7tsJ8iAHqY62+D
	p8clWz9ZN36S1oOc4lNGT92thoHDvuboTiDaSpjuZu9gdNLLtK14t877nbqo84iM3urtu7qfalcDI
	e+RqTizW1u0H5+LJyLGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUrzM-00000000GfT-2aXl;
	Sat, 21 Nov 2026 20:47:12 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUrzK-00000000GeY-1mzc
	for linux-nvme@lists.infradead.org;
	Sat, 21 Nov 2026 20:47:11 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-4a358881793so1022747f8f.0
        for <linux-nvme@lists.infradead.org>; Sat, 21 Nov 2026 12:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795294028; x=1795898828; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=frozdrDM24Ydlq+8LMNupUA76B/2Yy0U0uY6WHToTZ8=;
        b=F0o7haJQntkSLkknfqTMQrrCfxwmXd07VKaU/BRNgLWiMJ+sS6N2spykTzrX3n6hwu
         X7r28WiFlPjIHDlBt+jCuVcv6aF8nhR9PSQ/RAe9lmuDZIidKNF3kbBJLaDSQx6F+IBG
         E7jptAvgT82+MsO03Q8j4xY7/E5prJhuvp2MST3/YKcVua0Wm+GrfHf2wA+c5VVNLs/5
         zNHBQu+3LRG8KTVsO5FfDKBJFn9FPDXp0emlDrq1k/Hb6YE1grdSRiCMce3e5DEBxy7Y
         frrzKFZZgcKzFJmyvK0/1fZkjQ90I6hY9TtA0nfWG0G6znIGAsY7j3qAfvUwoTiVW7iF
         wAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795294028; x=1795898828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=frozdrDM24Ydlq+8LMNupUA76B/2Yy0U0uY6WHToTZ8=;
        b=eXUceWrIOrcGyycSfODiAmsG3l/UTGsh3b9P334ZL9pez2Ll9e1OIDjV03J80yXgbA
         gKlp8kU+EZb91cdgUoZDkOmSZuftTBqvw/Lnu5D615gKqew6pp0ROHe4/5U4co33zIoL
         HD/l8kVHEUnR+XGLPH3eZRe7hXVOJHr1s/CE4ZbTVM2lym61NcN8KV2gqsfiNP0KdcXj
         hVd7hjp+7nNpoapvVwbEFmJOOt2cjdXHR6BhbwJE4pXmvxEEqwYpD+f0PVLabaVEmdm6
         cdrKtP7v4oN0m7NY0NtuerfarUD2RVJN55OPA3yA3BPXX8Kx8kt8j35g4AdRD3outWRC
         1G3w==
X-Gm-Message-State: APuU4Z9VVt4Tkx4aElv2GMWn8TZQ3QLSYJMMT2t/TEgp96VNTRfafirN
	eee9IN6mvgCTMbLW4txJFYYRPi4efnVy8BeBxz4lCiuWe0TXYoKK3HDbSU1MToiuI6s=
X-Gm-Gg: AZFdTZe1PFaVSyljquSPMFqA/wEPYMm0XTf0YrXUh/WqFUedrSCMzw9lANmwWW3oT5S
	+aAN/219X9b5G+fMGvdB+3AVbbbw17Mlz0KaABLZuEAX4TqTkSW06UAsvBylfjc680fxor6S7lj
	hujn/jYPOc+M78OWDYMdpZheJVrGAq/+gEbAk5JEFhsCdE2dcIlf4L274fdPjw/Mnv6VXuub2ww
	GJ5wvvL5q6gbU9H2inQxUJit+HghaVuACiAmMkX8XCk6Fe/0QZr7jve7+M7PwCeJt+mgbayhlup
	2ROe9QEP88nPo+1i/kLKiN71Amb7z7OnZkALbwiPx7iLjIUVEmeLnJh7C1Ize7WmUuNzWxItPAS
	2guARHJjS3giG8UTDRQEQScG+nD+FRpPIeSBGxyo4wl8/567g/o7MfUR1RD8zmxXdtYewV9GKry
	zpdbNn7uv+4oUxdfz6vjNsYhYCKvtXDd5sLmN2YgGm8JBPRW8VUFQa7MB9k2m7irE1/hb6l5qQP
	U0EuvHXktIsYB7f41E0keHh+ic/JGGLFWb/lr0E2jqvVG9pa+aMd/acbd2bWQg5RzzRoXN0p/t6
	TkRV4AuFPfbBMxHxVhS4roZy9vARPUpAhHgHe9LfVXhDc6yCy4R90OoC8KWt2VncocXPUsMBfkr
	FvEA1T8CVqoMTlrLT25zYOeCqxMJjOAwN+Tka+smK2KQrSHN3ZNGQ
X-Received: by 2002:a5d:6f13:0:b0:4a7:a7d2:eb45 with SMTP id ffacd0b85a97d-4abb6d04777mr12653198f8f.44.1795294027900;
        Sat, 21 Nov 2026 12:47:07 -0800 (PST)
Received: from Omar-Alzand-Manjaro.dlinkrouter.local ([169.224.8.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm11703985f8f.18.2026.11.21.12.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:47:06 -0800 (PST)
From: Omar Alzand <omaribrahimfadel@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bean Huo <beanhuo@micron.com>
Subject: [PATCH RESEND] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for Micron 2200
Date: Sat, 21 Nov 2026 23:46:52 +0300
Message-ID: <20261121204652.16374-1-omaribrahimfadel@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CALJMncxA-=OFc05Ht74hWnia8-sCd5yLn5hK+KfnoHMO_sbzSQ@mail.gmail.com>
References: <CALJMncxA-=OFc05Ht74hWnia8-sCd5yLn5hK+KfnoHMO_sbzSQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261121_124710_481136_569019D2 
X-CRM114-Status: GOOD (  13.26  )
X-Spam-Score: -1.1 (-)
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Micron 2200 (1344:5410) corrupts the last page of reads of exactly
33 pages (132 KiB).  Such a read uses a 32-entry PRP list, which exactly
fills a 256-byte small-pool descriptor, and the final page is dropped
while the read still returns success.  On btrfs this appears as
intermittent "csum failed" read errors that succeed on retry.

A raw-device test (eight O_DIRECT readers of N pages into a 0xAA-filled
buffer, plus mixed-size background load) isolates it to 33-page reads:

  pages   reads    bad pages
     32   23515    0
     33   17715    1001   (all at page 33, ~5.65%)
     34   13735    0

Booting with nvme.quirks=1344:5410:dmapool_align_512 eliminates it
(133280 reads at 33 pages, 0 bad) and clears the btrfs checksum errors.
Splitting the read via max_sectors_kb=128 also avoids it; writes are
unaffected.  This is the same quirk the Micron 4100AT needed.

Verified through the nvme.quirks module parameter on a single 2200V
(Micron_2200V_MTFDHBA512TCK, firmware P1MA0V4); this adds the equivalent
id_table entry.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Omar Alzand <omaribrahimfadel@gmail.com>
---
Resent inline as Christoph asked; the 7 Nov copy was only an attachment.
No changes.  Bean noted the quirk has no functional downside and had no
objection to the 1344:5410 entry.  Applies to v7.4-rc3; checkpatch clean.

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 076603df0..2b718cfd7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4416,6 +4416,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	 { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
+	{ PCI_DEVICE(0x1344, 0x5410),	/* Micron 2200 */
+		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	 { PCI_DEVICE(0x1344, 0x6001),   /* Micron Nitro NVMe */
 		 .driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1344, 0x6004),	/* Micron 4100AT */
-- 
2.56.0


