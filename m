Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861E0C76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 11:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WjKL3IUmd2yhtd6/zqBD1oFcl0SRMQ7/AbTsfxYBfBQ=; b=XRjP3vADJZa+mKKNWkD870XeM6
	FfYSDu4cTY+YKltC0LDAQrVDC6Vibd9cWL0uW6uglk5IKInqUcB472d5MXaEml577b16+FJcX+W0O
	5diCRRmx5i9LVcGvsqyP3zKAuFKE/OgLZVQ63xrqGnXajLGAzeRMdKfux3CpzrurS8Bh+Uj07SxxC
	yakJIzs17ZzPPgdz3dTRT8TxM3F6TRU3lYnMpPJe+yshYEuSJ0z5AGmgNofH60Y3+6jouxlV1z8vb
	6liAAMnumJSd2oqL94habuGwtpkYg2CQLoOejySM2MRY6pMvDctBNNP9NSmWb2D+MHxpcIeuqzN1X
	LVfRQezQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgkwk-00Ak92-2c;
	Mon, 27 Mar 2023 11:23:30 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgkwf-00Ak85-0s
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 11:23:29 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230327112320euoutp014aa5f7016e117b0c50e3dfcc75e9afb7~QQuJFdaGr2157821578euoutp01j
	for <linux-nvme@lists.infradead.org>; Mon, 27 Mar 2023 11:23:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230327112320euoutp014aa5f7016e117b0c50e3dfcc75e9afb7~QQuJFdaGr2157821578euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1679916200;
	bh=WjKL3IUmd2yhtd6/zqBD1oFcl0SRMQ7/AbTsfxYBfBQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=td4HZdpXSTCIkF4ddluz0S7O9O1tL0A9auq8xeZyp0NWMo/lzRIUnZ2rvRdphT/De
	 YH1t86+hvj/Aoto+eM8wcire0ZX672G1LjK5mSCrYCEUQyS4Jkq1VXCEYp5kGmWuJk
	 QagsKnErU8sJKNW98S/ALgzjOvGR27jABNLcHFPo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230327112320eucas1p10f0976e12617435819a3c99dcc1b045a~QQuI_sg490976709767eucas1p15;
	Mon, 27 Mar 2023 11:23:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 70.5B.10014.8AC71246; Mon, 27
	Mar 2023 12:23:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230327112320eucas1p2628cea047978a31872fa96aca8265c2c~QQuItJp7G0407604076eucas1p2c;
	Mon, 27 Mar 2023 11:23:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230327112320eusmtrp2ace255e6013aaf432644627bcc10e190~QQuIsgH3W2282622826eusmtrp2U;
	Mon, 27 Mar 2023 11:23:20 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-c9-64217ca8de65
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 61.91.08862.8AC71246; Mon, 27
	Mar 2023 12:23:20 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230327112320eusmtip1ca117bd4d9f8295a30e340b556845632~QQuIkHZIM1211512115eusmtip1i;
	Mon, 27 Mar 2023 11:23:20 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 27 Mar 2023 12:23:19 +0100
Date: Mon, 27 Mar 2023 13:15:03 +0200
From: Pankaj Raghav <p.raghav@samsung.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
CC: <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>, <hch@lst.de>,
	<sagi@grimberg.me>, <hare@suse.de>, <p.raghav@ssamsung.com>
