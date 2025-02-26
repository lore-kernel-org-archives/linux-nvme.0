Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982E2C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 13:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=mYlgMANAA3/12lPDPVDBmMvxGDvs5skYaJT+zjvYVg8=; b=QzWiH+CibEJrUsWOBDJAxNHZ5c
	atTjAZcoBPqUfuEbhCLlJZ1cXzJ5HRHclJzcPLU+NYxOGFmvWZhkUdgLFioMPt+oIz7QaSULyLZX4
	O33VXX/R1utSmNeuqXF40GB3xC+8TFCJl5f21vzsBZ8ShJFwcegOuMi0iSG7CNwrByOTg/ZwqVAZU
	dYY3CwB7FQnP/TnF7fx+o8EnCof1odhsWbiT3qIn0E7qK3UylbivReCCt0gZkuzm7w80UlyLZFYZI
	4HuHgjmPfX6LxwAzsws+iUFq3qIZw2DEPvIXXiATsYfV7lVbN9i8aB/FLJ4MSGykNHzBMDp0wHA0k
	AZ53rcPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnHPO-00000003pqj-2C0W;
	Wed, 26 Feb 2025 13:25:06 +0000
Received: from [203.254.224.24] (helo=mailout1.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnFba-00000003TfS-13jE
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 11:29:38 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250226112927epoutp01a7de94c00da41288b7493100893f0439~nvp4riG1T2681126811epoutp01X
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 11:29:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250226112927epoutp01a7de94c00da41288b7493100893f0439~nvp4riG1T2681126811epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740569367;
	bh=mYlgMANAA3/12lPDPVDBmMvxGDvs5skYaJT+zjvYVg8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=fup7pU9DYOY4ikf5gTsVY33fY0x4zAQoa5c2tMO4Uzdk8Zm8uiybYlruNtHbOIFSv
	 VwzFry0KbmI4AYmI4ii01jqiuqFzpXknWokQshB2BOB5PeEUcjtuG2NRhzdTsGnlDR
	 fAn4/YaLczh3cXml+AlkJq1X0u7yjq1ziS99Bvfs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250226112922epcas5p190c013ea4bad09aee59696e3431204f0~nvpzg_reI2155121551epcas5p1y;
	Wed, 26 Feb 2025 11:29:22 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z2sgh1Skpz4x9Pp; Wed, 26 Feb
	2025 11:29:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	30.27.19933.01BFEB76; Wed, 26 Feb 2025 20:29:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250226112855epcas5p330a1f2e300a44ddea5189ff906de7788~nvpamDUgx1479014790epcas5p3t;
	Wed, 26 Feb 2025 11:28:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250226112855epsmtrp16f0b74908e6bcf174d407a437d511e6c~nvpalW5mY2293422934epsmtrp1v;
	Wed, 26 Feb 2025 11:28:55 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-91-67befb104f79
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.60.18949.7FAFEB76; Wed, 26 Feb 2025 20:28:55 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250226112853epsmtip2bc828ba372ecf4dd6b3c9e7ddc173556~nvpZJtslA0998309983epsmtip2d;
	Wed, 26 Feb 2025 11:28:53 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Cc: anuj1072538@gmail.com, nikh1092@linux.ibm.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, dm-devel@lists.linux.dev, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH v2 0/2] Fix integrity sysfs reporting inconsistencies
