Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B41BC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 17:59:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E505601FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 17:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E505601FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=CiRAW/NnUirHC9so6d9p4wz3h
	gqMEWckcmX7r/8eMebmBJ3lo3/saxRCMVsVLh3+PdujDoJUqVpmMlPpahTqNhurv96bPao4BtGqsT
	DNpz2akbIDTrlb5j9ZW7RFz9aYVQwuvobSP55IhcGbf4YxTHCIQi+koHp15LUtZHLPK58jo9y2Z2k
	61vnVvuyY77nRogVnFlvULk8pMmhM5mt39hL+Msgh1dxoTdS71SO8jYpPLYrJOXFOS1Shl3ZoU1uL
	Gs843ipm+ODmuyTftJH7njmJRW6C1oqS43mEDMxn1y6vA5MhvvksuOJB/n+0Lg4U6VBIpXyVyorSk
	qJC4VUxeQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lj407-001YLn-5v; Tue, 18 May 2021 17:59:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj404-001YLI-PV
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 17:59:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=dlFO6ZJzzyXYB0fsU/b+W5Go87
 wUnlToWLw7zHvays9Pb0ZR81Rx8cuxhaL8wBMtKXZppenEexFKEMyJZak8Lod+IH9PcfhDmJ8PMSr
 qZA7PRz4i/heHw2C9dHDnVOwFL+ghhad93DtbfwbGfnxw1KcQYvR0mm0DkyGRZ75TLGJRP/dFV0vh
 yJ52J7bAh3sC6vW3VmWunYZGS3YMFaOP5VGII8GMPTaNuildR6VDxplh/ej8+SYv0YkBJmaTI5rCI
 VcMVATfOuuRBd4oaanwvKtjTO8mCNeh9frbrq5+EPvUka6W6KeUZUYnXza4ntqIYdajQFzGhPOGSk
 Y8m9ilyw==;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj402-00ErGi-EH
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 17:59:23 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 h3-20020a05600c3503b0290176f13c7715so1938387wmq.5
 for <linux-nvme@lists.infradead.org>; Tue, 18 May 2021 10:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=BdFYu8YQXIM5Cszef45+IuLR6WvOq8Bi9I5QCmvQJUTeSFOC8v6hMiWchHLc5yao1s
 CRhMrlIoXb/p+KzguFdiovz5+pOKPJ7ucTCHT40y3adl+j4YctKA8njbBKjVgj93/i48
 F1fQXNBP04yE6wUNgd/H6ZvD9W54kqmfOoewJDYkPx7ISO4ds8C49iHuxS0laNgxwPfV
 omruKAaXqSKbJlvVRPCbyqnNZ05yrFFXh8K2mp36AWKXEl310Xjw33Zf19WAgz09igbE
 vsEG5IeytiFYsIo44lPX+oD0jHJtQd2JnGm93JTe9FZDrFz458jujnRHUQxCoF6Fe8yK
 1yQA==
X-Gm-Message-State: AOAM533rQg5ehH291lacO4ENTp8StgQOtPHzPGQjwr8bsEWAiSmcwK+D
 DfAZQlmglmW2U/iXuK077SXCucop2R4=
X-Google-Smtp-Source: ABdhPJyCHy1Y6ONQuCnsRU/NA0aFJlrcBnYFsBnvRs+a2KUVrQgl9Di7mwlDPSi44RK0HLzFH8Ojow==
X-Received: by 2002:a1c:e487:: with SMTP id b129mr6748712wmh.137.1621360759887; 
 Tue, 18 May 2021 10:59:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f888:e3f1:214b:6edc?
 ([2601:647:4802:9070:f888:e3f1:214b:6edc])
 by smtp.gmail.com with ESMTPSA id s6sm3957505wms.0.2021.05.18.10.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 10:59:19 -0700 (PDT)
Subject: Re: [PATCH] nvmet: fix memory leak on nvmet_alloc_ctrl()
To: Wu Bo <wubo40@huawei.com>, hch@lst.de, chaitanya.kulkarni@wdc.com,
 kbusch@kernel.org, amit.engel@dell.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: linfeilong@huawei.com
References: <1621327598-542045-1-git-send-email-wubo40@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7b29210e-8d64-0fea-2cb4-3e96e85559bf@grimberg.me>
Date: Tue, 18 May 2021 10:59:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1621327598-542045-1-git-send-email-wubo40@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_105922_505589_5C440DD4 
X-CRM114-Status: UNSURE (   8.50  )
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
