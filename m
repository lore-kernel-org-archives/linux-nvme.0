Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986EDC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 02:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=Dvx3tMy1tf7WyzaGZeCTaUFviPpUzeSOJVyNY5a+tyk=; b=X+IWj2Vi++dhLEWlHfD360edYN
	C8hx2TmdDzi4kLQduASMhwPgR0nqveG5LFpUUn5PTmd4Y11vpYHRJ6arsgJgLwaJ3KIcPzK6z8Ii0
	ePGYPdyShkwqsJhsUYd1B5+IZhuJv1Y28V2cl50JHI5B7zhQGR5o9F3n2wAVMEVw1tvrL35aqCPa1
	BIewgZsj6lgEo3G/3WBpE98YhbJFIzNByFqevE6bAz4wkwa9z22i81hgYiqdKOY6veXIWaYaFGErq
	t4qi13yQ1US7wBJywKV8UZpaaLrA/2rcLE4EYmEeAeO3Fr3B9orE0NRu+9uB3QnjI6n1WcsQCWiQl
	PsV03wzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzVKP-005JYU-18; Tue, 21 Dec 2021 02:56:37 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzVKB-005JRQ-9t
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 02:56:25 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20211221025615epoutp04019bc9676c0cd3ece6810a162e785fdc~Cpayw39s21357613576epoutp04W
 for <linux-nvme@lists.infradead.org>; Tue, 21 Dec 2021 02:56:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20211221025615epoutp04019bc9676c0cd3ece6810a162e785fdc~Cpayw39s21357613576epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1640055375;
 bh=Dvx3tMy1tf7WyzaGZeCTaUFviPpUzeSOJVyNY5a+tyk=;
 h=From:To:Cc:Subject:Date:References:From;
 b=oDd2Ljs8mGK6tXvAdxleJ0CEBkCOfdkwbgY5atYIsoGEXl93XhtirU8b7AoBt9mjS
 bitKNN1s43fHfA7SJOe1ToimhR+JHo3oCId8YvM8NszvWaORRyvMRAD39Gf8Oz13/p
 FTm7aGRqbGgQ0YJTVyaJmhwUYf9BnNRRfNG2wc90=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20211221025614epcas5p216026b654311a2a0da888bd87ce00bf6~CpayIhzOj2587925879epcas5p2C;
 Tue, 21 Dec 2021 02:56:14 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4JJ1LL3p1fz4x9Q0; Tue, 21 Dec
 2021 02:56:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 59.16.06423.24241C16; Tue, 21 Dec 2021 11:56:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20211220142227epcas5p280851b0a62baa78379979eb81af7a096~CfIohG-Cu1680716807epcas5p2W;
 Mon, 20 Dec 2021 14:22:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20211220142227epsmtrp1a36366eb442951cc7948e65cbb1f8cdd~CfIogTxzx2445924459epsmtrp1S;
 Mon, 20 Dec 2021 14:22:27 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-e9-61c14242cdeb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 42.85.29871.2A190C16; Mon, 20 Dec 2021 23:22:26 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20211220142225epsmtip1689d6fa6f161f6cf4764d3fafc99d304~CfImp21wT0637406374epsmtip1p;
 Mon, 20 Dec 2021 14:22:24 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, javier@javigon.com,
 anuj20.g@samsung.com, joshiiitr@gmail.com, pankydev8@gmail.com
