Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1B4C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 15:07:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C96C20671
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 15:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BBkc5LOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C96C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7TEF69AnDiucrgeivxGkPbvvIc6hF3h57R62kAXEtQc=; b=BBkc5LOuYA0BIF
	pQVXYZ9Zjmp7S1Kb7/SSEOqBXaoJfBCTOPCd4QnT/8lD619yy4LJGK60ngtHT3JvuHjDgT5n48g4K
	ESEIadDsJwNbYCzY77GDy+RfrBYxWzMGuDn2VeY34+CQQaLdFSra6cE1BBEZVIni6rrul3Z6xjRbZ
	WASCJcMTQCFd7C+lif92k1SnADhGSMVnduIGs4KmplU76ClzwTBN54jvgkpJdd1uu4/zgF+zoqgBR
	qns6VD5Jn5U3hpWmqKNQY+PtRX1CHsg37HGH5joU0Ourjs/SOwnBEVMLxdPyJQ7hvvEGD7Cw54GTC
	ObaxgE/h2G9jMSWFRS8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jahMq-0000iu-B5; Mon, 18 May 2020 15:07:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jahMo-0000iZ-9X
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 15:07:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D80E368B02; Mon, 18 May 2020 17:07:43 +0200 (CEST)
Date: Mon, 18 May 2020 17:07:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet-tcp: move send/recv error handling in the
 send/recv methods instead of call-sites
Message-ID: <20200518150743.GC8871@lst.de>
References: <20200517111522.6105-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200517111522.6105-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_080746_478984_EE4A31AD 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, May 17, 2020 at 04:15:22AM -0700, Sagi Grimberg wrote:
> Have routines handle errors and just bail out of the poll loop. This simplifies
> the code and will help as we may enhance the poll loop logic and these are somewhat
> in the way.

Way too long lines in the commit message.

> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index f8dd69f3b657..9527cdc19611 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -723,6 +723,13 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
>  		(*sends)++;
>  	}
>  
> +	if (ret < 0) {
> +		if (ret == -EPIPE || ret == -ECONNRESET)
> +			kernel_sock_shutdown(queue->sock, SHUT_RDWR);
> +		else
> +			nvmet_tcp_fatal_error(queue);
> +	}

Not really important, but how about a nvmet_tcp_handle_error helper
to consolidate this duplicated code snipplet?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
