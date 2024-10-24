Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4776CD0BB5E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 06:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7bGZ/uy+x9gHy2r+EigG6l4pgmO7OrgOE/fqes8Osc=; b=zzu7Y09BtkAg/4cncbHSTCfZwK
	dIcbKKq1qlrpDlpgjCGSRyqFT9JLhriO6yLkS4ylZOqa0K6cLJQi7SJH65eCFrHFjJZov5/fwlnSe
	oXPx8cHD8wqX605vhjRK1KinauOPj4K6ksonarjv7i7ZRWiQwZPty1lmy77gF6lv9QsXFLklOGDuM
	/BqtIZZC+z7PIEoJAq5vOa33pYjR+EqARoJpeYj9wjt2lem3A8ZY07QyRxeqOx15TNDJztBJA8tAJ
	Sodgo1Ft4FasTJPxzoCMY+O/dT3cbbiXTWqwBbd9ug62hRcncVZ8h010Cl3i85pb0d5nIbtjIqmOH
	AuAilr+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3r3K-0000000GrvP-1t6C;
	Thu, 24 Oct 2024 06:10:34 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3r3C-0000000Grte-2KJV
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 06:10:29 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241024061018epoutp0438373283491dd61590e4f6944fad5117~BTqjFV1SE1613216132epoutp045
	for <linux-nvme@lists.infradead.org>; Thu, 24 Oct 2024 06:10:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241024061018epoutp0438373283491dd61590e4f6944fad5117~BTqjFV1SE1613216132epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729750218;
	bh=e7bGZ/uy+x9gHy2r+EigG6l4pgmO7OrgOE/fqes8Osc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OC2rFkWEVS/5V+y/5NKv4L2DTPjYZ10DYuIseB09TuIOJFKhcx5CX5Q/6z0pyRvmz
	 UjWKUrDz5RWEA7r5eIsm3wH4DZUUWJz1Bjr6z0zJEafjTZNJKYuIzPgDI0TTWLmrnh
	 1nrNTXim96ywgkgNAPex12mHqjamean6SkAm/er0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241024061018epcas5p12216add5e1d618346cdecd26b5b3bd50~BTqiyDPa01353613536epcas5p14;
	Thu, 24 Oct 2024 06:10:18 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XYwWD5B6jz4x9Q7; Thu, 24 Oct
	2024 06:10:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3F.A7.09770.6C4E9176; Thu, 24 Oct 2024 15:10:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241024061013epcas5p35c39e25f9b231fe2b268a59cabed0113~BTqetx_4z1075010750epcas5p3B;
	Thu, 24 Oct 2024 06:10:13 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241024061013epsmtrp258e93bb08a412a48c1bacc0ed79c0820~BTqesZLio1385313853epsmtrp27;
	Thu, 24 Oct 2024 06:10:13 +0000 (GMT)
X-AuditID: b6c32a4a-bbfff7000000262a-a9-6719e4c63204
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.16.18937.5C4E9176; Thu, 24 Oct 2024 15:10:13 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241024061012epsmtip237d60541f52f7f3a3f88b4af24b13b14~BTqduvL0Q2452624526epsmtip2D;
	Thu, 24 Oct 2024 06:10:12 +0000 (GMT)
