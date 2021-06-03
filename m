Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5B2C47082
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 07:17:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F266101C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 07:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F266101C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I4EHnlUYhl498X/C8ocfGMqqAK8YvJZNvlryoCZT7gY=; b=OKgwinCbeSg0nA
	6I67hTopcZqJOux6BeKNH8bTt+wkFqe8aiB/fjiVA3DZhPkW8w3U16Id+TOFDcCpu5LwrvDu+eMyO
	zX9TlGz6fRrSRW4LOLR29W/0rm7RueALhR/wR/aM6Q3C65ISJgWPh9GWd138kiHWgDkpBn8S1hPct
	8bNVdeWSkTA9iaXwQJ8KHnKBAB7u2IlcQcPkwjwX2LMehIoOXrIQZ93TSM4k5fh54JimWgR9q606B
	h7U6yE2Ze7nyIVYKct8X7LvUVqcFM+pPTyJFn8ySorPr4QI52qkqX1c20iSnDbNKAUEAoH3bqxavD
	ebWYTf2n4S7wCOhNvweA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lohbE-007SgZ-FH; Thu, 03 Jun 2021 07:17:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lohbB-007SfB-52
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 07:17:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7865B6736F; Thu,  3 Jun 2021 09:16:54 +0200 (CEST)
Date: Thu, 3 Jun 2021 09:16:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: verify MNAN value if ANA is enabled
Message-ID: <20210603071654.GA4536@lst.de>
References: <20210531103651.109426-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210531103651.109426-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_001701_363660_36B76944 
X-CRM114-Status: GOOD (  12.52  )
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

> @@ -2972,6 +2972,16 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	if (ret < 0)
>  		goto out_free;
>  
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (ctrl->ana_log_buf && (!ctrl->max_namespaces ||
> +				  ctrl->max_namespaces > le32_to_cpu(id->nn))) {
> +		dev_err(ctrl->device,
> +			"Invalid MNAN value %u\n", ctrl->max_namespaces);
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +#endif

Please move the check into nvme_mpath_init_identify, where we can avoid
the ifdef and the ana_log_buf check, which won't trigger for the first
initialization.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
