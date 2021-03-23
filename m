Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D999C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 16:24:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7AE561477
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 16:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AE561477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1P+c3sgYWirwntnDhXf0h7Wehv/RZGdE7BiZ0AxLALM=; b=ALKDa9MMFrSa8qnYHsh0DYgpO
	ZIWPmcbTVVEGcOm7s5x6GBCY1SWdqf7gvinICEkkb7/GbDZDhg9glw/qs8KPijzvA8bCnWbB2g62Y
	OlPdKNYIrj7ejuzYB8pW0OKLjAXMrEz/7FLICrpqpUEgHbJyDSXJ6VDFwZQ0CXOoOIHXuz4MY5VOe
	MO0jAh/tZ2WQACyaPxlN9WYydCcNSTK0zTSRSR9DcB/CElDTCwuWKjke9Sn/dQp02F39j3d2yR4wP
	bFN3ATYNMyiG3Gp5HLHmbhurGR4Q/ePbL+mEqE0As4h2eEtwiYdb3IDz4s2P780pJjygKH4s7p8we
	RmUoCL7lg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOjpJ-00FJLv-8D; Tue, 23 Mar 2021 16:24:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOjpG-00FJLI-BY
 for linux-nvme@desiato.infradead.org; Tue, 23 Mar 2021 16:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=31JwxxJE8z9YVDK0kLLWKu7TtX9toDfV99qQyfOCmqU=; b=icvcOrhBn9tVtQIxL4rKPNpbEL
 1jq/7kbDQWzuvbW62aNcpUbR4jx+YyY/9UaCHJw46XnUsDwlYLOMHZl0TTeOMb+TcS94fgd4uIdK5
 iwbXRQvXKmb5NTmmy/zQy6k2q4KEkCXV5NjL9owQn7Q+B81Jdz/8glxAb3nfHUKM+DHkyV4plerKB
 OIBoc+6mf7g5HhWxKKUvR10yPi2uXb2uZbLZU+8G6WqRiD1yDb5YFrTxzHgKLeuHhuKvmxsem1Q6E
 +kmefeD2BEKVVEG4byFaUQ+cF5nbiFzUL2Ko69JcVa9uP3+/yZRO9YsrtyaWv1hQIvsFCUHo2zu/2
 M3ch2Rdg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lOjoP-00AGw1-MQ; Tue, 23 Mar 2021 16:23:46 +0000
Date: Tue, 23 Mar 2021 16:23:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: pngliu@hotmail.com
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org,
 Peng Liu <liupeng17@lenovo.com>
Subject: Re: [PATCH] nvme: fix APST error for power latency tolerance
Message-ID: <20210323162321.GA2446196@infradead.org>
References: <OSYP286MB0181647E6B1C99AF64C0803DC6649@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OSYP286MB0181647E6B1C99AF64C0803DC6649@OSYP286MB0181.JPNP286.PROD.OUTLOOK.COM>
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

On Tue, Mar 23, 2021 at 03:31:33PM +0800, pngliu@hotmail.com wrote:
> From: Peng Liu <liupeng17@lenovo.com>
> 
> Clear apsta so that nvme_configure_apst() does not execute
> nvme_set_features(), which will fail because admin_q is either not set up
> yet or no longer available at the time of nvme_uninit_ctrl() being called,
> and this leads to the error message "nvme nvme0: failed to set APST feature
> (-19)".
> 
> Fixes: 510a405d945b("nvme: fix memory leak for power latency tolerance")

How did you get into this situation?  For PCIe nvme_uninit_ctrl is
only called at the end of ->remove and ->delete_ctrl, so how do we end
up in nvme_configure_apst after that?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
