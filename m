Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914F6C48BC1
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 11:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H2ts4ER8BzFpsej/Vq671mVhhz9ldXAVP7yjnlzRlLI=; b=i6+ERl3obIKvDo0WF4BNs8tEIL
	Rp5c6FdAll8uMdqbucrImDOl+UEIp2c0dzaaGMSbQgiCZ8fSO7NBIt9Kv6kVONhHcGK+UpriC8WAV
	r3y2vLf0VJH5XkwJPNlS2DiL4Tswwp8ftC5eHV45tgoNI5SPYdCwAi0XhGYcdv4qIcHLmyKNO0H5u
	FfCb/Cc/rjn+LDXK58tDU2mk2TA6eQx9mJA1gVUHm68axymskYKYmBdKFeEEv8EMBsNa6rtd5Elqy
	0j5wlG2xj8lHKIN6cokNchVA8L7tnsUw0B1pDpsrDHeGI8WrSmFj+tvtRmFPaOTqz/E//NDRfkqd6
	6wOvFFtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZr2j-000000092C8-0tUK;
	Tue, 13 Feb 2024 11:33:41 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZr2g-000000092Bg-2du3
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 11:33:40 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240213113334epoutp02c4dcaa8f0e137a4836b82ec1e0e8ece2~zaOR-ox8G1208912089epoutp02o
	for <linux-nvme@lists.infradead.org>; Tue, 13 Feb 2024 11:33:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240213113334epoutp02c4dcaa8f0e137a4836b82ec1e0e8ece2~zaOR-ox8G1208912089epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707824014;
	bh=H2ts4ER8BzFpsej/Vq671mVhhz9ldXAVP7yjnlzRlLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fXzX132c8WZGPUug0d5Q8wvvY0/bBsdgZAXBzRqeSiUkjNFj9U9m/OhN8pZgNLOut
	 RrTZhj8pOuydQKNogUuyI8+FoBfwnyqeGzVAN1aHS1kmdT7BSoJdRfU9qHKwFWZ54G
	 N3zN268UyCU0vNGwx9yI50KMdDgv55GukbmTr03g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240213113334epcas5p2bb1183a9ab984cdf571411079352891c~zaORuAT4u0751307513epcas5p2x;
	Tue, 13 Feb 2024 11:33:34 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TYzjS1MYJz4x9Pp; Tue, 13 Feb
	2024 11:33:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F3.84.09672.C835BC56; Tue, 13 Feb 2024 20:33:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240213112919epcas5p202d7598368353872b176976666422d55~zaKkfX7_d2432524325epcas5p2L;
	Tue, 13 Feb 2024 11:29:19 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240213112919epsmtrp1d62f496720e8a8efe6c18925be684ecc~zaKkeo1Of1649016490epsmtrp1g;
	Tue, 13 Feb 2024 11:29:19 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-44-65cb538c0e0b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E6.13.07368.F825BC56; Tue, 13 Feb 2024 20:29:19 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240213112917epsmtip20a2951ec729f0be8d6168072901db468~zaKjG1JqX1541015410epsmtip2H;
	Tue, 13 Feb 2024 11:29:17 +0000 (GMT)
Date: Tue, 13 Feb 2024 16:52:38 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: sathya.m@samsung.com
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, d.palani@samsung.com,
	prakash.bv@samsung.com, anshul@samsung.com
