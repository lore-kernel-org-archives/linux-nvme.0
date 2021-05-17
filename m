Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBB0C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 21:51:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA7B61059
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 21:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA7B61059
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Sh9+gmtz3DhLdV/RbGlRDcX1kDlT7eshjZrudv8K1Ps=; b=bQsjVDaFjODpGIJA/KpspOqoZ
	oeV2AfTtMYdqLqU2Do+obRuHgiwThrA83YSTGELaS8Zf5ePQEeSwFN1zDWac7Q6ZNsUF1Mks1o9vd
	DloEVuKpG5cRYQBFrTy2HVtDx1QhU1gx6avc+156+8NDu1c+1/Lw8czlMq7879hrP7wbmPzm8Arnn
	MnomjHmKvojzDhAw+hlWT8gEmYdYoOFJP955HH5V9TIxZc9UHghrY+x8Pp4TPS8+EJE2MEClF6N+g
	M18536N+Gh6wLkg1TtlkhM5o5AbuwjW19pd2ZvOUf/hiBqDVxIQa7wMh9G0vly/opn03Cr3g2Bt6N
	YzrQGvr0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lil8Y-00GFbs-4G; Mon, 17 May 2021 21:50:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lil8V-00GFbk-KU
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 21:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=S8J17f75EVIuSOXWM2ztxratiAnAm7S3pGpDDu0F+vY=; b=oHu9zy5acpmiFIoWcFcaECiCp6
 FpoKh8lBsB9lBLUJuf+wgDoNU6E4BBTyBMBXwKKR/+jbwjl4L+PbH+T9JpcrTqn283/XHRVvdK2e1
 3uwekbupWnPmUPvbTnIXnkIWNFTusIkEU2nNvF1j413ZVNT7VUoaO1y1pyYZX8HqO9sPETiF7G+0/
 VBCHqv1RqrvBvSBa5+41pcupxbGSsHkYVQSqSiMjl4tOb2jnAArmlp1ecZxND3Pw392oZIZKNAK0N
 hBh0QuIAZsEfUfqVP0ytOpb9A3MuzczfocoHcClc3su7nlCS23HX5L6u1uLdqWL8Tduy64ycJwE8o
 acjHIQgg==;
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lil8S-00EAeo-II
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 21:50:50 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 b9-20020a17090a9909b029015cf9effaeaso358875pjp.5
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 14:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S8J17f75EVIuSOXWM2ztxratiAnAm7S3pGpDDu0F+vY=;
 b=Wr5KFc6S3I3mW2gld+vBpKcrUdEedp5vEIijJRs0MGp6aCkIQunEqfDZE60Ceue683
 F9R8DVYGNwnyuAf/6jMBPOgQhLO1j7HqOUaDiIyOxrlcP/JpNnbDSiEkB3rcmmZXsekV
 dgrTKsCgjQiJTbnxBdLQD3wH6HxkCTXeo4LasPapmHEUPrDHYHljMp4YXZb+zs1j+Vea
 7reoT9EF1mKKpE7JzQUq+KxlkSHgMnd31r7DIlw4HlqnuRHmsCOTY72G9BmMqNXxYVs3
 4C6PihUsp4KvrVMMFLJTWCMnvXAygGTQ5edIT96vIKOuNX/4DijtZOmCXhsXvgeMH/eF
 /LCw==
X-Gm-Message-State: AOAM5319DCWpvyg7too05DIfAKyuE/9QBdgdbGlGxGblNK002S6yTl6n
 gs1fnVSpYAQsWAJWyWv79VQ=
X-Google-Smtp-Source: ABdhPJyDgA+uEYTAoCubjKkjGlKS7fSzfj+lc9u3kIbBWh0GrsnedKxXiPAXzALG7AnoGkWo9kQVRQ==
X-Received: by 2002:a17:90a:578a:: with SMTP id
 g10mr1196706pji.165.1621288247992; 
 Mon, 17 May 2021 14:50:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e600:1f8f:de79:17f9?
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id k21sm11120741pgb.56.2021.05.17.14.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 14:50:47 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: code command_id with a genctr for
 use-after-free validation
To: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>
References: <20210517175955.602725-1-sagi@grimberg.me>
 <20210517175955.602725-4-sagi@grimberg.me>
 <0bd3f659-9691-4f25-6d3b-bdd19546186c@acm.org>
 <20210517194613.GA2709569@dhcp-10-100-145-180.wdc.com>
 <64e3ad99-8435-22c0-bb11-cb9ad08eb52e@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6474b916-9911-ba34-bd35-e5b5c7d11ac5@grimberg.me>
Date: Mon, 17 May 2021 14:50:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <64e3ad99-8435-22c0-bb11-cb9ad08eb52e@acm.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_145048_639795_E1CFEB1B 
X-CRM114-Status: GOOD (  14.18  )
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


>> On Mon, May 17, 2021 at 12:09:46PM -0700, Bart Van Assche wrote:
>>> Additionally, I do not agree with the statement "we never create such
>>> long queues anyways". I have already done this myself.
>>
>> Why? That won't improve bandwidth, and will increase latency. We already
>> have timeout problems with the current default 1k qdepth on some
>> devices.
> 
> For testing FPGA or ASIC solutions that support offloading NVMe it is
> more convenient to use a single queue pair with a high queue depth than
> creating multiple queue pairs that each have a lower queue depth.

And you actually see a benefit for using queues that are >=40956 in
depth? That is surprising to me...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
