Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CACC433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 11:02:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591B5229EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 11:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591B5229EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=MGaitp+qUFfqpPaiXPmqcIAV133tcdplb2wKsqGUhKk=; b=a8ISZar60JGJZ2jnkLwXv/u4e
	dom3gB5z9F63Cs4fW+L4mNbxU6RIlysTB0N0mfyL6zg9dRIZJY7aVz+hfkUPvJ+7L+Kph+iIKEGbU
	2hCxBra1ywc8QobQ0pPYsU3B4sOlM6nLww6Z34ouGQ/BEX0/ASF9JIcSzW4TDaI2mv4oSq98PIlAD
	k6TOe5vUlTlogMvrk8CZIMATA8EzeeyabxWBLQbWeQbHtIV/RIaFvR0+ucPANYWPQMnV4l7JvGKj9
	VMF1/YJngDN34Gtoos0o+dMnAlxrJaAUXYn4MDRj/WxfiMjBSkPBq47F5oZx4+QQ8kBZNpwuCC1hf
	Yn+zhsPWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kl8qs-0001nz-Qy; Fri, 04 Dec 2020 11:02:14 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kl8qq-0001mh-BC
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 11:02:13 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20201204110208epoutp01327d44b45673b0e6b4e3403020fdc200~Nfn96QJ9t1638016380epoutp01g
 for <linux-nvme@lists.infradead.org>; Fri,  4 Dec 2020 11:02:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20201204110208epoutp01327d44b45673b0e6b4e3403020fdc200~Nfn96QJ9t1638016380epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1607079728;
 bh=Pz7T7lvezf7uUx497RUs/1CY6IS+UdFFwDgy1q2ME+I=;
 h=From:To:Cc:Subject:Date:References:From;
 b=pfUDIzN4YF/W7QBifd6+9bpPmleqA7bFARrNhRwFeGhNvs40FwJ0ePpP6LZVrWFQ6
 +mfs0hhHqE/rMW1Ler91RzlE2GhoLSpOdi9kn+KsyXOCfFG85FtnHFRserwkVrykeb
 mAZWfT7eesnZm563+ApiMN4GUHvjugVL6KmdiAx4=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20201204110207epcas5p208934b5f67b6f15fe11761b1292f0dc5~Nfn9MckUd2339123391epcas5p2S;
 Fri,  4 Dec 2020 11:02:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 39.9C.50652.F271ACF5; Fri,  4 Dec 2020 20:02:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5~NempRmT2H2182421824epcas5p2V;
 Fri,  4 Dec 2020 09:47:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20201204094719epsmtrp122b4869dd4861c71d0efc9ac0aa99115~NempQw_vK2092920929epsmtrp1x;
 Fri,  4 Dec 2020 09:47:19 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-a8-5fca172f1ed9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C9.28.13470.6A50ACF5; Fri,  4 Dec 2020 18:47:18 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20201204094716epsmtip2329cbe727fd325e53ac93dbc006cd44d~Nemmxh8jE0388403884epsmtip2M;
 Fri,  4 Dec 2020 09:47:16 +0000 (GMT)
