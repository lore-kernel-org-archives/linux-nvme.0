Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B51C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=0x9c8Tch3r42RNcTSQDUDfqDkkWQ0sqG6b0e2Vfyu4I=; b=4boTtj1uIw84JEbta91sd0G3MD
	c+bDKuQ7BsHUdrdFguAiT+dQPSCBMWp7V+gPRyeQ5AGgyyxOZ3MbftW718g0cwcRJURtwFSO1p5MD
	dsTsXOWkZzu/kVR/G0r8XWiEcvv2VNZ/xPG3ZxDl6VyrPTF/8kdboKXkNF8WMxWqmaK7hEo0QqSvd
	S7OOwtEFPG8yP4rjpnkQnSZSCfJ3KdlqLYeLvA3UmNs0NZk7cuxvTJwoY8rTNEFej9xPIetgrrOEo
	a9JcbfpUOIC/ECuVPd44MZom7OE27FtXEInvzpiPn2bmvSgL+KJfVq6vKUk7XrzTJWXVI8lXRHhvO
	dsoQGOZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o40sl-00AkgD-O6; Wed, 22 Jun 2022 13:58:59 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o40sf-00AkcB-Im
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 13:58:58 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220622135843euoutp01422a884d9c305e9e1e1259e5dd59d4cf~69gcFaPDa2215322153euoutp019
	for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 13:58:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220622135843euoutp01422a884d9c305e9e1e1259e5dd59d4cf~69gcFaPDa2215322153euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655906323;
	bh=0x9c8Tch3r42RNcTSQDUDfqDkkWQ0sqG6b0e2Vfyu4I=;
	h=From:To:CC:Subject:Date:References:From;
	b=jSTcCy4ncddbjs3F3ZPcTt+RWgvBEqeYVkrhi9pCC89rmJGoXSJL3ge77GDTMLt52
	 6cN5SgK7TuoQOUy+4GMxEZ7lIUQ8+3s3ZUFu9R43To359VTdu3Gf7gXBahC3AgYBt7
	 D5oCfoIdaUhUFYS6DRUSw2QBdRMQpuAlqti28CoY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220622135842eucas1p28c7a156a20b8b6c05b3ce4cfd1847a15~69gbtUYJ51882918829eucas1p2E;
	Wed, 22 Jun 2022 13:58:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 89.17.10067.21023B26; Wed, 22
	Jun 2022 14:58:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220622135842eucas1p21d3cadfa3f9dd1bff4fe531472270b88~69gbR6wkm1881918819eucas1p26;
	Wed, 22 Jun 2022 13:58:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220622135842eusmtrp272c73babd2da7b6cc77c3ee962086c89~69gbREXoX2672726727eusmtrp29;
	Wed, 22 Jun 2022 13:58:42 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-84-62b32012d874
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 51.5C.09038.21023B26; Wed, 22
	Jun 2022 14:58:42 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220622135842eusmtip25da7533ea75fb91717de3cb558a7afb3~69gbI43TK3062830628eusmtip2F;
	Wed, 22 Jun 2022 13:58:42 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 22 Jun 2022 14:58:41 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <joshi.k@samsung.com>,
	<gost.dev@samsung.com>, <k.jensen@samsung.com>
Subject: [PATCH v3 0/2] nvme: Enable generic interface (/dev/ngX) for
 unknown command sets
