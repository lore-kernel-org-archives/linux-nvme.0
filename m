Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507F3C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 18:39:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E76A2222A
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 18:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E76A2222A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=udmCOAKKBOx8mW++zjIWPn/B5fjeSH9p+RhdldOdL7E=; b=qn8WqmDjE2NWu7d5oLApYn6DD
	+/EtgpqItC+R78znfhL4aJwllXLkokZX029P9zZRxxYd9rT7ndrFH/oJth/I03ycGfj1g0LUWfmlP
	+Bd4k7Y511134SzM8KY19l16Y8M1wzrcm9Rx8H8pBpTcaHEy3P29FvOyvO6lTcwkBTNaGqYKAzYXz
	2GRtpsQ+A6dAJhvcFvYoLeO1tcVJvDYizy00guKBT0QArqisVu9AzD9zQ1zAaNy/+UvQL+1PtY6k2
	MpqNQeicFpbtZl3O1W0kB9WbegYk0dj99tizDxesQZ8f+ezEi4qUd2DKAcUudG4QMRiK0RPC6mzoa
	v/XmChYcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzOZa-0003p1-4A; Tue, 12 Jan 2021 18:39:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzOZW-0003nu-CZ
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 18:39:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4244F67373; Tue, 12 Jan 2021 19:39:11 +0100 (CET)
Date: Tue, 12 Jan 2021 19:39:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: Re: [PATCH v2] nvme: Check the PRINFO bit and the Metadata size
 before deciding the host buffer length
Message-ID: <20210112183911.GB5050@lst.de>
References: <20210112172941.3911-1-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112172941.3911-1-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_133914_557924_3467312B 
X-CRM114-Status: GOOD (  10.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>,
 Jonathan Derrick <jonathan.derrick@intel.com>, hch@lst.de,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> @@ -1546,6 +1546,11 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
>  	meta_len = (io.nblocks + 1) * ns->ms;
>  	metadata = nvme_to_user_ptr(io.metadata);
> 
> +	if (io.control & NVME_RW_PRINFO_PRACT && ns->ms == 8) {
> +		meta_len = 0;
> +		metadata = NULL;
> +	}
> +

Wouldn't something like:

	if ((io.control & NVME_RW_PRINFO_PRACT) &&
	    ns->ms == sizeof(struct t10_pi_tuple)) {
		/*
		 * Protection information is stripped/inserted by the
		 * controller.
		 */
		if (nvme_to_user_ptr(io.metadata))
			return -EINVAL;
		meta_len = 0;
		metadata = NULL;
	} else {
	 	meta_len = (io.nblocks + 1) * ns->ms;
		metadata = nvme_to_user_ptr(io.metadata);
	}

make a little more sense?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
