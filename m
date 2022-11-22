Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101DAC43219
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=0U5lbWgR/xgBdBcQ6cf1yCIcbPX5uUV5fZhczu/TlAg=; b=fEZevnjkAA8I1jTRrniPGVaUaF
	/mbIvehrGBTCpLlUdlbECWxenBJaxlmLRDif+z4tgQmzejDxyxr+KQTYaizYLlvOJSDWzD+ToOvpI
	yUD7BADGVrLQ1XOkecUn/1n8VQdrTkSWAZnusd/PDTrGdJgBmPsTpInJSNrvjStaNr7iSwjFkZFh6
	4pGinMWNOEydKLfn5cvE90SA28fxqUWQwAjjTsCe1SRcrUcWm8Iyl8XEgqchULCGWQ5Uc/e1uFHPN
	X31hlIuKsedq0LLsVGwedlY7WFsf1hmmDlNECFVl1FmyIUYow5LG5d9VXtU11RzIm86FD3/5kMohm
	lwKXLN+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxPZi-0070Ah-EZ; Tue, 22 Nov 2022 09:28:18 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxPY6-006yya-Dh
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 09:26:41 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221122092632euoutp018e2ab6fe417fd94de813bd3cbf536fa2~p3feN5Ojf0316503165euoutp01m
	for <linux-nvme@lists.infradead.org>; Tue, 22 Nov 2022 09:26:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221122092632euoutp018e2ab6fe417fd94de813bd3cbf536fa2~p3feN5Ojf0316503165euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1669109192;
	bh=0U5lbWgR/xgBdBcQ6cf1yCIcbPX5uUV5fZhczu/TlAg=;
	h=From:To:CC:Subject:Date:References:From;
	b=BYP/pgYOLVLH02zbetFNNk3PuYp55xjOTyMb9FHRTKnBMmEFO0ptOPTXhcid1ri6H
	 ib1tqwcFYMW/s9sRW5ii9Zj7BbOI7J6qYDQJOT77ef65csHVEeCjy6MW6W+BFBiSes
	 paPh0wUjE/AfycO5aJN0cTqljPYHqhe71VXGF5qY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221122092632eucas1p1a629118d01160d1857b984ce1a25e84c~p3feDRJnJ1926919269eucas1p1x;
	Tue, 22 Nov 2022 09:26:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id ED.CC.09561.7C59C736; Tue, 22
	Nov 2022 09:26:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221122092631eucas1p2c60b7bca62b950b8f41367af79ff018c~p3fdsVZvO2130721307eucas1p23;
	Tue, 22 Nov 2022 09:26:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221122092631eusmtrp24ded5361e04a8631c7f8e2227a886713~p3fdrkHPW0180001800eusmtrp28;
	Tue, 22 Nov 2022 09:26:31 +0000 (GMT)
X-AuditID: cbfec7f2-0b3ff70000002559-51-637c95c79c74
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id DB.9F.09026.7C59C736; Tue, 22
	Nov 2022 09:26:31 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221122092631eusmtip12e7a595136bde5b96b422edfdf58f1a0~p3fdhxlUN0227802278eusmtip1h;
	Tue, 22 Nov 2022 09:26:31 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 22 Nov 2022 09:26:30 +0000
From: Joel Granados <j.granados@samsung.com>
To: <sagi@grimberg.me>, <hch@lst.de>, <kbusch@kernel.org>,
	<chaitanyak@nvidia.com>
