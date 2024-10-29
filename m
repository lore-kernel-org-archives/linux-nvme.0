Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE38D5B87A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 04:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h44AaFIuVj8hfLgHPGpbeTSm19ALdc/srv0kkAeiXYM=; b=puj0glLqzsKGDVfxx+bBMuC1EF
	pdj04NwZN5l6BwFEMgGVjPoaxQwZ0PmujnP/Xn/nI5X1VeeOdG8Ro0lDM6CuDZb7SngcpiWfOuXEQ
	vXmik+9ScNoyOC3pWLdGEKNYnV2tS46/HkOIlaRW8y6sp5XZhs4C3Tz6O+t3FbEWwSI/T9kdFyOPn
	B0mPm9ZYOfL6bJUgu+j07LMiYTsgz5PgK5O2ieWollsrfxjsYB+ylDzJCugJH4ZisIwxmMlr215hc
	VkUHPp0kQuKjTAlChX8dhzRUYNycVAC0uG2Usc2+sFm/WlhkNG+AFUuu9nBGWvIBx8gWnBsTLoK4c
	Hs4809ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5eGM-0000000DD8k-1f9G;
	Tue, 29 Oct 2024 04:55:26 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5eGI-0000000DD7y-0qdr
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 04:55:24 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241029045515epoutp01441acc93419b9463f977d446f6f7bde9~C03c6iUKV2606726067epoutp01D
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 04:55:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241029045515epoutp01441acc93419b9463f977d446f6f7bde9~C03c6iUKV2606726067epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730177715;
	bh=h44AaFIuVj8hfLgHPGpbeTSm19ALdc/srv0kkAeiXYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aN4zwyHBP7AyeGDBw4xgIjca+JSFCndb8vneHcTd2Tzl8SNMelbXM8VfCUtEj0+82
	 6hnZQohixu3Dx0teOyHdz44ECoEQOLTMEWg+R5+GoyUPo7n5c5OrTzCaIArUC6Hjxr
	 56Get6yU0sCJfubNwR0upHruy8HcpBb9R/hRrxMY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241029045515epcas5p21f96738ebecfcffcb123209919fdebf6~C03csX6wp2974629746epcas5p2r;
	Tue, 29 Oct 2024 04:55:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XcycL0jl7z4x9QV; Tue, 29 Oct
	2024 04:55:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BC.27.09770.0BA60276; Tue, 29 Oct 2024 13:55:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241029044954epcas5p4efdda30c8b0f79d7995b201101ed9e12~C0yx9frPJ2341423414epcas5p4G;
	Tue, 29 Oct 2024 04:49:54 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241029044954epsmtrp15e21120f30bb4540306895b3cc906a12~C0yx8w2qz1363313633epsmtrp1f;
	Tue, 29 Oct 2024 04:49:54 +0000 (GMT)
X-AuditID: b6c32a4a-e25fa7000000262a-0b-67206ab07f09
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F6.8A.07371.27960276; Tue, 29 Oct 2024 13:49:54 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241029044953epsmtip18546239a2c80cfd795fe717bb00f5df5~C0yxDk06B1296012960epsmtip1l;
	Tue, 29 Oct 2024 04:49:53 +0000 (GMT)
Date: Tue, 29 Oct 2024 10:12:11 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme: re-fix error-handling for io_uring
 nvme-passthrough
