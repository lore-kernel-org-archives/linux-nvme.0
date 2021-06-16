Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A785DC48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 16:21:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7BD6115C
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 16:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7BD6115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nnuyh+biovEdsD4SyhyOFFuHct3lUzVkNZHdXMJSuVE=; b=3HQ9X1LjysbXFL
	WSycCwxOJPqLosBJW0jcXnXllf7bPhEygbVjqjm+G6BfCZZm1YuwDmXWpXo8ePVcsQef/df9TpvgG
	5cYIr4C9lXfT/JsC56qtrF1cGBgfgozFFS0Ts1M35i4/No9xgzeWQnmqw+hOVJ4YFYgT0pJp1wrPq
	6GxJ4Rt2rRh773enESJFyzg0nkJsLuIb8Pk3zGaMjxP+0iKWPQDKp3ZLveUMJ9xbnV5twTbukKPQ4
	GeECC/mfvvBqi8T7kiOUO7vIXolKvCmpXX1OvqbsbkZfWqEfNP20EjesaMMQlCDvrMb52vld7oZJw
	nv959KOPuNL8srkIKxIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltYHl-00773Y-TR; Wed, 16 Jun 2021 16:21:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltYHi-00773H-W3
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 16:21:00 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5F7E61159;
 Wed, 16 Jun 2021 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623860458;
 bh=TUi3AGy4c9pZM9xCp7urAs/B5ayKSelanerCLeFiPrk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uPv/3nW40kGqX3VnayNJhtiD6X6YzDFxkVz76otVbhfxJjwPz8jxb/iCcqhaj1m+l
 WKX/V83nDlhacGmoI4NM8s6nApmnS1iO4s8A/98UetXN+yjtkzWiw8t1vz2deAWFk0
 qjrx7N8yCcZycW036DMZUh26mb2tuc6IAJ0RlOjWxfXDasmoMC4hsIhMC6m3AZzI12
 h8jbWi4qfq7AHPsEpl28hiWxFE29hysxAsxrM2ikeZyTG3piqdWZ2QgQQRVyWz2ySZ
 Fb6MU75lHeJnj73wsxMmt/tAWkr/goFSP9zpj6ndEsll1TJLi96JwF93TI9opF3UTh
 /IeUI9p0kXaNg==
Date: Wed, 16 Jun 2021 09:20:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-nvme@lists.infradead.org, yzhong@purestorage.com,
 ashishk@purestorage.com
Subject: Re: [PATCH] nvme-pci: Fix multiple races in nvme_setup_io_queues()
Message-ID: <20210616162056.GA906592@dhcp-10-100-145-180.wdc.com>
References: <20210615215741.26844-1-cachen@purestorage.com>
 <20210615215741.26844-2-cachen@purestorage.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210615215741.26844-2-cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_092059_089317_E828A081 
X-CRM114-Status: UNSURE (   9.18  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 15, 2021 at 02:57:41PM -0700, Casey Chen wrote:
> @@ -1590,8 +1590,9 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
>  		goto release_cq;
>  
>  	nvmeq->cq_vector = vector;
> -	nvme_init_queue(nvmeq, qid);
>  
> +	mutex_lock(&dev->shutdown_lock);

I really think you want to use mutex_trylock() here and return early if
locking fails since that must mean the device is being disabled.
Waiting to acquire the lock in this path doesn't do any good on a
disabled device.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