From: SelvaKumar S <selvakuma.s1@samsung.com>
To: linux-nvme@lists.infradead.org
Subject: [RFC PATCH v2 0/2] add simple copy support
Date: Fri,  4 Dec 2020 15:16:57 +0530
Message-Id: <20201204094659.12732-1-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7bCmlq6++Kl4g8tP2SxW3+1ns2ht/8Zk
 sffdbFaLlauPMlk8vvOZ3eLo/7dsFpMOXWO02HtL2+LyrjlsFvOXPWW32PZ7PrPFlSmLmC3W
 vX7PYvHg/XV2i9c/TrJZtG38yugg4LFz1l12j/P3NrJ4XD5b6rFpVSebx+Yl9R67bzawebzf
 d5XNo2/LKkaPz5vkPNoPdDMFcEVx2aSk5mSWpRbp2yVwZbx8Ppm14KBQxdlzDUwNjEf4uhg5
 OSQETCRu3Wlg62Lk4hAS2M0ocXD6ESjnE6PE/SNfmECqhAS+MUq8WskE07Gk5xkjRNFeRolz
 j25BOZ8ZJT41PwOrYhPQlbi2ZBMLiC0ioCTxd30TC0gRs8ApJommf7vYQRLCAsYS8/ffZQSx
 WQRUJV7P2Q3WzCtgK7Fx1xU2iHXyEjMvfWeHiAtKnJz5BGwoM1C8eetsZpChEgJ7OCRenF8I
 lOAAclwk2l67Q/QKS7w6voUdwpaSeNnfBmWXSzzrnAb1TgOjRN/7cgjbXuLinr9MIGOYBTQl
 1u/ShwjLSkw9tY4JYi2fRO/vJ1CtvBI75j1hgtiqJnFquxlEWEbiw+FdUNd7SLTsXs0OCcRY
 ia3PtzNOYJSfheSZWUiemYWweAEj8ypGydSC4tz01GLTAqO81HK94sTc4tK8dL3k/NxNjODk
 puW1g/Hhgw96hxiZOBgPMUpwMCuJ8MaqnowX4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqv040yc
 kEB6YklqdmpqQWoRTJaJg1OqgWm6wa3GB7U5GQb7FO0nt69fPyfEVk96zreyaXsefdDxrVzd
 P/tJ3wQm8dl/9l5t7JzzVnBtxJ3tKgeZHflFJ6sKlU7ReCZ5pjp59tng0nCOpSrxiQfuWa+9
 vsS25QDTa+bUYK8Zqq4rdk+ZqtG0/PmMhjyXMMbYjauDDI34nk9SsJFoYr6sY9HJuGjOBuVH
 M74dXnt469dN5h9MJi5j0zunufLB22sGx/g9vp4OLTFIXJpusvqOUsSFvUsONQee7uJdu/e6
 BOspS+sHK9fecvik7Svo8rZuCZ8k84/SmgmLp7AEvXzT4TW3QO/Le83lBz4GJ3Y6tk1c6/5S
 5227+Ie9OrzLJRh3nHzoenPutl5jJZbijERDLeai4kQA23lOOt0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXnc566l4g2dSFqvv9rNZtLZ/Y7LY
 +242q8XK1UeZLB7f+cxucfT/WzaLSYeuMVrsvaVtcXnXHDaL+cueslts+z2f2eLKlEXMFute
 v2exePD+OrvF6x8n2SzaNn5ldBDw2DnrLrvH+XsbWTwuny312LSqk81j85J6j903G9g83u+7
 yubRt2UVo8fnTXIe7Qe6mQK4orhsUlJzMstSi/TtErgyXj6fzFpwUKji7LkGpgbGI3xdjJwc
 EgImEkt6njGC2EICuxkl1m+2g4jLSKy928kGYQtLrPz3nL2LkQuo5iOjxJLLE8Aa2AR0Ja4t
 2cQCYosIKEn8Xd8EZjML3GGS2PbDFcQWFjCWmL//Llg9i4CqxOs5u5lAbF4BW4mNu65ALZCX
 mHnpOztEXFDi5MwnQHM4gOaoS6yfJwQxUl6ieets5gmM/LOQVM1CqJqFpGoBI/MqRsnUguLc
 9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgqNLS3MG4fdUHvUOMTByMhxglOJiVRHhjVU/GC/Gm
 JFZWpRblxxeV5qQWH2KU5mBREue90AWUEkhPLEnNTk0tSC2CyTJxcEo1MFm+eODexX/fNo+H
 NcFKWW3Cac7PbRNtrWuDIr2nd82MuRrNuKjhziIRtrCOdZsSpx+b66ny/F2+eeFr/b3KVr2X
 3J9ldaVw5LLEpZ7TyNX7u8jyD6/yocJFocdfnSjZv+Tk75+Fs5SFrx330FPf9v7Y5isn1fj1
 rqXoyc2IWcv07f/fmIPGLGnz6+pMHpybZhTbv/Po+lsKOybV/azn5QwJVX4e6CkdPZHZWsJu
 l9GDbZp66q9dXx72lchcFJ979qH+kn/zTb+macfIWHv8qSjQ++euNoF5wabHM5fzrpf4Z3qQ
 qffZ11X9ngXpf+6HmPE6T+j9cFzZdd5Btdrl2vNdE3O5Nyf7vlQ511QiocRSnJFoqMVcVJwI
 AOAWwJIZAwAA
X-CMS-MailID: 20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_060212_828952_030F6929 
X-CRM114-Status: GOOD (  18.48  )
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
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me, snitzer@redhat.com,
 selvajove@gmail.com, linux-kernel@vger.kernel.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com, joshi.k@samsung.com,
 kbusch@kernel.org, javier.gonz@samsung.com, hch@lst.de
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
source ranges from application and attach it as payload to the bio and
submits to the device.

Following limits are added to queue limits and are exposed in sysfs
to userspace
	- *max_copy_sectors* limits the sum of all source_range length
	- *max_copy_nr_ranges* limits the number of source ranges
	- *max_copy_range_sectors* limit the maximum number of sectors
		that can constitute a single source range.

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

 block/blk-core.c          |  94 ++++++++++++++++++++++++++---
 block/blk-lib.c           | 123 ++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |   2 +
 block/blk-settings.c      |  11 ++++
 block/blk-sysfs.c         |  23 +++++++
 block/blk-zoned.c         |   1 +
 block/bounce.c            |   1 +
 block/ioctl.c             |  43 +++++++++++++
 drivers/nvme/host/core.c  |  87 +++++++++++++++++++++++++++
 include/linux/bio.h       |   1 +
 include/linux/blk_types.h |  15 +++++
 include/linux/blkdev.h    |  15 +++++
 include/linux/nvme.h      |  43 ++++++++++++-
 include/uapi/linux/fs.h   |  13 ++++
 14 files changed, 461 insertions(+), 11 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