Subject: [RFC 00/13] uring-passthru for nvme
Date: Mon, 20 Dec 2021 19:47:21 +0530
Message-Id: <20211220141734.12206-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmpq6T08FEg0kXTSyaJvxltlh9t5/N
 YuXqo0wW71rPsVh0nr7AZHH+7WEmi0mHrjFa7L2lbTF/2VN2izU3n7I4cHnsnHWX3aN5wR0W
 j8tnSz02repk89i8pN5j980GNo++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53
 jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6UEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xi
 q5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnbHuvF7BDrmKqw9vsTcw9kl0MXJySAiY
 SKy48pSli5GLQ0hgN6PEr+adrBDOJ0aJ/4/nsUM43xglzm++xQ7T8v12LyNEYi+jxO9HL6Fa
 PjNKbD+7AaiKg4NNQFPiwuRSkAYRgWiJC8+vsYHYzAIdjBI7u21BbGEBHYmNi3cxgdgsAqoS
 q8/NAqvhFbCQaNt0AWqZvMTMS9/ZIeKCEidnPmGBmCMv0bx1NjPIXgmBn+wS6579YgTZKyHg
 IvHjeyJEr7DEq+NboOZISbzsb4OyiyV+3TkK1Qt0z/WGmSwQCXuJi3v+MoHMYQa6f/0ufYiw
 rMTUU+uYIPbySfT+fsIEEeeV2DEPxlaUuDfpKSuELS7xcMYSKNtD4v/me4wgtpBArMTyU0tZ
 JjDKz0Lyziwk78xC2LyAkXkVo2RqQXFuemqxaYFhXmo5PF6T83M3MYLTqZbnDsa7Dz7oHWJk
 4mA8xCjBwawkwrtl9v5EId6UxMqq1KL8+KLSnNTiQ4ymwDCeyCwlmpwPTOh5JfGGJpYGJmZm
 ZiaWxmaGSuK8p9M3JAoJpCeWpGanphakFsH0MXFwSjUwTTr3tly98WuvjKbypQ+Hi4/KVcZm
 fF3WfWGtaf2pPxd9n7IZleqX/lCbs5zhMVPSTGlNr6Lrj7I2N5dUut6xF+669GHfY9Wtois5
 7vh5KjBYHSopSXh3+RBbVuo9xrKbpzfv7bljaNhWGbLMf6q9Srjlv0ZWxeIa+zst+gysvvan
 ZgXEOh71elq/S4pxn9LzPn9Lo6+THLY0zhT+WHM4nuW2zOnX8sya723W7sk5Hnuk+uaN0mSr
 Q/ofWG8cnrt7Mw9/pJ2lyHTNRe5vs97/fDjRZdftrScNItvCH7eflX4zydw2aOFrHrnA3ItF
 5wSarrnN+88xr2OqjM1BseyVTG5Xrv/vWF/+TP7MS7deJZbijERDLeai4kQAIpqkmzAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSnO6iiQcSDZ5cMrJomvCX2WL13X42
 i5WrjzJZvGs9x2LRefoCk8X5t4eZLCYdusZosfeWtsX8ZU/ZLdbcfMriwOWxc9Zddo/mBXdY
 PC6fLfXYtKqTzWPzknqP3Tcb2Dz6tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoErY915vYIdchVX
 H95ib2Dsk+hi5OSQEDCR+H67l7GLkYtDSGA3o8TX339YIBLiEs3XfrBD2MISK/89Z4co+sgo
 8fbndSCHg4NNQFPiwuRSkBoRgViJD7+OMYHUMAtMYpTY0P8ArFlYQEdi4+JdTCA2i4CqxOpz
 s9hAbF4BC4m2TRegFshLzLz0nR0iLihxcuYTsCOYgeLNW2czT2Dkm4UkNQtJagEj0ypGydSC
 4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjODQ1tLcwbh91Qe9Q4xMHIyHGCU4mJVEeLfM3p8o
 xJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9PqDREbDlbI
 xIqe98h+uoj9XM+dbTU2jrfXmgiKzF0faFR8jG3avy1rGON692ef0jHdwHJOTunh7RXSGTJO
 Sddvty0qV4yu43u9rjWx1e8o/+EzvcqLBW6lKf0+tWHh/EWbmF0nnXvJvGDLS7PLU11XSs2T
 lJS7X/no6ceiIgWFuUVvDCdMmajwUeS8U6PrsTyRiWG+ubPEQ6VUpu+0iyx1/W//L8jwceG2
 OVM2vqzeG+BjVHTj7j7/Hx8nafPvV3u5/qGHl3fByumWRarqbVc2+jjcbzxdllqyL1ln7wK+
 dQmstb3v+LavTi28331h3oKzGgdjqwruXq1rlO4we3YiYVP1BrONno+kK9hs1vYpsRRnJBpq
 MRcVJwIArtCOG9wCAAA=
X-CMS-MailID: 20211220142227epcas5p280851b0a62baa78379979eb81af7a096
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211220142227epcas5p280851b0a62baa78379979eb81af7a096
References: <CGME20211220142227epcas5p280851b0a62baa78379979eb81af7a096@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211220_185623_711465_117556D4 
X-CRM114-Status: GOOD (  16.13  )
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

