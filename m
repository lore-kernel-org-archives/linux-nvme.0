Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD023C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:02:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366C564E0B
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366C564E0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WUjZ+1KzzZyt0SlXMRg84k51bVnRvO1WWYG7wk8w2TM=; b=e6fvnSgTTcjcOXMd9iS/hnSVf
	kGr+yHX9Rrmmv2JZLhL2Y1YdZLEUmk+H2JYzHhwkOYKZZRuJJpxD7yrv+1j6O+LeR+5pO6niQ1JkZ
	bKrmr9u0y3uylQRSKvVD8iMxVVrbUWhxYpAHksdgDG1+N8Qf5Ld1p2bxqQadZia2q5y88G8D5FMCd
	CfqqlvPbyeRNzbOjoMq++dfoGsrc9nv2KCmH0npwJRMT4dXc5khDn7olXkSsfSEwbTK2d8cpuTOMO
	CTCSNi7baOBcvoLIRrR94uFpyaZi0dOHEY/xj7uwN1SHJB4nj6wxxJu5e6mCeRMwXl3fjyawSUvKn
	fGfaZRaJA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Z2m-0006BA-OM; Fri, 29 Jan 2021 19:02:56 +0000
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Z2k-0006Ab-F1
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 19:02:55 +0000
Received: by mail-pl1-f176.google.com with SMTP id s15so5760251plr.9
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 11:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v+VA6WumOd6/AnUqRsFYeWIcMeG2/yfCFCriaC+nvNk=;
 b=l4w90xAIpmW9JHtfIfLMLVBzJMIhXpCLMqtHjh0LvEb8xhNDIMt+sFZsrxorbjbDvZ
 v6T+rUnMYSiKkg3RspCXEZZOdLR7+SsO7Y2F0BG8Zm4xzVQkFBNKMAFP46Ns+jW9hDJX
 u7MfmHZZTQraCTDDTBuejZ3tBQhJLXeoLMqXS6Fhu9hXTFG/GT8ipwTxdGft1sEddO+5
 /nQ5srU8Us+xjxIJ4xsYTsA82Ecr83t4rJAq9EE3FdOY2N91YT06YStfsDzJTwoKTfb+
 zw6yQqpzJaKvV0RQOLZMmoQNI4Sgfo0iiXAbFvULkER4PbFpQ9eQVHzBXIsbf6BAq0uR
 qYqA==
X-Gm-Message-State: AOAM5331S+rFBK9/Sl/JKR3pwH/pK5RFI0nYEQukLjYJAm8WSPPYBNV/
 9+2yo3EfOjytMPRzagCzhPs=
X-Google-Smtp-Source: ABdhPJyH7WuQHet6DnZfoH4db0b58/TbwXqe1oiPknHMtEIA4mIj1IeKIuEH+IcsSvkY657n9N/XcQ==
X-Received: by 2002:a17:90a:4582:: with SMTP id
 v2mr5798648pjg.79.1611946973261; 
 Fri, 29 Jan 2021 11:02:53 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id ob6sm7614191pjb.30.2021.01.29.11.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 11:02:52 -0800 (PST)
Subject: Re: [PATCH 18/35] monitor: add "--persistent/-p" flag
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-19-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6d6104c8-708f-d09c-7b5e-5bcd6bddf223@grimberg.me>
Date: Fri, 29 Jan 2021 11:02:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-19-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_140254_563497_C00D0D7E 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Without this flag, AENs on created controllers won't be received.
> While --persistent is probably the behavior most users will want,
> it has to be explicitly activated, to be consistent with the
> connect-all command.

What is the usage model without this flag?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
