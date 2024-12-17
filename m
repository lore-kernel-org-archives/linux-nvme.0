Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0026E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eLXAYiyU1iqMID7+HfNyBZxwgcF9EMYHiTYuuHxkZvc=; b=amsyrEjXDxwwEr6AvYUXASEK80
	HqC+MhToqfSoUEVAki/2R3X5FvjG/vLFltRW4pwNqW6R6yQ885jEGurCfFULihKI6kEg9X5fuuDWw
	yLPBwbzm65qMwqKaPwFxGyJ6ng7aHnwopWhRRpTgYnUvVsir8v2fk+N2xYFIvdbrlZF9x0b1yuOeX
	TGeto+cofB0O0T5PITaLHfEqzsMvABo4SWc94Sl835K6nr5XHT7TJ63ripIe3b3bz7viu7uy/6+Bw
	kJsM+TlbPPw9KkhnLlfEnkRlbSHBrFeDud//CybvM98CmIGEc8eH3ahKjLhCNn5+aZcHvbjN+CIyw
	d9lkoirQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNaej-0000000EEXL-22UL;
	Tue, 17 Dec 2024 16:42:45 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNaZV-0000000EDSv-2Drn
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 16:37:22 +0000
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3a8aed87a0dso18953475ab.3
        for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2024 08:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734453440; x=1735058240; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLXAYiyU1iqMID7+HfNyBZxwgcF9EMYHiTYuuHxkZvc=;
        b=DO17ePpSlneZiXHETZNoRD0j7EhaVy2Z3usLfDkp45c5MLS2PJiepSCdMdzswAzh2e
         L9knSyVerqoXsUI8gkHebSUd0OGkhWZ1LGTNmqQXdki8XBNeUdKBiuVmy6u/Ma213ira
         /YJ81+YJo2haD2KrsiCyg7TiYY5H9RUO7HXOQC7Ro+tNUuOAwPYrHRsn3PrRJMJlvY2z
         5Kg7/Gq9seX7gn9axpzATpIw81b49Wwk3/fhsA1pAUlb6XddrN7q/M6j854SzZM1XJ1Y
         TeJw1/Z4SCEeyAkaWSdnDD8OXv8cNEt3iCf3s3pGRK/xI/mqliXJaR9aO4ThV2H0lBe/
         DI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453440; x=1735058240;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLXAYiyU1iqMID7+HfNyBZxwgcF9EMYHiTYuuHxkZvc=;
        b=LaNfrGXOkJ9wkuqYxkNbdtHtdYg8OR7hBPBHYVVOO5XA3ywJXWx2prgry7QYGwgKpw
         xON3SUQMmkVG5sMnitqGpIGiSbQVScfquIHjtY58zp3BKPMe5wCvG5gBCPitRy9Un+tw
         SF0Dju4tlEZ7SQDROwgZ1Qul388ecjzIDIRDSW/s4tnlQ8Inb3+KarF0DQRTFlVCpAUf
         F5NYT3q9QWrLZjkbVLMZMPGtqZ+BRJg95a6JhChwj4kXOLC086VmUNLJcCUgK4OfEevH
         6+LOiVbhcZChyTMmb8j+nEcuS6zZpT501M1+H9Ft2IZLVKcnCq1lWHjzZHbzFOR8AXYG
         BxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGRSjhEgsTmcizaIgilJugJcZ/M1907eLyvU/oEIwtczeTB6hz87VM7bGGNChrN3Tcis8TC48GJTKg@lists.infradead.org
X-Gm-Message-State: AOJu0YzBH+DduocSn490kb6lBkNvAC8pnozUDPUi0a/yJDRiAxPb1Ww2
	lpZebRkkwVoonN8UWxiI95bM4tpu79vxuM1f2UFlxi6KJftVljV8oXjzgQiRZ48=
X-Gm-Gg: ASbGnctCxngDMJqgx86NtCIFqi72WaINkczKD8ZDFf5A8Al55Icjs/0RwL+zi5R76Y+
	9vgKCpMk2YSpiaKb+QuTdHgU33KvtOqohHtsbwsxLaYSdjsW5cuvnYmjkbHBYLcr1eZ6nrn8rp0
	sqUutxJV/nxoj5fEUKeoTl1sUlzPNuORKwrARHa71eJ9VGudydWWAzqTpZqv82JnfEcjf8TEyd/
	dFA2nZ7vci7a/J3100TnVzTxudINKrBkpTSoujSEkAeyek=
X-Google-Smtp-Source: AGHT+IE/HVlmxcalHVFA9B+15PGcwD/7VUAayQaHnmJ8VTv9HsAtDcrPfDzLFsYJKWRCm33fWsrd4w==
X-Received: by 2002:a05:6e02:1d11:b0:3a7:708b:da28 with SMTP id e9e14a558f8ab-3bd8b195aa9mr912455ab.21.1734453440010;
        Tue, 17 Dec 2024 08:37:20 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e0a3de5esm1774339173.51.2024.12.17.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:37:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
 Daniel Wagner <wagi@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org
In-Reply-To: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
References: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
Subject: Re: [PATCH v6 0/8] blk: refactor queue affinity helpers
Message-Id: <173445343855.487134.18283101203931240403.b4-ty@kernel.dk>
Date: Tue, 17 Dec 2024 09:37:18 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_083721_571919_B702828E 
X-CRM114-Status: GOOD (  10.40  )
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


On Mon, 02 Dec 2024 15:00:08 +0100, Daniel Wagner wrote:
> I've rebased and retested the series on top of for-6.14/block and updated
> the docummentation as requested by John.
> 
> Original cover letter:
> 
> These patches were part of 'honor isolcpus configuration' [1] series. To
> simplify the review process I decided to send this as separate series
> because I think it's a nice cleanup independent of the isolcpus feature.
> 
> [...]

Applied, thanks!

[1/8] driver core: bus: add irq_get_affinity callback to bus_type
      commit: ccddd556cfba3db6cb4d45d9f7d30c075e34808b
[2/8] PCI: hookup irq_get_affinity callback
      commit: 86ae920136e7c6352e7239a459544b0eae57613a
[3/8] virtio: hookup irq_get_affinity callback
      commit: df0e932e866b5cfad8cedafa0123ab0072a665ce
[4/8] blk-mq: introduce blk_mq_map_hw_queues
      commit: 2b30fab613e2ef54ae4b3fbb238245a29ba2a285
[5/8] scsi: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues
      commit: 7c72e20573d0d350c7c087289e7b7b605100651f
[6/8] nvme: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues
      commit: f0d672680e0b383b14add766b57db60c4c4acf92
[7/8] virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_map_hw_queues
      commit: 5a1c50296039ca32a22015bbb9696d6a96514947
[8/8] blk-mq: remove unused queue mapping helpers
      commit: 737371e839a368007758be329413b3f5ec9e7976

Best regards,
-- 
Jens Axboe