Date: Wed, 26 Feb 2025 16:50:33 +0530
Message-Id: <20250226112035.2571-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmhq7A733pBltb2S0+fv3NYtE04S+z
	xeq7/WwWCxbNZbFYufook8XeW9oW85c9Zbfovr6DzWL58X9MFncvPmV24PLYOesuu8fls6Ue
	ExYdYPTYvKTe48XmmYweu282sHl8fHqLxaNvyypGj8+b5AI4o7JtMlITU1KLFFLzkvNTMvPS
	bZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOVFIoS8wpBQoFJBYXK+nb2RTll5ak
	KmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZzxse8pesIel4l/HKsYGxmvM
	XYycHBICJhIN0zoZuxi5OIQEdjNKfL/9nRXC+cQoMefeJBYI5xujxNIZa5hgWi6teAbWLiSw
	l1Hi3ZRoiKLPjBK/2iezgCTYBNQljjxvBZrLwSEiYC3x/rU4SA2zwFlGib+N/8FqhAVcJTY8
	WMoOYrMIqErs+P8IbCivgIXEmVtfoe6Tl5h56Ts7RFxQ4uTMJ2C9zEDx5q2zmUGGSgg0ckh8
	fL8UqsFFYsnkpYwQtrDEq+Nb2CFsKYmX/W1QdrrEj8tPob4pkGg+tg+q3l6i9VQ/M8jRzAKa
	Eut36UOEZSWmnlrHBLGXT6L39xOoVl6JHfNgbCWJ9pVzoGwJib3nGqBsD4k3v2awQgIrVmLu
	ygbmCYzys5C8MwvJO7MQNi9gZF7FKJlaUJybnlpsWmCUl1oOj9jk/NxNjODUquW1g/Hhgw96
	hxiZOBgPMUpwMCuJ8HJm7kkX4k1JrKxKLcqPLyrNSS0+xGgKDOOJzFKiyfnA5J5XEm9oYmlg
	YmZmZmJpbGaoJM7bvLMlXUggPbEkNTs1tSC1CKaPiYNTqoHpgLCYU0OYss/1uF9hZxZfdJ1c
	I9rtdmzdglO/c1YsPxr3+Zf+KVtz6XdMn2RvHWLtfrq21KcrJOLit+nWsk8OXZz1m/F/TV7P
	vZOljopLlu7t3eZ951S55bzddaf+6M4t5zin1nnwycTHblmlu3y3Kcpozyvdf3nP1OYTvle5
	Zu17fdZn7lL7TfV3Dac2qxyvaDt//QzXw72l0ysE14dWcroqlW/cMUHwqPlxzUk705ftWFBw
	42JI9o/lynuX/+Q2avV5XmlkzvfBk8fmVZN9+eN5fnaZXE7XpFdclmqL9T60uOm16Y6WmlX3
	Jix+rr6dm6P0lLHl6Tb9lRfWVv/necPDrmMZpbjh68cXi2I+2CqxFGckGmoxFxUnAgC/YZHx
	NgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSvO73X/vSDV4c47D4+PU3i0XThL/M
	Fqvv9rNZLFg0l8Vi5eqjTBZ7b2lbzF/2lN2i+/oONovlx/8xWdy9+JTZgctj56y77B6Xz5Z6
	TFh0gNFj85J6jxebZzJ67L7ZwObx8ektFo++LasYPT5vkgvgjOKySUnNySxLLdK3S+DKeNj2
	lL1gD0vFv45VjA2M15i7GDk5JARMJC6teAZkc3EICexmlHi2tIUFIiEhcerlMkYIW1hi5b/n
	7CC2kMBHRomzG7JBbDYBdYkjz1uBajg4RATsJe79qACZwyxwmVFiyqsvrCA1wgKuEhseLAXr
	ZRFQldjx/xHYYl4BC4kzt75CHSEvMfPSd3aIuKDEyZlPwG5gBoo3b53NPIGRbxaS1CwkqQWM
	TKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKDXEtrB+OeVR/0DjEycTAeYpTgYFYS
	4eXM3JMuxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb694UIYH0xJLU7NTUgtQimCwTB6dUA1PB
	Rte7zYrOewOFfH8FPlFQiV3F9Sf2mtTPT7kqLK6nhHcKuu+eFxTwYeM/ofdtSlc668ziuo4r
	Cnq+kPt66t/WWy1fdiq2rfn87nrgZaeel6ufnTaM0uT/aBqlf7I+WaRPfM46ow+bwmdlcu1e
	IjvfUaBKxe3jg6vhbHyPK9mNXFe1hVhkbHMJP+NjHLxWJvXloab1TGdfMPbtCjBbE3Li0y6/
	JfUWX/qy7Wy+Kf4/bnlV6tLkyspOFf1wNiu9UhOOHS+qC18vu/R62vPkyj2CNmePZ3B72lTv
	/Pope/aKfz8mcjxs1+JLWfOi90RFacV2nzeijRHzOQJ9Vny8uYnrp8aype7TMxVOsW3dVqbE
	UpyRaKjFXFScCABNdJ7t4QIAAA==
X-CMS-MailID: 20250226112855epcas5p330a1f2e300a44ddea5189ff906de7788
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250226112855epcas5p330a1f2e300a44ddea5189ff906de7788
References: <CGME20250226112855epcas5p330a1f2e300a44ddea5189ff906de7788@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_032934_955725_F1E449C6 
X-CRM114-Status: GOOD (  13.28  )
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

Patch 1: Ensures DM devices correctly propagate device_is_integrity_capable
Patch 2: initialize nogenerate and noverify correctly

v1 -> v2
initialize BLK_INTEGRITY_NOGENERATE and BLK_INTEGRITY_NOVERIFY in
blk_validate_integrity_limits rather than doing it in the driver (hch)

Anuj Gupta (2):
  block: ensure correct integrity capability propagation in stacked
    devices
  block: Correctly initialize BLK_INTEGRITY_NOGENERATE and
    BLK_INTEGRITY_NOVERIFY

 block/blk-settings.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.25.1