Message-ID: <20241029044211.GA3140@green245>
MIME-Version: 1.0
In-Reply-To: <20241028205253.2054407-1-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTQ3dDlkK6wasr0har7/azWaxcfZTJ
	YtKha4wWZ64uZLGYv+wpuwOrx+WzpR6bVnWyeWxeUu+x+2YDm8e5ixUBrFHZNhmpiSmpRQqp
	ecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAq5UUyhJzSoFCAYnFxUr6
	djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ2Rmnjp9iLXjFU9F2
	fw5LA+Mbri5GTg4JAROJqe9esHUxcnEICexmlFg86yUrSEJI4BOjxNOuEojEN0aJuz+/scF0
	bFi7hAUisZdR4tblTYwQzjNGib5959lBqlgEVCWW/JkBZrMJqEsced7KCGKLCChKnAeGAIjN
	LJAv8fPEeiYQW1ggQOLwpZXMIDavgI7E9sm32CFsQYmTM5+wgNicAuYS3c/+gvWKCihLHNh2
	nAlksYTAI3aJ49NfsUOc5yJx7fcLKFtY4tXxLVC2lMTL/jYoO13ix+WnTBB2gUTzsX2MELa9
	ROupfmaI4zIkPi16xgoRl5WYemodE0ScT6L39xOoXl6JHfNgbCWJ9pVzoGwJib3nGoBsDiDb
	Q2LfYwVIAHUxSlz9OIN5AqP8LCS/zUKyDsLWkViw+xPbLKB2ZgFpieX/OCBMTYn1u/QXMLKu
	YpRMLSjOTU8tNi0wyksth0d4cn7uJkZwytTy2sH48MEHvUOMTByMhxglOJiVRHhXx8qmC/Gm
	JFZWpRblxxeV5qQWH2I0BcbVRGYp0eR8YNLOK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2x
	JDU7NbUgtQimj4mDU6qBaRvXbC/1zvUfpG/x1a/Wtjim+ODV/Y11ZY8EdOtz5Wb2XWFdser+
	2ikl8+/f13gcfFR/W9C9wG8Jmxds6lfyO6G1wnGaevqGZdyORvd+VCa2rlsed+Ua99cO64/7
	VCpVn0rxzHdP2FocHC0sWvpt7aZUu3/ZGlo7kqLamRKyvPi35W6sP6Ubfv9V2tnTN4MnJ+hO
	e7LOydnpUIXyoue39USfLk1ytg/+toyvtuTbYfHrUcduLOx/83bt3rsu77taffbcVY6Xj9E/
	ua73ZNKVUJ7E9r38tqFHZv0/MnnttcJOX+5/N15P1DdxzrO598TKqLTkaBTf1eclVY+Y1FqS
	zMOmtt4N73rNGW54J8H3sRJLcUaioRZzUXEiALNDJNUiBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnG5RpkK6wb9uXYvVd/vZLFauPspk
	MenQNUaLM1cXsljMX/aU3YHV4/LZUo9NqzrZPDYvqffYfbOBzePcxYoA1igum5TUnMyy1CJ9
	uwSujM2TkgpWcVX09V5mamA8ytHFyMkhIWAisWHtEpYuRi4OIYHdjBL3D51nhkhISJx6uYwR
	whaWWPnvOTtE0RNGidPnD7KAJFgEVCWW/JnBDmKzCahLHHneCtYgIqAocR7oChCbWSBf4u3T
	h0wgtrCAn8S+G+fA6nkFdCS2T74FNbSLUeJ/0zlGiISgxMmZT1ggmrUkbvx7CdTMAWRLSyz/
	B3Y1p4C5RPezv2DzRQWUJQ5sO840gVFwFpLuWUi6ZyF0L2BkXsUomVpQnJuem2xYYJiXWq5X
	nJhbXJqXrpecn7uJERzqWho7GO/N/6d3iJGJg/EQowQHs5II7+pY2XQh3pTEyqrUovz4otKc
	1OJDjNIcLErivIYzZqcICaQnlqRmp6YWpBbBZJk4OKUamMyX3CmSNf++052r4UmZb2FTY5K/
	wyv9Sftjs5XelUReVDKTVZ5y9u41+4iUmmvLg3+LTvSb41RzPjdl3izZ+pedca9l52vvi2Qu
	fH7g3tm5FSvrtB5+iZy/ebb04uzGjZxxcS3rXMLnbjDdKpeilid0eEn0zoJfE830WKfMqBaS
	S30zQ3KP7+YPOgurZ6j4LW9Zs7J9FcuK+m83Uyee9VDyUJ0f/MjTbUHYfy/5S3WL/veF77z4
	4pP7p4WpM6um/w6zUSmWsPT2UDoSXaS1OXkBu+Zk0ZXz1h27pxvZ99jw/Fae6jKGWTWXlzNc
	Not/75md+Crop5XsnLAHOTOXKz/crLHNZ36OZdY5W5azRUosxRmJhlrMRcWJAAvSQK3kAgAA
X-CMS-MailID: 20241029044954epcas5p4efdda30c8b0f79d7995b201101ed9e12
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----4Q1Zi_KIf9_.4xoFwoas6UvdQHcFnkls7nqrl97Ci5BoFZ08=_8382a_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241028205307epcas5p18f70f43acb5c87103122bdfcc2f76e7a
References: <CGME20241028205307epcas5p18f70f43acb5c87103122bdfcc2f76e7a@epcas5p1.samsung.com>
	<20241028205253.2054407-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_215522_731363_0FE5F330 
X-CRM114-Status: GOOD (  24.49  )
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

------4Q1Zi_KIf9_.4xoFwoas6UvdQHcFnkls7nqrl97Ci5BoFZ08=_8382a_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Oct 28, 2024 at 01:52:53PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This was previously fixed with commit 1147dd0503564fa0e0348
> ("nvme: fix error-handling for io_uring nvme-passthrough"), but the
> change was mistakenly undone in a later commit.
> 
> Fixes: d6aacee9255e7f ("nvme: use bio_integrity_map_user"
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/ioctl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index b9b79ccfabf8a..6c531088043b7 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -422,9 +422,13 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>  	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>  
>  	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> +	if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {
>  		pdu->status = -EINTR;
> -	else
> +	} else {
>  		pdu->status = nvme_req(req)->status;
> +		if (!pdu->status)
> +			pdu->status = blk_status_to_errno(err);
> +	}
>  	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
>  
>  	/*
> -- 
> 2.43.5

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

------4Q1Zi_KIf9_.4xoFwoas6UvdQHcFnkls7nqrl97Ci5BoFZ08=_8382a_
Content-Type: text/plain; charset="utf-8"


------4Q1Zi_KIf9_.4xoFwoas6UvdQHcFnkls7nqrl97Ci5BoFZ08=_8382a_--