Here is a revamped series on uring-passthru which is on top of Jens
"nvme-passthru-wip.2" branch.
https://git.kernel.dk/cgit/linux-block/commit/?h=nvme-passthru-wip.2

This scales much better than before with the addition of following:
- plugging
- passthru polling (sync and async; sync part comes from a patch that
  Keith did earlier)
- bio-cache (this is regardless of irq/polling since we submit/complete in
  task-contex anyway. Currently kicks in when fixed-buffer option is
also passed, but that's primarily to keep the plumbing simple)

Also the feedback from Christoph (previous fixed-buffer series) is in
which has streamlined the plumbing.

I look forward to further feedback/comments.

KIOPS(512b) on P5800x looked like this:

QD    uring    pt    uring-poll    pt-poll
8      538     589      831         902
64     967     1131     1351        1378
256    1043    1230     1376        1429

Here uring is operating on block-interface (nvme0n1) while 'pt' refers
to uring-passthru operating on char-interface (ng0n1).

Perf/testing is with this custom fio that turnes regular io into
passthru on supplying "uring_cmd=1" option.
https://github.com/joshkan/fio/tree/nvme-passthru-wip-polling
Example command-line:
fio -iodepth=256 -rw=randread -ioengine=io_uring -bs=512 -numjobs=1 -runtime=60 -group_reporting -iodepth_batch_submit=64 -iodepth_batch_complete_min=1 -iodepth_batch_complete_max=64 -fixedbufs=1 -hipri=1 -sqthread_poll=0 -filename=/dev/ng0n1 -name=io_uring_256 -uring_cmd=1

background/context:
https://linuxplumbersconf.org/event/11/contributions/989/attachments/747/1723/lpc-2021-building-a-fast-passthru.pdf

Changes from v5:
https://lore.kernel.org/linux-nvme/20210805125539.66958-1-joshi.k@samsung.com/
1. Fixed-buffer passthru with same ioctl code + other feedback from hch
2. Plugging (from Jens)
3. Sync polling (from Keith)
3. Async polling via io_uring
4. Enable bio-cache for fixed-buffer passthru

Changes from v4:
https://lore.kernel.org/linux-nvme/20210325170540.59619-1-joshi.k@samsung.com/
1. Moved to v5 branch of Jens, adapted to task-work changes in io_uring
2. Removed support for block-passthrough (over nvme0n1) for now
3. Added support for char-passthrough (over ng0n1)
4. Added fixed-buffer passthrough in io_uring and nvme plumbing


Anuj Gupta (3):
  io_uring: mark iopoll not supported for uring-cmd
  io_uring: modify unused field in io_uring_cmd to store flags
  io_uring: add support for uring_cmd with fixed-buffer

Jens Axboe (2):
  io_uring: plug for async bypass
  block: wire-up support for plugging

Kanchan Joshi (6):
  io_uring: add infra for uring_cmd completion in submitter-task
  nvme: wire-up support for async-passthru on char-device.
  io_uring: add flag and helper for fixed-buffer uring-cmd
  nvme: enable passthrough with fixed-buffer
  block: factor out helper for bio allocation from cache
  nvme: enable bio-cache for fixed-buffer passthru

Keith Busch (1):
  nvme: allow user passthrough commands to poll

Pankaj Raghav (1):
  nvme: Add async passthru polling support

 block/bio.c                     |  43 +++--
 block/blk-map.c                 |  46 ++++++
 block/blk-mq.c                  |  93 +++++------
 drivers/nvme/host/core.c        |  21 ++-
 drivers/nvme/host/ioctl.c       | 271 ++++++++++++++++++++++++++++----
 drivers/nvme/host/multipath.c   |   2 +
 drivers/nvme/host/nvme.h        |  13 +-
 drivers/nvme/host/pci.c         |   4 +-
 drivers/nvme/target/passthru.c  |   2 +-
 fs/io_uring.c                   | 113 +++++++++++--
 include/linux/bio.h             |   1 +
 include/linux/blk-mq.h          |   4 +
 include/linux/io_uring.h        |  26 ++-
 include/uapi/linux/io_uring.h   |   6 +-
 include/uapi/linux/nvme_ioctl.h |   4 +
 15 files changed, 542 insertions(+), 107 deletions(-)

-- 
2.25.1


