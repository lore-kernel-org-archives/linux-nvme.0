Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97797C54EBC
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 13:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=UnJEdGtMkmielzUj97uMvqqEmcraHfTEsa9rYb4MiL4=; b=OkxE3TNYwxoGLb7Soqe6VGBmGP
	lg2xPTrJDdu0VbGyHFqQftTf4E/1Q40tXLs61ilkrnW9RSq6BvWcBLPgZvAeOuH8P2uDzjgK/GJl5
	707q8P5ygEe68WLMBEZvOMk9O++2FvXUtuhUjyBdRQ39Qe+25cAkK/cysaU8U6Ylcp91XERNSrTJF
	FaPToaCHuAC/pGELnBHmWC+bT3Uj6Y+hYdKREctcaXwfgOMugBKPmkFqI2AIi6Riff+A4KM/N12jM
	lfM0VC13v8xzCU2yoVgQPlWXZrrNlv3iNfxnF1s5LJkc1NG0g1mjyfiFhmcKWziSBGcJRC2qM1hSU
	E3bb1olA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFxlg-00FAuc-RR; Thu, 12 Jan 2023 13:37:20 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFxlX-00FAr8-5K
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 13:37:14 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230112133703epoutp038f88c26e87fa983fe329a291e9c9eb22~5kzw8E_RA1682216822epoutp03F
	for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 13:37:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230112133703epoutp038f88c26e87fa983fe329a291e9c9eb22~5kzw8E_RA1682216822epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1673530623;
	bh=UnJEdGtMkmielzUj97uMvqqEmcraHfTEsa9rYb4MiL4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jPsdy0FLJVmoHPlf7esT8RLkvODdsPw1FWF+J2dZpGJwGdJjh2qy6UtgRqEVahPwP
	 H+SaHi/AtUicq+UFrUcuORTeMTRmI1cYmPE1Fi/UdFLkn0iIYHbutHNTsHm5Bl2PmE
	 ffOOER8Tv+i16Jf4O8TfOgHRi1a7v8BiLQOTPBXw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230112133702epcas5p477b3e6fb8d168ff430c4caef47563981~5kzwJKFZW1179511795epcas5p41;
	Thu, 12 Jan 2023 13:37:02 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Nt5F86Y3Gz4x9Pt; Thu, 12 Jan
	2023 13:37:00 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.D4.02301.CFC00C36; Thu, 12 Jan 2023 22:37:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230112115954epcas5p4a959bef952926b8976719f1179bb4436~5je8PVHxa1997319973epcas5p4J;
	Thu, 12 Jan 2023 11:59:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230112115954epsmtrp152f30b7df859064e2bec0ca3a6c8a57e~5je8OV1ZL2220922209epsmtrp1w;
	Thu, 12 Jan 2023 11:59:54 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-07-63c00cfc1b69
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.13.10542.A36FFB36; Thu, 12 Jan 2023 20:59:54 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
	[107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230112115951epsmtip238e47c6957ed82e8528fd357d0332494~5je5ksTYN0887908879epsmtip2C;
	Thu, 12 Jan 2023 11:59:51 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>, Mike
	Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, Chaitanya
	Kulkarni <kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, Nitesh Shetty
	<nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 0/9] Implement copy offload support
