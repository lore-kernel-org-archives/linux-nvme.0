Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E5EEB64DA
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jul 2023 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UEc/gKJsyHCzqxEQtroXydSdK7o/MzgDF2qH7kIt9/8=; b=F3df2KQazIUDh71dsXAHAK/b0b
	H5jPzwaaFVPW3H8zh3FPTI/NVQ9j6H+F/Z0KNG2jLxXfqnXjGhau7nveZhf70dVKLqPH3i9ZhAT+/
	C2/mlokzPJeqZDXE9IDXDjw+NpGOZmcr5YNmqmwK0eFH5ZGeDI/kMtNJKlSfYTWvXZ7UJln3j2JPy
	wPv6Z+Wvm9NroGKkXAQybQhJiI8Plo3AnLnaGGDEHbnyOg9/RhyvK5kbYN3KKOU9b0ieKCth8zfIn
	TEvW6UwiiMiQwBQTho2Nu5VYPLvbKwZ3OwHQR2+CfeYhc5VN585l401jVosIec5VpnVSyHt+DyRyv
	zy2JpI5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNDHH-00GpXq-1a;
	Sat, 22 Jul 2023 14:08:11 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNDHC-00GpWy-2P
	for linux-nvme@lists.infradead.org;
	Sat, 22 Jul 2023 14:08:08 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b89cfb4571so22311655ad.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Jul 2023 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690034882; x=1690639682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEc/gKJsyHCzqxEQtroXydSdK7o/MzgDF2qH7kIt9/8=;
        b=ELPN2a4KsE8+/aqvLMY5S0P2fyMByLMQqiSF9pX8JuC7oGTZVB5HYHVMvzNzY1KnIl
         GnJBlAWSiAueIRoNvLe9IcYNeggkvdnhJGlGGcTtUlgmthMN0wfICvjvUES8PCphL+hr
         n1w+lPJty/2/PXZoXKl7Q2Api/XhUV6p5698jVfPGbiSvL+JINRJcxjN81KVQRwE+b+M
         NYFFjz+yzKl+ItrP0ERVTX+cL2OdXqV5XMX1mLoGkW7cUYjwp53ekLZypEmHHmSswMLy
         VsKkQy5yYS9553auaCwuPGn1akKj7dbHXXyeUC9BUcrp6dV0JAGvcxys17cBgIqrhdfQ
         qdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690034882; x=1690639682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEc/gKJsyHCzqxEQtroXydSdK7o/MzgDF2qH7kIt9/8=;
        b=DymX4j4EBiOI3QN5qyFIFVMuAFDwa9+mcKR/FrLjIL082iY48mE/XWu+ZsGYBsPpMD
         4wcnqvYwXyVQL11gNCF8vQgx0I3Y8ecf79lLQFi08GL+wSoei2si+EvuME6aa2k1JGw2
         NaquFi2jx4CuElbhRGToqXNAaO/5MHlq4xcI3Zv8bzNSHWEEh7X5nRoLzWQWHq2pbyHW
         e2kZKr+BPLpLpx7VftPJw2Y+qmpNNuLOU4mJ7S5BuKVsjT+AmHTtWex18tmffrCKsvPB
         G00l9F1obzS8seHlnfhfdYIjCbI73PoR5mGPItzTQAX1vHhn8N1Q89eBzYkABuigVr5d
         fVfA==
X-Gm-Message-State: ABy/qLZLhLkecFA+n5CxLFS+wMp2kuzGr/Vv8ZUWjCXH+0WdvuoxulAK
	lpBZvYVENNGiOM6LHnCQOUQ=
X-Google-Smtp-Source: APBJJlGyYcJ+Gs2gK8banGHT6FQdje64Ooc8PKiLBj2Rmlhda6BN2YnbvbGb8h7pXNj2OFE+rsYByA==
X-Received: by 2002:a17:902:6b4c:b0:1bb:7d2f:7c19 with SMTP id g12-20020a1709026b4c00b001bb7d2f7c19mr2367596plt.64.1690034882167;
        Sat, 22 Jul 2023 07:08:02 -0700 (PDT)
