Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B94C54F54
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSJ+f9xik0x5jkahvNZE5rtQIeiR1wLKaWlk7HAViBs=; b=Hm6bCWTpby4bqcnxjyJBecdoeH
	4iqYyotIxiMAICNEFP1JGa//eqnAZv5sjUNmO9OpwzQprRo4OMRmZKF+2q6+7hVft6NhQoFlO25Jt
	0jrkoUC17cQJcBRr54lCqm7Fa3XR35/lbisHRG+p+UiO9Y9Zn4HEEiwWu88/LgpYXfQvSuPKOYx5R
	amqAm2BgDctECuGrGh9Xjvfb3Ido+TpRmDWjRSmv78hZBYlPOsPZHFsY8QU+F627qSOMNKFdhhstS
	t+4p5tb3MCq02g1kBm45TnyI3u0AMv41+kaTVbYfAiYaLRPsU4oDvDKZyWHd8+9cvjT1iSxUrI0+b
	I9wcwZQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpqEW-0000000D9vv-0naG;
	Fri, 31 Jul 2026 16:37:16 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpqEQ-0000000D9uF-3Vl4
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 16:37:15 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260731163704epoutp02177183b1abdaf2fea5b726c5d0510ffe~HbS7JfZBq3130031300epoutp02y
	for <linux-nvme@lists.infradead.org>; Fri, 31 Jul 2026 16:37:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260731163704epoutp02177183b1abdaf2fea5b726c5d0510ffe~HbS7JfZBq3130031300epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785515825;
	bh=RSJ+f9xik0x5jkahvNZE5rtQIeiR1wLKaWlk7HAViBs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=oXGgdx5I4pdtdFhQ7C3nRvqpVC67xEMQWz/zxaFf35/i1ftBV//0gcu+4BQn7aDzD
	 vef7+zS67JWgYN9hdf9rFuB+kzDryJ1jGPccjD+m4Su2GrJTnpvPFkS0mGX6swsZnU
	 5iQuvxvm9Ckq5Oa+ZYRFEqbvE9D/aASNZa9ryQzQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260731163704epcas5p333bbb98de3a12d85a15d2ec43d6cd047~HbS6g26pC1817818178epcas5p3T;
	Fri, 31 Jul 2026 16:37:04 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hBWtl2Rb8z2SSKY; Fri, 31 Jul
	2026 16:37:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260731163702epcas5p2c474c8a976177d918f5fb498a1f674ce~HbS4Y7Poo1789617896epcas5p2X;
	Fri, 31 Jul 2026 16:37:02 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260731163700epsmtip13f39ce4f73eff014ec538c2251d1b978~HbS3MbXnO2402224022epsmtip1I;
	Fri, 31 Jul 2026 16:37:00 +0000 (GMT)
Message-ID: <fe8f6e8c-185a-4089-848b-2c965fed84a8@samsung.com>
Date: Fri, 31 Jul 2026 22:06:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] nvme: raise FDP placement handle cap to U8_MAX
 and warn on overflow
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, nilay@linux.ibm.com,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260731032031.1090755-6-kanie@linux.alibaba.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260731163702epcas5p2c474c8a976177d918f5fb498a1f674ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260731032043epcas5p46e85c04297e36291545e0b688ba7f6fa
References: <20260731032031.1090755-1-kanie@linux.alibaba.com>
	<CGME20260731032043epcas5p46e85c04297e36291545e0b688ba7f6fa@epcas5p4.samsung.com>
	<20260731032031.1090755-6-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_093711_558688_2566833B 
X-CRM114-Status: GOOD (  11.63  )
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

On 7/31/2026 8:50 AM, Guixin Liu wrote:
> @@ -2342,7 +2350,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   	if (!info->runs)
>   		return ret;
>   
> -	size = struct_size(ruhs, ruhsd, S8_MAX - 1);
> +	size = struct_size(ruhs, ruhsd, NVME_MAX_PLIDS);
>   	ruhs = kzalloc(size, GFP_KERNEL);
>   	if (!ruhs)
>   		return -ENOMEM;
> @@ -2357,8 +2365,13 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   		goto free;
>   	}
>   
> -	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
> -	head->nr_plids = min_t(u16, head->nr_plids, S8_MAX - 1);
> +	nr_plids = le16_to_cpu(ruhs->nruhsd);
> +	if (nr_plids > NVME_MAX_PLIDS)

I'd move this check down; after if (!head->nr_plids) part below.

> +		dev_warn(ctrl->device,
> +			 "FDP RUH status reports %u placement handles, capping at %u\n",
> +			 nr_plids, NVME_MAX_PLIDS);
> +
> +	head->nr_plids = min_t(u16, nr_plids, NVME_MAX_PLIDS);

And will keep this in above if block, alongside dev_warn(). And kill 
that min_t with a simple
	head->nr_plids = NVME_MAX_PLIDS;

>   	if (!head->nr_plids)
>   		goto free;
>   

Modulo these nits
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