Date: Thu, 12 Jan 2023 17:28:54 +0530
Message-Id: <20230112115908.23662-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzevbe9XBhll4fjwLLZFKdSnkUoB0I3Fh27bCYjgThjdHBX7iih
	tLW3yB4kwADHyLDyzCjDogHlNVAEVwqFBmEiyNjC6HwAzgSXwUREWNwQZa0XNv/7zvf7vvP9
	fudBYB53cF8iXaVjtCpaKcJdeJcu+4uD1l2t8tAJQyjsGP0Bg1+cfILB1hk9Di33a/nwhrUH
	hc2twyjsPb2MwuGNRRyWD9oQeHfKgELLzQDYZ7nKg5Pmb3FoPHvXCZrm8hF46bERgyuNhU6w
	/c8lHhy5+QqceHKFH+tFGW6P41SPYcaJmpi9wKMmx7OozpavcOpiQy7VeyMPp0oL7uPUUv8U
	Tp3oakGolc7XqM65RTTB9VBGjIKhUxmtkFHJ1anpqjSZ6L3E5L3JEdJQSZAkCkaKhCo6k5GJ
	9u1PCIpLV9rHFAmP0cosO5VAs6wo5I0YrTpLxwgValYnEzGaVKUmXBPM0plsliotWMXooiWh
	oWERdmFKhmKtpB/TNMFPni5b8DzEJi5BnAlAhgPbuplfgrgQHmQvAm7Z1nBu8RABZ6aHeA6V
	B7mCgKbxD7YcrUMPUY43IyC/MpczFKDg6+rTdjdB4GQAGNsgHBovchoFPWN+Dg1G1qJgZPEO
	31HwJKXgensd4tDzyNfB0/53HbSAjAaVjZdRBw3IEKC/7c7R7uBqzdyzdjByOyjorsUcWwJy
	lQANxwtRrrd9IG9wncdhT7BwpcuJw75gXn98E2eD5somnDMXIsDwqwHhCm+ColE95gjGSH/Q
	YQ7h6FdB1Wg7ygW7gdLHc5tZAmA6tYX9QFtHPc5hH2B7lL+JKdD1t2XzDI8AY/kEehLZbnhu
	HsNz8xj+T65HsBbEh9GwmWkMG6GRqJjs/65Vrs7sRJ69dXG8CZn57UHwIIISyCACCEzkJegb
	HpB7CFLpTz9jtOpkbZaSYQeRCPsRl2G+2+Rq+2dR6ZIl4VGh4VKpNDxqj1Qi8hYw3Ua5B5lG
	65gMhtEw2i0fSjj75qHFhwfOj5xZswZFzfY5L/ktR1eEESsHjFikbPKFwO+6I9/fHXMgLPej
	Hjqpyv3LyZ0yYz1/9i9X8PKETVX+zlkZNVxXuhCRKxFnTiW9mCi/vvOn5tWaY4lvfT7/oYtz
	9VB/vBiZr/2xuE3mfa1CIQz8/TCvPcbNWrWj4WcrlAw0xzb6FX38aJdCr2qbC0gI+SNHkp+z
	3xLrcvAQWRw8nMKfbuGV7dmbgOmvte52M/uc+6f6FkrO58SdulC2JryXRMftqgl8O837XHzG
	aky7yXpwh9f3Y2T2dF1U0VFPf4vpF5maufigYXrmiDZlSn9ec3SDdd8WWV7Bwm8EweaXTMqF
	eyIeq6AlYkzL0v8CTBj6s3QEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRzGe885nh0t7WwKvWZljsSaaGVRL9r1g3YShKAgs8JOdpjXZTvZ
	RdKmVtDoZhejqZmiopspecvlrTZdXlADc5jl7DK7EOp0aqipsSzq2/P/Pb/n05/CRXnEcipK
	dpqTy9hYMelAVOvF7j7+k40RGy5rhKiszYCj1FuzONL03yRR/XCmHXrzXIuhYk0zhmpzRzHU
	PD9Eots6I0CDPSoM1fd5o7r6VgJ1P8siUU7hoADVmFMAqp7JwZG14JIAlX4fIVBLnxvqmn1p
	t8uFUQ10kIxW1S9gukxPCKa7I4EpV18lmYr8i0ztGwXJXE8bJpmRhh6SuVGpBoy1fBVTbh7C
	9i0Jc9h2gouNOsPJ1+845hA5rWzA44vQubnRelIBjBIlsKcgvRlqmsYwWxbRNQB+z/rDXWHh
	bBO+kJ1h8dwXwYKTgkFFmrsSUBRJe8P2eUoJHCgX+jMGO0wfcduB0wUYfNSQYmcbONNbYG9p
	NrANCNoTzjUE27Aj7Q/vFugxG4b0enhzQLiAhbD1gZmwYZz2gmUPRTaM0+4wrSoTvwWWqv6z
	VP8s1X/WI4CrgSsXz8dJ4/iN8X4y7qwvz8bxCTKpb8TJuHLw+40SSQ2oU1t8dQCjgA5AChe7
	ONY1N0aIHE+w5xM5+clweUIsx+uAG0WIlzm+UraGi2gpe5qL4bh4Tv63xSj75QrMqTvp+Bcm
	dzxwW4ulrJ85MNX0NHrl+XtVXH90bWVCXxhrd+cbV9pS7dOmlQW9DP5h6NK3n4quNN7PTYd+
	ewfqGhMXG6fmAvKW5E/oh/UjJV690VHBJrBmxcTY4Hzy47zUtp4Qf4V1tW9I+Lqtk++kq5Or
	DAF72Ws6z6IjmPJVznhSZJFA6pSVLr6U4ZlksHYepl+YPNjXQaIKHdgum8n+9ulTqN/uoAwP
	89eSC5ZFA28tK/dT2UeleFvQjVrxUu3BwMRN4KdlWnZF9/6Ot/OH3q1kqLopm/e0eryPMaWe
	6SPxtQWxO6u6ditahj6j+3lervnSPcJDk2YrH9ZZLSb4SHajBJfz7C82n+OzNQMAAA==
