Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A7AC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mynA3hOHhjeAHIHrb8EAsJfCGMTR5iy6lVdtNnqiPPM=; b=Hyh3chRtaEuLhw
	tKLbrmN1oQ62k8w0BJRmSWTmnsr1QwWcsUdmkdYzvHOggjAc9rARnkulduuVnG0EWRz/sjzEc5LuK
	PsSJJTFTxk0Cp/Z+zMfr8dM8OgJIx0FK3HhidN9TY63Y8Y5b4CW05OfyraS9S/XFNnLmYOfiI2Ira
	dC0V0674rFjn/nTT4chp1bvMputToCkWTYnqK7MQtSHJepd0IFTT57p+QvxN5XbvYOMTbpfGGofvh
	juupbAzS0Kuj20Eq94MoeuutFpuwqbL2vLNPRskNG07IAo9D75745iA9Sgw6yjXMPSgSdptVruv/7
	5CkhC03oZgpC8seQ7jkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okmy6-0079lI-Rv; Tue, 18 Oct 2022 13:49:18 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okmy0-0079hS-66
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 13:49:17 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221018134900euoutp01379a9a1ba7830b5440dea853a6699d6c~fLfpS3lPO2645126451euoutp01j
	for <linux-nvme@lists.infradead.org>; Tue, 18 Oct 2022 13:49:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221018134900euoutp01379a9a1ba7830b5440dea853a6699d6c~fLfpS3lPO2645126451euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666100940;
	bh=mynA3hOHhjeAHIHrb8EAsJfCGMTR5iy6lVdtNnqiPPM=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=C7Y0hup3gMBBxhiqra5fg1vHaJYJyYnua7/31aW8hK3uZmssWcys5HcGwxGtYrIB4
	 bxLAm9cE3j6zlGUmCXTJxW7Epe5swIWbh8BG+WjCsAwq5dx7svliDm+O2fhbB+d3ZY
	 Dn9wwbgUK5YYeBBJKH+AHXLIXqvHTW3Ej4qQ6cHQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221018134859eucas1p13850940e6c3b11385ded166dea2c8337~fLfo7bLrz1600816008eucas1p1Y;
	Tue, 18 Oct 2022 13:48:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 8E.31.19378.BCEAE436; Tue, 18
	Oct 2022 14:48:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221018134859eucas1p226f166a18862f0b86f968460687a63c6~fLfocs46w3071430714eucas1p2r;
	Tue, 18 Oct 2022 13:48:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221018134859eusmtrp142d3ae09b74de7fe9d22496744d2a0e6~fLfobKc9w2431424314eusmtrp1P;
	Tue, 18 Oct 2022 13:48:59 +0000 (GMT)
X-AuditID: cbfec7f5-fc0a2a8000014bb2-c5-634eaecb8128
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.5D.10862.BCEAE436; Tue, 18
	Oct 2022 14:48:59 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221018134859eusmtip19ad33fdc91c6852ba1cf6083e3ca9567~fLfoR5lXO2904429044eusmtip1B;
	Tue, 18 Oct 2022 13:48:59 +0000 (GMT)
Received: from [192.168.8.101] (106.210.248.178) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 18 Oct 2022 14:48:57 +0100
Message-ID: <3f6f41b5-c743-83f7-a8f4-ab3ee2f16b3a@samsung.com>
Date: Tue, 18 Oct 2022 15:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.2.2
Subject: Re: [PATCH] nvme: ignore starting sector while error logging for
 passthrough requests
To: <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Daniel Wagner
	<dwagner@suse.de>, Alan Adamson <alan.adamson@oracle.com>
