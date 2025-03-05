Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BBEC19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 07:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=TqTMIzOu/gxWCqxo2RhLijjV18qKrUTqkY9kGAPDnjc=; b=2XwDR42dlemWKIJ2skNdV7d2pK
	GKRkcNv4RBq0pY1qJDKnqjBOWOiAGRGFMMd6hglcDlmOjjxzAEKD9rIZtviH/koJ25TFjCHko/ITH
	9MDxTEbjvpTKWYL2WKYroZFF6cmkOJ03Eq0uXN3oRGCfv/5MfAYnmb/Yk5xUNB6AZY+x8mFeBKj4u
	1kZR9f8tUXB0Cq8uiTMkfQaKTxG3NlkVHUPrIJ2+4KpNWzsWyzwMhSgoUPfzEBHCzBZX3uMH53/is
	gi07cTEItV3ftkEPa6dGOrEERhZIWzHX0VUha+z8g3NVCZTwvIj7f3yLZZ01EkksLxErwJ02Y/PQW
	LGlyia4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpjWc-00000007HlE-0Aw8;
	Wed, 05 Mar 2025 07:50:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpjNd-00000007GOB-20u4
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Mar 2025 07:41:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
	bh=TqTMIzOu/gxWCqxo2RhLijjV18qKrUTqkY9kGAPDnjc=; b=Elsp5u8xZHiRhm8e4D5nne3g2n
	/tMoWdlOEWil9SNJKvJa863ApUCeN4Tyi9FT81K0X5vPaYTz2RDrJ0Q4y14ca0fsdGhhq3j5h0dHg
	pbk4lCLt/oY2QFTZfuC2NQeHMDVKCg9rC/4vbsEZsd7RyqZ+BqdrhnNWjATqT4y+BM8NQriDu3T9z
	hKoU8Aw7ndkG7nExRkXEkpEWb7zUmIxmXdOovrFA7l+AkeslT62SvHbhMjVrjQuA0CN7bwh9atrnZ
	M99veYCsTO4ovHf5tU9QlNNsuUmH6ph9XxRglBYrWzI87pMbvz6rwYjujphQwydiiknYpwkTyxPvO
	B7p0rTAQ==;
Received: from mailout4.samsung.com ([203.254.224.34])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpjNP-00000000PFC-11yN
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 07:41:24 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250305074105epoutp04c36a0856def46152b0f2fd5468819131~p2DfiKN4G1563415634epoutp04R
	for <linux-nvme@lists.infradead.org>; Wed,  5 Mar 2025 07:41:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250305074105epoutp04c36a0856def46152b0f2fd5468819131~p2DfiKN4G1563415634epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741160465;
	bh=TqTMIzOu/gxWCqxo2RhLijjV18qKrUTqkY9kGAPDnjc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=BCUqLNUg3AQK+eFt6t3zq1DmCGkSiH2rEkVbmJo9nlExtaG6GgbD/D8NotUIAPcq1
	 eoC/j+cPhBEaigpK/lyaqE9OsrWr+LjUk+9hZaS5mw/DmqMwwPxUAFfWUOuabBWa0t
	 We31/fyZ+gyQyRuApQfOEf6jcaqGFhMcq2otF7bc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250305074105epcas5p2ea7197f1fa88dd7766f2a65ad5139f88~p2DfFpRxB3180831808epcas5p27;
	Wed,  5 Mar 2025 07:41:05 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z74H33PL7z4x9QD; Wed,  5 Mar
	2025 07:41:03 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.1E.20052.F0008C76; Wed,  5 Mar 2025 16:41:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250305063900epcas5p38bb20587ccf4310cfb0f3307180eb536~p1NSb-V4G1936819368epcas5p3U;
	Wed,  5 Mar 2025 06:39:00 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250305063900epsmtrp2d7a9c79c37c0042a29392c21b8b0893f~p1NSVvIPN0758807588epsmtrp2B;
	Wed,  5 Mar 2025 06:39:00 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-0a-67c8000ff15f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	49.53.33707.481F7C76; Wed,  5 Mar 2025 15:39:00 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250305063858epsmtip1ca541a816175f86a904b65b74ee49cf7~p1NQ6wL351091010910epsmtip19;
	Wed,  5 Mar 2025 06:38:58 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Cc: anuj1072538@gmail.com, nikh1092@linux.ibm.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, dm-devel@lists.linux.dev, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH v3 0/2] Fix integrity sysfs reporting inconsistencies