X-CMS-MailID: 20230112115954epcas5p4a959bef952926b8976719f1179bb4436
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230112115954epcas5p4a959bef952926b8976719f1179bb4436
References: <CGME20230112115954epcas5p4a959bef952926b8976719f1179bb4436@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_053711_910545_71DF521A 
X-CRM114-Status: GOOD (  23.82  )
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

The patch series covers the points discussed in November 2021 virtual
call [LSF/MM/BFP TOPIC] Storage: Copy Offload [0].
We have covered the initial agreed requirements in this patchset and
further additional features suggested by community.
Patchset borrows Mikulas's token based approach for 2 bdev
implementation.

This is on top of our previous patchset v5[1].

Overall series supports:
========================
	1. Driver
		- NVMe Copy command (single NS, TP 4065), including support
		in nvme-target (for block and file backend).

	2. Block layer
		- Block-generic copy (REQ_COPY flag), with interface
		accommodating two block-devs, and multi-source/destination
		interface
		- Emulation, when offload is natively absent
		- dm-linear support (for cases not requiring split)

	3. User-interface
		- new ioctl

	4. In-kernel user
		- dm-kcopyd

Testing
=======
	Copy offload can be tested on:
	a. QEMU: NVME simple copy (TP 4065). By setting nvme-ns
		parameters mssrl,mcl, msrc. For more info [2].
	b. Fabrics loopback.
	c. blktests[3] (tests block/032,033, nvme/046,047,048,049)

	Emuation can be tested on any device.

	Sample application to use IOCTL is present in patch desciption.
	fio[4].

Performance
===========
	With the async design of copy-emulation/offload using fio[4],
	we were  able to see the following improvements as
	compared to userspace read and write on a NVMeOF TCP setup:
	Setup1: Network Speed: 1000Mb/s
		Host PC: Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz
		Target PC: AMD Ryzen 9 5900X 12-Core Processor
		block size 8k, range 1:
			635% improvement in IO BW (107 MiB/s to 787 MiB/s).
			Network utilisation drops from  97% to 14%.
		block-size 2M, range 16:
			2555% improvement in IO BW (100 MiB/s to 2655 MiB/s).
			Network utilisation drops from 89% to 0.62%.
	Setup2: Network Speed: 100Gb/s
		Server: Intel(R) Xeon(R) Gold 6240 CPU @ 2.60GHz, 72 cores
			(host and target have the same configuration)
		block-size 8k, range 1:
			6.5% improvement in IO BW (791 MiB/s to 843 MiB/s).
			Network utilisation drops from  6.75% to 0.14%.
		block-size 2M, range 16:
			15% improvement in IO BW (1027 MiB/s to 1183 MiB/s).
			Network utilisation drops from 8.42% to ~0%.
		block-size 8k, 8 ranges:
			18% drop in IO BW (from 798 MiB/s to 647 MiB/s)
			Network utilisation drops from 6.66% to 0.13%.

		At present we see drop in performance for bs 8k,16k and
		higher ranges (8, 16), so something more to check there.
	Overall, in these tests, kernel copy emulation performs better than
	userspace read+write. 

Blktests[3]
======================
	tests/block/032,033: Runs copy offload and emulation on block device.
        tests/nvme/046,047,048,049 Create a loop backed fabrics device and
        run copy offload and emulation.

