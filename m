Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D4C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 14:57:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6204A20637
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 14:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6204A20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=A4KSstvUB4lv7vC8RT7+Ow4gt+UkKuHJmP+USLrdY24=; b=pegjLngmAYEOQZ395SoGsLf8f
	ARnRfVZ3axkMJYOlazU7eCvUv843W4qWQVpvNPPW6SL1kyInf1CjjmTOWVDV8En6s1C9Kp69FHwJI
	On0KwrAYXBzq2jsVuLHESpibccR986ulpn0/62wnW74zmkXYxEwMzyCRVS5aaCW7CVNIqB6mSmDYw
	623HrIzGkrkdd5oYXc8fLarHYCEwNU0kHO0ZXWRZ5V8jDIY/+RmAsgOaLphc0hWIpfiUuPpDcnwL4
	H55TjzuOxHMcCFskyo27PeFSJNTemlXGH8pH/Ptpp4EahF707eqgAlueRTpZXkqub9npPt5gx8RM6
	NQ1PdAQMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knjrJ-0005NH-CS; Fri, 11 Dec 2020 14:57:25 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knjrG-0005ML-3x
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 14:57:23 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20201211145718epoutp011d615c8d8be02e63b6029d1d572486c6~PsWTKM-sa1163911639epoutp01O
 for <linux-nvme@lists.infradead.org>; Fri, 11 Dec 2020 14:57:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20201211145718epoutp011d615c8d8be02e63b6029d1d572486c6~PsWTKM-sa1163911639epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1607698638;
 bh=u5EHaj2RvOw56lEf4LMUK81fLkqGQjeLes6BsaXpzCg=;
 h=From:To:Cc:Subject:Date:References:From;
 b=psDvopmTZ6p+GOon7I6JCO3Etapje88YH3GE3Cpcdu0BdtqVkhatB5Wf6A/ijwNP+
 7+dW+D50ERdamhq+G2HFwZ1/EqrOj4iYujJeXksB33MTLAm1BKBBeQPx9b+AKoUdQM
 rSdBLs5aaIXf8VY+u+0+HhnhJN6/mFM0cKsT6pAg=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20201211145717epcas5p22608a58a5da7ce017b50fa98c9f90ec0~PsWSLZWm80483404834epcas5p2N;
 Fri, 11 Dec 2020 14:57:17 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E9.00.50652.DC883DF5; Fri, 11 Dec 2020 23:57:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20201211135154epcas5p34cd7f57fb4b13fcd50619efdc0099fa8~PrdM5ATwv0152001520epcas5p3S;
 Fri, 11 Dec 2020 13:51:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20201211135154epsmtrp2af0d193a3214535a0e5e48537c9fabe8~PrdM3-diG0546605466epsmtrp2F;
 Fri, 11 Dec 2020 13:51:54 +0000 (GMT)
X-AuditID: b6c32a4a-6c9ff7000000c5dc-09-5fd388cd9fcb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 21.71.08745.A7973DF5; Fri, 11 Dec 2020 22:51:54 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20201211135151epsmtip26a5ca344d2057143679d0988adfaddc1~PrdJ0roqu2927029270epsmtip2E;
 Fri, 11 Dec 2020 13:51:51 +0000 (GMT)
