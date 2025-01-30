Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A93C0218A
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2025 09:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=HL2b46SyDwrvkIWYoi81OvrWq4Eysr5AGb4a/UeMMQM=; b=p8wjrpcTLBZ6TzEOzJVUcFW7dC
	5ogQe8KFROZhg6V22P1pcqrk+a/Fit5EFPzuDfxkIrRGOvE9/cKtWtJ9U2aX1oArl3ZvlkRGJpcm4
	JpBIVX9hEmua0F04er6AmHtWmHWJFhb3xChaZw9/nPDYOGYDe7jGD+ui1rDyqOUZ0H4+QLlWOAHZN
	PLetYWqgx6SynxZX7YA6MULPXfy2NBbPOuuf4Yo3Snjn7nO8hZde73p+MlqD+642WK2zND7YfV+I+
	GwSuZSq2uTg9VM76xp6/cVzjYJnWnnz8CQ1Qr7iBZY07r/HuiBknagjIs6lc5MPDjPwQEdcRmIhZJ
	RlVnRC/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdQmS-00000008Un2-3zeM;
	Thu, 30 Jan 2025 09:24:12 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdQmQ-00000008UmI-1SJa
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jan 2025 09:24:12 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250130092406epoutp04eae9bc12f6f5569c3b7bdc3f98fa077e~fbhupDJ7C1273112731epoutp04d
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jan 2025 09:24:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250130092406epoutp04eae9bc12f6f5569c3b7bdc3f98fa077e~fbhupDJ7C1273112731epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738229046;
	bh=HL2b46SyDwrvkIWYoi81OvrWq4Eysr5AGb4a/UeMMQM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=lUaPnMXYhwNeMB8B+YvsrITQIJrKbrlkCr9EpJRcxNHCAomubdC1iCeTRKajiMnuH
	 gs9JzyLYDFCp/OHawbKziR4PV584ZDp35mNGqXKmDsRB6SkK7YPAKggJpGid/O6y+B
	 bCmWeiO+7kuDEFc12RjKBgsp7JWsIXZ7c3fnvm+g=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250130092405epcas5p42d70c6889f2557bcd170da527a833ecb~fbht1lcYn2236122361epcas5p4C;
	Thu, 30 Jan 2025 09:24:05 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YkD9X71gxz4x9Pv; Thu, 30 Jan
	2025 09:24:00 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C2.02.19710.0354B976; Thu, 30 Jan 2025 18:24:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824~fbhpUXIOC0519205192epcas5p1M;
	Thu, 30 Jan 2025 09:24:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250130092400epsmtrp159a78ca4d56e861a43ca4208e9e92dd8~fbhpTsRQ82911429114epsmtrp1Y;
	Thu, 30 Jan 2025 09:24:00 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-cf-679b4530db53
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	48.92.18729.0354B976; Thu, 30 Jan 2025 18:24:00 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250130092359epsmtip26e09c636698aef1a63ab7522eb163c66~fbhoPBJSn2717827178epsmtip2Z;
	Thu, 30 Jan 2025 09:23:59 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [LSF/MM/BPF TOPIC] File system checksum offload
