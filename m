Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115ACC77B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 05:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:To:From:Subject:
	Mime-Version:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=b0Tl3wa1A0rsyeO1OYkPsDbplQjwdowp8kNaOSgtlvc=; b=Fv0LX8bWQrQr1EItwNlKVkSnvG
	AcmG/es8aH3cITzTnmaz5TTKyE/S0u+JG2xITxY/uILyYM6qqHI96SRox6xJfGFzssBFIGo84awxS
	35DxdFtytosRDFS88TkZkZpgy3R+nQEWTC0aw83CAaP+799W6ogwAMTO02wdryphuYYmI0uhRFJns
	7f4rP1TcHELt6MNv2jyFh6twOyPDNUhcOogWPcctpRXKZOycxovWloKB1G5ilLgf7qr2daAF4gKxN
	g2jgWWmW/w4QuCaI6iqpp9wug8dQfuGA9ZYQ006aru8T3tVmlQ/mh15GTiHyULV+Boc4X9vutNcXC
	SnTwtAAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmSqs-001pG6-0v;
	Wed, 12 Apr 2023 05:17:02 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmSql-001pEX-1Q
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 05:17:01 +0000
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230412051644epoutp047714940a725b8ff11aa24329a227ca1c~VGCnljAVS0400604006epoutp04Q
	for <linux-nvme@lists.infradead.org>; Wed, 12 Apr 2023 05:16:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230412051644epoutp047714940a725b8ff11aa24329a227ca1c~VGCnljAVS0400604006epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1681276604;
	bh=b0Tl3wa1A0rsyeO1OYkPsDbplQjwdowp8kNaOSgtlvc=;
	h=Subject:Reply-To:From:To:Date:References:From;
	b=LrQXJKbze31urzXZTdZsyJjyC/4bcY1UC1t8RCjUmdSD9ZaBusXC1ZD1v2E7RkOgd
	 izEvcq/GFyMC8iIYjfHbtzVg7dklKbVtAxv0Ogb9q6UXsZi3W980yv/Z/qp7Lv/7jU
	 NfB55l+As47uAvdQ+FRI0I/e1yxGyxKU/PiqBih0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20230412051643epcas2p48563904c3edf7f1cee2ea3f40804209f~VGCm8veog1406114061epcas2p4V;
	Wed, 12 Apr 2023 05:16:43 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Px9tM0kt0z4x9Py; Wed, 12 Apr
	2023 05:16:43 +0000 (GMT)