From: SelvaKumar S <selvakuma.s1@samsung.com>
To: linux-nvme@lists.infradead.org
Subject: [RFC PATCH v3 0/2] add simple copy support
Date: Fri, 11 Dec 2020 19:21:37 +0530
Message-Id: <20201211135139.49232-1-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTG9957uS3Ezksh7G3dRtJYF1hAV9z2mrnh0CxXjctipn8sc9DM
 KxChYgurzkXLhyIw2WAWR3F8yYaUWUZBRikgtiNEtENatKHDBiJ0OjZbBAt6RUd7Mfrf7zzn
 Oe9zTvLyceF8iJifrshmlAp5hoQMIzqsMTFxtpOO5HWXCinUfOs7ElX4HuLoeKEfQz33qkJQ
 d305hpqa+zF0e2yWhxaL3Rjqf/oficotNwHqcb2JHF1nSVTzyxQPlTg7SdQ48ARDZSdvYKiD
 rcHRyOl6HBmmvQQa9zp5aHrhColOtD4Am6Jox8h22qS7xaOH3K0E7bDl0EZ9EUm3NRyjzaMa
 kp6ZchG0t/cGSZe26wHddvUIPWt8nS7sK8E+EXwWtnEvk5H+FaNc+0FKWJr5McvL+g0eqpr+
 l9AAfUQxCOVDaj20DGvIYhDGF1JmAGt6/8S54j6A3xawGFfMAvhksRV7NtLH1gKu0QVg39zY
 c1eDyckLuEgqDt5sMBIBjqQkcLEljwiYcGoUh/ZH94OmCCoBnvXPgAATlBQO+K6TARZQ78PB
 gjKci4uGlfZ5HqeHwyuVk8FH8SU9/2JVcFlI5YfCOpcHcANbYK3BRnAcAf8ZaOdxLIaz93pI
 jtXQU1SxfI8GwFKvmuNEONy9uKTzlwJiYEvXWk5+DWoHDRiX+zI8xU4ujwpgZ/Vk0A6pNXDw
 93c4+VXos3YtJ9FwwawLspDaA6fy88D3IFr3wjW6F67RPQ+uBbgeiJgsVWYqo3o7S6Zg1PEq
 eaYqR5Ea/+WBTCMI/s3YbZ1gYtwXbwEYH1gA5OOSSAF7zJEsFOyVH/6aUR5IVuZkMCoLWMUn
 JK8IJAvXvhBSqfJsZj/DZDHKZ12MHyrWYNnRCVLr1kMbN+1sDc/z5T8US9cZesM/VZzZ0jYe
 tb90TEubau7S503xKxOGQrZWD6Ts2pHkaNGyucdFJd3VuQ2/yizpxrp6lbfZZe1Jss3vfje7
 6cemOM9Ft/9yy7mipxPnY1QfTlQY1h8UdZTnKtw/2b4RHT66/fG+drv9XGXpmUZ7IjmvXFF7
 esid80PGX7dXuMx3YtlJsX+3GiRFbbgw1Pd5h/XECMv8Xb7yaKXME+G5+tHcS87IPbKfnaAg
 5Q3TKSyVbCsrk/ofXLrwsYfetqNdenfDH9idSEPd6qbEUelmLS9tuL8iUT/TiGuZMfWISL4Z
 HqFk712b27Uq+pGEUKXJ34rFlSr5/84rHiEKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSvG5V5eV4gx3TlC1W3+1ns5j24Sez
 RWv7NyaLve9ms1rsWTSJyWLl6qNMFo/vfGa3+Nt1j8ni6P+3bBaTDl1jtNh7S9vi8q45bBbz
 lz1lt+i+voPNYvnxf0wWEzuuMlls+z2f2eLKlEXMFutev2exePD+OrvF6x8n2SzaNn5ldBDz
 uHzF22PnrLvsHufvbWTxuHy21GPTqk42j81L6j1232xg8/j49BaLx/t9V9k8+rasYvTYfLra
 4/MmOY/2A91MAbxRXDYpqTmZZalF+nYJXBm7//xmL9ggUTH79RuWBsZVwl2MnBwSAiYSB34v
 YOxi5OIQEtjBKPHo1WtmiISMxNq7nWwQtrDEyn/P2SGKPjJKfLx+ggUkwSagK3FtySYwW0RA
 SeLv+iYWkCJmgc/MEvN3tYElhAWMJeZ8+8gIYrMIqEoc/3ABbCqvgK3EqZaJUNvkJWZe+s4O
 EReUODnzCVAvB9AgdYn184RAwsxAJc1bZzNPYOSfhaRqFkLVLCRVCxiZVzFKphYU56bnFhsW
 GOWllusVJ+YWl+al6yXn525iBEesltYOxj2rPugdYmTiYDzEKMHBrCTCK8tyKV6INyWxsiq1
 KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJscNrl03GG9qVC3fWFCQ
 1LD3fqfb4SPPb5core/W71M21XQTiD991yvU+3D15bhnNdE/Zia7l//KE/Zbqn3Hc/u2ZfIW
 pmyPztwxU5kiuL7kt9kbuRWxa/JKpucqtq2etd/M+e6FWW/YIqZdmznx0+UlXw75yDXbH3vZ
 LLGjYEHPs4YnRlKizXV/T4n4rzXty7lgkC0aqdXs9HhV7ozzJfHMb3YJv55cN6Utxrx0XzWn
 V4+GbjzbcvVZmQI3NrUdmdhZWO/k97L2RXepnsXfR1nB2WHf3aMnXF7H5fjfyLxP9y7b6vMz
 1+6WVC53UVp1I/ZQTfjXpX3Nyr+XN/Bs395zJJ2Bq+ZsYnv/nS5jJZbijERDLeai4kQAHK+k
 gkcDAAA=
