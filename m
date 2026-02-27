Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD5510398AD
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 20:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=; b=UdyA01as/wHgHSC4hFhLFp1Wvg
	GsX0MLG7qF4C2NHh0se9oOVFQ/fQHkCsZewXEZp7z0eopMU7FG6nEBavw/d7tSRwzMFv3lnrJUBzQ
	/2Y/cnYFRYr6pQQO8fa67quA62Zq5y/AszI8rVQ0jFJQ3lc2hH0h11MnwjtDpJUv9sGpE/qtCPe8A
	KHvjmKalw21HYnkfDMYwdxxG6UlNQbVRdL55g7KUicGes68v0AzGiLcuOCoeRdNWPL71KvprPBruJ
	X34Ok4Gd5v9qdq7CCWSH9GIRf8yC4JgPZS27Ll1sK9UgoGfXCbu4PnTdsC1E9AiRhwQWqJhfkPzXn
	gyNUbg4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Nj-000000096Vm-2gIY;
	Fri, 27 Feb 2026 20:24:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Ni-000000096T6-0NPu
	for linux-nvme@bombadil.infradead.org;
	Fri, 27 Feb 2026 20:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=; b=O2s7sRHi55xHnOsO2NV5/oqN03
	PpqUed5OXS331hRJtZkMZ/UYlFD9IlWAmZblBAyCQjudttAlVXFDbe/xYmXXitu3JpPWMoHlSZeVI
	RwDYC1FBfpaXFx9wY4smWrvHu+cmUBSg0+UA2xR+pEGeZtIMsPm3OSoAQuMEOl8wGW1cbY3IrJp1K
	SXQUIMFlBYcMsFx5QQ5G8Gl0YCq0eZEGx/9M/yG8FN0PwLZmXGdXKd/Ig/1nfar77faBTSn8D50dj
	/N819LNmmZI4bdQp1HQ4zJYOEkYSS/J47tq6jlP1UWay15bC1dfC4vYD62YssY2RoNfxEkM5vBUjF
	T2smr6IA==;
Received: from mail-pf1-x463.google.com ([2607:f8b0:4864:20::463])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4NZ-0000000Dt7P-3ysl
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 20:24:12 +0000
Received: by mail-pf1-x463.google.com with SMTP id d2e1a72fcca58-8272cea0718so150010b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 12:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772223843; x=1772828643; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=;
        b=CLCv93W2uO1ptfto4HBRKsxVQpr3m5UMx728zIdHo+f96ciKajDaZV+ihksEqjXnmz
         JSnThvJLkI9QroRMsRtAA4rYIpH1ifQ3Ausj+eLQ8YKW7eHDB6MjH55YUgrdgYkt4Cu8
         E78fskO9xGayIqkb2+P0pFjAFi8ovnH1FD66fi+Vmp/Upoa+9Ou5tijJ1FuU8avYBN9s
         UolKknPZyEBTP6iNiTLw8oiBf/dC/iqmKP50fJ8mIEwvrRWbOZ+oXaWK6aZ4iex7gMBG
         QfVjCGG2Ph2E1Q/fuNSnwAn/vRFh2zy+aCzHIFm4VzKxuktTAGa8zUTolVWVUbi3uNbF
         A2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223843; x=1772828643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=;
        b=WdPaxc0cZv1haTcFJHDL3A8k4B6aCL3HmHFj7WMx10PAhkBNPbJxSYxTufW28C6OCC
         SgV+fmg02TkD1qEklMhp+LBYFdPgdZkfIzG4lmv/0WmT4aDPG4lxQELotDLFvNL+TYWS
         oNM+9kMAGZqoSDeXIkEERBlfQjthD54CZHdYWJIe5J2cPxiOQrY1vzQqDJWgdLLlJPf0
         vwhr922qYzhwoQiYziCojPFjEn0aqbGOGDxZ1zh+ZbItj8ObCtMy4R6oTu0aY95qYwIN
         Kbz6RAQ5EtDXaSBFFIfU34rDaIN8ttcEm3WAJyMCszHJZsrEsvGRoEMxMp2UHogjjYjl
         38YQ==
X-Gm-Message-State: AOJu0YyY+cZTBYDGBYbHcDeyYS7q6vHNDKNxQlk0fp8QKuUsnu4Uaflj
	ieNpyMKAy+SCqcu4+XEAl6ToRDzDL/Csa8lGAH1ZfBVLTY8GIS3EFu/17VwYK2Pq5czHOoGj2na
	hMERl6aW1aPryzb6palIGtusinpuqswmsb96C
X-Gm-Gg: ATEYQzyr6F1El/zAWBXYEQodnu+YwuZtNF4B7I+eQUbx3Fl/T4voz7DOFPWd7wIzKWp
	1j9ZdbIAULR3vOyiA7IRt0T7pWwp9xFdFMQVTwDyjxSfB+/MGsBtcse9pUMDhZmAk/9J830llr/
	5yKDtUXcEsNGhbGNLUa8mBsXoS+ImuvZ9Im62D+Pgo2qCSZJocV4LqfKB5Ui9WlBSfBLbucYMh0
	1ZsYW1OF9GpWlZjZq6SJ+lSg9JaGFLZecLPtpCinz9Zmt32xIu7IanRaC1yNAOQGgYfps5Htkcl
	O7LKuL/6wZ1A5qsZ7Wl1beW74pZ3yVPAnzxS421tSBSfOSVPua+1dyHevT1bB95AQp5SOHWLEWe
	tYcfepERvNPFv1aoTRrimyA8j3RQzeWrtgFx+PyWhafFn+5o2T9yE6g==
X-Received: by 2002:a05:6a21:6d88:b0:38b:e7ca:9517 with SMTP id adf61e73a8af0-395c3b422bamr3131161637.7.1772223842730;
        Fri, 27 Feb 2026 12:24:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82739d70643sm670497b3a.3.2026.02.27.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:24:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5A9693422C9;
	Fri, 27 Feb 2026 13:24:01 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 543BBE420D8; Fri, 27 Feb 2026 13:24:01 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 7/8] nvmet: use NVME_NS_FEAT_OPTPERF_SHIFT
Date: Fri, 27 Feb 2026 13:23:52 -0700
Message-ID: <20260227202354.1012322-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227202354.1012322-1-csander@purestorage.com>
References: <20260227202354.1012322-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_202410_584388_CCDBFE84 
X-CRM114-Status: GOOD (  15.32  )
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

Use the NVME_NS_FEAT_OPTPERF_SHIFT constant in nvmet_bdev_set_limits()
to set the OPTPERF bits of the nvme_id_ns NSFEAT field instead of the
magic number 4.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/io-cmd-bdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca604..d94f885a56d9 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -28,15 +28,15 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->nawun = lpp0b;
 	id->nawupf = lpp0b;
 	id->nacwu = lpp0b;
 
 	/*
-	 * Bit 4 indicates that the fields NPWG, NPWA, NPDG, NPDA, and
+	 * OPTPERF = 01b indicates that the fields NPWG, NPWA, NPDG, NPDA, and
 	 * NOWS are defined for this namespace and should be used by
 	 * the host for I/O optimization.
 	 */
-	id->nsfeat |= 1 << 4;
+	id->nsfeat |= 0x1 << NVME_NS_FEAT_OPTPERF_SHIFT;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
 	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.45.2