Message-ID: <f4995460-61d3-495d-bed2-0e64d7fe0211@samsung.com>
Date: Thu, 24 Oct 2024 11:40:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: module parameter to disable pi checks
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>, David Wei
	<dw@davidwei.uk>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20241023155048.634988-1-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmlu6xJ5LpBv/WiFq8mrGWzWLl6qNM
	FpMOXWO0OHN1IYvF/GVP2S2WH//H5MDmcW3GRBaPTas62Tw2L6n32H2zgc3j3MUKj49Pb7EE
	sEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaGk
	UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpM
	yM5oevGcseCiQsXUd5fZGxj3S3QxcnJICJhILPp1hrGLkYtDSGA3o8TbiVPYIJxPjBI91yew
	wDkXPm5hhWl5NO8ME0RiJ6PErntroKreMko0zVvNBFLFK2An0bTkECOIzSKgKjF/8xOouKDE
	yZlPWEBsUQF5ifu3ZrCD2MICDhK/Z/cB1XBwiAj4S1x45AJiMgvESjzvKQKpYBYQl7j1ZD5Y
	BZuApsSFyaUgJqeAmcT1VcYQFfIS29/OYQY5RkLgL7vEg3+9LBAnu0hMvrAOyhaWeHV8CzuE
	LSXx+d1eNgg7W+LBowdQNTUSOzb3Qb1rL9Hw5wYrxDWaEut36UPs4pPo/f0E7BoJAV6JjjYh
	iGpFiXuTnkJ1iks8nLEEyvaQWN3wGBponYwSO08/YJ3AqDALKUhmIXlyFpJ3ZiFsXsDIsopR
	MrWgODc9tdi0wCgvtRwe28n5uZsYwSlUy2sH48MHH/QOMTJxMB5ilOBgVhLhvZghmS7Em5JY
	WZValB9fVJqTWnyI0RQYNxOZpUST84FJPK8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU
	7NTUgtQimD4mDk6pBqaq9bMPlU6ber835LHz7egfgQwLC+7rLQ+rYV24fXfMHYGf3e2hEY1d
	gvW3NBwjkq52mSn09OyOXJ9+8syb99MWXrROX5fG/7CAa+Pf8uXTHtWx79l6PPFxmu9Enk1G
	LpNPfOO07Sg7uujpbgZfx32ObHYGz6IVZp262LSj/Y/5nLsqL8JWHmazur/J38DAuy4tJEZu
	QvrnmsjFy1S7r10xmv3/O3fZOb5puX96dsUknSiS2Nx+dNmCQNufmQn77wvx3lvKoSjmu/u4
	9savZ7++OC8sbbvtbcmLWw+4f4myeP9rKrPNUdh16mzwvKTjbLfqoowqVQ50dl/aI+5adiCK
	zW/LiwsVSZM5+Z3N5p5UYinOSDTUYi4qTgQA+pm6RioEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvO7RJ5LpBnMWmVq8mrGWzWLl6qNM
	FpMOXWO0OHN1IYvF/GVP2S2WH//H5MDmcW3GRBaPTas62Tw2L6n32H2zgc3j3MUKj49Pb7EE
	sEVx2aSk5mSWpRbp2yVwZTS9eM5YcFGhYuq7y+wNjPsluhg5OSQETCQezTvD1MXIxSEksJ1R
	4tecRkaIhLhE87Uf7BC2sMTKf8/ZIYpeM0osW/OGBSTBK2An0bTkEFgDi4CqxPzNT5gg4oIS
	J2c+AasRFZCXuH9rBtggYQEHid+z+8BqRAR8JT5P+wpmMwvESjxb2s0GsaAT6Ip9LYwQCXGJ
	W0/mAxVxcLAJaEpcmFwKYnIKmElcX2UMUWEm0bW1C6paXmL72znMExiFZiG5YhaSQbOQtMxC
	0rKAkWUVo2hqQXFuem5ygaFecWJucWleul5yfu4mRnCsaAXtYFy2/q/eIUYmDsZDjBIczEoi
	vBczJNOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yrndKYICaQnlqRmp6YWpBbBZJk4OKUamNjn
	nP8X2fj1uaNtjeHO1j6hTGfVyw5bzh751/irz6cvwGd1X9dek1v5H5tnTi50Nsxd9caum+FA
	vMcWsXh1JwNOvu4dfFG9nppMq/YtdXiddLBd4ajewc/KN1quXjnvrBfKIjMvY+mhXadbjrx3
	V+Q2Pqovk17244qqfs1b/+9r/aemue3+s/Xh9DmeqfNdL6hpG/rLmkRNM/28tfzthXuvLl3j
	1uhd/GvtjRsns2R708Lf3TeXfxY3NUY2KKdy1uHYDY0SWxk2vXj8xOBDW0rOg4Ss2XlM/A67
	9d8VcbzsCG47ffNDVNcym541C6Uu7+xalqO/85+c3Ndf3QELbH9c7LCsi+z8282msGtduhJL
	cUaioRZzUXEiAByfm0sEAwAA
X-CMS-MailID: 20241024061013epcas5p35c39e25f9b231fe2b268a59cabed0113
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241023162331epcas5p17398e6453b275a480ace5ae5a0176001
References: <CGME20241023162331epcas5p17398e6453b275a480ace5ae5a0176001@epcas5p1.samsung.com>
	<20241023155048.634988-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_231027_205172_4875A14C 
