Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7714AC67871
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 05:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jf/kaJgmgYaWVW9+QxmV+CVXNeqdVBi3rW+OgftoYzA=; b=2wM8sMdeX17pYr819ahi5LrjpP
	ietcYIj1P7ieoFvFkdeW7iO5Uv7dR6ja0a+mK/Bm6MwkUrfJ9UKhS7VNWuxC+iBrMXw3uKcBCaeHd
	KxxWZt7F6IgNSRO17pVyBXigNDQj5o2mGaNoe+BuADwu7pzkG6flNkNC8qk5iw3gUUAxbvb+Br/2v
	VjAH3R31vhIPisL5F+wuPiYgwRkHQ6iuAD6znwP+cBFMSLWq0aDL0xLTb4Th9uEEA7fFJbe9P1j6X
	2eAFjlnCpK9n2fqNeceUBSoJEsup82SRlch/cYwpdjDcQQTLtPHpm/e+2mHOqTv3ICmDfnt35Nsbh
	vDRza5LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onvpg-00Bv2W-70; Thu, 27 Oct 2022 05:53:36 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onvpW-00Bv0c-Jl
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 05:53:32 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221027055256epoutp041586426bd3c34c0b1b627c223b9516b1~h1zj20KRG2386823868epoutp049
	for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 05:52:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221027055256epoutp041586426bd3c34c0b1b627c223b9516b1~h1zj20KRG2386823868epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666849976;
	bh=Jf/kaJgmgYaWVW9+QxmV+CVXNeqdVBi3rW+OgftoYzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kG2e5VJcbZK959ybP1+xBKxn7fX5m4hJGe2t102Zr8MbC8m6R6j9px+cCP211vzr4
	 BDMGLIICwg3ytewKHXZ41Vwea2Hxs+adMrvj7M7eT4kjRMQsHkJdCms9Bl6izSLORl
	 vDRRcO8l4GUhj7xMBgLTM8RaKovahdxURa5fPCKY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20221027055256epcas5p18c001e5b4596c2e1f135cdb6512f793b~h1zjdtnS22575725757epcas5p1c;
	Thu, 27 Oct 2022 05:52:56 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4MyZbB1DNdz4x9Pw; Thu, 27 Oct
	2022 05:52:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AB.10.01710.6BC1A536; Thu, 27 Oct 2022 14:52:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20221027055253epcas5p1f438f576f1268c03ff388563c0450309~h1zhCkotd2067820678epcas5p16;
	Thu, 27 Oct 2022 05:52:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221027055253epsmtrp1d27343df0078c48f272f420c11599164~h1zhBb1BJ2593525935epsmtrp1G;
	Thu, 27 Oct 2022 05:52:53 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-7b-635a1cb6d79e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4E.0C.14392.5BC1A536; Thu, 27 Oct 2022 14:52:53 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20221027055252epsmtip21071185e38426795d8e53e30cd0d1a72~h1zffK2Lj1299012990epsmtip2Q;
	Thu, 27 Oct 2022 05:52:51 +0000 (GMT)
Date: Thu, 27 Oct 2022 11:11:36 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, Keith
	Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>, Alan Adamson
	<alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme: quiet user passthrough command errors