X-CMS-MailID: 20201211135154epcas5p34cd7f57fb4b13fcd50619efdc0099fa8
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201211135154epcas5p34cd7f57fb4b13fcd50619efdc0099fa8
References: <CGME20201211135154epcas5p34cd7f57fb4b13fcd50619efdc0099fa8@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_095722_484084_C9DC5F1C 
X-CRM114-Status: GOOD (  22.17  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, damien.lemoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 linux-scsi@vger.kernel.org, selvajove@gmail.com, Johannes.Thumshirn@wdc.com,
 snitzer@redhat.com, linux-kernel@vger.kernel.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com, mpatocka@redhat.com,
 hare@suse.de, joshi.k@samsung.com, martin.petersen@oracle.com,
 kbusch@kernel.org, javier.gonz@samsung.com, hch@lst.de, bvanassche@acm.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patchset tries to add support for TP4065a ("Simple Copy Command"),
v2020.05.04 ("Ratified")

The Specification can be found in following link.
https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip

This is an RFC. Looking forward for any feedbacks or other alternate
designs for plumbing simple copy to IO stack.

Simple copy command is a copy offloading operation and is  used to copy
multiple contiguous ranges (source_ranges) of LBA's to a single destination
LBA within the device reducing traffic between host and device.

This implementation accepts destination, no of sources and arrays of
source ranges from application. For devices suporting native copy
offloading, attach the control informantion as payload to the bio and
submits to the device. For devices without native copy support, copy
emulation is done by reading source range into memory and writing it to
the destination.

Following limits are added to queue limits and are exposed in sysfs
to userspace
	- *copy_offload* controls copy_offload. set 0 to disable copy
offload, 1 to enable native copy offloading support.
	- *max_copy_sectors* limits the sum of all source_range length
	- *max_copy_nr_ranges* limits the number of source ranges
	- *max_copy_range_sectors* limit the maximum number of sectors
		that can constitute a single source range.

	max_copy_sectors = 0 indicates the device doesn't support copy
offloading.

	*copy offload* sysfs entry is configurable and can be used toggle
between emulation and native support depending upon the usecase.

Changes from v2

1. Add emulation support for devices not supporting copy.
2. Add *copy_offload* sysfs entry to enable and disable copy_offload
	in devices supporting simple copy.
3. Remove simple copy support for stacked devices.

Changes from v1:

1. Fix memory leak in __blkdev_issue_copy
2. Unmark blk_check_copy inline
3. Fix line break in blk_check_copy_eod
4. Remove p checks and made code more readable
5. Don't use bio_set_op_attrs and remove op and set
   bi_opf directly
6. Use struct_size to calculate total_size
7. Fix partition remap of copy destination
8. Remove mcl,mssrl,msrc from nvme_ns
9. Initialize copy queue limits to 0 in nvme_config_copy
10. Remove return in QUEUE_FLAG_COPY check
11. Remove unused OCFS

SelvaKumar S (2):
  block: add simple copy support
  nvme: add simple copy support

 block/blk-core.c          |  94 ++++++++++++++++++--
 block/blk-lib.c           | 182 ++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |   2 +
 block/blk-settings.c      |  10 +++
 block/blk-sysfs.c         |  50 +++++++++++
 block/blk-zoned.c         |   1 +
 block/bounce.c            |   1 +
 block/ioctl.c             |  43 +++++++++
 drivers/nvme/host/core.c  |  89 +++++++++++++++++++
 include/linux/bio.h       |   1 +
 include/linux/blk_types.h |  15 ++++
 include/linux/blkdev.h    |  16 ++++
 include/linux/nvme.h      |  43 ++++++++-
 include/uapi/linux/fs.h   |  13 +++
 14 files changed, 549 insertions(+), 11 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
