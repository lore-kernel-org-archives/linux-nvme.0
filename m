Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AB3C77B7F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 00:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qKxUj3mSqe2ylrvojKPzYZcY3zgpPlBo94eym74T81o=; b=FQoo9x44RpsAkcezglQWpdSBGW
	+dpKvbwSNxGp4eU7B/PASTxjmoGnkE7z3fa6ZzDsqVPorXOl8RCKOBeVNtBCBaZtu/z23FxkL0RMx
	F6YmpX/vnHaum441Aj3v99B1f5vP26CsZyXPQBPjf1x/yVBcdbkGljnh6bxBNNjIfrp38itETRYIi
	67yjDAS1qcw/OKQA0B9Kf3WiPTKwQQApYW9ImtosACEjBhOOk9zgwh1HcxI0kNe5DKVdKWCCzl78I
	mggkkSkgm4fPmiqVsG3jQzpWNteZdrysPzaTd5oXLRbV/aZSEN7NBDkV8HRsJ88/33y81Wan+a+OW
	J8fsqCIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTrb1-00000004HQ3-1tGx;
	Tue, 24 Jun 2025 00:33:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTo2p-00000003wxN-481r
	for linux-nvme@bombadil.infradead.org;
	Mon, 23 Jun 2025 20:45:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=qKxUj3mSqe2ylrvojKPzYZcY3zgpPlBo94eym74T81o=; b=aE8df9CdEzwmZkDOLdi+H4GjIY
	ay2wlqzEmQB1G3fXGj4TwjHX4kJWu3JD0XC0AQtyWtWzOhOCsVyDTCr4PVIjum6WqZC4F0Ng6dMTo
	lylP3y2LTMecyqf1FLH5EyqymMXLviNX3SADRJptj8kZuWHK1URqZFmZ+pd9TM2MW+3UfJIA1Q4BY
	ASYtrc+QkjhflVa8g1di97WGFF2P3eg44LmrrqTGI49Mja8O7ZHjp1qlVGSe8dVEwEr+u/4MhCR8Y
	dkt/iNkYHfcwhynJVgPj7QMo5nTtVVlpB2eNA60AxT2uQfPF/NnuXBtUgABvliSRhXItfYsPaEI0j
	r69evLJQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTo2o-00000004Z4k-0bjY;
	Mon, 23 Jun 2025 20:45:34 +0000
Message-ID: <50e80a33-30cc-4231-87ad-c0fa392acf45@infradead.org>
Date: Mon, 23 Jun 2025 13:45:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvmet: Remove redundant assignment of error code in
 nvmet_ns_enable()
To: Alok Tiwari <alok.a.tiwari@oracle.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, nilay@linux.ibm.com, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
 <20250623064036.4187788-4-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250623064036.4187788-4-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/22/25 11:40 PM, Alok Tiwari wrote:
> removing the unnecessary ret = -EMFILE; assignment since it is
> immediately overwritten by the result of nvmet_bdev_ns_enable()
> The initial value(-EMFILE) is redundant because it has no effect
> on the code logic or outcome.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/nvme/target/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 175c5b6d4dd58..884286f90688a 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -581,8 +581,6 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>  	if (ns->enabled)
>  		goto out_unlock;
>  
> -	ret = -EMFILE;
> -
>  	ret = nvmet_bdev_ns_enable(ns);
>  	if (ret == -ENOTBLK)
>  		ret = nvmet_file_ns_enable(ns);

-- 
~Randy

