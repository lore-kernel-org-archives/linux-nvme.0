Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214D9C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:43:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4BA613C1
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4BA613C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=Ornwe5JZJb/KuSiVUZucj9vx6
	X6KInb4eXFsLvDkr1JG1CKzzeactCRsYuwYZcsZDs3E260oa/id6B1L0vbH5lrPWSg1NJxtQ0AC9I
	hqLJHWm+e8H8XW+4svOjCDKHnEoX3Dr5QUW3buN67lWNLRZxsDZuAnZH0dhBXs3Ed77L/sPZI4ZWL
	6MGIHLWSbEHkxeKsOwgnP0SuhzdjgHJqVd+vDvBuAKCRdBqCQsphfJuFWxfTrN+cGSFP3Uae5LLwr
	tFaWE8SILjL3iYH9YpcvuqBxI01vnD8anEfV44E5d1haXOw7sAnItFkmzOQyiuTt3A+I0Us6x8jZ5
	eimX9OQVQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgwdJ-0045gI-2P; Wed, 12 May 2021 21:43:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwdG-0045g5-Jw
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 21:43:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=pEuMnWQOC5nNfUq2pnMEak+G2H
 /Mno9pzQoYGP4jJx65HFmSnvgkzu4COzMGQZUJlD5Uzb0ZCuUKTuWPYqYTO9mZVnlK3IdOWXnNVW/
 7H4hzCHyjxUUFiVLTqDTojJtIXuigFKc1TeZYElxA6HynWsEf9hksftv6YWFYbAjF357GzoQcuv2K
 Y7xHt5JEEY10w7ihjIiUY2DL/DuSCzwAV0nruPYYksevcaGxjKEbTlM40b9a6+X3Xd9+1UDe5alkN
 C06ti7fTeu4ecM93/YMKfNPnhjoD118kWT1qTLrzuQshIsuNFmw1DXuo0NowggtnQXmlv6sHcRPqZ
 ZvvsGDeA==;
Received: from mail-qk1-f181.google.com ([209.85.222.181])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwdE-00AqVX-A6
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 21:43:05 +0000
Received: by mail-qk1-f181.google.com with SMTP id o27so23761259qkj.9
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 14:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=JNurr4AJiI7A1DHevzuz6IIZrNJww78xaGprHw/D54wI4KxZ8uwta/SdkV/uRHG5mc
 bWy3BO4QmOKo+82w5/AUrvqQJowMNBQjqWkJJrqbhVusJ1vsxr+jDq3kz8gQdlIwjzc/
 tE10p/EboFfPUbShsHk4OhRo6Y9ugem5V6YJ2vZyih5+wBzEvgvnplGd4q4fMnAXdLG1
 z8CARpKdYBHn5lG9F6JtRiP6cNgNDekkS57HGO2aqQE0anrXkAGPaTONRbBWmEr29wdI
 MFO6GZUalKgYT2OQ0y4UErJNjylfYqYBeaJbSeSdEPW5l9E4QZSNrm8zw2QoLb5A0wF8
 Vwvw==
X-Gm-Message-State: AOAM532+5IUTZBPeiW+nLU2sO5E1SvjfGRaftW+rhBdGkqPrG8yFzgl0
 O0m3gUexJAB8GQfbxHXpQBhvgmX1o3U=
X-Google-Smtp-Source: ABdhPJxHg6k8rV7EcmCHMksmgDbuJ4bvztCFiTBTf+jeuEkuvXgT9EZ1bU2CW3wZIEtVpGmthvm32w==
X-Received: by 2002:a05:620a:b1b:: with SMTP id
 t27mr28617638qkg.42.1620855782980; 
 Wed, 12 May 2021 14:43:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id g185sm1021532qkf.62.2021.05.12.14.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 14:43:02 -0700 (PDT)
Subject: Re: [PATCH 07/15] blk-mq: remove blk_qc_t_valid
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-8-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0dd86996-1274-b1a8-571f-4d5b9f71c2ed@grimberg.me>
Date: Wed, 12 May 2021 14:43:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-8-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_144304_358416_214E9844 
X-CRM114-Status: UNSURE (   8.90  )
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
