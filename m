Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A99CFD376
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 05:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wcvKr1ao30Z8aHb96IIMe6bHHGG9Y30itFaMOMQwwz4=; b=C/Dorf5hhek+nMyvBMjSVoRbdW
	gHOGGpsBt2et9k0d2qGhJbuEr7OWO3ei3TdYTQx68/YZ4bemLSgb47f67R8A8ozyhQk3V1DnhmRqk
	1PebtZLPO1Vs8U4J3DZTda0cf4+4VGO9P+or2q76jOlMUHrwM1Ix/Qkqaw+JQIdAthOwqOhnY4YvF
	bET+Cpej3rArrRxXAEwZ6uaM7FGzvtsaabWllxoNwvzNaZoCtBhnD36Vhg+0VPhlB8PqxaqxPQ7af
	alpByQGAZlDFtC3pITrkZcVqlUSi5linLqKLPvsaG7Ji3UMFtCDjXShS3wiTUsyU7zyaZi3sxvhCO
	tq1SJnCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQImt-00000004oub-3Gi6;
	Tue, 02 Dec 2025 05:18:55 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQImq-00000004otX-0f2f
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 05:18:54 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso3600633b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 21:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764652723; x=1765257523; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcvKr1ao30Z8aHb96IIMe6bHHGG9Y30itFaMOMQwwz4=;
        b=F55wVKStfy8R/G0TFCYpnE7wPGE33I5WQxGAWLircRvW9jL5+977OllB3OIgdMxRig
         +uN9JdV3gFTBJMFZFkM2ioNEfAJ/bV/y0+M4GEb+Vy4dNayBIGgZLunItiv/4HaqbvFA
         Ed1gQ6Yu8rhrkRA39BdFR6044CHM1ZHsCiXYja6YGruSZheeuFE0IUl23AZI3zu6S3Rl
         Z6KyspW4YMyNxSqcoNIet+UUildyhpoezWqgQTN4QvdfOJ0phiE4XXChqViYooqWe1Mr
         dtav4rE+pYj/tCT+5ZWqcW/itAIy+TUt7sQ28gPdOpKEJgpJSxvACRFjeTIMCrjrNQqS
         SrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764652723; x=1765257523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcvKr1ao30Z8aHb96IIMe6bHHGG9Y30itFaMOMQwwz4=;
        b=W1dS1ggbcEx+Hzq4jbVg0fPmYocgMwYVrAIIzHc/IBShkXo2c2VAHbrq5EvDcVW4R/
         lnlnK71bsxGor2BniDhydmfggmGdt3z93IZwrgvkNlozwdyiuzYXWkWPCgG4DssoydzD
         GfNtNdbtxiYGMDZSKSP2UqdLdrJz2mPombHwvYVS+B4EwJ6YlzmKKjCN2fvPe2ckRJ/y
         7VEl4W7Qmv5UmiZK8Bf6dT9egejbq+G37+GzBjRzvXxpljyS1oHfQsybzC6eOj/9Bw4L
         /uggTZWi3gWGB88X5RYw0+hNq/fmJIfgSR/06AjpqhXHKuHa1YXkTxCnrUg0pAbRadmU
         fVPg==
X-Forwarded-Encrypted: i=1; AJvYcCW7aTXatOj2uC/UfCPzFbnIJvtQVm8FAorFkw5iOwhF7wzt1+qAj3hfpTc+s1zsuE1MCRYRN/I/IHWS@lists.infradead.org
X-Gm-Message-State: AOJu0YwtCUc9cWi3id1gPoKDBB8nPxs8weZ86BLpOYU46xmQuAgVDfoU
	bjsY+IlCcHd9AEHnuD2/JFc2U2z+HQ7iperQcA7+j2dwKOPyA21iHfJ2
X-Gm-Gg: ASbGnctW1tyIhD54c9wA2wT+Xbqe3T/pQeM5t4QX5oaysVt4R6REjn1/qlKA+frogQG
	fBsIBj8juDJRbH5YMFkM38MRswtO1EtPqLjoKkpY/DvvvQA00B+psvSS6TQ3SuIwIsYXwsgxvfJ
	OQcupjgaCbTEPmemKckys0bjOkKjadEgaf1NfLugq4wLfWcA848z7TOP2rjA0/LUKvGC4ArQXtt
	1mn26f+cPCP+EcRYTT7Gr3zs94CJcKLsLEBGVpZ64E+LFIlUCny0HlcZwE5eW2xkJ2BxNW+L27t
	W8C4W9k2x84EEdwB+c9vtCVOqiLtcQqjGY1q6hcm0eoqftcva9QVaZMe9QHQldGyQ4CXpNGiWLp
	qkH4huaY8QnrCLglcmkKDRkNHgHlO7Y1BPWByCXp8PYe1QOHYxWzbm28yiEV5TcAoWAFLbp23Dz
	ddT+pkeANd2Ko0fgo5soG62LUhWoKTm3cNNMCUCxuxbLEka7RlSk1fXbXoxXxwkjc0OdvMvdigd
	ouEzKjbTePMdqzGumFa5VjeCD0aZA==
X-Google-Smtp-Source: AGHT+IGFAZ0OgsJE/To1vgW60IspjZLY7oBAQ7ISwfzajk5GLjT0pdgWYrr6WOnIoFYOdfYycky9nw==
X-Received: by 2002:a05:6a00:2d04:b0:7b8:10b9:9bec with SMTP id d2e1a72fcca58-7ca8abe6241mr28938960b3a.19.1764652722659;
        Mon, 01 Dec 2025 21:18:42 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3f79sm15206433b3a.42.2025.12.01.21.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 21:18:42 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 0/4] Support PSK reauthentication (REPLACETLSPSK)
Date: Tue,  2 Dec 2025 15:17:51 +1000
Message-ID: <20251202051755.1312158-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_211852_926137_13C337C7 
X-CRM114-Status: GOOD (  12.79  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Allow userspace on the host to trigger a reauth (REPLACETLSPSK) from
sysfs. This will replace the PSK for the admin queue when using
a secure concat connection.

This can be done by writing 0 to the `tls_configured_key` sysfs file,
for example something like this

```shell
echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
```

`tls_configured_key` will only appear for concat connections as that is
all that is supported.

Reading `tls_configured_key` will return the current configured key, which
changes after each REPLACETLSPSK operation.

This series also include some fixes for the NVMe target code to ensure
this works against a Linux NVMe target.

v4:
 - Forcefully reset the connection after updating the keys
v3:
 - Only trigger if a 0 is written to `tls_configured_key`
 - Add documentation

Alistair Francis (4):
  nvmet-tcp: Don't error if TLS is enabed on a reset
  nvmet-tcp: Don't free SQ on authentication success
  nvme: Expose the tls_configured sysfs for secure concat connections
  nvme: Allow reauth from sysfs

 Documentation/ABI/testing/sysfs-nvme   | 13 ++++++++
 drivers/nvme/host/sysfs.c              | 46 ++++++++++++++++++++++++--
 drivers/nvme/target/auth.c             |  4 +--
 drivers/nvme/target/core.c             |  2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 12 +++----
 drivers/nvme/target/nvmet.h            |  4 +--
 6 files changed, 68 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvme

-- 
2.51.1