Date: Wed, 22 Jun 2022 15:55:54 +0200
Message-ID: <20220622135556.2185991-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7djPc7pCCpuTDM70qVisXH2UyWLSoWuM
	FvOXPWV3YPbYtKqTzWPzknqP3Tcb2AKYo7hsUlJzMstSi/TtErgyvszvYCm4yFPxYtJX9gbG
	eVxdjBwcEgImEo2LzboYuTiEBFYwSsxe858dwvnCKLHxcCtTFyMnkPOZUWL+D1EQG6Rh9YlL
	bBBFyxklZnU8YoRwgIpWrv0IldnMKLF8/SRGkBY2AR2J82/uMIPsExFQldjXYgsSZhbIlWic
	9wYsLCwQI3HpZCFImAWo4uO16WwgNq+ArcTb8w+ZIBbLS7Rdn84IUs4soCmxfpc+RImgxMmZ
	T1ggJspLNG+dzQxRriixZc53Vgi7VuLUlltMIJdJCCzlkLh16RUrxPcuEhPXZ0LUCEu8Or6F
	HcKWkfi/cz7U2myJnVN2Qc0skJh1ciobRKu1RN+ZHIiwo8TbOXvYIcJ8EjfeCkJcwycxadt0
	Zogwr0RHmxBEtZrEjqatjBMYlWchvDILySuzkLyygJF5FaN4amlxbnpqsVFearlecWJucWle
	ul5yfu4mRmCSOP3v+JcdjMtffdQ7xMjEwXiIUYKDWUmE14Z7Q5IQb0piZVVqUX58UWlOavEh
	RmkOFiVx3uTMDYlCAumJJanZqakFqUUwWSYOTqkGJq+T4dufTa+baHh0bUWa4rUwTb2FSopP
	qta/28B+ovts1qrJHSopfGVP5ydfs30oF/umQC5Xa9c9zbAvMx/l2ysHrnvxyt6Dg+HJeldb
	5fLdkxM+J06ed3HNXoEJfyOtN4c2SehvW+tevzHu8/s7Xx7+vp2iG/xn9Y2S5um2yz+vvrE9
	u6vx/MK6DccKlq/6OXHXWU6OEHHOyvWB+wT5hPbKX887nOT8daGWsvniyCN6Z57sa5jRtObj
	tKpdh7MWMHNOSVj1/Uu7QFJXi/IK+U+ty0ulH+0LeR0brHNQsbzD+uGVyT/c7q/xyP6aVnqX
	JW+jmdHCeXFnwn76h7i8+H05qvinyMHlTId1J5g3LfijxFKckWioxVxUnAgALRssu4EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e/4PV0hhc1JBvP2slqsXH2UyWLSoWuM
	FvOXPWV3YPbYtKqTzWPzknqP3Tcb2AKYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
	zWOtjEyV9O1sUlJzMstSi/TtEvQyvszvYCm4yFPxYtJX9gbGeVxdjJwcEgImEqtPXGLrYuTi
	EBJYyihxo7eNDSIhI/Hpykd2CFtY4s+1Lqiij4wS3ccvsUI4mxklemedYwKpYhPQkTj/5g5z
	FyMHh4iAqsS+FluQMLNArkTjvDdgYWGBKInW6TogYRagio/XpoPt4hWwlXh7/iETxC55ibbr
	0xlBypkFNCXW79KHKBGUODnzCQvERHmJ5q2zmSHKFSW2zPnOCmHXSnz++4xxAqPQLITuWUi6
	ZyHpXsDIvIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwNrYd+7llB+PKVx/1DjEycTAeYpTg
	YFYS4bXh3pAkxJuSWFmVWpQfX1Sak1p8iNEU6JuJzFKiyfnA6MwriTc0MzA1NDGzNDC1NDNW
	Euf1LOhIFBJITyxJzU5NLUgtgulj4uCUamByeDD18IvqvB9fXtzl3qCqxNfBkNQnnSHk/8/I
	efOTU6YNhh9qpxUta/kxTX/vQaenMx+kVNmk7J+5l9mvp9V1nsESQ+bTMp9y/fS/aXkqbylb
	uf9sfeiyTVlXvs67vUD8GHvSEpuAZ7sCj1383KYwl7lHYv0VwxzZQzyMAjxr12q2nuli7Jy2
	6X1V7a1l3dW9Rg8CTfwSp95JKksXnndQ/EC9iY2dSVzqHbviv18XBgmX/T18+Nm3Pd6zXWcV
	3WZs/hfrUVZ/remUTbaq3N3S505ni2u+btirqfxk+vNXyQtWyzxqCOoIKbMX3lIaw3TWJHzt
	lTtVh9r5+XfkpdscvGZyTic8MHvxAe/qlUJKLMUZiYZazEXFiQCSUIuVFgMAAA==
X-CMS-MailID: 20220622135842eucas1p21d3cadfa3f9dd1bff4fe531472270b88
X-Msg-Generator: CA
X-RootMTR: 20220622135842eucas1p21d3cadfa3f9dd1bff4fe531472270b88
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220622135842eucas1p21d3cadfa3f9dd1bff4fe531472270b88
References: <CGME20220622135842eucas1p21d3cadfa3f9dd1bff4fe531472270b88@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_065854_302611_39E733A2 
X-CRM114-Status: GOOD (  15.50  )
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

Currently block and char interface do not show up for any command set other than
NVM and ZNS. This series enables char interface to come up for unknown command sets.

Patch 1: Is prep. It allows the re-use of nvme_mpath_add_disk for
supported as well as independent command sets.

Patch 2: The following functions become aware of whether the command set is
independent or not: nvme_alloc_ns and nvme_validate_ns. A switch statement
is introduced in each of them to call the relevant helper to identify and
update the namespaces.  nvme_update_ns_info_cs_indep is added to update
command set independent devices.

Changes since V2:
- Removed unnecessary include to types.h
- Call nvme_identify_ns_cs_indep only once and reuse the created
  independent id in the nvme_alloc_ns call. We call
  nvme_identify_ns_cs_indep regardless of ctrl->cap & NVME_CAP_CRMS_CRIMS
  value
- Replace 'if' with 'switch' statements making it explicit that the command
  set independent functions are used when the command set is not NVM nor
  ZNS.
- Set the hidden flag in the multipath case so the block device does not
  come up when multipath is enabled.

Changes since V1:
- Use command-set independent id-ns to enable unknown command-sets

Joel Granados (2):
  nvme-multipath: refactor nvme_mpath_add_disk
  nvme: enable generic interface (/dev/ngXnY) for unknown command sets

 drivers/nvme/host/core.c      | 132 ++++++++++++++++++++++++----------
 drivers/nvme/host/multipath.c |   6 +-
 drivers/nvme/host/nvme.h      |   5 +-
 3 files changed, 98 insertions(+), 45 deletions(-)

-- 
2.30.2


