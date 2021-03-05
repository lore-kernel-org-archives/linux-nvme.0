Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D89C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 19:58:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391516509A
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 19:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391516509A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rCZQmDsmougm5TJOK1TllSZKnGzetqM5LL1zlTpH4nc=; b=YI+ialJC8EIqd6IFeUQHUB6zH
	Z6J4fe4X//ULXCqAfQcO1eLYTko15cG9h/RHgcTAAQ6uWK4FgEvYD+qiaFSBcI9WUaGylD6I21GL2
	+r6eCkvn4Avs+MSSNRdYpxXvka8E+D4+YOw0BmMtAbwE6oKXvRtHrLdMRcXSPZPpfDQ+HveuaIL+W
	GZg7eG9XlyHqqNMw4uPbfxPd8WBmcLbwUfbqGxqkf9Or5I7jZXMwBoPH4nbX6h45KwLZsWh34Phhh
	fA0qm3I03Snu6VWzplETC751nEfMfku43ep0yuf2EUOxRxO9fzFZ8VyVbvwW5UWCycdVRl2Igbw5p
	7AaQEVRkw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIGZv-00GGJB-O1; Fri, 05 Mar 2021 19:57:39 +0000
Received: from mail-oi1-f181.google.com ([209.85.167.181])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIGZq-00GGHd-HC
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 19:57:36 +0000
Received: by mail-oi1-f181.google.com with SMTP id z126so3793681oiz.6
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 11:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BvXqs9Un/8ft9bW8S9EkC2iye0k2IA9jrybCCvql2JM=;
 b=MbhShp7nux8JnnFgGqOEbyJm6/vOz+/g1FN5KMnMd6omfSqPyh10NAcT5otrPWf3IH
 y4NSQVVTifXwc4DFZrtp9kK8jwiH1wGDFycA7aVBR5MuhwhFxhA+lPTbOojzTtIiwXa5
 OxPKbHfYsxff/xTPu464h3AfPpBaq80tfxUUIOVaKl4ASSLOb9+0Zr0to6ldubqeDsmc
 ulEnZitN42uEAjv6iqjIntoYwPDxdzt/CjnN16iBsv0go0Sfwe+igBL6icCKkux1SyaS
 MK0/JM/oJKfcCqamKSyAywvX2kdBkk5dV1TL4RdtdD743kNHnTqJKsm/h5UkEazHkgAz
 l0iQ==
X-Gm-Message-State: AOAM53341gI30FYXEJfk6IMoRYfB/TQWEv/hGTzgEQfRDxUckT0yhCYG
 L816HJvPOYpZouj5zdQdcLY=
X-Google-Smtp-Source: ABdhPJyMwiXWbnwj6dGmjaoVUfexvraw+iQRPvDtahzZeQqf+s6eyaKCXxXZlYIep1wBZjvTiqxrEw==
X-Received: by 2002:aca:d708:: with SMTP id o8mr8354457oig.12.1614974252695;
 Fri, 05 Mar 2021 11:57:32 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id w15sm783647otp.29.2021.03.05.11.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 11:57:32 -0800 (PST)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
Date: Fri, 5 Mar 2021 11:57:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301175601.116405-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_195734_859990_58416721 
X-CRM114-Status: GOOD (  21.60  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> blk_mq_tag_to_rq() always returns a request if the tag id is in a
> valid range [0...max_tags). If the target replies with a tag for which
> we don't have a request but it's not started, the host will likely
> corrupt data or simply crash.
> 
> Add an additional check if the a request has been started if not
> reset the connection.
> 
> This addition check will not protected against an invalid tag which
> maps to a request which has been started. There is nothing we can do
> about this. Though it will at a least protect from crashing the host,
> which generally thought to be the right thing to do.

Daniel, again, there is nothing specific about this to nvme-tcp,
this is a safeguard against a funky controller (or a different
bug that is hidden by this). The same can happen in any other
transport so I would suggest that if this is a safeguard we
want to put in place, we should make it a generic one.

i.e. nvme_tag_to_rq() that _all_ transports call consistently.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
