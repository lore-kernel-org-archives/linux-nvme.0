Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CD5C7EE23
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 06:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HveqXqToYJXo+ib6j5UChYBYig7p+UKJZr6SH/N8pEA=; b=gAXxVtMm5QC59x4pNlVRC3fxWI
	e/6p2ceVmAC6Ls3EFdb7hNwC4yQTHY5l9Vvz063br0/pewSIbx5UYvPQeWw0UDWA1aCNiJzqkdA80
	scMh3yokAykyWfJeTwa2Ue693NCRwTkjD/YD8QrDWbw0mxpxl4JNdBxZOpZSAfcPwDkdnXV8AfA+I
	e4qyHhKod+/fKuG6xKp3xwx2Ujr+v2gj8seuZydToTLPckVkKeF6w3EQBV6zIKL7Xn6PawrKNET/a
	rXKyiTJ14nqrcqbNl84J55YJpf83tB6HbaP75pRps7Lvm+nYerc36hv+nXBAu306DbDdUWZYHHY+1
	XCMmPnug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2QhU-001CyL-36;
	Fri, 26 May 2023 06:13:20 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2QhQ-001CxN-2f
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 06:13:18 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230526061310epoutp022a1baf95965cbb57f984a52d4a6043d2~inMdry9R72383723837epoutp02s
	for <linux-nvme@lists.infradead.org>; Fri, 26 May 2023 06:13:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230526061310epoutp022a1baf95965cbb57f984a52d4a6043d2~inMdry9R72383723837epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1685081590;
	bh=HveqXqToYJXo+ib6j5UChYBYig7p+UKJZr6SH/N8pEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pou/XUtPNrcRaXxGsX8G8ceQ5a3dsyWUND0A/R6fV658GURIVqln03LpuiBFNrkG9
	 qEzZVNjE0eupPkgUEVJqUpRrXtcdBkC772MaSMhjPwQUHxWhS63p+9Kri3t41jqPAv
	 vWZAae5tlZH4u++DQArBounpgfbH79/JSQVrZtQk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230526061310epcas5p406432c09355ff671136101631c2463d9~inMdf2qc80329803298epcas5p4j;
	Fri, 26 May 2023 06:13:10 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4QSF392zbNz4x9QB; Fri, 26 May
	2023 06:13:09 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.55.44881.3FD40746; Fri, 26 May 2023 15:13:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230526060759epcas5p3cadfc28c2b45dfc1955cc1bd21f2a351~inH7b7Pwk0437704377epcas5p35;
	Fri, 26 May 2023 06:07:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230526060759epsmtrp2766a0acca550b28dc2e70cb33fad64df~inH7bPdFB2898428984epsmtrp2B;
	Fri, 26 May 2023 06:07:59 +0000 (GMT)
X-AuditID: b6c32a4a-c47ff7000001af51-05-64704df3b422
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	82.67.28392.FBC40746; Fri, 26 May 2023 15:07:59 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230526060758epsmtip174f574cf9e1cb6cc768b2dc303dc1cb5~inH6feDcH2395623956epsmtip1U;
	Fri, 26 May 2023 06:07:58 +0000 (GMT)