X-CRM114-Status: GOOD (  20.01  )
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

On 10/23/2024 9:20 PM, Keith Busch wrote:
> @@ -1763,6 +1767,7 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
>   		struct queue_limits *lim, struct nvme_ns_info *info)
>   {
>   	struct blk_integrity *bi = &lim->integrity;
> +	int pi_type = head->pi_type;
>   
>   	memset(bi, 0, sizeof(*bi));
>   
> @@ -1777,7 +1782,10 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
>   	    !(head->features & NVME_NS_METADATA_SUPPORTED))
>   		return nvme_ns_has_pi(head);
>   
> -	switch (head->pi_type) {
> +	if (disable_pi)
> +		pi_type = 0;

I think this will not give the desired outcome. Since, regardless of the 
nop profile, driver continues to send PRCHK_GUARD/REF to the device 
during nvme_setup_rw. And you will continue to see read-failures.

Instead, you probably want this patch [1]?

Also in current boolean form, "disable_pi" will do its thing on all 
connected nvme devices. Should we make this fine granular. Like this 
patch [2]?


[1]
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d..c93557621bcb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -91,6 +91,10 @@ module_param(apst_secondary_latency_tol_us, ulong, 0644);
  MODULE_PARM_DESC(apst_secondary_latency_tol_us,
         "secondary APST latency tolerance in us");

+static bool disable_pi = false;
+module_param(disable_pi, bool, 0444);
+MODULE_PARM_DESC(disable_pi, "disable protection-information if used");
+
  /*
   * nvme_wq - hosts nvme related works that are not reset or delete
   * nvme_reset_wq - hosts nvme reset works
@@ -1911,7 +1915,7 @@ static void nvme_configure_metadata(struct 
nvme_ctrl *ctrl,
                 head->guard_type = NVME_NVM_NS_16B_GUARD;
         }

-       if (head->pi_size && head->ms >= head->pi_size)
+       if (!disable_pi && head->pi_size && head->ms >= head->pi_size)
                 head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
         if (!(id->dps & NVME_NS_DPS_PI_FIRST))
                 info->pi_offset = head->ms - head->pi_size;

[2]
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d..0876acadb81d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -91,6 +91,20 @@ module_param(apst_secondary_latency_tol_us, ulong, 0644);
  MODULE_PARM_DESC(apst_secondary_latency_tol_us,
         "secondary APST latency tolerance in us");

+static u8 disable_pi;
+module_param(disable_pi, byte, 0444);
+MODULE_PARM_DESC(disable_pi, "disable protection-information if used");
+
+/*
+ * disable_pi = 0, do nothing.
+ * disable_pi = 1, disables pi only if it is in the last bytes.
+ * disable_pi > 1, always disables pi.
+ */
+enum {
+       NVME_DISABLE_PI_NONE,
+       NVME_DISABLE_PI_LAST_BYTE,
+};
+
  /*
   * nvme_wq - hosts nvme related works that are not reset or delete
   * nvme_reset_wq - hosts nvme reset works
@@ -1897,6 +1911,8 @@ static void nvme_configure_metadata(struct 
nvme_ctrl *ctrl,
                 struct nvme_ns_head *head, struct nvme_id_ns *id,
                 struct nvme_id_ns_nvm *nvm, struct nvme_ns_info *info)
  {
+       bool last = !(id->dps & NVME_NS_DPS_PI_FIRST);
+
         head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
         head->pi_type = 0;
         head->pi_size = 0;
@@ -1913,9 +1929,20 @@ static void nvme_configure_metadata(struct 
nvme_ctrl *ctrl,

         if (head->pi_size && head->ms >= head->pi_size)
                 head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-       if (!(id->dps & NVME_NS_DPS_PI_FIRST))
+       if (last)
                 info->pi_offset = head->ms - head->pi_size;

+       switch (disable_pi) {
+       case NVME_DISABLE_PI_NONE:
+               break;
+       case NVME_DISABLE_PI_LAST_BYTE:
+               if (last)
+                       head->pi_type = 0;
+               break;
+       default:
+               head->pi_type = 0;
+       }
+
         if (ctrl->ops->flags & NVME_F_FABRICS) {
                 /*
                  * The NVMe over Fabrics specification only supports 
metadata as



