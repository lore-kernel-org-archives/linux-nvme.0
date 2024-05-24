Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB6CC25B7D
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 09:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=++cVoJJr4pyWWuMW0gMUDuI60OCYgTd9/kIQhFdu8SE=; b=b88y/4KL0nwsWj796Vs6eUS0Vc
	I4YSROVTEd69vbevQbHgZ55hUNJRGeIh5xhJYjwYYIl4mzWdEPLiEnEm/KbDmWYT7nlVDnnWewHaF
	t9+srx5Zw0Qe2iRhw96G7bmxhZTyakfdorY43vUWgaCho1OVW0U5yX2nes6acufwL92GAQnlU4Igo
	MVY4ei2wIhMzpC7P3QviIP6EX3FwYP8yjNMqCryyZ0iuFrAuFYqaaJuqHxy4i1IiYYMV9iNCOo7xI
	q/9XBHNRYXKPNNWsbhdZPaRBbNt5SRrVBdlniOw4ENeVJE+we6/XGv27zywlDr7BYaG/aRU5Z/Xr5
	8+Kkzt+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAR2l-00000008Vic-3S09;
	Fri, 24 May 2024 09:16:55 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPxp-00000008LPl-3QFX
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 08:07:48 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240524080738epoutp03377f93422a3acffab2c5fe2bb1eeec2c~SXkTqutwB3109131091epoutp03W
	for <linux-nvme@lists.infradead.org>; Fri, 24 May 2024 08:07:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240524080738epoutp03377f93422a3acffab2c5fe2bb1eeec2c~SXkTqutwB3109131091epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716538058;
	bh=++cVoJJr4pyWWuMW0gMUDuI60OCYgTd9/kIQhFdu8SE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FYGVLuYECXC6Ta0bDif2BWL/oyAFInAkpWOsl6RldADKWQmfMdadJL4g5t5HTBSHV
	 NAKAXZEs/Uo9091CHhYWBzSngHFWVYg14T57cXJAdBGwQ6R+JeX80uNT5uFb8RYZKu
	 Z3u5y08thkDBLWcNOqa1ENJ7qrqLpb5XvbaLu/sc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240524080737epcas5p2852974f8da6567c829de3bfa25711594~SXkTe-Z_01447114471epcas5p21;
	Fri, 24 May 2024 08:07:37 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VlyMD5F4nz4x9Pw; Fri, 24 May
	2024 08:07:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	39.A7.09666.4CA40566; Fri, 24 May 2024 17:07:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240524080511epcas5p311957ded505b60f89d19355b15193600~SXiKwHPOK3169331693epcas5p3D;
	Fri, 24 May 2024 08:05:11 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240524080511epsmtrp24939a453b706b50419c731843a9172d3~SXiKveamn2306123061epsmtrp2K;
	Fri, 24 May 2024 08:05:11 +0000 (GMT)
X-AuditID: b6c32a49-f53fa700000025c2-29-66504ac4db27
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.EA.19234.63A40566; Fri, 24 May 2024 17:05:10 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240524080509epsmtip176c23edc98eb756268c58c6bb42cedcb~SXiJsShB51798017980epsmtip1O;
	Fri, 24 May 2024 08:05:09 +0000 (GMT)
Date: Fri, 24 May 2024 07:58:03 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
	Grimberg <sagi@grimberg.me>, Damien LeMoal <dlemoal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: nvme: fixup zns namespace initialisation
