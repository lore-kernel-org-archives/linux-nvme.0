Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB8C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:43:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50886613DF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50886613DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=jZksWE8rQTq+ZRnSm0b6r0vwf
	ngzItdyI8Plqys8yBMEc4t1rg8lRbcFHh+CCJzZU/MQ7SUiRDP8vLgTP0BmaBIn8lpL2LOmdGTjLB
	OfNNe4hhVYsMwCUgjc8E5bSlOir+fhugPkBlgavmpGrBwg/yHt2Hxso+LwHWYmRsqp4O1O8pUXpUC
	ZrSO9dTSJ1gznUSYeuVkbRWyGkbk3kKJXDpOXAib7mKZeGAIAMX/fuXEW7Bz9oGPrR/JyVL0xV5WR
	T2dOR6hfkzcUsiRGXFhvYYksNynS8mekfEB6NBrBSBuZQIanGy9fAvDSOnfVqI95Qh3MoQ9MOHsGq
	UEyqZmx5Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgwcy-0045cO-Hq; Wed, 12 May 2021 21:42:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwcw-0045cB-Rl
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 21:42:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=UA1l1GxooY30VU74XPc/YTEjBn
 6ShcM0xKVQ2k7oqIvDTYjHh8XCF31imXxpySMNeqLQ0jtI8C5hwZHAqVcQxYfreZpsNMu+OJMhdQE
 0dVuGwUwGgoifdmHmGmAcnc819Bi0TsYHelIcezmFn8PcjqfJBv16tYTFf4A5giZGCNdPn3PAYrHO
 tXaqglz6Dz5l30jzeopBK+CThOpnzg4DVB6I47YwuEr59ObrYKwbdKdZ/CjHBvToDxy07Eh9QNT7b
 unijVeyubzBBPODdI5yQLCppp72XZkJaENEk3gXslyq5eQ3ZvqWzzjTGyj4LLe3Wr67swCFmRJ0wo
 5I212trw==;
Received: from mail-qv1-f44.google.com ([209.85.219.44])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwcu-00AqV8-3e
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 21:42:45 +0000
Received: by mail-qv1-f44.google.com with SMTP id w9so12867502qvi.13
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 14:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=C+cT+FRgCoJXZ1fOa3k5D/OtW36mtUuvd0MJa4BrI8et/lavAFkRrubKOkU24Z1tjs
 ddKysopA5IZ5U6qi1MYWmKenREFpQ6g+RwFT+/iWixcyJ2ujD0evu8IE8rLcOL4J42oa
 4ga/dmvErSiUhznFUIg7bGrKnpozqWb3/5g4u/Tc5ili3OAxCtG/qSUmGAX/UuNjzYFw
 YlQ41iGKJ7e99GnMwGNa9EhD46rmWtrEpRiZzQcL+j6j7QvAutIWNOJXy2qyw+UCKQ5h
 Qb1GRvESe9ugOv1nibO/PFjEIDdigCm4v6+26kIUp0d4oMkIO+eY9Ocx2yHf1FbDqw/L
 ylPQ==
X-Gm-Message-State: AOAM5330cH1zWAfBtp3EJuip/6ZbTnUPuP6ylzRJ/lWAyc8PvIm9ovuI
 dLzeRDlVOMrCx90DEF8NrdqdnqnlgxU=
X-Google-Smtp-Source: ABdhPJyQfuitcMrAy159D1EWSmAvwixoWGUhMcEbMkPwnZu1KEiGdYKWQ1QjgHqpg1FJYlvEW8gmvw==
X-Received: by 2002:a0c:a909:: with SMTP id y9mr37501332qva.20.1620855761936; 
 Wed, 12 May 2021 14:42:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id d21sm877778qtp.74.2021.05.12.14.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 14:42:41 -0700 (PDT)
Subject: Re: [PATCH 06/15] blk-mq: remove blk_qc_t_to_tag and
 blk_qc_t_is_internal
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-7-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9f8a7bf6-366f-bcb2-f5d0-fb9bbf6678d7@grimberg.me>
Date: Wed, 12 May 2021 14:42:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-7-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_144244_157253_62FA983A 
X-CRM114-Status: UNSURE (   9.11  )
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