CC: <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20221006091053.36611-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.178]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87qn1/klG6xepG+xp/8Uk8Xhx5PY
	LVauPspkMenQNUaL+cuesjuwemxa1cnmsXlJvcfumw1sHh+f3mLx2Hy6OoA1issmJTUnsyy1
	SN8ugStj+c0VLAVzBCq2vPvK0sDYzdvFyMkhIWAi8WNtP1sXIxeHkMAKRomZk48xQjhfGCU2
	PngO5XxmlJj98CYrTMufpfdYIBLLGSXOTz3CBlfVfOIqVGY3o8S7pn9gLbwCdhJbFt1hB7FZ
	BFQlzu8CmQsSF5Q4OfMJC4gtKhAlcWnTG7B6YYEEia/nGtlAbBGBGokpS66D2cwCNhL9Z5ey
	QNjiEreezGfqYuTgYBPQkmjsBBvPKWAlMfPRI6hyTYnW7b/ZIWx5ie1v5zBDfKAs8WPDaTYI
	u1Zi7bEz7BD2Gw6JJ5+DIGwXiYuPl7BA2MISr45vgaqRkTg9uQcqXi3x9MZvZpB/JQRaGCX6
	d65nA7lHQsBaou9MDkSNo8SyQy2MEGE+iRtvBSHO4ZOYtG068wRG1VlIATELyWOzkHwwC8kH
	CxhZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgQmnNP/jn/dwbji1Ue9Q4xMHIyHGCU4
	mJVEeN2++CQL8aYkVlalFuXHF5XmpBYfYpTmYFES52WboZUsJJCeWJKanZpakFoEk2Xi4JRq
	YJqxcYIB03xPsT1bv7aKujO7CrxZ92LVq5OlJ4IeFr0Uj3aRKyzc814kuHRhQ33Unb8d53h2
	6WdGLilZ5nVNu2WaUubvH69/uZ/rZ3H6ILXq/XajmRf0JNVzHA3lT1v0PWntq74yf7H5m2NH
	S2uu7rq7tn1rsMf5B3JnovnO3d/Zumvf/PwdukcXi0z9tLiD38SgaqmW/L/qL+ZF+aJNnsvc
	jz5bIaXe0GagcMZg3r/pLtpi2p6Fa81ZeB5+f7BPtMvRsuH+gR/Kk0+vfjFPprl1LvvWmkXL
	D1y+ZOD0W3D2l43P7h2XumMu86NIMtJuOa/Cja2nW/subJaLW7bo/92wvMzHC96sSmiTPm1y
	/7OJEktxRqKhFnNRcSIApuLqS6cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7qn1/klG5w/Kmyxp/8Uk8Xhx5PY
	LVauPspkMenQNUaL+cuesjuwemxa1cnmsXlJvcfumw1sHh+f3mLx2Hy6OoA1Ss+mKL+0JFUh
	I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j+c0VLAVzBCq2vPvK
	0sDYzdvFyMkhIWAi8WfpPZYuRi4OIYGljBJbD8xhh0jISHy68hHKFpb4c62LDaLoI6PE1dmv
	WUESQgK7GSUmvQwBsXkF7CS2LLoD1sAioCpxftdzRoi4oMTJmU9YQGxRgSiJpY97wGxhgQSJ
	r+ca2UBsEYEaiSlLroPZzAI2Ev1nl0Jd1MsosWn9ElaIhLjErSfzmboYOTjYBLQkGjvBdnEK
	WEnMfPQIqldTonX7b3YIW15i+9s5zBAPKEv82HCaDcKulXh1fzfjBEbRWUjOm4Vkwywko2Yh
	GbWAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYJxuO/Zzyw7Gla8+6h1iZOJgPMQowcGs
	JMLr9sUnWYg3JbGyKrUoP76oNCe1+BCjKTCMJjJLiSbnAxNFXkm8oZmBqaGJmaWBqaWZsZI4
	r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDk5vZBg6Td5N2zn981lwg/ufDLcs8X0/6I5b/aMvk
	7NsKEv3y6tJFP8O+ty54cfTSh07zUyfUe8/9tG165HVt8fPWhUatVpFsrsw7H8yz3uniXRnS
	56DvU/la1YGjbePTHzK7FnW9y6t7Ei9itDrHoeJo0pqte3sY6lrU1nv7Gge9qrrgUS9hV/px
	5wHdzSI+69X4L61Teb9jnvCSz26vZh2p/WP80XXSmg1TE5NbMp9cK29Sjks6+UCWf+e1ij8v
	klLz+D/p3Q7j8Z05y78p5f+7izYdXZMbhNMvXdTVkXqU3GO3zHSbfs3b+8W5p1xv9y5cNlFj
	y9JJRQZVm274JQjrhSwWkTicuinpQOGB90osxRmJhlrMRcWJALLPKplcAwAA
X-CMS-MailID: 20221018134859eucas1p226f166a18862f0b86f968460687a63c6
X-Msg-Generator: CA
X-RootMTR: 20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92
References: <CGME20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92@eucas1p1.samsung.com>
	<20221006091053.36611-1-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_064914_395510_43356AF1 
X-CRM114-Status: GOOD (  19.78  )
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

The final consensus in Daniel's patch[1] seems to be adding an opt in to
log error only for admin commands, and logging error for user IO commands
will remain as is.

In that case, should we reconsider this patch to avoid printing a garbage
value ((sector_t)-1) while logging error for IO passthrough commands?

[1]
https://lore.kernel.org/all/79E937D0-58DA-4AE2-A0B8-A30185CE7FCE@oracle.com/

On 2022-10-06 11:10, Pankaj Raghav wrote:
> Error log will print a garbage value as the starting LBA for passthrough
> requests and requests with uninitialized starting sector that return an
> error. Print LBA as 0 instead for these requests. This behaviour is
> similar what tracing does for these type of requests.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c1..41e0a257f1c2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -305,6 +305,13 @@ static void nvme_retry_req(struct request *req)
>  	blk_mq_delay_kick_requeue_list(req->q, delay);
>  }
>  
> +static inline u64 nvme_log_error_rq_lba(struct nvme_ns *ns, struct request *rq)
> +{
> +	if (blk_rq_is_passthrough(rq) || blk_rq_pos(rq) == (sector_t)-1)
> +		return 0;
> +	return nvme_sect_to_lba(ns, blk_rq_pos(rq));
> +}
> +
>  static void nvme_log_error(struct request *req)
>  {
>  	struct nvme_ns *ns = req->q->queuedata;
> @@ -315,7 +322,7 @@ static void nvme_log_error(struct request *req)
>  		       ns->disk ? ns->disk->disk_name : "?",
>  		       nvme_get_opcode_str(nr->cmd->common.opcode),
>  		       nr->cmd->common.opcode,
> -		       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
> +		       (unsigned long long)nvme_log_error_rq_lba(ns, req),
>  		       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
>  		       nvme_get_error_status_str(nr->status),
>  		       nr->status >> 8 & 7,	/* Status Code Type */

