Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D33D13595
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 03:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bo6Ea5i0R6emGG7nj9+WppTEgZq02wQoJLP9S61V1so=; b=enA5+1MMsBiNUUbjoDa2iSt0vJ
	ck88B9023SXmeDDSMGyA4WCCzp6SlrzdfE9X9lAbjvybYeqWL2vKEyTV1guAlQuqBhVnUnEi9smS0
	NAsRltXYQ2FLwx8SAhjb7N2EFSOzHPtQbDfkW5Y+h5qyPSiW0Gqy8urOI16FzV8uW+35w0jCkdlvY
	nokobyVSAst9vPQAGh4eaf8yZEV5BNdC7jG33XtVrpARHFSvp0TWtcU9zRlXgQmJC/oU9HMWjEPCs
	V/G4I1cizr13QvHY8zCk1E3778rmjQXkQOe4VEIZa0Z8IywLcQHupIUPXrw4Mpc00seKis0+sj889
	43eC1F7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5GtT-00000009Ucx-1OfM;
	Mon, 28 Oct 2024 03:58:15 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Gqe-00000009UQu-0eTm
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 03:55:23 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241028035511epoutp01b778e61d9f13070406c94b16d4d5f502~CgZttXxWO3080930809epoutp01U
	for <linux-nvme@lists.infradead.org>; Mon, 28 Oct 2024 03:55:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241028035511epoutp01b778e61d9f13070406c94b16d4d5f502~CgZttXxWO3080930809epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730087711;
	bh=bo6Ea5i0R6emGG7nj9+WppTEgZq02wQoJLP9S61V1so=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cuWgeGAAxiRPYto8Vna81W6OItruMIz3jjDQB6H+MCaRHXO6PkfHOQZNTCZRajkVb
	 CGGuM6JRagmkzQTN5OT43pqHs67vE2iwQqT64BHiwsoZRz0zF+ba8qNulbJk4vyF/P
	 LLa4m1HHm6PYkAetkSIuadaCKSpaF0x7/zmEIG6k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241028035510epcas5p2656031a5840a38aca3e05b9581123591~CgZtMYkcw2900229002epcas5p2k;
	Mon, 28 Oct 2024 03:55:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XcKKS43Vpz4x9Q5; Mon, 28 Oct
	2024 03:55:08 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F1.A6.09420.C1B0F176; Mon, 28 Oct 2024 12:55:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241028035435epcas5p4dbd78e5f7bacde9fc302fcfde86453b9~CgZLzQgVv1472514725epcas5p4c;
	Mon, 28 Oct 2024 03:54:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241028035434epsmtrp2eb03ec25eb9f71578219fd904e79a04d~CgZLyUu_81877218772epsmtrp2k;
	Mon, 28 Oct 2024 03:54:34 +0000 (GMT)
X-AuditID: b6c32a49-33dfa700000024cc-a9-671f0b1cde6c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	02.26.08227.AFA0F176; Mon, 28 Oct 2024 12:54:34 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241028035432epsmtip2358aad8e30b6e4241266bb0a578e7b49~CgZJ1ATw50427304273epsmtip2a;
	Mon, 28 Oct 2024 03:54:32 +0000 (GMT)