Future Work
===========
        - nullblk: copy-offload emulation.
	- generic copy file range (CFR):
		We explored the possibility of using block device
		def_blk_ops, but we saw a major disadvantage for in-kernel
		users. fd is not available for in-kernel user [5].
	- loopback device copy offload support
	- upstream fio to use copy offload

	These are to be taken up after we reach consensus on the
	plumbing of current elements that are part of this series.


Additional links:
=================
	[0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=zT14mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
	[1] https://lore.kernel.org/lkml/20221130041450.GA17533@test-zns/T/
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/nitesh-shetty/blktests/tree/feat/copy_offload/v6
	[4] https://github.com/vincentkfu/fio/tree/copyoffload
	[5] https://lore.kernel.org/lkml/20221130041450.GA17533@test-zns/T/#m0e2754202fc2223e937c8e7ba3cf7336a93f97a3

Changes since v5:
=================
	- Addition of blktests (Chaitanya Kulkarni)
        - Minor fix for fabrics file backed path
        - Remove buggy zonefs copy file range implementation.

Changes since v4:
=================
	- make the offload and emulation design asynchronous (Hannes
	  Reinecke)
	- fabrics loopback support
	- sysfs naming improvements (Damien Le Moal)
	- use kfree() instead of kvfree() in cio_await_completion
	  (Damien Le Moal)
	- use ranges instead of rlist to represent range_entry (Damien
	  Le Moal)
	- change argument ordering in blk_copy_offload suggested (Damien
	  Le Moal)
	- removed multiple copy limit and merged into only one limit
	  (Damien Le Moal)
	- wrap overly long lines (Damien Le Moal)
	- other naming improvements and cleanups (Damien Le Moal)
	- correctly format the code example in description (Damien Le
	  Moal)
	- mark blk_copy_offload as static (kernel test robot)
	
Changes since v3:
=================
	- added copy_file_range support for zonefs
	- added documentation about new sysfs entries
	- incorporated review comments on v3
	- minor fixes

Changes since v2:
=================
	- fixed possible race condition reported by Damien Le Moal
	- new sysfs controls as suggested by Damien Le Moal
	- fixed possible memory leak reported by Dan Carpenter, lkp
	- minor fixes

Nitesh Shetty (9):
  block: Introduce queue limits for copy-offload support
  block: Add copy offload support infrastructure
  block: add emulation for copy
  block: Introduce a new ioctl for copy
  nvme: add copy offload support
  nvmet: add copy command support for bdev and file ns
  dm: Add support for copy offload.
  dm: Enable copy offload for dm-linear target
  dm kcopyd: use copy offload support

 Documentation/ABI/stable/sysfs-block |  36 ++
 block/blk-lib.c                      | 597 +++++++++++++++++++++++++++
 block/blk-map.c                      |   4 +-
 block/blk-settings.c                 |  24 ++
 block/blk-sysfs.c                    |  64 +++
 block/blk.h                          |   2 +
 block/ioctl.c                        |  36 ++
 drivers/md/dm-kcopyd.c               |  56 ++-
 drivers/md/dm-linear.c               |   1 +
 drivers/md/dm-table.c                |  42 ++
 drivers/md/dm.c                      |   7 +
 drivers/nvme/host/constants.c        |   1 +
 drivers/nvme/host/core.c             | 106 ++++-
 drivers/nvme/host/fc.c               |   5 +
 drivers/nvme/host/nvme.h             |   7 +
 drivers/nvme/host/pci.c              |  27 +-
 drivers/nvme/host/rdma.c             |   7 +
 drivers/nvme/host/tcp.c              |  16 +
 drivers/nvme/host/trace.c            |  19 +
 drivers/nvme/target/admin-cmd.c      |   9 +-
 drivers/nvme/target/io-cmd-bdev.c    |  79 ++++
 drivers/nvme/target/io-cmd-file.c    |  52 +++
 drivers/nvme/target/loop.c           |   6 +
 drivers/nvme/target/nvmet.h          |   2 +
 include/linux/blk_types.h            |  44 ++
 include/linux/blkdev.h               |  18 +
 include/linux/device-mapper.h        |   5 +
 include/linux/nvme.h                 |  43 +-
 include/uapi/linux/fs.h              |  27 ++
 29 files changed, 1324 insertions(+), 18 deletions(-)


base-commit: 469a89fd3bb73bb2eea628da2b3e0f695f80b7ce
-- 
2.35.1.500.gb896f729e2


