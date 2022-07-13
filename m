Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2C9C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zNHOdE7IAuqrwMD2kNc6pCTNu/+Di/LHrG/e6tSV7sE=; b=JR0TA6iMgpirrFRqJiMOKZco99
	1e1M73AY2n/DZKOxvd8Td09s/YuCFtkQwpCJfYuWhgHIIAAgKFTxdOPN76mTPb4183SajY7NNHuOG
	OLBHiRiXzpoh4B9SXlL9Pkur0WvRbA5vEinK8G8YPHVfotE+8jQmuEnUqAZAsXhOxAiHdQNeF1rAV
	cQ+Xrj/Ps2PQV/SwKje9RMLNJLBKpwIZMgLUv9sCLgeDt44qRmA3rvhL2SHF6KDCu4s8CfoVe0b13
	croVTdWEg1ViTD/xBY7xf7iqJgk/ZQIu0I1OCvlkEcoa1VRmaI90S70jMKKYWQKXXWAQYpM6mGUJI
	AeC2UPig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBaWZ-0037eW-KM; Wed, 13 Jul 2022 11:27:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBaWV-0037am-Qs
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 11:27:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C89B767373; Wed, 13 Jul 2022 13:27:12 +0200 (CEST)
Date: Wed, 13 Jul 2022 13:27:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, k.jensen@samsung.com
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Message-ID: <20220713112712.GA702@lst.de>
References: <20220713054914.1888305-1-hch@lst.de> <CGME20220713054931epcas5p1293ad393b3977d9e289c413c96984fe5@epcas5p1.samsung.com> <20220713054914.1888305-4-hch@lst.de> <20220713101700.GA16726@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713101700.GA16726@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_042720_055996_423C882E 
X-CRM114-Status: GOOD (  13.75  )
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

On Wed, Jul 13, 2022 at 03:47:00PM +0530, Kanchan Joshi wrote:
>> -	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) &&
>> -	    !nvme_identify_ns_cs_indep(ctrl, nsid, &id)) {
>> -		ready = id->nstat & NVME_NSTAT_NRDY;
>> -		kfree(id);
>> +	if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
>> +		if (nvme_ns_info_from_id_cs_indep(ctrl, &info))
>> +			return;
>
> Is this return fine if independent id-ns fails? Earlier behavior was to
> ingore such failure.

Good point.  If NVME_CAP_CRMS_CRIMS is supported we really need to
support this log page, and later on for the unknown command sets
we need as well.  So I don't think we can do without it here, but
maybe that is worth mentioning in the commit log