X-AuditID: b6c32a45-e13fa700000026e9-c6-64363eba8ae4
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AD.76.09961.ABE36346; Wed, 12 Apr 2023 14:16:42 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 0/2] Fix NVMe metadata mapping size for integrity
From: Jinyoung CHOI <j-young.choi@samsung.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230412051642epcms2p648d91f72aba5647bbccd6d4d6333224e@epcms2p6>
Date: Wed, 12 Apr 2023 14:16:42 +0900
X-CMS-MailID: 20230412051642epcms2p648d91f72aba5647bbccd6d4d6333224e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmhe5uO7MUg14fi/97jrFZzLr9msXi
	5SFNi5WrjzJZ9PZvZbOYdOgao8XlXXPYLOYve8puse71exYHTo+Jze/YPc7f28jisWlVJ5vH
	5iX1HrtvNrB59G1ZxejxeZOcR/uBbqYAjqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
	XUNLC3MlhbzE3FRbJRefAF23zByg45QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5
	BeYFesWJucWleel6eaklVoYGBkamQIUJ2RkvlnUzFzwVqNjbv4KxgXEjbxcjJ4eEgIlE98UZ
	bF2MXBxCAjsYJW4enM/UxcjBwSsgKPF3hzBIjbCAo8SMNZ/ZQWwhASWJc2tmMYKUCAsYSNzq
	NQcJswnoSfxcAjFGROAik0Rb1wtmiPm8EjPan7JA2NIS25dvZYSwNSR+LOuFqhGVuLn6LTuM
	/f7YfKgaEYnWe2ehagQlHvzcDRWXlDh06CsbyA0SAvkSGw4EQoRrJN4uPwBVoi9xrWMjC8Qn
	vhLH7+eCmCwCqhKLp0VDNLpIbH/sClLMLCAvsf3tHGaQMLOApsT6XfoQFcoSR26xQFTwSXQc
	/ssO81HDxt9Y2TvmPWGCaFWTWNRkBBGWkfh6eD5UiYfE9hf3mScwKs5CBPEsJCfMQjhhASPz
	Kkax1ILi3PTUYqMCQ3isJufnbmIEJ1At1x2Mk99+0DvEyMTBeIhRgoNZSYT3h4tpihBvSmJl
	VWpRfnxRaU5q8SFGU6DXJzJLiSbnA1N4Xkm8oYmlgYmZmaG5kamBuZI4r7TtyWQhgfTEktTs
	1NSC1CKYPiYOTqkGppQns4qE30S8f7XKcl1jefmuLZvFfqZWGrLNePOrhP9bpciOsgu2dZLX
	f0z2zQu6kPAmLvNXpJBa3j1G3dWbZ7wMWpL15pFO2NWpm/YaLxZJPqOR/K1248125dzu5nkv
	XkZP9nqZ+KVOlsl222KZiY8fF+rb2FWVvpp8bcmRaVe6GkNmXfwW+7zdaXWobcCiIu9P72/O
	+1nFdORzGsPZvHT+qbaFomnPKneE1qybM/nake8nzf4oXLZvOZ4mf7jQqdtI9928isNcUa/W
	aC73td3qXR1fOcV6wTer3nnrFNWzdt2539EcHWJxMZL/tYtW6detTivSBawl+uad3LSeYc70
	bXOt7T3cZ/hm7Tov8FSJpTgj0VCLuag4EQAhNEtSKQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412051642epcms2p648d91f72aba5647bbccd6d4d6333224e
References: <CGME20230412051642epcms2p648d91f72aba5647bbccd6d4d6333224e@epcms2p6>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_221657_160447_5999B61C 
X-CRM114-Status: GOOD (  15.68  )
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
Reply-To: j-young.choi@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the case of NVMe, it has an integrity payload consisting of one segment.
So, rather than configuring SG_LIST, it was changed by direct DMA mapping.

The page-merge is not performed for the struct bio_vec when creating 
a integrity payload in block.
As a result, when creating an integrity paylaod beyond one page, each 
struct bio_vec is generated, and its bv_len does not exceed the PAGESIZE.

To solve this problem, DMA mapping for metadata was modified to use the 
total segment size of the integrity payload.


Tested like this:

- Format (support pi type 1)
$ sudo nvme format /dev/nvme2n1 --force -n 1 -i 1 -p 0 -m 0 -l 1 -r

- Run FIO
[global]
ioengine=libaio
group_reporting

[job]
bs=512k
iodepth=256
rw=write
numjobs=8
direct=1
runtime=10s
filename=/dev/nvme2n1

- Result
...
[   93.496218] nvme2n1: I/O Cmd(0x1) @ LBA 62464, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.496227] protection error, dev nvme2n1, sector 62464 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.538788] nvme2n1: I/O Cmd(0x1) @ LBA 6144, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.538798] protection error, dev nvme2n1, sector 6144 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.566231] nvme2n1: I/O Cmd(0x1) @ LBA 124928, 1024 blocks, I/O Error (sct 0x0 / sc 0x4)
[   93.566241] I/O error, dev nvme2n1, sector 124928 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.694147] nvme2n1: I/O Cmd(0x1) @ LBA 64512, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.694155] protection error, dev nvme2n1, sector 64512 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.694299] nvme2n1: I/O Cmd(0x1) @ LBA 5120, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.694305] protection error, dev nvme2n1, sector 5120 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
...

Jinyoung Choi (2):
  blk-integrity: add rq_integrity_payload_size helper
  nvme-pci: fix metadata mapping length

 drivers/nvme/host/pci.c       | 9 ++++++---
 include/linux/blk-integrity.h | 7 +++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.34.1

