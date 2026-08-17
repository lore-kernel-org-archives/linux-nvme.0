Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2107DC5DF70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pdTEYko51VQQEc0CA2y6v8Lzo2U3dvqtdyhyjdZdCxg=; b=aKTGydQPsv1TK+PlfFykzsdL4R
	rXgD7A7Kfv1DNAI2eCa5xzmoquezSwuIk6fnvaA4EdCXz/ymlFSunRoNfHCjTiAbZN6hQoSgpBzQ+
	jldmDxjHmxadKxT2z+Ur6TP18lt4qktV3DdmQu/xUlzdlaw6OBgZBAxbeIPVjAMQqheEpA4OHmDa0
	WrU51vn3AWnvR/FgqHevBxQG+WgvYZfJjvls3dkEE4djZRz0dO2dplc7zBvbE/xlgNySLAEAHGiKb
	oSWDJGC1JoXTad18PgTopN1m2gfi/JHCnIfwPqUgCMLeX0CYSA3D2Z071vI8O417xTmmYwMJtbOcD
	PBkC9UEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvtYV-00000005nnC-2La5;
	Mon, 17 Aug 2026 09:22:55 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvtYS-00000005nmP-2UbR
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 09:22:54 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260817092246epoutp01b66e99dfca94d4f9a97cbb9d2785dae2~MjVkiimXW0441404414epoutp01J
	for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2026 09:22:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260817092246epoutp01b66e99dfca94d4f9a97cbb9d2785dae2~MjVkiimXW0441404414epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786958566;
	bh=pdTEYko51VQQEc0CA2y6v8Lzo2U3dvqtdyhyjdZdCxg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=t2XNdVvm+p2W2t3moYwp49n1uXzN0o0hQUVBVkQJ1nqJihcX231ZbVz5TW+yDh6ah
	 2wD0JZraorzDSyXccSBMh0w6yUytyeKqmS8RwCqYgBM1w5TOrX8whFhJDwqf0LGRgZ
	 1YN4jQxo4D1Kj+T0KQbQM3eGcToSEyulHNZn70NA=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260817092245epcas5p3626f7e70a301e2b90474d3ec0a26c016~MjVkXRjTl1485514855epcas5p3q;
	Mon, 17 Aug 2026 09:22:45 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4hNnRm6vL3z3hhT3; Mon, 17 Aug
	2026 09:22:44 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260817092244epcas5p2cf409524b9aa8a76845787348f5e3cf8~MjVjDGHmk2014220142epcas5p2t;
	Mon, 17 Aug 2026 09:22:44 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260817092243epsmtip2e48b64edd3932cd4fd19587749a0a543~MjViOtzQo3069130691epsmtip2f;
	Mon, 17 Aug 2026 09:22:43 +0000 (GMT)
Message-ID: <e8dff6d2-8e2c-4ccf-b8c6-671a1b9e7f09@samsung.com>
Date: Mon, 17 Aug 2026 14:52:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix racy access to FDP placement id array
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, harimishal1@gmail.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260817082303.GA22747@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260817092244epcas5p2cf409524b9aa8a76845787348f5e3cf8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260817071233epcas5p19cd2497118e33c212af714ad84b06ac8
References: <CGME20260817071233epcas5p19cd2497118e33c212af714ad84b06ac8@epcas5p1.samsung.com>
	<20260817071158.2794-1-joshi.k@samsung.com> <20260817082303.GA22747@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_022253_132949_6B183140 
X-CRM114-Status: GOOD (  13.15  )
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

On 8/17/2026 1:53 PM, Christoph Hellwig wrote:
>> +	if (ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
>> +		ns->head = head;
>> +		ret = nvme_query_fdp_info(ns, info);
>> +		if (ret < 0)
>> +			goto out_clear_ns_head;
>> +	}
> The conditional assignment of ns->head here is weird.  Just pass it
> explicitly to nvme_query_fdp_info so that you don't have this issue.

ns->head is required even beyond nvme_query_fdp_info().

nvme_query_fdp_info(..)
-> nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
  -> __nvme_submit_sync_cmd(...);
   -> nvme_init_request();

Which is going to touch ns->head here:
          if (req->q->queuedata) {
                  struct nvme_ns *ns = req->q->disk->private_data;

                  logging_enabled = ns->head->passthru_err_log_enabled;
	}