Subject: Re: [PATCH 1/1] nvme-pci: Verify the CMB's Controller Base Address.
Message-ID: <20240213112238.62nmky62eud2fqvz@green245>
MIME-Version: 1.0
In-Reply-To: <1707282098-28131-1-git-send-email-sathya.m@samsung.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmum5P8OlUg1ff2Cx+T5/CavF/zzE2
	i7dfH7BZrFx9lMli0qFrjBbzlz1lt7g3o4vdYt3r9ywWWy8vYHfg9JjY/I7d4/y9jSwem1Z1
	snlsXlLvsftmA5tH35ZVjAFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
	eYm5qbZKLj4Bum6ZOUBXKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNz
	i0vz0vXyUkusDA0MjEyBChOyM35ubWQsWMxfcX3nJNYGxoc8XYycHBICJhInzk1h7mLk4hAS
	2M0o8WzfRXYI5xOjxKK7qxghnG+MEp9vXmKCaZl5vxsqsZdR4vbPdjYI5xmjxJQvu9hAqlgE
	VCVePfwNZHNwsAloS5z+zwESFhGQkJj75wUTSD2zwHJGiTfrNzCD1AgL+EhMPKMOUsMrYCZx
	61s7I4QtKHFy5hMWEJtTwFXiaEs7O4gtKiAjMWPpV7C7JQRmckhMvH6LHeI6F4l/K6ewQtjC
	Eq+Ob4GKS0m87G+DssslVk5ZwQbR3MIoMev6LEaIhL1E66l+ZhCbWSBD4sGNicwQcVmJqafW
	MUHE+SR6fz+BBgWvxI55MLayxJr1C9ggbEmJa98bwZ6XEPCQWNjoBAmgGYwSDbvamCYwys9C
	8twsJOsgbCuJzg9NrLOA2pkFpCWW/+OAMDUl1u/SX8DIuopRMrWgODc9tdi0wDgvtRwe48n5
	uZsYwalWy3sH46MHH/QOMTJxMB5ilOBgVhLhvTTjRKoQb0piZVVqUX58UWlOavEhRlNgXE1k
	lhJNzgcm+7ySeEMTSwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGpiyAgtt
	c27Ebl5heMC72blcPlCqo/rG3d/p+1WNKhzeha9h+yZy77tHZWmjz6lrhRVVm8U8eC9mm165
	+f5U/OqO+mpmwT99/xwfrb2wtXbH55snDuXaN4cL9fZmMhyPV9a+eXnXUZUJwu1m6yt8Sh78
	crFq8T69fcXyVw7Gy/quczwqYfh94lvu+fWVb+8/7u1XvnB80xJHF1neA2s+CS9527Mhdaru
	uYivt0MZGMuqEk69z4nXvJXovOWFSsmDlEb5R70lZlfvqLoXRMUejJvx5dTKT195sy6fEWpV
	NjuwS+/8GkXnHyst/t//+GKpKe+KycC8vcSjsP4KQ+7GvTM4ZOa9FLp7jUH8xPbqhCwlluKM
	REMt5qLiRADWZDsVPgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvG5/0OlUg2l/OSx+T5/CavF/zzE2
	i7dfH7BZrFx9lMli0qFrjBbzlz1lt7g3o4vdYt3r9ywWWy8vYHfg9JjY/I7d4/y9jSwem1Z1
	snlsXlLvsftmA5tH35ZVjAFsUVw2Kak5mWWpRfp2CVwZW7Z2MxZc5ak4OLmXuYFxLVcXIyeH
	hICJxMz73YxdjFwcQgK7GSW2TTnKApGQlFj29wgzhC0ssfLfc3aIoieMEh+bT7CCJFgEVCVe
	PfzN1sXIwcEmoC1x+j8HSFhEQEJi7p8XTCD1zALLGSXerN/ADFIjLOAjMfGMOkgNr4CZxK1v
	7YwgtpDADEaJg+ctIeKCEidnPgG7gRmoZt7mh2CtzALSEsv/gY3nFHCVONrSzg5iiwrISMxY
	+pV5AqPgLCTds5B0z0LoXsDIvIpRMrWgODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzg+tDR2
	MN6b/0/vECMTB+MhRgkOZiUR3kszTqQK8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9
	sSQ1OzW1ILUIJsvEwSnVwJSXwPq95Hijyb2nS602L1t23NBw0bR088SDYm4i/+frPKsxFP20
	94uI7bzUmY8PNrLyyP5u1P7MV+G3xeT/+kK3st///e+mynx+szBYuPzj00rbD93PA0Uta8Ky
	a5r4tS5fj4+/e7Jeac16g1UvHnAv3tEol6XUUacx5fus/+K3bNLfJ38KW8pnkO9f9TxKelvM
	rrWPnUwYz+ybPLPu79vl+dIpFmyXYs/P2rVRhVnypIAx34vi5kU7mbm+Jwqd/zfrtv6ZrQdk
	Xuf7Z/VmNT98tqMxzIZpmdWPTXNLjB+dWpj4P2RRSelLToaaydeepv8XfXK85ar210qW4vap
	jioHc3R4vPisgix5rTzt1yixFGckGmoxFxUnAgAfc+Xk/gIAAA==
X-CMS-MailID: 20240213112919epcas5p202d7598368353872b176976666422d55
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----pZhlYd6Le89yu_j4cm6a7oh4XpCDVzwixOFt0LdgVmQpm6tz=_501d5_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240207103103epcas5p1b4f57f29cac1387546301ba279ea0f96
References: <CGME20240207103103epcas5p1b4f57f29cac1387546301ba279ea0f96@epcas5p1.samsung.com>
	<1707282098-28131-1-git-send-email-sathya.m@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_033339_377334_270355E3 
X-CRM114-Status: GOOD (  16.06  )
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

------pZhlYd6Le89yu_j4cm6a7oh4XpCDVzwixOFt0LdgVmQpm6tz=_501d5_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 07/02/24 10:31AM, sathya.m@samsung.com wrote:
>From: Sathyavathi M <sathya.m@samsung.com>
>
>As per the NVMe Base Specification, CMB should not be enabled if
>the CMB's Controller Base Address(CMBMSC.CBA) is invalid. This patch
>detects if the CMB's Controller Base Address is valid or not.
>
>Signed-off-by: Sathyavathi M <sathya.m@samsung.com>
>---
> drivers/nvme/host/pci.c | 3 +++
> include/linux/nvme.h    | 1 +
> 2 files changed, 4 insertions(+)
>
>diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>index e6267a6..6edc442 100644
>--- a/drivers/nvme/host/pci.c
>+++ b/drivers/nvme/host/pci.c
>@@ -1856,6 +1856,9 @@ static void nvme_map_cmb(struct nvme_dev *dev)
> 		hi_lo_writeq(NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE |
> 			     (pci_bus_address(pdev, bar) + offset),
> 			     dev->bar + NVME_REG_CMBMSC);
>+		/* Check the status of Controller Memory Buffer */
>+		if (readl(dev->bar + NVME_REG_CMBSTS) & 0x1)
>+			return;
> 	}
>
> 	/*
>diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>index bc605ec..0ff925b 100644
>--- a/include/linux/nvme.h
>+++ b/include/linux/nvme.h
>@@ -145,6 +145,7 @@ enum {
> 	NVME_REG_CMBMSC = 0x0050,	/* Controller Memory Buffer Memory
> 					 * Space Control
> 					 */
>+	NVME_REG_CMBSTS	= 0x0058,	/* Controller Memory Buffer Status */
> 	NVME_REG_CRTO	= 0x0068,	/* Controller Ready Timeouts */
> 	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
> 	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
>-- 
>1.8.3.1
>
>
Looks good to me

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------pZhlYd6Le89yu_j4cm6a7oh4XpCDVzwixOFt0LdgVmQpm6tz=_501d5_
Content-Type: text/plain; charset="utf-8"


------pZhlYd6Le89yu_j4cm6a7oh4XpCDVzwixOFt0LdgVmQpm6tz=_501d5_--