Message-ID: <20240524075803.zbjoke26nyk4sm5h@nj.shetty@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20240524061808.129399-1-hare@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTU/eIV0CawbJlShYP9ttbnPt6g81i
	5eqjTBaTDl1jtJi/7Cm7xbrX71kc2DzO39vI4rFpVSebx+Yl9R67bzawBbBEZdtkpCampBYp
	pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
	6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRn3Nz7k6ngHl/F
	3wOHWBoYH/N0MXJySAiYSHTems3YxcjFISSwm1Fi7vTzjCAJIYFPjBKXlmlAJIDsO2dWMsJ0
	9K3+wwqR2Mko8evFfnYI5zOjxNsHa1lAqlgEVCWOPe5m62Lk4GAT0JY4/Z8DJCwCFO6euJEJ
	pJ5ZYC2jRM+cb2D1wgKmEisObmAHsXkFnCUezNzJCGELSpyc+QSshlPATGLNu26wzRIC19gl
	ph59wQRxkovEp1d7mSFsYYlXx7ewQ9hSEp/f7WWDsMslVk5ZwQbR3MIoMev6LKh/7CVaT/WD
	NTMLZEi8vb4dKi4rMfXUOiaIOJ9E7+8nUMt4JXbMg7GVJdasXwC1QFLi2vdGKNtD4t7FQ9Bg
	6WSUaLy+n3kCo9wsJB/NQrIPwraS6PzQxDoLGGLMAtISy/9xQJiaEut36S9gZF3FKJlaUJyb
	nlpsWmCYl1oOj+bk/NxNjOAEqeW5g/Hugw96hxiZOBgPMUpwMCuJ8Eav9E0T4k1JrKxKLcqP
	LyrNSS0+xGgKjKGJzFKiyfnAFJ1XEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZqakFq
	EUwfEwenVAPTLpn/d27sd+K5/8fw8Lu3fximnOU/PCmiyvnpHus3Lp5ze36eSpSutPJK0JLh
	s5Gfwnw+h+0bW8itfFk/29Vbdc3L3D6GbdLRCM1OTDK4uyhs6yLjxnc5k888Pmpy13Wi+Y5v
	E3lzjz/ZJj93I4fz6Ys/bU9MjbujcnXWgdaaWJMHGp0/ecTjVJSXzax1+ZjUKL3pa/OWvJvS
	1+8WZIruXfjsuL4pq5DDpQ7eWWIPXNWak+6LG/Ub9je1FF7by3bf/smGLq1fH9hVwyeFRakw
	WSQvWeju03mG/WJOoWN77Kms+TLLzrNVpzsIfNJlXGoxgc9misHKN4fm1kRo6pQw1ZruXy8Q
	dFp5xtx+8TVKLMUZiYZazEXFiQAjrhsFGQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSnK6ZV0Cawd9PNhYP9ttbnPt6g81i
	5eqjTBaTDl1jtJi/7Cm7xbrX71kc2DzO39vI4rFpVSebx+Yl9R67bzawBbBEcdmkpOZklqUW
	6dslcGVc/nSVuWACT8X1hvWMDYzruboYOTkkBEwk+lb/Ye1i5OIQEtjOKHFtcw8zREJSYtnf
	I1C2sMTKf8/ZIYo+Mkr8WD+VESTBIqAqcexxN1sXIwcHm4C2xOn/HCBhEaBw98SNTCD1zAJr
	GSX+3znACpIQFjCVWHFwAzuIzSvgLPFg5k6wOUJA8RMPbrNAxAUlTs58AmYzC5hJzNv8kBlk
	PrOAtMTyf2DzOYHCa951s05gFJiFpGMWko5ZCB0LGJlXMYqmFhTnpucmFxjqFSfmFpfmpesl
	5+duYgQHs1bQDsZl6//qHWJk4mA8xCjBwawkwhu90jdNiDclsbIqtSg/vqg0J7X4EKM0B4uS
	OK9yTmeKkEB6YklqdmpqQWoRTJaJg1Oqgan4RfrRgkhehowo44d2h4znM4s9Vvy0t7Np8u7w
	Xjm/teGrDflYIw9t3Cc051KpRelHyzrdlPNbv/00r7D58HrO6auXhAL9k36fCLfillK/4PLZ
	c4K3xcQzc+OKOidzn+y5mCua+2FP4CfjVubIdDY2s3B3q7VtHreV38R2Zn8SXr/SdovexdSX
	vx6cMTtkcMys+kDQ3iafHlM/R+9v3+SYVDeUpUWqFz4uUXc79+aIuWRxWN7X3i+MEu7W65Kj
	953fc99VwC1yBeerH76Orvo+ASpv36vWBC68NkPIdPkeH9PcXZkclYLzwk9Id12tyrNe62ed
	wnD6Ys4Cxk2ak37dOH735c1pk3Yb6SycqsRSnJFoqMVcVJwIAPLU9CPVAgAA
X-CMS-MailID: 20240524080511epcas5p311957ded505b60f89d19355b15193600
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_258be_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240524080511epcas5p311957ded505b60f89d19355b15193600
References: <20240524061808.129399-1-hare@kernel.org>
	<CGME20240524080511epcas5p311957ded505b60f89d19355b15193600@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_010746_695385_CC60E752 
X-CRM114-Status: GOOD (  14.89  )
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

------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_258be_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 24/05/24 08:18AM, Hannes Reinecke wrote:
>nvme_set_chunk_sectors() needs to know whether it's a zoned namespace
>or not, but the information is only set in a later call.
>So move the calls around and ensure that the namespace is marked as
>non-zoned initially to avoid calculation errors when trying to derive
>a non-existing zone geometry.
>
>Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")
>Signed-off-by: Hannes Reinecke <hare@kernel.org>
>---
> drivers/nvme/host/core.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index 111bf4197052..a968d33914a7 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -2115,13 +2115,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
> 	lim = queue_limits_start_update(ns->disk->queue);
> 	nvme_set_ctrl_limits(ns->ctrl, &lim);
> 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm);
>+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>+	    ns->head->ids.csi == NVME_CSI_ZNS)
>+		nvme_update_zone_info(ns, &lim, &zi);
> 	nvme_set_chunk_sectors(ns, id, &lim);
> 	if (!nvme_update_disk_info(ns, id, &lim))
> 		capacity = 0;
> 	nvme_config_discard(ns, &lim);
>-	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>-	    ns->head->ids.csi == NVME_CSI_ZNS)
>-		nvme_update_zone_info(ns, &lim, &zi);
> 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
> 	if (ret) {
> 		blk_mq_unfreeze_queue(ns->disk->queue);

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_258be_
Content-Type: text/plain; charset="utf-8"


------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_258be_--