Date: Mon, 28 Oct 2024 09:16:48 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 04/11] block: define meta io descriptor
Message-ID: <20241028034648.GA18956@green245>
MIME-Version: 1.0
In-Reply-To: <yq1h694lwnm.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmhq4Mt3y6wfVbUhYfv/5msZizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFkf/v2WzmHToGqPF9jNLmS323tK2mL/sKbtF9/UdbBbL
	j/9jsjg/aw67A5/Hzll32T0uny312LSqk81j85J6j903G9g8Pj69xeLRt2UVo8fm09UenzfJ
	BXBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2u
	pFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUq
	TMjOuP/as2ADW0XvuW+sDYwrWLsYOTkkBEwkrv3oYuxi5OIQEtjNKLHlcjuU84lRYsnaVijn
	G6PE/Ddv2GBavq66yAKR2MsoMWvJRSYI5xmjxMnLp8GqWARUJQ5/uMMOYrMJqEsceQ4yipND
	RMBUYvKnrWwgDcwC+5gkjl2awwySEBawk+g5sg+sgVdAV+L32otsELagxMmZT4DWcXBwChhL
	LJ4rABIWFVCWOLDtONhiCYETHBLPbzRAfeQiceg5SD2ILSzx6vgWdghbSuLzu71QL6RL/Lj8
	lAnCLpBoPraPEcK2l2g91Q92D7NAhsTa/Z+h5shKTD21jgkizifR+/sJVC+vxI55MLaSRPvK
	OVC2hMTecw1QtodE04EWNngIdTxdwDyBUX4Wkt9mIdkHYetILNj9iW0W0M/MAtISy/9xQJia
	Eut36S9gZF3FKJlaUJybnlpsWmCYl1oOj/Hk/NxNjOCUreW5g/Hugw96hxiZOBgPMUpwMCuJ
	8K6OlU0X4k1JrKxKLcqPLyrNSS0+xGgKjKyJzFKiyfnArJFXEm9oYmlgYmZmZmJpbGaoJM77
	unVuipBAemJJanZqakFqEUwfEwenVANTduR9QT9BM7/J6V6us3/2a3nWzpR8yf/1h7TZfXNN
	T57NR3bc1o2yOKrLuDz97GVtqWWlml2JJk6c+9YH/jNRFS1Z+2aKwBqmJrOel499NoQs2hLo
	uvBdxqtXod6yuiH1XW11qQmddoY+V07NzY7anx21pGHOycPBDP/q3/tNqam980Ba72iHn7mW
	z2F36Xm3LdcLsq+OrNG9crNN8n/QfTsHwanLRQ34v9syXtilFb7i7/UZDd5BaZxlXRNnbbjO
	lNx+9atRWSP3bNP64LVz3bS/L5uekNu2s3jK28rSjx9dHDUnbkr6ZWOeujiH343NaKV6+u/z
	nVfP/X9gfb6Wca7bqTe2c+u31orM71ViKc5INNRiLipOBAB9ZzhnYgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvO4vLvl0g039xhYfv/5msZizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFkf/v2WzmHToGqPF9jNLmS323tK2mL/sKbtF9/UdbBbL
	j/9jsjg/aw67A5/Hzll32T0uny312LSqk81j85J6j903G9g8Pj69xeLRt2UVo8fm09UenzfJ
	BXBGcdmkpOZklqUW6dslcGVsPfaTveADc8WKpjbmBsZG5i5GTg4JAROJr6susoDYQgK7GSVu
	fuSBiEtInHq5jBHCFpZY+e85excjF1DNE0aJk32z2UESLAKqEoc/3AGz2QTUJY48bwVrEBEw
	lZj8aSsbSAOzwD4miRW9b8ESwgJ2Ej1H9oE18AroSvxee5ENYuozRolV7x+wQCQEJU7OfAJm
	MwtoSdz495Kpi5EDyJaWWP6PA8TkFDCWWDxXAKRCVEBZ4sC240wTGAVnIWmehaR5FkLzAkbm
	VYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwZGmpbWDcc+qD3qHGJk4GA8xSnAwK4nw
	ro6VTRfiTUmsrEotyo8vKs1JLT7EKM3BoiTO++11b4qQQHpiSWp2ampBahFMlomDU6qBKdRx
	2YKrJ9ZGXFO98FgyYc+9b44aIpl2vvstei93an5MeixVZai7hENA1tO0eH/Bdj1/07tJx61P
	RrG5LF/r5TJzw6kuJW7H3b8EXLguBF1/aJ29T8H7adrPN7bLdr1XEvAXjk86deoyZ87nR37n
	ZvB25cpG1731ct9wQ/64bvzz1e2erXn8t2aXtm1mevhATCBjges7wx/5FWzuOhNPr/SfeaAm
	7ajyRrV/Aq8FzExkcpdoTJyu1BYjrHZ20Y/HuiumXD7UoDRNv3xjzN5lfnUvk2bP5xB0XWT9
	bf0nJ+nfHUz+mWEuNzjCWe+wfGgp7RM9fstiWVnnxZjTFc8NPl2JNZbIPxFyIqOxVLFUiaU4
	I9FQi7moOBEAaLCvJyMDAAA=
X-CMS-MailID: 20241028035435epcas5p4dbd78e5f7bacde9fc302fcfde86453b9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_7d6d3_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016113741epcas5p3b90adb3b43b6b443ffd00df29d63d289
References: <20241016112912.63542-1-anuj20.g@samsung.com>
	<CGME20241016113741epcas5p3b90adb3b43b6b443ffd00df29d63d289@epcas5p3.samsung.com>
	<20241016112912.63542-5-anuj20.g@samsung.com>
	<yq1h694lwnm.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_205520_888324_F699A1D5 
X-CRM114-Status: GOOD (  19.67  )
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

------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_7d6d3_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

> Not sure what to do about the storage tag. For Linux that would probably
> be owned by the filesystem (as opposed to the application). But I guess
> one could envision a userland application acting as a storage target and
> in that case the tag would need to be passed to the kernel.

I will reserve space for storage tag in the user interface for now.
That way, we can introduce and use it later when it is actually used.

> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering
> 

------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_7d6d3_
Content-Type: text/plain; charset="utf-8"


------w5-2f3KIOrSunQhSxAIo7Dy_B_SBAQB3Xz8aCSUoiMSFB8w5=_7d6d3_--