Date: Wed,  5 Mar 2025 12:00:31 +0530
Message-Id: <20250305063033.1813-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmhi4/w4l0g4MfJC0+fv3NYtE04S+z
	xeq7/WwWCxbNZbFYufook8XeW9oW85c9Zbfovr6DzWL58X9MFncvPmV24PLYOesuu8fls6Ue
	ExYdYPTYvKTe48XmmYweu282sHl8fHqLxaNvyypGj8+b5AI4o7JtMlITU1KLFFLzkvNTMvPS
	bZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOVFIoS8wpBQoFJBYXK+nb2RTll5ak
	KmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ5zs28lWcI+14vzzI+wNjI9Y
	uhg5OSQETCS23dvICmILCexmlNi03RLC/sQosWJZUBcjF4S9+/9LNpiGuzN/s0IkdjJKXF15
	ng3C+cwo8ezMN3aQKjYBdYkjz1sZuxg5OEQErCXevxYHqWEWOMso8bfxP9hqYQFXiX9nl4Gt
	ZhFQldh47ysTiM0rYCGx/uBSqPPkJWZe+s4OEReUODnzCVicGSjevHU2M8hQCYGv7BKTtnUz
	QzS4SFy+v5MRwhaWeHV8CzuELSXx+d1eqBfSJX5cfsoEYRdINB/bB1VvL9F6qp8Z5GhmAU2J
	9bv0IcKyElNPrWOC2Msn0fv7CVQrr8SOeTC2kkT7yjlQtoTE3nMNULaHxO5ra9ghQRor0XXk
	F/MERvlZSN6ZheSdWQibFzAyr2KUTC0ozk1PLTYtMMxLLYfHa3J+7iZGcGLV8tzBePfBB71D
	jEwcjIcYJTiYlUR4X586ni7Em5JYWZValB9fVJqTWnyI0RQYxhOZpUST84GpPa8k3tDE0sDE
	zMzMxNLYzFBJnLd5Z0u6kEB6YklqdmpqQWoRTB8TB6dUAxNLn7Hor/8zNW+nbpNn/JFi1rfx
	su/kuSL3s/0efViY1vDoxu/prNdnrC/n/CcpHXhuEW97uNGe9Emb7pfc1tF1E+X/4LPQfcPZ
	Iw/SbS6kPFcOYu/wP2az8Oj97S3HJz/8kvBxsdKJ951/p1ny194M2yLFG5+Rf3sFi2RWxOI1
	f+pvGE37wX0kxFRt7+Ir6oGp346qWzxtf7IqJLyu/kexcXDLvrUvfTlXpf5huZrxbYq67xar
	fqvg+AMuHz5o36ic99apaHZaWuvUC5dj56Q0O0ilLmTap/WBT3FTabn+qcSbFQE3i0Mm3Kr1
	jA+pO2DTGJzRpLnoWeDXWul3imbr5izdkOzHfkfmySuTlulKLMUZiYZazEXFiQAmnHv6NQQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnG7Lx+PpBtdXSVh8/PqbxaJpwl9m
	i9V3+9ksFiyay2KxcvVRJou9t7Qt5i97ym7RfX0Hm8Xy4/+YLO5efMrswOWxc9Zddo/LZ0s9
	Jiw6wOixeUm9x4vNMxk9dt9sYPP4+PQWi0ffllWMHp83yQVwRnHZpKTmZJalFunbJXBlnOzb
	yVZwj7Xi/PMj7A2Mj1i6GDk5JARMJO7O/M3axcjFISSwnVFizuoWqISExKmXyxghbGGJlf+e
	s0MUfWSUuDLzCViCTUBd4sjzViCbg0NEwF7i3o8KkBpmgcuMElNefWEFqREWcJX4d3YZmM0i
	oCqx8d5XJhCbV8BCYv3BpVDL5CVmXvrODhEXlDg58wlYnBko3rx1NvMERr5ZSFKzkKQWMDKt
	YhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAgOb62gHYzL1v/VO8TIxMF4iFGCg1lJhPf1qePp
	QrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUwq7W53LHep
	3w2aI7Z3EQfjvbNiCYzN8xqMP+o93tfk7XTL/gtD6bUMufnhATv+Ts4Q+bOs8ir/mYLT6X8W
	z/QXnJ8jt0wo1+WNvnnN5+xEyVf70nL5BMTPRh4NSHqu+LFnQr7hSk72+pCH+hYGUcId9oy8
	JX98ulw9inidSs6IbnOrWun3o9Kvb//+tva23BMa103MlxbpWj1fp/t/8rFLM/i7LhUVTjrF
	o2Vi87z97ap1DOJGsXdnF2tcimkIqd5741vP4YM3frcd/K28+ip7p71T7xzRpdxLFJMnmq6c
	HK+xUHjWu+WrmG44sN/W07WdYijJ2lmY+qHDKCZV8+Lx3hj1XrtHNvKz7grdVWIpzkg01GIu
	Kk4EAJFyOqTeAgAA
X-CMS-MailID: 20250305063900epcas5p38bb20587ccf4310cfb0f3307180eb536
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250305063900epcas5p38bb20587ccf4310cfb0f3307180eb536
References: <CGME20250305063900epcas5p38bb20587ccf4310cfb0f3307180eb536@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_074120_506256_68144949 
X-CRM114-Status: GOOD (  11.21  )
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

Patch 1: Ensures DM devices correctly propagate
device_is_integrity_capable
Patch 2: initialize nogenerate and noverify correctly

Changes since v2:
Ensure that integrity capability gets propogated correctly for all cases
in DM (hch)

Changes since v1:
initialize BLK_INTEGRITY_NOGENERATE and BLK_INTEGRITY_NOVERIFY in
blk_validate_integrity_limits rather than doing it in the driver (hch)

Anuj Gupta (2):
  block: ensure correct integrity capability propagation in stacked
    devices
  block: Correctly initialize BLK_INTEGRITY_NOGENERATE and
    BLK_INTEGRITY_NOVERIFY

 block/blk-settings.c | 51 +++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

-- 
2.25.1


