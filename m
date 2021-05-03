Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C608C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 19:36:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D46C610A7
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 19:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D46C610A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dCu2vdNNHROo5Jg0BLCRtxse1M4NzgvwO3zmiW9rs88=; b=BRbOQ1b0/Of502A0uaFyKuNov
	wlBMVwG/dJzzHciB4B4OzOZClkZTw3Bgox5oV2S2/ZtEv7aLa6xE4jVLnrdaFYj5ew3wrQrLAIkzT
	Bxtfv6OombpbsBw4dBt+OAjU0bMVTvidDpcHEEcUUXEbzzMwZGrqw9cl2Q9kAp5qoGx233TAGtc6b
	y7DmKqV1M6TwcS9Q7HnHKOdW0fJl3MJTsQ1UsoewPL/sqADWbVVPhZzBsSb/WwDjQVFJiQxuMixE7
	VC2K582lwpcTokd8Np8XDNZ0n9lgCZXaG5axbuO3GUppwrR+03K4HspRwuK+QhaKQluO75XEoTJTq
	LKfMyp3Jg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldeMi-00EjFY-99; Mon, 03 May 2021 19:36:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldeMf-00EjEz-RB
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 19:36:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=6uFxMUKwOGPqDS6w5FlE2re7XabCuZy0gRvSdEMLR4E=; b=WlxNjNuPjWgWtwoEL73pbe8+zS
 UBUXwfqTBwA5+kVCcyAMJeiXJt8mmD8U5qah8islcsczlkAutmfEDMYhvHy4mHyVJCcR9arojXTab
 6TEOwOTRY4UezVus8hwgg+YZ23OFnAC7/+PCf1xtw+DgJmtDf8tpLIdkl01c588XIHyXHfm7ADAgv
 g+B20ngVKGBuO8UBUlDCoMqHZ9sW6G36+ifx8mdHlEM7t+Itj2PZDWiiBRA422nqwlhDtjb8cNozV
 I7D0lQORVHoilwR3UrQthmnmxZkuAeB4au6gOGgTXhLiufOTa/UEn6iRjx85vaU6kCAk1jI2Hn9vX
 wqSP3U6g==;
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldeMc-003R7w-VV
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 19:36:20 +0000
Received: by mail-pg1-f172.google.com with SMTP id m37so4453237pgb.8
 for <linux-nvme@lists.infradead.org>; Mon, 03 May 2021 12:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6uFxMUKwOGPqDS6w5FlE2re7XabCuZy0gRvSdEMLR4E=;
 b=OmeMIugtavDOSi3VPMowhGfCO5w75Oa/5ev3fIr7ESMRq6S61uiwlLrG3gFIMjGg/e
 rKTMxGB+ePZRbfS53nrzGl+GsUcGKckRbdi3Gk0Lftac2qmNHHMy4hJ9Fd61oC9Adwcl
 9NhIERzWXipJo6jTiq/f9kvvJfSOB7fW0jBrXvPbqk6M2qwxUY1rR+cFBk9z1PRIUsKP
 BYTs0vhuC1N+lciF6U/ulwx+75Qaubm9AxZ2eqdFY357OU0Gvsacmwx3UfoATKVz9K7T
 OgCgHfCutrf9RlMj/tGM0FgkCyqk9xopid5WQaw4Y5pCanvPJTC7o4IY5qhjoglwXA2F
 XZsg==
X-Gm-Message-State: AOAM531nDQ4TeGwJwF/1rbx/3SOknvr7B0lmpFi5hogmi9ozTZOlGm0w
 f7cRSpf548u43NC7aSntLAQ=
X-Google-Smtp-Source: ABdhPJy8p/W0DvJtlR7LJSPEWz+UOnVodBZR8ReDlHQxYqmQLNCt9lVBtif5uW7YvU949Y7/b17tGg==
X-Received: by 2002:a63:1959:: with SMTP id 25mr9504755pgz.84.1620070576226;
 Mon, 03 May 2021 12:36:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4840:6f98:816c:4241?
 ([2601:647:4802:9070:4840:6f98:816c:4241])
 by smtp.gmail.com with ESMTPSA id 14sm9502014pfl.1.2021.05.03.12.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 May 2021 12:36:15 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
 <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
 <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
 <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
 <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
 <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
 <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
 <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
Date: Mon, 3 May 2021 12:36:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_123619_042701_5F429809 
X-CRM114-Status: GOOD (  14.92  )
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


>> Hey Keith,
>>
>> Did this resolve the issues?
> 
> We're unfortunately still observing data digest issues even with this.
> Most of the testing has shifted to the r2t error, so I don't have any
> additional details on the data digest problem.

I've looked again at the code, and I'm not convinced that the patch
is needed at all anymore, I'm now surprised that it actually changed
anything (disregarding data digest).

The driver does not track the received bytes by definition, it relies
on the controller to send it a completion, or set the success flag in
the _last_ c2hdata pdu. Does your target set
NVME_TCP_F_DATA_SUCCESS on any of the c2hdata pdus?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
