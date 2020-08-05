Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B17C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:00:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A841021744
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pB5JjmD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A841021744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h3rvCRusABQJWZet6mf5PfICJXW5t3HXL4Wa4Oh/UA0=; b=pB5JjmD1s1N305iYtT4C0jIWW
	t85EjXzjwEOen1vFn1f+tMGv+RFTop9203six8I4VU/+/Jo7g7G/HcWpnEUts4wCBeQD5Y0BTU9ee
	mORSF1NZKbob9W4lrWxm3Gw465xrQMzDEx8wdC684mfr9ejgumU6c16iMlVHQsTOC0o1ArEBh1faB
	CC9xU7ym/YAY4IXG6vrA4YnxbQkNgtHso61ygJLDh43Cj8XhdkJPYsUvP1ORG9ZWPqrL9v8sAKWkX
	Yd1ZzgQllK48jnh8WkEXnz+kgq49/ohh76AdecPuaDKEGk9eoDMevKey5owODBbDr3sMV91kOhQsX
	UqqFeK3Jw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3DPN-0002IB-Ux; Wed, 05 Aug 2020 07:00:17 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3DPL-0002Hj-2N
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 07:00:15 +0000
Received: by mail-wr1-f49.google.com with SMTP id l2so29045903wrc.7
 for <linux-nvme@lists.infradead.org>; Wed, 05 Aug 2020 00:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kDiZ8++6BO7fNLWOTJjWzxTTqh/SgA8menhxTdDCj1E=;
 b=PS0YKudmdoXMIC5BIAYsTLTVJ3svkh3PVy6B8J/Vo250GrE7P0EA8nKQwoRp+BMtti
 JgFzgM+zKD6aXK/PO1Ab3Mk33Zjc/E3HDP45idIDm7q3TFAkkyPnLrLFxDl8WNCs11X7
 yk1o0oQ2SkzJ/ndSUqnLSQNcujyhXdU0JJnsIdWM9MlxABnxh0k6H432oMkgS1OZWoFc
 DeEdzrPnoZ0OJ1w6udHOFwPZ6xrKfGogHmAw/M66Udnm8Y2Q0mNQSyNDyXYADNnnFZaA
 MKAxSA0mo/K+iSNpshO5XIoOcbrIN8VD9SHj+EaXonSUHDodbkekvCTTxEx0EoTn6Uha
 fp4Q==
X-Gm-Message-State: AOAM530uOLHtfuy12TYuAm3CptY942G0f2c8InH84B/w+OBg8OIuSLUX
 T4mWoW9IdwBuWs126SZIPYRwjaAX
X-Google-Smtp-Source: ABdhPJwfgXA4QuhSFmOLJig/NyfLj09/5LCMjC1DjuFOH1sGqOUOHbuIIIrYn5bBoqaLl3adthSlKA==
X-Received: by 2002:adf:82a5:: with SMTP id 34mr1435099wrc.266.1596610812755; 
 Wed, 05 Aug 2020 00:00:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e1a8:cb16:c589:8b34?
 ([2601:647:4802:9070:e1a8:cb16:c589:8b34])
 by smtp.gmail.com with ESMTPSA id b8sm1450767wrv.4.2020.08.05.00.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 00:00:12 -0700 (PDT)
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
 <a918db0b-0979-c39f-aefa-e53de249beeb@huawei.com>
 <a05974ca-45cf-8baf-3f68-8c5e8e5ec5a1@grimberg.me>
 <d0b6e574-eee1-02db-e27d-e9c88e5b0c80@huawei.com>
 <938aa34b-b4db-f8ca-2478-0b48954899ea@grimberg.me>
 <85b3a7e5-5769-c1b2-eff5-318671c6850f@huawei.com>
 <7250e072-c0f8-430e-3afe-d0837efe14ad@grimberg.me>
 <7a05ff5c-9ad6-786a-b1a6-9556d520f436@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ae787cff-f1a3-b464-f471-18b3d736c381@grimberg.me>
Date: Wed, 5 Aug 2020 00:00:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7a05ff5c-9ad6-786a-b1a6-9556d520f436@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_030015_133756_48E0CA70 
X-CRM114-Status: GOOD (  19.50  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>> may interrupt by hard interrupt, and then timeout progress flush work
>>>>> at this time. Thus error recovery and nvme_rdma_complete_timed_out may
>>>>> concurrent to stop queue. will cause: error recovery may cancel 
>>>>> request
>>>>> or nvme_rdma_complete_timed_out may complete request, but the queue 
>>>>> may
>>>>> not be stoped. Thus will cause abnormal.
>>>>
>>>> We should be fine and safe to complete the I/O.
>>>
>>> Complete request in nvme_rdma_timeout or cancel request in
>>> nvme_rdma_error_recovery_work or nvme_rdma_reset_ctrl_work is not safe.
>>> Because the queue may be not really stoped, it may just cleard the flag:
>>> NVME_RDMA_Q_ALLOCATED for the queue. Thus one request may concurrent
>>> treat by two progress, it is not allowed.
>>
>> The request being timed out cannot be completed after the queue is
>> stopped, that is the point of nvme_rdma_stop_queue. if it is only
>> ALLOCATED, we did not yet connect hence there is zero chance for
>> any command to complete.
> The request may already complete before stop queue, it is in the cq, but
> is not treated by software.

Not possible, ib_drain_cq completion guarantees that all cqes were
reaped and handled by SW.

> If nvme_rdma_stop_queue concurrent

Before we complete we make sure the queue is stopped (and drained and
reaped).

, for
> example:
> The error recovery run first, it will clear the flag:NVME_RDMA_Q_LIVE,
> and then wait drain cq. At the same time nvme_rdma_timeout
> call nvme_rdma_stop_queue will return immediately, and then may call
> blk_mq_complete_request. but error recovery may drain cq at the same
> time, and may also treat the same request.

We flush the err_work before running nvme_rdma_stop_queue exactly
because of that. your example cannot happen.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
