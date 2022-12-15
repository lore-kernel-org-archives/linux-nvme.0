Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84309C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 13:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33UNpfp1QatBOGHf/v7UqCCXIXo+yEoVVkXfTsGvhYw=; b=lZ/6iIbUYkGJ13+bkTvJwe/MOm
	2mExP1lH0JG+adVcfIBfaQJq6bRN9vNqDRcQTJ8/+HTw0b26dG+V5hNKt+CANSus7T4lbTsEm1IoM
	fX4CMcGl09TyLrF7mw2NS3+AUaDhdIXqqiI0G+vMZ6rnuLZ3abyQmfOk5ciSjt3bEqvn2WBu4KZgj
	Ee9AErxzTX6sXazCZZ/1dtC0e5iPZ5NTgtni8KCwFps+lgFdKFPP3mNT8VfdnWoCkwFzA3DSPrWrJ
	auluSo4u9zBvS0Qb/nuarIMxmUCQ9UWnm2xXvvwg2wGffpN9zlevIGEtqkoF7AbprYoBaBUba09nB
	6+LBGLyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5oGY-009YYp-Mk; Thu, 15 Dec 2022 13:27:14 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5oGT-009YVk-1j
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 13:27:13 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221215132700epoutp022492281f94e364b7c5b68e66bd3a0602~w_nAFoWAE0233802338epoutp02e
	for <linux-nvme@lists.infradead.org>; Thu, 15 Dec 2022 13:27:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221215132700epoutp022492281f94e364b7c5b68e66bd3a0602~w_nAFoWAE0233802338epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1671110820;
	bh=33UNpfp1QatBOGHf/v7UqCCXIXo+yEoVVkXfTsGvhYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jdei5RKK11CIK0IBO8YB7juIbcgbWyS7NLDhAqxT+3tJ7rYqlZJ/alFIT+1upH0Ni
	 eEh2GgsHrfPxCYkgUCk1754NIjPTybpnhkr3iiZi3W6xNGc81/Zy+Pq2AIAYcse8Pu
	 +GEiHvcceiUaRQMoXsmA7MdxabjzddftO+2O+284=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20221215132700epcas5p1b7073e44645914341bec350d94e34329~w_m-fMRLO3171731717epcas5p1Y;
	Thu, 15 Dec 2022 13:27:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4NXtLV36NPz4x9Pv; Thu, 15 Dec
	2022 13:26:58 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F1.5E.56352.2A02B936; Thu, 15 Dec 2022 22:26:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20221215132657epcas5p3d80eeb2df5d957c7222661b348c84e3a~w_m8qRmug1361413614epcas5p3s;
	Thu, 15 Dec 2022 13:26:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221215132657epsmtrp2f087be54f7db0804d7979cc7e5289528~w_m8pposw1261112611epsmtrp2C;
	Thu, 15 Dec 2022 13:26:57 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-7c-639b20a286b3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E4.4A.14392.0A02B936; Thu, 15 Dec 2022 22:26:57 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20221215132656epsmtip17ca348690ff554525db9a565e3b38eb1~w_m71AwAO3122531225epsmtip1T;
	Thu, 15 Dec 2022 13:26:56 +0000 (GMT)
Date: Thu, 15 Dec 2022 18:45:31 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] nvme: assign known effects at controller
 initialization time
