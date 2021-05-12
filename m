Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C59C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:57:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FF4613BD
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FF4613BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=eghlyRZ1PYDhdVimkGMtdYRzU
	BvVxxbS+ZglDdAfBsGuSSfENZPsM51ysYnTnV8LKGtGVs9Tni82yYwPpkmXkWxBpYMc79Ud1uA8aT
	XG3B03hA5lFHYrQG65UoutWS8kK50xxEHad7QbGxji/rNq1QILi8fDQB/IXX5stsrinKpdscUo2k1
	kgA88IHprFGRSDwu8OwtNQSluzUxEX7x6NphorwSXMX4X9rpt25sZ7cfeM5mR2a3xVddmD2Ughc4f
	PZ6chv6DPraD3d34NH/uqY4nPkynJQ2V6b9OlKxzbjZkwfn/+RFvJR16XlGQ6jpb8bXZ9KHi4ReOQ
	vlgujZgUg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgwqP-0046yB-5F; Wed, 12 May 2021 21:56:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwqM-0046xz-Hl
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 21:56:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=0MMqB2om3ldZXGbc6xq6pETjpB
 VsBk4q+EDIQVYaRY7I9oC8nFP53bZSF4P66UYYWFMWQLUk4rjZXpTwmhGsp6FJVGAl2wOs4qT62zB
 1/mvMcxiOuRDKiUByPcL5nTZR2sFFARCjxl844vd9CP697jzAtwzaQ+T9/oEOdYQUWx1WbdFC9GMy
 pnkaOma6ZLAvkzZHPipzj1DJt/Dvf+h128XKu05CjAuIep/zKpQW957bgtmLRF6Ae8GjFQ2UBlxmt
 Ijcb7t9y0w9QNQDBFcQupKmIHPcyBoWojG8wiiOz6R4ZzX4ZrMJ30vNyiwsjiFGljryC39bfcM6Fq
 G74LNNPw==;
Received: from mail-qt1-f181.google.com ([209.85.160.181])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwqK-00Aqzg-8B
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 21:56:37 +0000
Received: by mail-qt1-f181.google.com with SMTP id t7so18447675qtn.3
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 14:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=oZW7Im6WSPQP2CY+1omuXrT/ycQm2PkizGz2MEUY5cj51an2d3UVvghaGbiFrSKR83
 RhbjWyLy1n06ioir6jITsU+HWkpkjtFU8IUkUT4NuJwstRPGs5bYUwfG0topYJopwZtU
 W8MfAFxb9oBDC8YKCoU9WYQfGTyGE2oG6bDpeeh1gIlWsguxUIlp6ZP1PvNedVTvunJC
 q5Hl9iY48JMbUY3t5zAghd31ola00RRikWRo7F2HrJxSWPOuqT9Bh0jGpDkhHC8Limt/
 id079+WGwyMIsZqbtIIa35uQ2QZ3hb82aHh2fWzpZP19sRsQuwpSQ9Ynqn8vulN5TVwT
 oszQ==
X-Gm-Message-State: AOAM531ytPp+zPNqgYtmJxtknR9EAwukJTM6rd2AIzo3dicdM7NFxUFq
 9+v8kOMXvrmAMumtEAlSJaxQNBcX/f4=
X-Google-Smtp-Source: ABdhPJwYPpqcLmh1APgGWbVUiV8sQc+3QfAra0qNQgr2jBSjvP1PggUkq5ZH6t3A+NBeDVWpyNSa6Q==
X-Received: by 2002:ac8:5850:: with SMTP id h16mr23621157qth.355.1620856594575; 
 Wed, 12 May 2021 14:56:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id v11sm854434qtx.79.2021.05.12.14.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 14:56:34 -0700 (PDT)
Subject: Re: [PATCH 09/15] block: rename REQ_HIPRI to REQ_POLLED
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-10-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c687ee05-da4d-5f61-32ea-7a7292c3cf01@grimberg.me>
Date: Wed, 12 May 2021 14:56:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-10-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_145636_299744_08C8D859 
X-CRM114-Status: UNSURE (   9.07  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
