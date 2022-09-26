Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D3CC07E9D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m7+pn4X8U00ASpeRaDMsH/D+hAAvfLdhTETm9qg7Hik=; b=H+zu875RvKrevuVvft7zQRmo5i
	5HHQ8Nr24lo4NHPNo70ZkzuTJYmZ3p15z7ZjTGKmMQjNHKSvcntG+9QNzYaOl8U0Pnr+OJOD8yVeJ
	+ylKVIoCSvQn33McEkCGllrziRaBIrIjL1+YhzOJJbeksc2lxFCK+i1geqQx/jtpWgdc9hAOBcVei
	go1PYze21/BBu17KJoMbX3k7Vrkw9/BAAyIq2RYaNF9YVyK8NXPwkQqtW+LRSJt1URdqschj9wJBz
	OcSTwqS4t+zu8qpQjVxuIGmXNVAWFqLcu4Z++AAJFH96Em01Y2ieJbL6jict0kvwPM/4rl/UJQp9R
	nQrhSHXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpSo-005VXN-5Y; Mon, 26 Sep 2022 14:52:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpSk-005VVa-Q7
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 14:52:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 14ACD68AFE; Mon, 26 Sep 2022 16:52:00 +0200 (CEST)
Date: Mon, 26 Sep 2022 16:51:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v8 3/5] nvme: refactor nvme_alloc_user_request
Message-ID: <20220926145159.GB20424@lst.de>
References: <20220923092854.5116-1-joshi.k@samsung.com> <CGME20220923093916epcas5p387fdd905413f6d90babecf5d14da5b67@epcas5p3.samsung.com> <20220923092854.5116-4-joshi.k@samsung.com> <20220923153819.GC21275@lst.de> <20220925194354.GA29911@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925194354.GA29911@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_075203_010303_2A798349 
X-CRM114-Status: GOOD (  13.34  )
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

On Mon, Sep 26, 2022 at 01:13:54AM +0530, Kanchan Joshi wrote:
>>> +	if (ret)
>>> +		goto out;
>>> +	bio = req->bio;
>>
>> I think we can also do away with this bio local variable now.
>>
>>> +	if (bdev)
>>> +		bio_set_dev(bio, bdev);
>>
>> We don't need the bio_set_dev here as mentioned last time, so I think
>> we should remove it in a prep patch.
>
> we miss completing polled io with this change.
> bdev needs to be put in bio to complete polled passthrough IO.
> nvme_ns_chr_uring_cmd_iopoll uses bio_poll and that in turn makes use of
> this.

Oh, indeed - polling is another and someone unexpected user in
addition to the I/O accounting that does not apply to passthrough
requests.  That also means we can't poll admin commands at all.