Message-ID: <20221027054136.GA5939@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221026170715.2657664-1-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmpu42mahkgx8T2S329J9isjj8eBK7
	xcrVR5ksJh26xmhx5upCFov5y56yW6x7/Z7Fgd3j/L2NLB6bVnWyeWxeUu+x+2YDm8e5ixUe
	H5/eYvHYfLo6gD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
	J0DXLTMH6BwlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5q
	iZWhgYGRKVBhQnbGm+PHGAvm8Vd8PXmPsYHxOU8XIyeHhICJREdDA2sXIxeHkMBuRonDtzoZ
	IZxPjBJbZ39ngXC+MUqcvXwQqIwDrOX+lzKQbiGBvYwS/+6VQ9Q8Y5S49v40O0iCRUAVqP47
	M0g9m4CmxIXJpSBhEQFFifPAgACpZxZYxygx9ftzRpCEsICDxKvrq1lBbF4BHYl1N+8yQ9iC
	EidnPmEBsTkFzCVe7Z3FBGKLCihLHNh2nAlkkIRAL4fE+a3L2CH+cZE4MfEslC0s8er4Fihb
	SuJlfxuUnSxxaeY5Jgi7ROLxnoNQtr1E66l+sMXMAhkSDze8ZISw+SR6fz9hgnieV6KjTQii
	XFHi3qSnrBC2uMTDGUugbA+JaVeXMEECqItR4u5srQmMcrOQvDMLyQYI20qi80MT6yygDcwC
	0hLL/3FAmJoS63fpL2BkXcUomVpQnJueWmxaYJiXWg6P4uT83E2M4PSp5bmD8e6DD3qHGJk4
	GA8xSnAwK4nwnr0RnizEm5JYWZValB9fVJqTWnyI0RQYPROZpUST84EJPK8k3tDE0sDEzMzM
	xNLYzFBJnHfxDK1kIYH0xJLU7NTUgtQimD4mDk6pBqb68FcyYVty7puJdC398j9GPLoyZoHi
	maWJKelL9pdz7Zp0U0Tly+vjs85PeNHLGNv/LP5TukPR3T8Z0nVRrun+nSvyYhoUOPKDBbsl
	X539aLTEKylXpucMe34xj2R282/R0Esqr+4+O/x40TQFn/fKj06bhJ9aXB7bymg0Zd2yOUJR
	05XrpP4oXz3VKsskqDGvQNbdbDKPmU+x07mQ8rmB15yCLFjF/dT7T5+vu8pn9XtxhWPBBeUq
	lYbI1Nycn2rCnJ8C2Y8k6W3KcT71UbbwTKNuBvvGucJ735XyHtqo9ID3Rjzb/F/53q0cK7Yu
	zam4s68+wyFHSbxa1pPToKfA/dz+VueLb16l689TYinOSDTUYi4qTgQAfABsDCgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvO5Wmahkg+fLVSz29J9isjj8eBK7
	xcrVR5ksJh26xmhx5upCFov5y56yW6x7/Z7Fgd3j/L2NLB6bVnWyeWxeUu+x+2YDm8e5ixUe
	H5/eYvHYfLo6gD2KyyYlNSezLLVI3y6BK2NL53G2ggs8FSum/GFsYNzM1cXIwSEhYCJx/0tZ
	FyMXh5DAbkaJ9tmb2bsYOYHi4hLN135A2cISK/89Z4coesIosWTFWzaQBIuAqsTZy9+ZQQax
	CWhKXJhcChIWEVCUOA90DUg9s8A6RokpR/qYQBLCAg4Sr66vZgWxeQV0JNbdvMsMMbSLUeLQ
	kw1MEAlBiZMzn7CA2MwCZhLzNj8EW8AsIC2x/B8HSJhTwFzi1d5ZYOWiAsoSB7YdZ5rAKDgL
	SfcsJN2zELoXMDKvYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgktzR2M21d90DvE
	yMTBeIhRgoNZSYT37I3wZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphak
	FsFkmTg4pRqYqh4zR+1M2axYP+UcS5fjaYeYg109TPzrt7ay+TvXr2mqXLb6doP73gkJ37Oe
	/Ob4u2e9/n/PudKnKkRfcE1Ru85ywfNquCzP/1RmQ5UFC+IOlyy5NLf457cpynZ7bsmlB+40
	aKo+sn2+7pTfiXcfs0R9uLnaRCKpYBKLiWHa7jKV2y+mfqrZpWDMOn3b+vtzfobp7ukV7jb6
	FBXZl2Js1nvHpEDL9uziRf6XTb4XL2KO/s6WHDcxyzw4/xFnQ6f+i2tHuacvqdNb//npw8Bl
	YQEbok892X9rxRap1TeyAkysNsceP5iweNr5/GlfhTtu1a1cdphD8Z8027fdKzotWSbceqPf
	4q1/zlM9T6F7oxJLcUaioRZzUXEiAME6r8/4AgAA
X-CMS-MailID: 20221027055253epcas5p1f438f576f1268c03ff388563c0450309
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Iofw26EFbNSGL_UgXoU1XVs5LxhMn2U4r7Cvdd9q_.3L.-0Y=_995c3_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221026171201epcas5p1f6333717c7f12b5a8fe362cf09c5447d
References: <CGME20221026171201epcas5p1f6333717c7f12b5a8fe362cf09c5447d@epcas5p1.samsung.com>
	<20221026170715.2657664-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_225329_691642_545A1479 
X-CRM114-Status: GOOD (  15.60  )
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

------Iofw26EFbNSGL_UgXoU1XVs5LxhMn2U4r7Cvdd9q_.3L.-0Y=_995c3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Oct 26, 2022 at 10:07:15AM -0700, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>The driver is spamming the kernel logs for entirely harmless errors from
>user space submitting unsupported commmands. Just silence the errors.
>The application has direct access to command status, so there's no need
>to log these.
>
>Cc: Daniel Wagner <dwagner@suse.de>
>Cc: Alan Adamson <alan.adamson@oracle.com>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
> drivers/nvme/host/core.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index 686c55cb5d1a..da874172a31d 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -1156,6 +1156,7 @@ int nvme_execute_passthru_rq(struct request *rq, u32 *effects)
> 	struct nvme_ns *ns = rq->q->queuedata;
>
> 	*effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
>+	rq->rq_flags |= RQF_QUIET;
> 	return nvme_execute_rq(rq, false);
> }

Can we do this for uring-passthrough path too? Like below patch -

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 81f5550b670d..a91cefc38506 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -556,6 +556,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
        } else {
                req->end_io = nvme_uring_cmd_end_io;
        }
+       req->rq_flags |= RQF_QUIET;
        blk_execute_rq_nowait(req, false);
        return -EIOCBQUEUED;
 }

Looks good otherwise.
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

------Iofw26EFbNSGL_UgXoU1XVs5LxhMn2U4r7Cvdd9q_.3L.-0Y=_995c3_
Content-Type: text/plain; charset="utf-8"


------Iofw26EFbNSGL_UgXoU1XVs5LxhMn2U4r7Cvdd9q_.3L.-0Y=_995c3_--

