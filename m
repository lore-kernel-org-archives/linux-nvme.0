Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE2DC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 17:34:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7171C619B1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 17:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7171C619B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uz8CtLj5Jb/MQEa4umFinjfEJex4wacBcoQLRThG7DQ=; b=qdG/bV4JWFhNAry0/jJNqIwkm
	mxREygH5yXRGFwuqSDXeC1OlXLLt7xfPU52x1cLg0/uk7WlsdaOfuHtwb6TZyYDgqWfgRcRdULgAV
	X9S+7SVpu7LLskMMNPb4P5U6MLGW3izJy/WHp5MqE0w5cERRmlC62CEORxOrWdxhL9AEj2/YS17WM
	YzUuWFuGtg88PK/lPSm4uldTKwu8pcMY17DnUBYGqtnOxcD6DxGT90hbufsytuKd8l1BfIfY+PJOe
	7hzSFqDQTh6YaRMPimaDksLxsbfVRvDWh7nrzj8mtu4MILmvzmZwnMSNuvoSqCaJFvtv8OpzY+4LX
	kc1fTjz3w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRIGD-004Sfj-J9; Tue, 30 Mar 2021 17:34:37 +0000
Received: from mail-ot1-f43.google.com ([209.85.210.43])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRIG7-004SeU-JI
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 17:34:33 +0000
Received: by mail-ot1-f43.google.com with SMTP id
 68-20020a9d0f4a0000b02901b663e6258dso16292217ott.13
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 10:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XrptEghcxdTQZaRjcdwhLqUukJxpuPSRHJqpw6RjUr8=;
 b=btnAn4t2xhXMenlCN9dEHz/ibPSLHBt7eJBfudpEqf6Wdc7b4YON5y0rF/UzA4jdPl
 t1aIGfnID9i4dwEYHA4o+EfHmXkBaZXVDYx++Deap/YfzfDNNz4Z0M4BbJE2V+/+JBju
 S/yJwMKQVkkO0bjlKa5s1LhVwSnhlQ1tO+F56LXTCrPztc7C+EbdN7zEN1jGUoEkglIt
 2d6dDtFDSAMiBplEnJo6Qqc6VSyzhL9nCiikFl7OSkmGclOab7+zHjC3Ap/vgerj+w9N
 s7h5wn8wOBN7AqpNIbFsA8jToTjXZx9D9SNnWPHZ1oPsp8pcszt82SUKDb9g42i6g1cs
 dSVA==
X-Gm-Message-State: AOAM532B3U9wzP2gp+a6ujN66e8vqlKOSsgg2AnI8heUulgaaWnrOi0u
 ZnE1sVse3VIM1iGMeCyN638=
X-Google-Smtp-Source: ABdhPJzoD7nzNnMZFuWsajtjOZufvncEn1PPO7i9ZOw45Ndyjy+l4lecZmqXg25ZTHBMlwk/qyOQrQ==
X-Received: by 2002:a9d:62d8:: with SMTP id z24mr28019748otk.258.1617125668624; 
 Tue, 30 Mar 2021 10:34:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:b4f0:c745:2568:3257?
 ([2600:1700:65a0:78e0:b4f0:c745:2568:3257])
 by smtp.gmail.com with ESMTPSA id d24sm5132266otf.12.2021.03.30.10.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 10:34:28 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To: "Ewan D. Milne" <emilne@redhat.com>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
Date: Tue, 30 Mar 2021 10:34:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_183431_817965_FAE3E236 
X-CRM114-Status: GOOD (  17.43  )
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


>> It is, but in this situation, the controller is sending a second
>> completion that results in a use-after-free, which makes the
>> transport irrelevant. Unless there is some other flow (which is
>> unclear
>> to me) that causes this which is a bug that needs to be fixed rather
>> than hidden with a safeguard.
>>
> 
> The kernel should not crash regardless of any network traffic that is
> sent to the system.  It should not be possible to either intentionally
> of mistakenly contruct packets that will deny service in this way.

This is not specific to nvme-tcp. I can build an rdma or pci controller
that can trigger the same crash... I saw a similar patch from Hannes
implemented in the scsi level, and not the individual scsi transports..

I would also mention, that a crash is not even the scariest issue that
we can see here, because if the request happened to be reused we are
in the silent data corruption realm...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