Date: Thu, 30 Jan 2025 14:45:45 +0530
Message-Id: <20250130091545.66573-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmpq6B6+x0g20/zS3+PDS0OPr/LZvF
	3lvaFpcer2C32LP3JIvF/GVP2S32vd7L7MDusXlJvcfkG8sZPfq2rGL0mLB5I6vH501yAaxR
	2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QDcoKZQl
	5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
	5j/9yFgwg73i6t4PrA2MH1i7GDk5JARMJI4dO8YCYgsJ7GaUWDC/uIuRC8j+xCjR8aWRHcL5
	xihxuPErXMfHY3dZIRJ7GSVmvr8O5XxmlFi8cANTFyMHB5uApsSFyaUgDSICqhJ/1x8BW8Es
	sItRYkVHNIgtLGAhcWzVdTYQmwWoZsGJU2CtvEDxpo3KELvkJWZe+s4OYvMKCEqcnPkEaoy8
	RPPW2cwgayUETrFLnN39jRmiwUVi4ZmfUIcKS7w6voUdwpaSeNnfBmVnSzx49IAFwq6R2LG5
	D6reXqLhzw1WkBuYgc5fv0sfYhefRO/vJ2CnSQjwSnS0CUFUK0rcm/QUqlNc4uGMJVC2h8Sl
	VZuZIAEaK7H19hnGCYxys5B8MAvJB7MQli1gZF7FKJlaUJybnppsWmCYl1oOj8nk/NxNjOC0
	p+Wyg/HG/H96hxiZOBgPMUpwMCuJ8Maem5EuxJuSWFmVWpQfX1Sak1p8iNEUGKoTmaVEk/OB
	iTevJN7QxNLAxMzMzMTS2MxQSZy3eWdLupBAemJJanZqakFqEUwfEwenVAPT1o6dD7cfaIj3
	YJNi3LWx7I2n7Lqpl7LLDrZUmtoXJTR1/S6Ve2b90HGndH4n6/vSoDutnmXv+/N/7Ns5VZB1
	Tlte4uqN0iuV821n3+aXsvXtVy2bPSNo42+eOhmTvHVCt/b/Unpw7mFmCbvh4XvZlxU0oyz+
	LjmgEDo/4NTBuPceUlysNR++u8bl7w4Ibn5yV2lBlOvMeBud/lm8bLkhFgs02Rdc/XJV5E5q
	58ZNH92bjZRnhe14Ud6X9Y1R9pbCbLnFEUxXZzSaBdzIF3jSabt28tqfFt1hJRsVkqdlLVr1
	wymN4wv7IZNF55LebhCZueRIXerTU2xpwddZK9dxcc/rnBft72q+wnDNmntKLMUZiYZazEXF
	iQCARAMXBAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSvK6B6+x0g87LchZ/HhpaHP3/ls1i
	7y1ti0uPV7Bb7Nl7ksVi/rKn7Bb7Xu9ldmD32Lyk3mPyjeWMHn1bVjF6TNi8kdXj8ya5ANYo
	LpuU1JzMstQifbsEroz5Tz8yFsxgr7i69wNrA+MH1i5GTg4JAROJj8fuAtlcHEICuxklPq6+
	yAKREJdovvaDHcIWllj57zk7RNFHRom/fa1AHRwcbAKaEhcml4LUiAioSvxdf4QFpIZZ4ACj
	RPOWNcwgCWEBC4ljq66zgdgsQEULTpxiAunlBYo3bVSGmC8vMfPSd7BdvAKCEidnPgG7gRko
	3rx1NvMERr5ZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDk8tzR2M
	21d90DvEyMTBeIhRgoNZSYQ39tyMdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNL
	UrNTUwtSi2CyTBycUg1MwRL/d3u1eHc9mm25Lb3OWae9cMmSo6ZCPLWqN5glX+xPXLkjatZT
	46rth+fLzk5cNemC6mzV/IolZ+t3cvB3zBHhv9S/pv/3si39tgEX5q7zeKfq4Wwm+G/drV0z
	OxMYMgsKcnnSEqwTd2X+qPl53Hqh516R4FOfbr8Xmnh2Tt6j/KWbfFc1Hc5cc2V67AP+lCWd
	d88mZRiGrX7AoRtnP3dRnMy8kMaPnofmefXdvuTMxHJdSbVR4881B37+u0WT6yLce15fLzxg
	/WP+vJwsy85nPPEVXWUqyjPv3G16d9r2+9w+3pZ3otV7jGUeMNy8p9bQVHZp/6Mcpiull665
	Rh2YyGY68/7fzorU9WeOKrEUZyQaajEXFScCAKrFmE++AgAA
X-CMS-MailID: 20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_012410_716781_B07E7464 
X-CRM114-Status: GOOD (  13.25  )
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

Hi All,

I would like to propose a discussion on employing checksum offload in
filesystems.
It would be good to co-locate this with the storage track, as the
finer details lie in the block layer and NVMe driver.

For Btrfs, I had a fleeting chat with Joseph during the last LSFMM.
It seemed there will be value in optimizing writes induced by the
separate checksum tree.
Anuj and I have developed an RFC. This may help us have a clearer
discussion and decide the path forward.

https://lore.kernel.org/linux-block/20250129140207.22718-1-joshi.k@samsung.com/

The proposed RFC maintains a generic infrastructure, allowing other
filesystems to adopt it easily.
XFS/Ext4 have native checksumming for metadata but not for data.
With this approach, they could just instruct the SSD to checksum the
data.
But I am unsure if there are FS-specific trade-offs. Maybe that can
also be up for the discussion.