Received: from kit.horse-mountain.ts.net ([159.196.93.60])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c21300b001b8b4730355sm3519469pll.287.2023.07.22.07.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 07:08:01 -0700 (PDT)
From: Josh Taylor <joshuataylorx@gmail.com>
To: wangxiao@hotmail.it
Cc: axboe@kernel.dk,
	hch@lst.de,
	highenthalpyh@gmail.com,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	xuwd1@hotmail.com
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for MAXIO MAP1602
Date: Sat, 22 Jul 2023 14:07:52 +0000
Message-ID: <20230722140752.616073-1-joshuataylorx@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <MEAP282MB0391131326CF9E3BD5C26FD0B338A@MEAP282MB0391.AUSP282.PROD.OUTLOOK.COM>
References: <MEAP282MB0391131326CF9E3BD5C26FD0B338A@MEAP282MB0391.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230722_070806_803034_4E548D45 
X-CRM114-Status: GOOD (  11.47  )
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

This is my first response to a Kernel patch, so I apologise for any formatting weirdness.

I have a Lexar NM790 (4TB), which uses the MAP1602. It looks like this is going to be a fairly popular controller, as it seems a few are using it - as of July 2023 it looks like ~18 M.2 2280 are using it according to techpowerup (https://www.techpowerup.com/ssd-specs/?f&controllerMfgr=Maxiotech#MAP1602).

I however cannot get this patch to work for me on 6.5-rc2 on ArchLinux, nor with 6.4.4.

This is my dmesg when booting (Linux archiso 6.3.9-arch1-1):


	[    6.634874] nvme nvme0: pci function 0000:01:00.0
	[    6.640698] r8169 0000:27:00.0: enabling device (0000 -> 0003)
	[    6.643601] nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0


When doing a suspend, then resuming, I can then re-initialise the device using the rescan steps in the previous email.

I then get this in my dmesg (Linux archiso 6.3.9-arch1-1):


	[  130.948667] pci 0000:01:00.0: Removing from iommu group 14
	[  131.983938] pci 0000:01:00.0: [1d97:1602] type 00 class 0x010802
	[  131.983963] pci 0000:01:00.0: reg 0x10: [mem 0xfcf00000-0xfcf03fff 64bit]
	[  131.984212] pci 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:01.1 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
	[  131.984346] pci 0000:01:00.0: Adding to iommu group 14
	[  132.031556] pci 0000:01:00.0: BAR 0: assigned [mem 0xfcf00000-0xfcf03fff 64bit]
	[  132.031662] nvme nvme0: pci function 0000:01:00.0
	[  132.044095] nvme nvme0: allocated 40 MiB host memory buffer.
	[  132.088892] nvme nvme0: 16/0/0 default/read/poll queues


The "allocated 40 MiB host memory buffer" part is interesting, none of my other drives have this, as this is a DRAM-less drive.

# nvme get-feature /dev/nvme0 -f 0x0c -H
get-feature:0x0c (Autonomous Power State Transition), Current value:0x00000001
	Autonomous Power State Transition Enable (APSTE): Enabled
	Auto PST Entries	.................
	Entry[ 0]
	.................
	Idle Time Prior to Transition (ITPT): 100 ms
	Idle Transition Power State   (ITPS): 3
	.................
	Entry[ 1]
	.................
	Idle Time Prior to Transition (ITPT): 100 ms
	Idle Transition Power State   (ITPS): 3
	.................
	Entry[ 2]
	.................
	Idle Time Prior to Transition (ITPT): 100 ms
	Idle Transition Power State   (ITPS): 3
	.................
	Entry[ 3]
	.................
	Idle Time Prior to Transition (ITPT): 2000 ms
	Idle Transition Power State   (ITPS): 4
	.................
	Entry[ 4]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[ 5]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[ 6]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[ 7]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[ 8]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[ 9]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[10]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[11]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[12]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[13]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[14]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[15]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[16]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[17]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[18]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[19]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[20]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[21]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[22]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[23]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[24]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[25]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[26]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[27]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[28]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[29]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[30]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[31]
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................

