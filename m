Return-Path: <SRS0=fYEw=LL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8947C2B9F4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 13:48:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA6D60BD3
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 13:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA6D60BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iQRN+bafeF8zURW2GR8X0RMrO14loq1shartgJlVe9w=; b=TmcqDMxe67eLIe
	vc7tRqp7wDQIqD3sHHLBNau7HNbYLaydbh7oo4GonX0gpmm3Kz65ILSxorr/LOnFo0HTamFxJ36Dh
	kdQamZwGhGGZH3bHP1bKNjfftgKXVOIQfpBTIccWWTtucVwVGjc+1u3Sf5jXbhbEGv9K6qyVcAeCD
	D4wZkmIddpq2Tff7Xs27wKLjEebJz1D5ImhFz6B+jBxkCy0Z6YwmAjXTkB01OVWmyzq4PjmphOrcj
	KJXK9H3Ugbvr0XuYoYtsLF8CzvziL3DOYRRO5oPMwHROrWY25Lp/7ur7cyodb+8j6JcXlFhgKlFl2
	MGlKk1GZqmVJxnmGOuIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltsNg-00AYsh-UK; Thu, 17 Jun 2021 13:48:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltsNe-00AYs1-71
 for linux-nvme@lists.infradead.org; Thu, 17 Jun 2021 13:48:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CFCD168C4E; Thu, 17 Jun 2021 15:48:22 +0200 (CEST)
Date: Thu, 17 Jun 2021 15:48:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 1/4] params: lift param_set_uint_minmax to common code
Message-ID: <20210617134822.GA27880@lst.de>
References: <20210616211936.451128-1-sagi@grimberg.me>
 <20210616211936.451128-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210616211936.451128-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210617_064826_463620_E66881CC 
X-CRM114-Status: GOOD (  10.46  )
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

This needs a Cc to linux-kernel..

> @@ -432,6 +432,9 @@ extern const struct kernel_param_ops param_ops_uint;
>  extern int param_set_uint(const char *val, const struct kernel_param *kp);
>  extern int param_get_uint(char *buffer, const struct kernel_param *kp);
>  #define param_check_uint(name, p) __param_check(name, p, unsigned int)
> +int param_set_uint_minmax(const char *val,
> +			  const struct kernel_param *kp,
> +			  unsigned int min, unsigned int max);

Super minor nitpick, but for consistency I'd move it above the
param_check_uint definition/

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