Date: Fri, 26 May 2023 11:34:52 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, james.smart@broadcom.com, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/2] nvmet-auth: remove unnecessary break after goto
Message-ID: <20230526060452.pbatl2bwxlhctvx2@green245>
MIME-Version: 1.0
In-Reply-To: <20230519094052.48575-1-kch@nvidia.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmuu5n34IUg9O3eSz2LJrEZLFy9VEm
	i90LPzJZPL06i8li/rKn7BbrXr9ncWDzmHX/LJvH+XsbWTw2L6n32H2zgc2jt/kdm8fm09UB
	bFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
	lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoT
	sjNaruxjLVjBV7Fs5R7WBsYJPF2MnBwSAiYSt24sZeli5OIQEtjNKLH+1RF2COcTo0TT3f1M
	EM5noMzP7awwLctPTGOESOxilJj1/QpU1TNGiY0zF7ODVLEIqErM2XCGrYuRg4NNQFvi9H8O
	kLCIgLrE1AM9YIOYBbIkdpxYyARiCwt4SFw9NgnM5hUwk7j4YwIbhC0ocXLmExaQMZxAi1uW
	64OERQVkJGYs/coMslZC4C+7xNnvV8FWSQi4SDy64w5xp7DEq+Nb2CFsKYnP7/ayQdjlEiun
	rGCD6G0Buv/6LEaIhL1E66l+ZojbMiQ2bNjHBBGXlZh6ah0TRJxPovf3E6g4r8SOeTC2ssSa
	9QugFkhKXPveCGV7SMy4fo8ZEj7tjBK9x7ayT2CUn4Xkt1lI9kHYVhKdH5pYZwH9wywgLbH8
	HweEqSmxfpf+AkbWVYySqQXFuempxaYFRnmp5fAIT87P3cQITqRaXjsYHz74oHeIkYmD8RCj
	BAezkgjvhpz8FCHelMTKqtSi/Pii0pzU4kOMpsComsgsJZqcD0zleSXxhiaWBiZmZmYmlsZm
	hkrivOq2J5OFBNITS1KzU1MLUotg+pg4OKUamNTez1/6qcOYiaPx3+I53AI73p9M/hr7PV1/
	N5/R0nlVHQ+YOeJzjkyyf/dr3jduJ8XFMrx3Nh0UOnrGdura0/8YKm0+7XcyXMJv9/9a8u2b
	d34p14soGFramEkwp5neyXp//7NKpVhuWG56/CVejZdyX5YqX1Csni2WM9fp+IftGk2/8074
	duRo1NU+neV96d4LxdKYwOBH6yUZ5xwtiBPz/WdlZcNzj+tieGJFa05Wu+yHXcHHcwWWqOjf
	dZlXJpVyyVj685ycJVMCAjjfdK3N5nFdZHPqnryDVOO0IC/miFUbt23NFnL3UH8mbNHpcHTS
	xsNRXBx1R5iYNKIrt5wx2XpvGUv3eUsLFx8NJZbijERDLeai4kQAhRAEIi0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSnO5+n4IUg68zeSz2LJrEZLFy9VEm
	i90LPzJZPL06i8li/rKn7BbrXr9ncWDzmHX/LJvH+XsbWTw2L6n32H2zgc2jt/kdm8fm09UB
	bFFcNimpOZllqUX6dglcGf3/VrMW3OKu2PFlHWsD4x3OLkZODgkBE4nlJ6YxdjFycQgJ7GCU
	eLjkLDNEQlJi2d8jULawxMp/z9lBbCGBJ4wSs49ngNgsAqoSczacYeti5OBgE9CWOP2fAyQs
	IqAuMfVADyuIzSyQJbHjxEImEFtYwEPi6rFJYDavgJnExR8T2CBGGkssaDrLAhEXlDg58wkL
	RK+ZxLzND5lBxjMLSEss/8cBYnICndyyXB+kQlRARmLG0q/MExgFZyFpnoWkeRZC8wJG5lWM
	kqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMGhr6W1g3HPqg96hxiZOBgPMUpwMCuJ8G7I
	yU8R4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgan18Cw+
	5pmrQrbZSlRpbBP15LJf4Mr0/d+UVMW8fx6PcyuWTnoR88Zcw2jZmZkpSqY7/0hs1Q/Wtaqq
	btqg9vH/WY/2mGizz6dXf8g7uajj+F0LzVDf7alnrmozX3gp3Pfj5IHpG6Il7X2faGhNn9Ra
	8CTt2Zvtp8u4uBexm/+7f0fuB/dG9bWvezalLdtxwkh4ddGH0xVzHzjwHNEus/k0c0tJbUew
	7RuhGVPCL/L+WX+HM/fT5+63/rcSH5u+FBLz2/DN04tlFpvMu1uXauafd/vb1C1X7fG5wLLb
	y3V+1XW/lYtqfqQzvEzgVM23O3fu46nLO9eueJsx/9fjhD/SNq0bZWxjVz3W9fUomvdRiaU4
	I9FQi7moOBEAoPDNTuwCAAA=
X-CMS-MailID: 20230526060759epcas5p3cadfc28c2b45dfc1955cc1bd21f2a351
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----RbnLpepSOhDWt1JmDV6HMUWO9Dmn-C3OOrycHY1seGoKI43i=_22c32_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230526060759epcas5p3cadfc28c2b45dfc1955cc1bd21f2a351
References: <20230519094052.48575-1-kch@nvidia.com>
	<CGME20230526060759epcas5p3cadfc28c2b45dfc1955cc1bd21f2a351@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_231317_579455_5B748DB7 
X-CRM114-Status: GOOD (  11.87  )
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

------RbnLpepSOhDWt1JmDV6HMUWO9Dmn-C3OOrycHY1seGoKI43i=_22c32_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/05/19 02:40AM, Chaitanya Kulkarni wrote:
>Remove dead break after goto.
>
>Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>---
> drivers/nvme/target/fabrics-cmd-auth.c | 4 ----
> 1 file changed, 4 deletions(-)
>
>diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
>index 7970a7640e58..6c9a1ce6068d 100644
>--- a/drivers/nvme/target/fabrics-cmd-auth.c
>+++ b/drivers/nvme/target/fabrics-cmd-auth.c
>@@ -295,13 +295,11 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
> 			status = 0;
> 		}
> 		goto done_kfree;
>-		break;
> 	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2:
> 		req->sq->authenticated = true;
> 		pr_debug("%s: ctrl %d qid %d ctrl authenticated\n",
> 			 __func__, ctrl->cntlid, req->sq->qid);
> 		goto done_kfree;
>-		break;
> 	case NVME_AUTH_DHCHAP_MESSAGE_FAILURE2:
> 		status = nvmet_auth_failure2(d);
> 		if (status) {
>@@ -312,7 +310,6 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
> 			status = 0;
> 		}
> 		goto done_kfree;
>-		break;
> 	default:
> 		req->sq->dhchap_status =
> 			NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
>@@ -320,7 +317,6 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
> 			NVME_AUTH_DHCHAP_MESSAGE_FAILURE2;
> 		req->sq->authenticated = false;
> 		goto done_kfree;
>-		break;
> 	}
> done_failure1:
> 	req->sq->dhchap_status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
>-- 
>2.40.0
>
>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------RbnLpepSOhDWt1JmDV6HMUWO9Dmn-C3OOrycHY1seGoKI43i=_22c32_
Content-Type: text/plain; charset="utf-8"


------RbnLpepSOhDWt1JmDV6HMUWO9Dmn-C3OOrycHY1seGoKI43i=_22c32_--

