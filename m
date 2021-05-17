Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82001C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 22:07:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C786023B
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 22:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C786023B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z2EaNwui88k90SHfg0nMdZ+y056T640w3ElD/kCXNkk=; b=DVIWMhSsJyzcUNurGXkDcRK5b
	Nr/R9PFvw32SqTnJxMjOn02yZ0XL2NpHw84DfU8C7X5JI9Bj2BIm73b+s/yalVMu5lSf674O+DpLQ
	N25AlE0Zo6jaeNaYFgC26+bkKsg/RLmmBcajAFNLcrI6RkcDtL/XkCBeQ82Corbl+qZ3oO+x/G+QQ
	uTWn06DWkQ7NfSNvHzSo6uFhkkijgVlLXE8V3NQOF5sr2Pt59W2JzLG+8Qw1yh8g5fVB+EzJRGzAJ
	ROSJSN7cgf7WGcCGMYgdvPJfI+7r20QrbyWu1lkOxw/jcRhqREeXoWzDZoKzoAWrGGHa2vypbzlaM
	fQi366BGw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lilOK-00GHMF-Rt; Mon, 17 May 2021 22:07:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lilOC-00GHLd-Nn
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 22:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=sX+UxD2gLWZrQVylWjbl+IwJ6J/m/LPAvIKBkEoTk0g=; b=QRqCSEtd0zQhPOhNeuHqJ5ZjX2
 tbihWQ7IXFL2xwJndv1kMAN/EzqLkIsmFU6aCn93siFBPqxEEk1r8PaTQVoe25U6TasCkX5Yq5c6w
 gQaUbzRJf5kHuL4WV8hGqVgQpmevVsokInOfnOjydK23RXpxBaJUQGG7JPVUANeaSh8IeSMpYFLf9
 PW/nqellh/IfirDH3nillkcn/nc0rT3jmNtigZCIuPTnHuG99/dkHkaVeK1z2izm06KIeZfKEBxvB
 YfUOHerKqBw/XMDB6guKDbI0XSF1VWNnFfxI7dlIdLt+vOMD9JcRt/UKpcEDGOHuHTaYRFR092p54
 DQetG/mA==;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lilOA-00EB2w-8X
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 22:07:03 +0000
Received: by mail-pl1-f178.google.com with SMTP id a11so3951387plh.3
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 15:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sX+UxD2gLWZrQVylWjbl+IwJ6J/m/LPAvIKBkEoTk0g=;
 b=dGtdQrQJz95g1at6xrvd/I8MgyVLO97mqJmT4M/s6hWXoEfKwB3Dx8Rj6/oLZ4PAfP
 AtlcgH5XzttuZQVK+bqC6HLkTCyGa7Vq79EZ998c0PEG3kqpJ+zn9J7JPBbVuKnXksSB
 vkNl3qgbIeIZubZ702OQZekzsU/9mc75Ic+e/Kpcm20if5L/Ly6hkJrpMgGpL/T7kj/C
 A2HbdWccuCesNl2qXIqf/hEnzAoPC7A1/8pUS2CgSu9WIxDrkt5Dl4ZfbRReB0jAafpb
 Yu0ij4N68e8ZXPdh8VvM//GEDB5epIVuvei8PjlcTDUrMgfvCxx4QSgHT/y7JWt8slB2
 LKcg==
X-Gm-Message-State: AOAM5326prYKaB6xbD/dk39Q85zE1ghRY4qtcOFxhesMZ/o5RlbrCQ2Z
 meRJ3ANkIZXUP2m/0cAqAnB25EffAQM=
X-Google-Smtp-Source: ABdhPJy2xmIFQ/SCCfx3cX+2nVf4ihlzF8U7pXkp3wOqkDOsUovUE9kk6Ip7fdNcOIuDPd+iMg4SAQ==
X-Received: by 2002:a17:90a:e2ca:: with SMTP id
 fr10mr1374936pjb.6.1621289221298; 
 Mon, 17 May 2021 15:07:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:9781:8633:8854:8704?
 ([2601:647:4000:d7:9781:8633:8854:8704])
 by smtp.gmail.com with ESMTPSA id g202sm3809124pfb.54.2021.05.17.15.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 15:07:00 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: code command_id with a genctr for
 use-after-free validation
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>
References: <20210517175955.602725-1-sagi@grimberg.me>
 <20210517175955.602725-4-sagi@grimberg.me>
 <0bd3f659-9691-4f25-6d3b-bdd19546186c@acm.org>
 <20210517194613.GA2709569@dhcp-10-100-145-180.wdc.com>
 <64e3ad99-8435-22c0-bb11-cb9ad08eb52e@acm.org>
 <6474b916-9911-ba34-bd35-e5b5c7d11ac5@grimberg.me>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <decf0b41-fa05-410c-80ab-b7f8de5618a9@acm.org>
Date: Mon, 17 May 2021 15:06:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <6474b916-9911-ba34-bd35-e5b5c7d11ac5@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_150702_337810_97103713 
X-CRM114-Status: GOOD (  15.65  )
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

On 5/17/21 2:50 PM, Sagi Grimberg wrote:
> 
>>> On Mon, May 17, 2021 at 12:09:46PM -0700, Bart Van Assche wrote:
>>>> Additionally, I do not agree with the statement "we never create such
>>>> long queues anyways". I have already done this myself.
>>>
>>> Why? That won't improve bandwidth, and will increase latency. We already
>>> have timeout problems with the current default 1k qdepth on some
>>> devices.
>>
>> For testing FPGA or ASIC solutions that support offloading NVMe it is
>> more convenient to use a single queue pair with a high queue depth than
>> creating multiple queue pairs that each have a lower queue depth.
> 
> And you actually see a benefit for using queues that are >=40956 in
> depth? That is surprising to me...

Hi Sagi,

It seems like there is a misunderstanding. I'm not aware of any use case
where very high queue depths provide a performance benefit. Such high
queue depths are necessary to verify an implementation of an NVMe
controller that maintains state per NVMe command and to verify whether
the NVMe controller pauses fetching new NVMe commands if the internal
NVMe command buffer is full.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
