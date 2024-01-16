Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B370C47077
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 18:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JG/1+n6ePxtoAUG3Qbwl79wTOKMylFKiQ7nh8g8yQ+o=; b=Rdxix8kA2Btx99sI/ooy+Nsqxy
	hmdgPF0eoJ/TLzUyVnBeFpD85qIfNNk2HIGzjEFakahKBZJICTfBtuwAhMGS6JodFiXPGIBEdL9Tw
	P102BqwGNVIgLXlhiJDC5bkoQT9UGpSXFe3z8m0fr1gOTQyL6R2ppg8hdopQrzisjTb4pi/oU/Fwq
	Lgzq61OiBYiRqkKHtQf2DFzKSKvnxkt6+73dvgbtm77hvfLTOL4hISAwOQjW5GzcCYQfIEFp6oZp2
	r499zQkVLnOL+LTTReeC03LaOVTkmQDBmTC2FbzRxOxzvV35farOE86KCz5wdmNrpHqUcthN7jYIl
	KLlUN8sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPo3P-00CxhT-37;
	Tue, 16 Jan 2024 18:20:52 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPo3M-00Cxea-2K
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 18:20:50 +0000
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d5f5a2e828so3091515ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 16 Jan 2024 10:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429246; x=1706034046;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JG/1+n6ePxtoAUG3Qbwl79wTOKMylFKiQ7nh8g8yQ+o=;
        b=LRCfwsRR9RtHP9y+WRnNwLUvo36JTiU3aIuShVP1LlTajRYC3twXqM9qdFDRARZpey
         1Da+XK277vkaXBkGZuvyJtoqYJK7GvyeFSIvvvXQl5NA4tzNsUuCOEPhl+gKNsL8F9CA
         8WDjfm9MXBObxzdV7BFtLBc8eOjhHn/edF/r4GlMY5R4bzjGb5hhzKyQpDCxAzZXR4yI
         7/vxJ/cLfiY6c3M7bdnWQVAFwyEVdaJPg1Vxr7xYL9v2mDRTTJqD0CVO74VFinPGP3dw
         5gI++s2jNJ/iPobJiRdxilHsE9k5JYxy/G/WeRIQk52b5LX0UTt/H4/4hMlb2fOAqYzE
         JlGQ==
X-Gm-Message-State: AOJu0YyKjJdfHq3gIor4ZSwVPQV332QrTLbrRRVpg1mlJob/d4INYCof
	/i425VLvyVxm0S+mYO9pHCo=
X-Google-Smtp-Source: AGHT+IHa9RorkOCy9n2FWNQ0utsG7HkkU8lYyXw/kw7/8PDkGXCpSISp/8dJ90ju8gPOMDgMz4bsVg==
X-Received: by 2002:a17:902:db02:b0:1d4:3d94:e183 with SMTP id m2-20020a170902db0200b001d43d94e183mr5568341plx.45.1705429245592;
        Tue, 16 Jan 2024 10:20:45 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:bf53:62d5:82c4:7343? ([2620:0:1000:8411:bf53:62d5:82c4:7343])
        by smtp.gmail.com with ESMTPSA id ix4-20020a170902f80400b001d6ea47ce68sm80059plb.52.2024.01.16.10.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 10:20:45 -0800 (PST)
Message-ID: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
Date: Tue, 16 Jan 2024 10:20:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_102048_755867_1F71DC07 
X-CRM114-Status: GOOD (  12.42  )
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

The advantages of zoned storage are well known [1]:
* Higher sequential read and random read performance.
* Lower write amplification.
* Lower tail latency.
* Higher usable capacity because of less overprovisioning.

For many SSDs the L2P (logical to physical translation) table does not
fit entirely in the memory of the storage device. Zoned storage reduces
the size of the L2P table significantly and hence makes it much more
likely that the L2P table fits in the memory of the storage device. If
zoned storage eliminates L2P table paging, random read performance is
improved significantly.

A zoned storage SSD does not have to perform garbage collection. Hence,
write amplification and tail latency are reduced.

Zoned storage gives file systems control over how files are laid out on
the storage device. With zoned storage it is possible to allocate a
contiguous range of storage on the storage medium for a file. This
improves sequential read performance.

Log-structured file systems are a good match for zoned storage. Such
filesystems typically submit large bios to the block layer and have
multiple bios outstanding concurrently. The block layer splits bios if
their size exceeds the max_sectors limit (512 KiB for UFS; 128 KiB for a
popular NVMe controller). This increases the number of concurrently
outstanding bios further.

While the NVMe standard supports two different commands for writing to
zoned storage (Write and Zone Append), the SCSI standard only supports a
single command for writing to zoned storage (WRITE). A write append
emulation for SCSI exists in drivers/scsi/sd_zbc.c.

File system implementers have to decide whether to use Write or Zone
Append. While the Zone Append command tolerates reordering, with this
command the filesystem cannot control the order in which the data is
written on the medium without restricting the queue depth to one.
Additionally, the latency of write operations is lower compared to zone
append operations. From [2], a paper with performance results for one
ZNS SSD model: "we observe that the latency of write operations is lower
than that of append operations, even if the request size is the same".

The mq-deadline I/O scheduler serializes zoned writes even if these got
reordered by the block layer. However, the mq-deadline I/O scheduler,
just like any other single-queue I/O scheduler, is a performance
bottleneck for SSDs that support more than 200 K IOPS. Current NVMe and
UFS 4.0 block devices support more than 200 K IOPS.

Supporting more than 200 K IOPS and giving the filesystem control over
the data layout is only possible by supporting multiple outstanding
writes and by preserving the order of these writes. Hence the proposal
to discuss this topic during the 2024 edition of LSF/MM/BPF summit.
Potential approaches to preserve the order of zoned writes are as follows:
* Track (e.g. in a hash table) for which zones there are pending zoned
   writes and submit all zoned writes per zone to the same hardware
   queue.
* For SCSI, if a SCSI device responds with a unit attention to a zoned
   write, activate the error handler if the block device reports an
   unaligned write error and sort by LBA and resubmit the zoned writes
   from inside the error handler.

In other words, this proposal is about supporting both the Write and
Zone Append commands as first class operations and to let filesystem
implementers decide which command(s) to use.

[1] Stavrinos, Theano, Daniel S. Berger, Ethan Katz-Bassett, and Wyatt
Lloyd. "Don't be a blockhead: zoned namespaces make work on conventional
SSDs obsolete." In Proceedings of the Workshop on Hot Topics in
Operating Systems, pp. 144-151. 2021.

[2] K. Doekemeijer, N. Tehrany, B. Chandrasekaran, M. Bjørling and A.
Trivedi, "Performance Characterization of NVMe Flash Devices with Zoned
Namespaces (ZNS)," 2023 IEEE International Conference on Cluster
Computing (CLUSTER), Santa Fe, NM, USA, 2023, pp. 118-131, doi:
10.1109/CLUSTER52292.2023.00018.
(https://ieeexplore.ieee.org/abstract/document/10319951).

