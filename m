Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F987C43381
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:08:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F193B235FF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F193B235FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=cHrtx8VB3tVTYthBJQ4QKJ2gL
	gERHUJwANqH2XKl/5s+uqxxP6KBt77Xn7LYm80L28V7q4+g5kouLruWTzQAZo5OMt8hm1XcQ3n9wH
	74meJ6BP0s9naek+iANPX5cd5s+G2R9PH4doVB5vPuu4VnJ8oPO/aGZJCl9RwUk623T9ElS9vpbgh
	Ybogwv1IG6cl2MBYlce5d71+7jB2I9a8ZgyRaeLTc7fLdj+jJVubKOQmwVg8dvhxx4qmuPoQGV3CF
	sF8X7gBMQVHALT/Hhl8212W02sERT66jsUUfZTl0Gek0dcnYac0TmfUqwiYw1o26Q0ZZb5embjakX
	vnelMbbrQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzs2y-0002E0-3N; Thu, 14 Jan 2021 02:07:36 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzs2n-00027D-6g
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 02:07:26 +0000
Received: by mail-wr1-f44.google.com with SMTP id a12so4140614wrv.8
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 18:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Y3qb8SFqigRl+FThDEnB8dWJYuIM2ea8jTdLEybw9/tlITgYSyzdq9Gme+aPQggk0B
 4DNpN8fLfP3Z/fMTnN1P/qPL6de0JHxfFXcEKYO+LUbyObJIZ1fcvJRmxpFuVLqIUGaO
 EZifSA2RlA3xWQ3jYKKRhRGl4AtGeEQZK06G89x9ki7+Ar7jkgFvfcTIgRDL0F6pzI2Y
 jFjm+NfSG54xnky8w29Il+3yOzMdUXkZ+7kYS16gMG6fajNq0qs4iI9GUd20X3lEyFKM
 ZwXek3GZzMLXfm2o0NV0ixx7Pju4rI1GpcewAvdzU7j71VkTfP+X7cxujIWA0zbjTGTq
 xCoA==
X-Gm-Message-State: AOAM533+rwtJteRbSoEWD9F5MbJ7XVZxvPFqXRfro44IKRIfaHsnOILM
 pNwPS+8iOS9tRWX7+1PjQ3Y=
X-Google-Smtp-Source: ABdhPJwaWzsKhOSzfXzT6txTQ3y64zjXAm7fk2URziS7D6S/KGYwQIl+ktocTEHgtBI53HI7YEBjWg==
X-Received: by 2002:adf:97d2:: with SMTP id t18mr5329553wrb.228.1610590043108; 
 Wed, 13 Jan 2021 18:07:23 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id o8sm5821584wrm.17.2021.01.13.18.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 18:07:22 -0800 (PST)
Subject: Re: [PATCH V4 4/4] nvmet: remove extra variable in identify ns
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
 <20210114013354.33946-5-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0d26053a-e15d-3771-f663-ea65f63423dc@grimberg.me>
Date: Wed, 13 Jan 2021 18:07:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114013354.33946-5-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_210725_428146_8DFAE458 
X-CRM114-Status: UNSURE (   9.39  )
X-CRM114-Notice: Please train this message.
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
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
