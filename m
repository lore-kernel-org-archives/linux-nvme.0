Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A417C83F17
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 05:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yWK6U2Cq7XN/X5bkFRdcHPeBoZecY/oOLVS/TcVu7Gs=; b=zGTgyky2ct60IFPg5unBrHQQnr
	nHa09gL4U3vMonwf1TgDRSO7GXiuUycWTQr+nB2HrA+Qj2LMkjPOeE6HP06UvyH2bm/xBjgI2fXTG
	WPHH/524u/Pj/gif114giCOQlkAXYaS45aU2IBe56BLOuBIDgkoj0i65MKc4PXNKtSVSlHLRfud+9
	E6wPxGcZuofrBkwnpyMckLownb/fPPO3sAvh2IY47wn53LqGw3xKR7iMgaMYG83RtZE873HdewK+Y
	DCF1jbYUeG5NC4RzBTFGx6PEdsJezr5Ht41JavoR6kW8h4x3KQcmEyquBQvubyPZxIrmWuj1phWog
	hNjWwfVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhLU3-00000002unM-0cVY;
	Thu, 31 Jul 2025 05:05:39 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhLU0-00000002uki-03Cs
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 05:05:38 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250731050526epoutp03912e959baa00a39f95dc389e9dc318ea~XPZ17NNX02622426224epoutp03X
	for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 05:05:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250731050526epoutp03912e959baa00a39f95dc389e9dc318ea~XPZ17NNX02622426224epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753938326;
	bh=yWK6U2Cq7XN/X5bkFRdcHPeBoZecY/oOLVS/TcVu7Gs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=g92NuYMaZZo4Zsq6V1i4x9F4Rk1ouLqIwWeXcIPfIXObjE/ICbuSuMlEukLeLIGv6
	 MjESqGRQCb13kx3v9o6M6wWOmNwTBEGM+wDvTAv4WhW4DiqEI1e3oBWmVdOVUNyIIM
	 dgnimg/+cpgEfm3sDSXMXqs3RLqdYMsPNjdxEkvE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250731050526epcas5p2a2e40852fa05e57a8520c1eed890d2d1~XPZ1rE-a92385923859epcas5p2q;
	Thu, 31 Jul 2025 05:05:26 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bsxq93YVJz3hhTC; Thu, 31 Jul
	2025 05:05:25 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250731050525epcas5p1bba1adb57fe4c80c67a73c29e9ee2e3a~XPZ0pM25p2446824468epcas5p1i;
	Thu, 31 Jul 2025 05:05:25 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250731050524epsmtip224c05823040674ab953586780c3e5db2~XPZztUocY0058700587epsmtip2L;
	Thu, 31 Jul 2025 05:05:23 +0000 (GMT)
Message-ID: <c2774764-651f-49d3-8e7e-2609a8dc035e@samsung.com>
Date: Thu, 31 Jul 2025 10:35:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/7] blk-mq: introduce blk_map_iter
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	leonro@nvidia.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <aIo3vLnxQFWCD_pv@kbusch-mbp>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250731050525epcas5p1bba1adb57fe4c80c67a73c29e9ee2e3a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729143610epcas5p114f07bbd8e9c27280e6ebd67b1afd47f
References: <20250729143442.2586575-1-kbusch@meta.com>
	<CGME20250729143610epcas5p114f07bbd8e9c27280e6ebd67b1afd47f@epcas5p1.samsung.com>
	<20250729143442.2586575-2-kbusch@meta.com>
	<09c06697-dd77-47bb-85c5-fd64e75c7968@samsung.com>
	<aIo3vLnxQFWCD_pv@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_220536_711912_2837E438 
X-CRM114-Status: GOOD (  14.03  )
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

On 7/30/2025 8:48 PM, Keith Busch wrote:
> On Wed, Jul 30, 2025 at 01:48:42PM +0530, Kanchan Joshi wrote:
>> On 7/29/2025 8:04 PM, Keith Busch wrote:
>>> @@ -39,12 +33,11 @@ static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
>>>    	 * one could be merged into it.  This typically happens when moving to
>>>    	 * the next bio, but some callers also don't pack bvecs tight.
>>>    	 */
>>> -	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
>>> +	while (!iter->iter.bi_size ||
>>> +	       (!iter->iter.bi_bvec_done && iter->bio->bi_next)) {
>>>    		struct bio_vec next;
>>>    
>>>    		if (!iter->iter.bi_size) {
>>> -			if (!iter->bio->bi_next)
>>> -				break;
>>>    			iter->bio = iter->bio->bi_next;
>>>    			iter->iter = iter->bio->bi_iter;
>> This can crash here if we come inside the loop because
>> iter->iter.bi_size is 0
>> and if this is the last bio i.e., iter->bio->bi_next is NULL?
> Nah, I changed the while loop condition to ensure bio->bi_next isn't
> NULL if the current bi_size is 0. But I don't recall why I moved the
> condition check to there in the first place either.

Yes, you moved it, but that is not going to guard when 
iter->iter.bi_size is 0.

while (true || immaterial) {
	..
	if (true) {
		iter->bio = NULL;
		iter->iter = iter->bio->bi_iter;  //crash here
	}
}

