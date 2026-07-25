Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAF6C531D0
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Jul 2026 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=epma33FkPsF+b18kaxFsYumaC3sPMXsHXADeyJf9rV8=; b=LjCcZasRl4fLQ8gTtfP9iYVmJa
	DZ3G8fqHMw4gKxQPygCCUbDC2E8Vej/nfmgn1WpYB6+5Q4Vb3nwIzllYXsaC+7VNawc2dOIL9sn8G
	W0kDBKjoS2fWzWFZ9CdKMQq8wyL8tRwWtbmfGCvVkTN4aqFywQpqAS8TYeJF989nkJIPbf/P8IApS
	oQzcNXlOXwUzyAlMJuk8ksUDWGPduTfvxPEUx6pvhqxOv61XylpM3E1ZBB6SfVBvxNAsHvVUQnJfb
	jpmCONWroo4lHyDMyqOfPHp0TJKF+WybY9SibclPOww0PZfdtT6YvSehqwEsOQWBTHwmwZEaqZcRU
	slVaSt5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wncmj-00000000PUg-2Lpy;
	Sat, 25 Jul 2026 13:51:25 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wncmd-00000000PU6-2p86
	for linux-nvme@lists.infradead.org;
	Sat, 25 Jul 2026 13:51:20 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-69eae037da1so2013447a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 25 Jul 2026 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784987478; x=1785592278; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=epma33FkPsF+b18kaxFsYumaC3sPMXsHXADeyJf9rV8=;
        b=Cdal46NGe08/pwQrx+53V2mNwBvb3+RBCj8sqSXP9G93cOtoBsfh3d5CtCLf87ex0W
         ezp6MQhtHV6UgmvT1k4VHwwvLv7qXHjkIc8Ayp5UlR1fX4tlj8n+hMMVn0pkU9nkqNb9
         iqdBfcz05x/4Ha7ABRIAgkYw4YRa4G8wICgPILqay6+lTp2IJj8ZXxc7cqvbMXaUia/b
         GEd46w0vXGwoOOuoRA+gkMXan5xzQfDVeUNlt4f6zOiIhpHiqOF6FFTKHtbyhpqhh5KP
         0F175JMXirU4F1DdOeC12X2ewUk2PkdzXFVlW0/fv1gX7Mvv9pam7+thRfQdGzrDe3nV
         gqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784987478; x=1785592278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=epma33FkPsF+b18kaxFsYumaC3sPMXsHXADeyJf9rV8=;
        b=lucB+N58IjOzXbekbOlsvq1SDQ3FVCZLgHqEydwcCY1mltSBTlNjcl3ijbPri7zuN/
         TWY44tcQRihoRneTwkXpwgTOxjcKp1uBYkYA0ThMSe0xmDqFMefFyOqH0P0+JkC5iEx+
         kkde5DxSLZ64SDr49XKJnoiOsrgVKZTKZ8vRbsxTKK2x4y9plOCcbKYIgt9Z9jpj9+vH
         Z/RwD/mJloEGP+m4/N5iVGZk1c+UoYPTN9uEmglzzlCPSzMvu2LigbxipZEre4bI6FcK
         NG4XbZDIu7v1t9XoJU2nmCZbzEOBglJ17iO5Wl6EY3+KHqF75wVTKSdXaK3i2nd3uIAB
         eZCw==
X-Forwarded-Encrypted: i=1; AHgh+RrtnSCJgJWVeouxx+2VXVG6wyP2QRy+E5vWPJ3hIVbnDuULfn8w4WAcIXbwgQmqptRDZNWEU5wjDg+q@lists.infradead.org
X-Gm-Message-State: AOJu0YyHKLOHEcuihzReypol8JwRhg8Gy1A18R9S3OGI3lfV06wmcXXS
	wcWsjYlWnpfbX4H5t6oz3dG1wSx0hB85Q0TxEdmyx6vUWAatwW+7i6W4
X-Gm-Gg: AR+sD12S7mVhYJ2NUbrpctZ8nVLp8869hJ6JKXnqRCNZylYYvU6WnReVx8FpwbGCTFw
	aExQVaXLeYctP38OuszusxTBB/Fft/6Jp+Jg92rE1F7/7UF+iVgMF06EpGfD14ogx1KCS7oef9c
	2mdJ/2vUdvNJmbRKPie34/49BbD1NDaem8KHPPkm29vOG2T8tZMVlqjSMdVebNq734xdNk7M974
	bvNVSAtJY7e1sQj7ZAFw0Q9xpZmsKMjpWppUPjtRNuR6qkiZvdwNDP/5OQuJDuCaX7q2eC+QmVT
	R5rYE8W2dVcv4FH28hjFRx3p32VhL6fB4l3G44VdQguejAszQ8czweDPTUV/MWdocw6rogYotTd
	LDS0whtQU9akYpHZpbGgLjn9d7sL1XecCNq+r0smvOgHeai6KF8RMfsGNxg8cCNpRYfPiDVwbwM
	jiNv+SywYVT+YPH+igHmIBgo/AznndW1VlNezJ0gPS3l36RgiNSO+HiTFZhaSYV6w=
X-Received: by 2002:a05:6402:5244:b0:698:9ea5:d195 with SMTP id 4fb4d7f45d1cf-69fc113fd7amr815371a12.23.1784987477466;
        Sat, 25 Jul 2026 06:51:17 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-7475-eec2-a79e-2db.fixed6.kpn.net. [2a02:a463:a071:0:7475:eec2:a79e:2db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb5543aacsm836431a12.14.2026.07.25.06.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 06:51:15 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH 0/2] nvme: fix racy access to FDP placement ID array
Date: Sat, 25 Jul 2026 15:51:09 +0200
Message-ID: <20260725135111.14041-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260725_065119_722801_AE3D5485 
X-CRM114-Status: GOOD (  14.01  )
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

nvme_ns_head can be shared across multiple nvme_ns paths (multipath,
or dual-port/multi-controller subsystems). nvme_query_fdp_info()
populates head->nr_plids/head->plids the first time a namespace's
FDP configuration is registered, but nothing protects that pair from
concurrent access - two paths scanning the same namespace at the
same time can race to populate it, and depending on how the writes
interleave a concurrent reader can hit a NULL dereference or an
out-of-bounds read.

Patch 1 adds a spinlock and closes the race.

Patch 2 is a small, unrelated cleanup on code sitting right next to
what patch 1 touches: it drops a WARN_ON_ONCE that turns out to be
unreachable through any current path, since the value it guards
against is already validated upstream in the block layer and F2FS
before a bio ever carries it. Happy to drop this one or send it
separately if you'd rather keep it out of this series.

Hari Mishal (2):
  nvme: fix racy access to FDP placement ID array
  nvme: drop WARN_ON_ONCE on write_stream bounds check

 drivers/nvme/host/core.c | 63 ++++++++++++++++++++++++++--------------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 43 insertions(+), 21 deletions(-)

-- 
2.43.0