Message-ID: <20221215131531.GA8002@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221214161347.764071-8-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTU3eRwuxkg4PtQhYrVx9lsph06Bqj
	xdOrs5gs5i97ym6x7vV7FgdWj/P3NrJ4bFrVyeaxeUm9x+6bDWwevc3v2AJYo7JtMlITU1KL
	FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
	lfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM65d62QqeMxe
	0dpZ1MB4ka2LkYNDQsBE4vUu+y5GLg4hgd2MEge/NbFAOJ8YJbYfOQTlfGOUWP5+N1MXIydY
	x8JrE5kgEnsZJU6/2gdV9YxRouvsezaQKhYBVYlZ7S/AdrAJaEpcmFwKEhYRUJJ4+uosI0g9
	s0APo8S59pWsIAlhgXCJids3M4PYvAI6EpdfLGOFsAUlTs58wgJicwoYSixYsxGsRlRAWeLA
	tuNgV0gIfGSXuHpxDjvEQy4S3zfqQVwqLPHq+BZ2CFtK4vO7vWwQdrLEpZnnoL4pkXi85yCU
	bS/ReqofbD6zQIbEilOnWCFsPone30+YIMbzSnS0CUGUK0rcm/SUFcIWl3g4YwmU7SFxcd4z
	ZkiYrGaUWPt7HssERrlZSN6ZhWQFhG0l0fmhCcjmALKlJZb/44AwNSXW79JfwMi6ilEytaA4
	Nz212LTAOC+1HB7Fyfm5mxjBqVHLewfjowcf9A4xMnEwHmKU4GBWEuENeDorWYg3JbGyKrUo
	P76oNCe1+BCjKTB6JjJLiSbnA5NzXkm8oYmlgYmZmZmJpbGZoZI479IpHclCAumJJanZqakF
	qUUwfUwcnFINTCw1U+N2LTy79yD7ytm68661Nlu/T61wyrfUzK6b75tgpb3cns2be+FP3jIZ
	ryMGy7Yq77pTfe5RV2e3Q4tLyEWr5Uc222V7L5N75ifjW8fM3P/JO1xBdK63zy3mvUVn9qYf
	c4lYu7XnXVyR9dYHCmxXtCoOTva+mPpj//fypbuvBunzLLRr3c60NUlvhlaJWY24M19ZH8va
	bwX+CuWLWljZTE5H/gky/G606kSZcoD/MtPOWrVp0fzHtn+RecnDGzv9RO2smXdm8fXqN3+S
	i4sv4FwS77HLe4KN366onyapC69xFu40cGb6evhB9b/vh3g2HCi1P/nwqtzMGW5V5dd+yzkE
	9emlfhcom+yrxFKckWioxVxUnAgA1aAHJxYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnO5ChdnJBlMPMFqsXH2UyWLSoWuM
	Fk+vzmKymL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/YwtgjeKySUnNySxL
	LdK3S+DKWN/fwVgwlbViy2WlBsa5LF2MnBwSAiYSC69NZAKxhQR2M0pMPSYHEReXaL72gx3C
	FpZY+e85kM0FVPOEUeJl53ewBhYBVYlZ7S/Yuhg5ONgENCUuTC4FCYsIKEk8fXWWEaSeWaCH
	UeJc+0pWkISwQLjExO2bmUFsXgEdicsvlrFCDF3NKHH0yzeohKDEyZlPwK5jFjCTmLf5ITPI
	AmYBaYnl/zhAwpwChhIL1mwEKxcVUJY4sO040wRGwVlIumch6Z6F0L2AkXkVo2RqQXFuem6x
	YYFhXmq5XnFibnFpXrpecn7uJkZwsGtp7mDcvuqD3iFGJg7GQ4wSHMxKIrwBT2clC/GmJFZW
	pRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cCkVxalklws/cz2mErE
	PxENTh1FY49jlzMKOZ63f3isVvBxbeeXB/bfHl6p6fn78pLamYJ13ZtY3z3SXyiy/4mXSE36
	ZL8Le9tmxRqlqKRfvJBTOytxh9/7Fz/Oz90pv6jCtrbr/BOV8upwLT21mzJaRftz2ANi+NJ/
	WE+UadFJl9W+L3TYs2H6zSNzmWO6csUzlQL/XPE/+DVCkSUnYMKiN5fddqu8nfJ3JfO36TM2
	bbac+e/ZQ/kJFpq5HNkTfhbI1ncckF7+ROe855uyR3qrszutqreWh0j59VUZP7GUM3nhMONZ
	B8eeyRL1zf8W7pj3VajP8e9WvutPT6xaybz6ZeHKio3zGP+vFF1+p/evEktxRqKhFnNRcSIA
	bDWnOuUCAAA=
X-CMS-MailID: 20221215132657epcas5p3d80eeb2df5d957c7222661b348c84e3a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_3720f_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221214161836epcas5p2650ec7f48d073aaf723a0efd203c96dd
References: <20221214161347.764071-1-hch@lst.de>
	<CGME20221214161836epcas5p2650ec7f48d073aaf723a0efd203c96dd@epcas5p2.samsung.com>
	<20221214161347.764071-8-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_052711_418365_01CC6343 
X-CRM114-Status: GOOD (  12.03  )
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

------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_3720f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Dec 14, 2022 at 05:13:45PM +0100, Christoph Hellwig wrote:

>+static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>+{
>+	int ret;
>+
>+	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
>+		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
>+		if (ret < 0)
>+			return ret;
>+	} else {
>+		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
>+		if (!ctrl->effects)
>+			return -ENOMEM;

Maybe I am missing something obvious, but when ctrl->effects gets
freed if it was allocated via the else path above?
It's not going to that "ctrl->cels" xarray which gets freed during
nvme_free_ctrl.

------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_3720f_
Content-Type: text/plain; charset="utf-8"


------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_3720f_--