Subject: Re: [PATCH V2 3/8] nvme-core: code cleanup for __nvme_check_ready()
Message-ID: <20230327111503.tiiun2amgwdpmkta@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230327060418.86655-4-kch@nvidia.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87orahRTDC51SFvsWTSJyWLl6qNM
	FpMOXWO0eHp1FpPF/GVP2S02/1jFZrHu9XsWB3aP8/c2snhsWtXJ5rF5Sb3H7psNbB69ze/Y
	PA5/Ocbosfl0dQB7FJdNSmpOZllqkb5dAldG57sr7AVTmSruLzrC1MB4ibGLkZNDQsBEYs3P
	PuYuRi4OIYEVjBIHl7eyQThfGCUebPjECuF8ZpRo2t/HBtNyte07VMtyRomJ3RfY4aq6F72F
	crYwSpw/1wi2hUVAVeLL9uVALRwcbAJaEo2d7CBhEQF1iakHesBWMAu0MUrsmDuTGSQhLOAj
	sf3kGjCbF2jd15Uz2CFsQYmTM5+wgNjMAjoSC3Z/YgOZySwgLbH8HwdImBOofOfNpUwQlypJ
	NGw+wwJh10qc2nKLCWSXhMAHDon/S3tZIRIuEseWbIOGhrDEq+Nb2CFsGYn/O+dDDaqWeHrj
	NzNEcwujRP/O9WCLJQSsJfrO5ECYjhJnDoRAmHwSN94KQlzJJzFp23RmiDCvREebEMRANYkd
	TVsZJzAqz0Ly1ywkf81C+GsBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwORz+t/x
	rzsYV7z6qHeIkYmD8RCjBAezkgjvZm/FFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE
	0hNLUrNTUwtSi2CyTBycUg1M5b2G1VZJEy46havpP13e9Zn75JKjD5TO+9tNnbJMOeu3Q0hD
	mNkutVqOKdvM6llk+h8oH/WvzH069XZwwMFn1fJeLZcebOf3WXzm8L9JRlOybonXsfrU6As0
	uZ+/26HDKlkgr9TSOTlLUKb6X8Kn8MyAr1Zir/rqe4sVrfzyVxvvO5wmJbSwbHHdy1PlU60v
	Gk3iCdS7yP/rZ3b5wqx5Oy4vO33mqcb6B+WfpggmfdsVen7bkfTtF2RZri3+/2w3Qx2rscnL
	v8Lr3igdZcrxEogtj33uoqw7O+Bk4rmoZJ2aokULLdsEuw3XKv93nbVuxc4KGb3HNtwB6deP
	6qXt5TUNP3L6qmmlc51L618lluKMREMt5qLiRAApGr9ErQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7orahRTDK7P47TYs2gSk8XK1UeZ
	LCYdusZo8fTqLCaL+cueslts/rGKzWLd6/csDuwe5+9tZPHYtKqTzWPzknqP3Tcb2Dx6m9+x
	eRz+cozRY/Pp6gD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSc
	zLLUIn27BL2MzndX2AumMlXcX3SEqYHxEmMXIyeHhICJxNW278xdjFwcQgJLGSWW/DzPDpGQ
	kfh05SOULSzx51oXG0TRR0aJ06fvskI4WxglPrVOBKtiEVCV+LJ9OdAoDg42AS2Jxk6wsIiA
	usTUAz1g9cwCbYwSO+bOZAZJCAv4SGw/uQbM5gU64+vKGWANQgKxEheOfGeDiAtKnJz5hAXE
	ZhbQkViw+xMbyHxmAWmJ5f84QMKcQK07by5lgjhUSaJh8xkWCLtW4vPfZ4wTGIVnIZk0C8mk
	WQiTFjAyr2IUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMwm3Hfm7ewTjv1Ue9Q4xMHIyHGCU4
	mJVEeDd7K6YI8aYkVlalFuXHF5XmpBYfYjQFhsREZinR5HxgGsgriTc0MzA1NDGzNDC1NDNW
	Euf1LOhIFBJITyxJzU5NLUgtgulj4uCUamDKOhiU3129qyk+WuHDkXXHbD84+Br4fdbklWzO
	me3aJyv7/vrDVO4JV39It+731AqZlbTGTG1xWOPZVTs013T9l8u69fnOM7VCptNTvqqd+3xr
	/9VF/zZam7Dxhrtsf1TzzWv99bwpov8vGi5nEnvy3fT7rUv9+ZZam5e+f+pes7PP3T/4mIxM
	t9GOF45zKjgPRCa/SUh9aBB4++fbNb++rkhQS5x98uW6oGa21P38vo/YbTYFfNHK6stOUGVL
	2P6Q4di8tdtXtGdaznlx/cIlpf3vXnQrXBU8Pkv/iM1KHavz917MSdyyYOLvfun+LdEq3668
	kJ+qsenFM+9nwqJ8yfOf/vxZzvW7sINx3vJnP5RYijMSDbWYi4oTAQ5mCrhLAwAA
X-CMS-MailID: 20230327112320eucas1p2628cea047978a31872fa96aca8265c2c
X-Msg-Generator: CA
X-RootMTR: 20230327112320eucas1p2628cea047978a31872fa96aca8265c2c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230327112320eucas1p2628cea047978a31872fa96aca8265c2c
References: <20230327060418.86655-1-kch@nvidia.com>
	<20230327060418.86655-4-kch@nvidia.com>
	<CGME20230327112320eucas1p2628cea047978a31872fa96aca8265c2c@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_042325_920535_98A94E20 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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

>  		}
> +		break;
> +	default:
> +		break;
> +	case NVME_CTRL_DEAD:
> +		return false;
While you are at it, doesn't it make sense to have default as the last
switch case instead of NVME_CTRL_DEAD. It looks a bit strange to have
something else after the default case.

