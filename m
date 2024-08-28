Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2727EC636E0
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Aug 2024 16:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bqc44ABQg6ruaDWPYgMyOlBqJ7wwPaJPKM6xG5VakJw=; b=byseSs6R8AkXGKiQA/pYrZwm1F
	nTmvUegU5lMy6lmICWLPbMoUPNSogBhp0bgNg3iPpMueFw7zvmPciTtiyCT58O4X1sxeC+xBkdp9e
	c90kRO1VixJ0T1lzte/M9q/lZBJ3EVl7PhYwEGkCgyoriGw72fd9+lCd7r3BX4Ln36/z70pqhqmCv
	689ScoFsOcUIFb0YsUfA/5Nn5VLgqOnHjfFe32obf54MgL96fJRbmoRLstuTPAtD8MDGflgndswTC
	Wa5qPfgLAV7ZOQGT8/durBkM2n1Xu3CNCCUYpGCpjDHe5SWtdL/PA73cpUoOyygiw0ktivE0kRpD3
	KZ1FbkJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjLnm-0000000GEzk-3Y9S;
	Wed, 28 Aug 2024 16:45:46 +0000
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjKdf-0000000FzLD-47Sg
	for linux-nvme@lists.infradead.org;
	Wed, 28 Aug 2024 15:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724859076; x=1756395076;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=bqc44ABQg6ruaDWPYgMyOlBqJ7wwPaJPKM6xG5VakJw=;
  b=VEAumESNcHjt0pvzJ2SYE33qk6FZTl6DP5iYXVyS2VgEt0nnB3yKaacd
   oSIbHPQPKgqkwv+fjf4368RWmoabkUZWkVem7/548ngHIBfkSvg+sKWsw
   VdWKn9qzWHh1UC5vZ67Ix3vWfY4G/dSWDLdOyMd1c3Ckxqw1HqVi/UI7w
   M=;
X-IronPort-AV: E=Sophos;i="6.10,183,1719878400"; 
   d="scan'208";a="676735071"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:31:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:6576]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.150:2525] with esmtp (Farcaster)
 id 4ed1dc69-1286-4d0a-b0b9-c846a8cc70ec; Wed, 28 Aug 2024 15:31:11 +0000 (UTC)
X-Farcaster-Flow-ID: 4ed1dc69-1286-4d0a-b0b9-c846a8cc70ec
Received: from EX19EXOUWA001.ant.amazon.com (10.250.64.209) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 28 Aug 2024 15:31:11 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.218) by
 EX19EXOUWA001.ant.amazon.com (10.250.64.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 28 Aug 2024 15:31:10 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Wed, 28 Aug 2024 15:31:10 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id B435F20841; Wed, 28 Aug 2024 15:31:09 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <puranjay@kernel.org>
Subject: Re: [PATCH v2] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
In-Reply-To: <Zs8360kRPGa1B5xy@kbusch-mbp>
References: <20240827132327.1704-1-pjy@amazon.com>
 <Zs8360kRPGa1B5xy@kbusch-mbp>
Date: Wed, 28 Aug 2024 15:31:09 +0000
Message-ID: <mb61p1q28y88y.fsf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_083116_332736_45A6C9BA 
X-CRM114-Status: GOOD (  15.02  )
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

Keith Busch <kbusch@kernel.org> writes:

> On Tue, Aug 27, 2024 at 01:23:27PM +0000, Puranjay Mohan wrote:
>> @@ -119,9 +120,13 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
>>  	struct request_queue *q = req->q;
>>  	struct nvme_ns *ns = q->queuedata;
>>  	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
>> +	bool has_metadata = bdev && meta_buffer && meta_len;
>
> If this is an admin command, then bdev is NULL, so "has_metadata" is
> false.
>
>>  	struct bio *bio = NULL;
>>  	int ret;
>>  
>> +	if (has_metadata && !blk_get_integrity(bdev->bd_disk))
>> +		return -EINVAL;
>> +
>
> Since has_metadata is false, we continue on to process this admin
> command, but ignore the user's metadata settings. Do we want to return
> error there too?

As an admin command with metadata is an invalid configuration, we can
ignore the metada and go ahead with the admin command or I can add the
following after the above check:

	if (!bdev && (meta_buffer || meta_len))
    	return -EINVAL;

I don't know what is the best approach here.

Thanks,
Puranjay

