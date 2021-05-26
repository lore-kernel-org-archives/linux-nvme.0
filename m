Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EE2C47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 15:18:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7896101E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 15:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7896101E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L+Uq3oEfhF1rz8qkUDbT5P+CW3tphvVOOwtHD4Jm4O4=; b=hPBeY1U2wGo6nQ
	n/iSYNwHnwpL31a45ENthAtC7PnAUNiBMfe3R5Ss3ijCylaDzJ/33h3Q+3hSrOl37+BpxHoopEty3
	5W256gKA8OW1XMbT29H1EPTfhMyGsxX3/S2Valv9UcGClE/img5NLs56qcVGd0wFObYu1/59/NIel
	EYvNtStVi+psX2VvQY+Oc5LFDr6OyEs5HoMTzuzBSoE4DBjKu7zB5BzbRlVU9akZul6CvOeEYLmgm
	S8oaEXpjyUpAqi+O20YFwGxxiskf9CqR+eFISGasz+N0kbEqTIkp2brFqoCPsoSPqmrBeK3xJO7mK
	UbEkwncAZLu0ONgWgZbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llvIS-00FHsq-BF; Wed, 26 May 2021 15:18:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lluAW-00EhxR-7r
 for linux-nvme@bombadil.infradead.org; Wed, 26 May 2021 14:05:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=FmqoT8wZa/oa+waJrbyGvRdee1CacliglIUq77+qvos=; b=WTWwlnsyHFhvyhjnnFAQcmascQ
 e7dLNReAiNaDzRER09oNRxNJuVbojX4UYKeg5B/nBr+HM96GnXw31rmkOCundePA3XHAsk/wmGnFR
 5wKCYnZzp4ZEVdMnQaPJGzvUM/qtRA9cyQimKXBZ8aSRULQCeGbwXSh6F4F1W4ABZXIYLlYiFWOTw
 4Xu+YLshkrh1+u0gLKi2TU5eM3Kv/lpx2n4BFi1f8zUNtBWKmRn5JggztKteMTMFntfuhmTesZ5L0
 uZB2mtzsS5eFGIaTMLTYT/E9J84QrEaVLzFhJK2JSLX8YFGy/6i5joaqiAS/Ftd58s+3fUz3l2CGE
 k8BhaKMg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1llu9n-004aQZ-1s; Wed, 26 May 2021 14:05:20 +0000
Date: Wed, 26 May 2021 15:05:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: elad.grupi@dell.com
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix memory leak when having inflight commands
 on disconnect
Message-ID: <YK5Vl75vgpi2FsvZ@infradead.org>
References: <20210524112441.27400-1-elad.grupi@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210524112441.27400-1-elad.grupi@dell.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Mon, May 24, 2021 at 02:24:41PM +0300, elad.grupi@dell.com wrote:
>  }
>  
> +static void nvmet_tcp_free_resp_list(struct nvmet_tcp_queue *queue)
> +{
> +	struct list_head *p;
> +	struct nvmet_tcp_cmd *cmd;
> +	int c = 0;
> +
> +	nvmet_tcp_process_resp_list(queue);
> +
> +	list_for_each(p, &queue->resp_send_list) {
> +		cmd = list_entry(p, struct nvmet_tcp_cmd, entry);

Please use list_for_each_entry instead.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
