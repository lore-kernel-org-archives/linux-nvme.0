Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B20C87FC9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 08:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7tle2Ig+xZHeUculCrMm8JZ5XDdMkIORqRSnHOVg2S0=; b=YPDE2TzpcWolOfUQ+KUcL85MXe
	SIr3WKl1AdqubdKjKmJXF5CxpvaBqRzONLXekF7MHZ24ZNQdGgletjp1tGoka8Kqb+n1UsmDAkvDw
	H4vPb0CvFniubX/t5X5uvtaSQWZmWof9rsQIgwQ3aSd84qASohorQoDCOK76+0MVOnjMbYAInKTTs
	/eIKuZiB4CRwiKIC9GbLMijBQhokknoY7RsySH7eZYs56KpZq2k3b8bCp4g2JCpVHcOCR1gxnZWMm
	mLZun8/8rE0Qwic9ZRUtxEOtMDYA3hP40n3vVnz63ha1cXV25Uym5BWlpibsW4XFvKvlGulUHLgRu
	hVQNMFEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh21d-00000000y0l-1xlo;
	Wed, 30 Jul 2025 08:19:01 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh21T-00000000xzj-3rSX
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 08:18:56 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250730081846epoutp03d36988473cb0cced8679ea05edfa1160~W_ZWzuwWA0762507625epoutp03Q
	for <linux-nvme@lists.infradead.org>; Wed, 30 Jul 2025 08:18:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250730081846epoutp03d36988473cb0cced8679ea05edfa1160~W_ZWzuwWA0762507625epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753863526;
	bh=7tle2Ig+xZHeUculCrMm8JZ5XDdMkIORqRSnHOVg2S0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jJ/roB/EsMLARdVD7r/oQ562VpNqF7CVvwwJc795ct3/1WjfyvjolcUUyTNrzc4v7
	 OkDS2Eas0HGjVqot64C4yT57iQTs+jXuEszV94pCNc2gpV4ZgRk4j4HyUChwjlyOE0
	 qmG2bM0c7oFoWRrIxQpBsC99eHMIy5pXIJHkTL0s=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250730081845epcas5p1e6b259e8081b9a35240d0933d5634c71~W_ZWFR2_d0760807608epcas5p1b;
	Wed, 30 Jul 2025 08:18:45 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bsQ8h5lWqz6B9mS; Wed, 30 Jul
	2025 08:18:44 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250730081844epcas5p1abca54e976cf9ab4f116c71b99a7a132~W_ZVGjnDE0760807608epcas5p1Z;
	Wed, 30 Jul 2025 08:18:44 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250730081843epsmtip1dec56cd22af8d06770003f4a91ba7673~W_ZUKBPTk2278222782epsmtip1R;
	Wed, 30 Jul 2025 08:18:43 +0000 (GMT)
Message-ID: <09c06697-dd77-47bb-85c5-fd64e75c7968@samsung.com>
Date: Wed, 30 Jul 2025 13:48:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/7] blk-mq: introduce blk_map_iter
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de
Cc: axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250729143442.2586575-2-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250730081844epcas5p1abca54e976cf9ab4f116c71b99a7a132
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729143610epcas5p114f07bbd8e9c27280e6ebd67b1afd47f
References: <20250729143442.2586575-1-kbusch@meta.com>
	<CGME20250729143610epcas5p114f07bbd8e9c27280e6ebd67b1afd47f@epcas5p1.samsung.com>
	<20250729143442.2586575-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_011854_055945_4BE41F67 
X-CRM114-Status: GOOD (  11.51  )
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

On 7/29/2025 8:04 PM, Keith Busch wrote:
> @@ -39,12 +33,11 @@ static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
>   	 * one could be merged into it.  This typically happens when moving to
>   	 * the next bio, but some callers also don't pack bvecs tight.
>   	 */
> -	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
> +	while (!iter->iter.bi_size ||
> +	       (!iter->iter.bi_bvec_done && iter->bio->bi_next)) {
>   		struct bio_vec next;
>   
>   		if (!iter->iter.bi_size) {
> -			if (!iter->bio->bi_next)
> -				break;
>   			iter->bio = iter->bio->bi_next;
>   			iter->iter = iter->bio->bi_iter;

This can crash here if we come inside the loop because 
iter->iter.bi_size is 0
and if this is the last bio i.e., iter->bio->bi_next is NULL?




