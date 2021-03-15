Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7F8C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:47:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CEE64E31
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CEE64E31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=EzqyxgBRaoOGiW8pHWnu01keA
	LvJmP8C+0hej//tPoxbxs8/CgM/LvX1U1ogLyjJjaTfeFG7UBpR4gaytZoTcRPOmKA75l5Sam3hgK
	zMrRw+of3lYwkq1m5yVPuF+pcZCQzwn4WXykiEU1GiDgskPwBqLMdDg2WJ9OSwDaHvJlgsesy8MHA
	qrOmCbLbhkLNLbo6os82ftxrgIjGv+wpjaX5LxI+RzDpK5730ZXrSd3kx+mt2t5S7T5byFrej/b60
	5OcFG80gg1SXqzPWrfuZT4tuEFzn2heQ7sWmYAh+7cxuGUyNvrujTuFqTDrmM4+wNUKGfTGDzB7MN
	uLKsTI0PA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLrIj-00GaIf-9c; Mon, 15 Mar 2021 17:46:47 +0000
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLrI7-00GaAY-W2
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:46:10 +0000
Received: by mail-pl1-f178.google.com with SMTP id c16so15692707ply.0
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=UbofN9uFdMpkfkRRo9W/X7smXMZPaD1CBz5Twit4zbr+y3P7Nr/wkQwLNqHuqFFjHU
 VIYbFDZz6n1hAsKQYSPubBY2ek2XVtFPXFu5+rUqAt/zxkyfb3TRj2zR9FAA3JO0dyAF
 antOtdTA1Oy8aEQvX29JTVvNJ9YpfuPOglXG1rlstHNLi143NcUAAOClhxTL1nIKZTER
 zHmz2pZg6TB9VUFxIhxeYhbgjthDUdbPV3WvN+CUZ9K7kvvUgJ1E0q/DrSZ0//+GEW0F
 tTTCAggYq80bb+RW4o2yDlUz96JrSKCuohvDblTm9B0NpOh3Qc3kbJUiFx4a2JoKbGOe
 wEnw==
X-Gm-Message-State: AOAM530eFr+592C0OtSi5w8FltGhuPCsbmNehbhDnctn54bd8qEjbqmf
 PVER8FDVun7N3Z+eUd/ZXHo=
X-Google-Smtp-Source: ABdhPJz6FomEj4udrgzCLkHjeEGhEd/X+Ioad4BdD1NfyRuS9y8jpUUsfkDunhY3b/w2JKI5Ec9SuQ==
X-Received: by 2002:a17:90b:4395:: with SMTP id
 in21mr190487pjb.201.1615830365417; 
 Mon, 15 Mar 2021 10:46:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id s1sm13765572pfe.151.2021.03.15.10.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:46:04 -0700 (PDT)
Subject: Re: [PATCH 07/10] nvme: convert some function arguments from "char *"
 to "const char *"
To: mwilck@suse.com, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-8-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <30b20b53-3c61-ed6b-c8c3-b88d55744e7b@grimberg.me>
Date: Mon, 15 Mar 2021 10:46:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210306003624.21102-8-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_174608_283983_50062C03 
X-CRM114-Status: UNSURE (   8.22  )
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
