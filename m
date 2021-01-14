Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C47CC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:08:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D35123A3B
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D35123A3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3P87vyOSCk3u9IiAB88AEGOjUx2xuU3EKI8pq/mq2mM=; b=0pg8aMmWYcL5unO0rOqB2zsX5
	UIUAeYEEmGnFfxGDyZ6+jkelJFnA9xHGOQe0dZiIMpP/+c6b+RJogl+lOAdCMIx3uvnUyw1wShDtR
	FQcP4aTMxihZV4QR0F2cMzcOoYG1Wzl1obkI9C735RA72JlzCIraA1JjoQ5qwQsCzT1i4y7oppk/P
	CTRDFMj5KRqxMYFeydhWez+FUhVxHPtd8P6BrC/scWc7mM3FaSJI9hfPElb6y7CLWnsrFxK+Qr3FK
	HNpSmZKGIEnAgmU/9v7n806fvsFWwLP5ohI60fAMDmZvVdTYiiwUqPhSj1lgA+kwmpl/cElmEu6pd
	+OmP39nmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l09qM-0003MM-W8; Thu, 14 Jan 2021 21:07:47 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l09qJ-0003Lq-17
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 21:07:44 +0000
Received: by mail-pl1-f180.google.com with SMTP id x18so3557406pln.6
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 13:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DVg1oNfEVBgfvsUX222J2RVxfLhd7d7Ta6Z42Snkcqo=;
 b=XojJtZ1draxYGCIAgYFDNhIDAzu1hhF1W0v5uQY6OcqUcWY4XS+6gSXwjVVgjd6/M3
 TEHiXe4gLfFSt2J0C7aX1DpBwyVu3PVXLuaXrzYJ5JNhYARhLqnAqNjweKDG+baZ4x8r
 4t1XpMX0cjUhEVJ8TPM2zkTB3zWXgolLhI+c09mdRgKHUmCpY2OJOfWyoraRwsHxiA6y
 aXwDo4kX7hLZkutHRjkzM83A7MqodsDpU0K1t3u/NDb3Zq8qy63+mHI7Ht5GdSl54sFT
 2K+TPtA604B7HnWmLexLADwgxCCQtd/SNvv9RAaPfzzfTB7MZOrrXEYeIAZYVpKqZkqw
 zM6w==
X-Gm-Message-State: AOAM530rrebtc4rKksD4A6sTtn7fq4v7XNEXWY+WOUIH+aye53igOE/f
 U4JfTlIbWMjCvTYfwz4oH+4=
X-Google-Smtp-Source: ABdhPJyiuuEDPj6uI3yVSujW4SS4ixWBdszT3qqJdtpd7o/NMXWt4Di4hauPFp+ZrazDE1BNdiFfpA==
X-Received: by 2002:a17:902:6b0a:b029:dc:31af:8dc3 with SMTP id
 o10-20020a1709026b0ab02900dc31af8dc3mr9344603plk.41.1610658460210; 
 Thu, 14 Jan 2021 13:07:40 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:9240:50d6:cd00:1b14?
 ([2600:1700:65a0:78e0:9240:50d6:cd00:1b14])
 by smtp.gmail.com with ESMTPSA id h5sm6612194pgl.86.2021.01.14.13.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jan 2021 13:07:39 -0800 (PST)
Subject: Re: [PATCH v1 net-next 00/15] nvme-tcp receive offloads
To: Boris Pismenny <borispismenny@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org, davem@davemloft.net,
 saeedm@nvidia.com, hch@lst.de, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <69f9a7c3-e2ab-454a-2713-2e9c9dea4e47@grimberg.me>
 <6b9da1e6-c4d0-7853-15fb-edf655ead33f@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <02f12db0-4f66-8691-72cb-7531395c7990@grimberg.me>
Date: Thu, 14 Jan 2021 13:07:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6b9da1e6-c4d0-7853-15fb-edf655ead33f@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_160743_089999_53AA6AE6 
X-CRM114-Status: GOOD (  18.72  )
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
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 benishay@nvidia.com, netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Hey Boris, sorry for some delays on my end...
>>
>> I saw some long discussions on this set with David, what is
>> the status here?
>>
> 
> The main purpose of this series is to address these.
> 
>> I'll take some more look into the patches, but if you
>> addressed the feedback from the last iteration I don't
>> expect major issues with this patch set (at least from
>> nvme-tcp side).
>>
>>> Changes since RFC v1:
>>> =========================================
>>> * Split mlx5 driver patches to several commits
>>> * Fix nvme-tcp handling of recovery flows. In particular, move queue offlaod
>>>     init/teardown to the start/stop functions.
>>
>> I'm assuming that you tested controller resets and network hiccups
>> during traffic right?
>>
> 
> Network hiccups were tested through netem packet drops and reordering.
> We tested error recovery by taking the controller down and bringing it
> back up while the system is quiescent and during traffic.
> 
> If you have another test in mind, please let me know.

I suggest to also perform interface down/up during traffic both
on the host and the targets.

Other than that we should be in decent shape...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