CC: <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH v4 0/1] nvme : Add ioctl to query nvme device attributes
Date: Tue, 22 Nov 2022 10:22:43 +0100
Message-ID: <20221122092244.899894-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOd3jU2uSDToPWlu8P/iY1WLl6qNM
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/YwtgjeKySUnNySxL
	LdK3S+DKmLb8LltBo3DF+SerGRsYj/B3MXJySAiYSOz6cImxi5GLQ0hgBaPEp2f3mSCcL4wS
	Pz/ehMp8ZpSY9XYCK0zLtA8zoBLLGSXe3PjDDle16s8DZpAqIYHNjBKX10mD2GwCOhLn39wB
	i4sIhEh83PIbbBKzQJrE+97j7CC2sICHxLVvC1lAbBYBVYkZU3+C1fAK2EhMP/oMarO8RNv1
	6UCbOYB6NSXW79KHKBGUODnzCQvESHmJ5q2zmSHKFSW2zPkO1VorcWrLLbDXJASOcEh8OvGL
	HSLhIrH87hEWCFtY4tXxLVBxGYn/O+czQdjZEjun7IIaWiAx6+RUNpAbJASsJfrO5ECEHSWW
	TZ3KAhHmk7jxVhDiHD6JSdumM0OEeSU62oQgqtUkdjRtZZzAqDwL4ZdZSH6ZheSXBYzMqxjF
	U0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQKTyul/xz/tYJz76qPeIUYmDsZDjBIczEoivPWe
	NclCvCmJlVWpRfnxRaU5qcWHGKU5WJTEedlmaCULCaQnlqRmp6YWpBbBZJk4OKUamDrThKZL
	brj87aKmkFiO8/Wa7EffxGbv+i/sv+435+2L3LJHblhO2B7e6+FltC/5jJm6hICbs0b5iSDn
	v7JVU5V/Z+uVNf9kDOG2ff1Sa9ftlIkV3i+lOhMS21t+7zBmP7xr+oOlfELfMlzUg/46Zp5U
	/n3hqGHu21c8C/4d/LSVidXmfNeB1rWnNn99euzer1/nzTKO3YzfsI8531Yv3sbTbl7DhNUq
	x/a2Hf+qyKy1UtOn8r7bW/cn0xau//O6WGBue7WtweHDtesPNLfvO+cpdPEbf5g924GHvYks
	D9T69n5h8nnB8EnysOHCxw4+YgmeqlOSnGwjPz9zOs59ObZ5+fRqR0WVPbFTSw6HhSuxFGck
	GmoxFxUnAgAiZc7emQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7rHp9YkG1y4pWzx/uBjVouVq48y
	WUw6dI3RYv6yp+wW616/Z3Fg9Th/byOLx6ZVnWwem5fUe+y+2cDm0dv8ji2ANUrPpii/tCRV
	ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY9ryu2wFjcIV55+s
	ZmxgPMLfxcjJISFgIjHtwwzGLkYuDiGBpYwSb3smM0MkZCQ+XfnIDmELS/y51sUGYgsJfGSU
	WNboAWFvZpRY3m8KYrMJ6Eicf3MHrFdEIETi45bfrCA2s0CaxPve42BzhAU8JK59W8gCYrMI
	qErMmPoTrIZXwEZi+tFnrBC75CXark8HOogDqFdTYv0ufYgSQYmTM5+wQIyUl2jeOhvqTEWJ
	LXO+Q7XWSnz++4xxAqPQLITuWUi6ZyHpXsDIvIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw
	hrYd+7llB+PKVx/1DjEycTAeYpTgYFYS4a33rEkW4k1JrKxKLcqPLyrNSS0+xGgK9M1EZinR
	5HxgFOeVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTBxHk/7bLPH
	IULtZsrCM8tvmSypvDOP432cYPTPF68Xm/2yvxk94fWce9kqSnO2Cs5IalcwfmVpeD20oduc
	LevJyYvM7/2CbPInWvfy/JuheFEx3279+e2Z8z+efbfiS0jHv98hMaIzdkUJVBhHszBO+vu8
	UVJxj2XQq8Z6tyfXtrM/t9+TOfmi0SetN5wCwnP/HpM2EklxZUw9c+nGnleG3331T/65s6GS
	76cyZ+ShzfODTV0yLyhk6THuX+7QvydNQM4wad8BB6PaydO+LUnavv7YbB31O54Hjq1fc/bP
	a5mjP9uCVZc8OWvL/mozg+Kyp1VO34+590h+SPNhYZaYlh3y5tLO3sz8M4/MH+sFKLEUZyQa
	ajEXFScCAA43cx0qAwAA
X-CMS-MailID: 20221122092631eucas1p2c60b7bca62b950b8f41367af79ff018c
X-Msg-Generator: CA
X-RootMTR: 20221122092631eucas1p2c60b7bca62b950b8f41367af79ff018c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221122092631eucas1p2c60b7bca62b950b8f41367af79ff018c
References: <CGME20221122092631eucas1p2c60b7bca62b950b8f41367af79ff018c@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_012639_101018_02F2EB8E 
X-CRM114-Status: GOOD (  16.24  )
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

What?
In this patch I add an ioctl that provides nvme controller attributes to
the user that can open the char device file. We also provide them for the
block devices for convenience.

Why?
Applications with write permissions should not need to be privileged to
write to the device. With Kanchan's latest patch
(https://lore.kernel.org/linux-nvme/20221020070205.57366-1-joshi.k@samsung.com/)
the nvme IO and identify commands in passthru now follow device
permissions; however there are still some controller attributes like
minimal data transfer size (MDTS) which need a privileged user to be
queried.

How?
Added an ioctl (NVME_IOCTL_GET_ATTR) that fetches existing and new
attributes from nvme_ctrl struct. The new attributes are dmsl, vsl and wusl
from the I/O command set specific identify controller data structure in the
nvme spec.

I have made the call extensible by embedding the struct size as the first
member and using it as a version. I call copy_struct_from_user to make sure
that struct members that are unique are zeroed out.  For this I followed
in the steps of the openat2 system call [1] and the extensible ioctl for
vfio [2].  Another interesting reference for this is here
https://lwn.net/Articles/830666/

Feedback is greatly appreciated :)

[1] https://github.com/torvalds/linux/commit/fddb5d430ad9
[2] https://github.com/torvalds/linux/blob/master/include/uapi/linux/vfio.h#L56

V4:
* Fixed an error where the ioctl number would change if new members were
  added. Now I use _IO instead of _IOWR to avoid leave the ioctl number
  static. This is very similar to the implementation contained in
  https://github.com/torvalds/linux/blob/master/include/uapi/linux/vfio.h

V3:
* Removed unneeded comments in nvme_ioctl.h
* Added a comment to the nvme_sectors_to_mps function
* Moved size checks to nvme_check_size in core.h
* Changed struct initialization to match what we use in nvme driver {} vs
  {0}

V2:
* Changed comment from // to /**/
* Took a call out from an if condition and assigned it to ret var.

Joel Granados (1):
  nvme : Add ioctl to query nvme attributes

 drivers/nvme/host/core.c        |  8 ++++-
 drivers/nvme/host/ioctl.c       | 61 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h        | 11 ++++++
 include/uapi/linux/nvme_ioctl.h | 23 +++++++++++++
 4 files changed, 102 insertions(+), 1 deletion(-)

-- 
2.30.2


