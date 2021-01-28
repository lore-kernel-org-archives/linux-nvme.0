Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA68AC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 23:54:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2355464DFF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 23:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2355464DFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iVFZXVEokfsVQk9xPNcekearDilKj/zuxdLEJ1vRL7o=; b=bzVND3HdTXwTRV+DSEedUBS1h
	05/EvTXUZL4I74LjekPUBApjUxQIUcYoPNqpA2Yt9K81tU3X2q/3JTB+WUBRmBFX1/igyA9J1Z/6N
	3YOoEtZuUQREYfzJj4dkHLTpKfvUbIncXsri8ENKlu/0Zjgkx3jANTuHdv47YUuRBsIie9UbiM+7m
	BdeqAXbgVIJxVz4qrq1mXNLSa/n+Q9ZnGRpria8+WQotWnjOMVonN2SaZz5yLPlbDp5liSYcA3yMc
	9z9lx5ssYW6qskJqE8c81EUGgNhxRLkVKZaxoiOsg4vrKkUqKYbg960ZmaGPGLAyX3ia/0t875Mxm
	OZGu1q6Rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5H78-00027E-FV; Thu, 28 Jan 2021 23:54:14 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5H75-00026P-Qn
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 23:54:12 +0000
Received: by mail-wr1-f46.google.com with SMTP id 7so7151050wrz.0
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 15:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=okQDLlSV1RsN5SLF5GVY9GlIjVLxurH7HeodIpW5CK8=;
 b=b9fEn86AFWN+jplZhUtV8r9e/EPnpfWLYUpaqZlINQHehi4PfW2PAlVA68dOFJiKKZ
 WekZzQXF1zNks3I0b3G5kU2WiqFIXMU+E9mbG/DtON0/oLz+ew3gXiOgz1Om3lHLzHbD
 zx1c+orlAesHN7V/Tz5J6AKbiuyB1yChl62gqSwNLGespLL7WZG1rFeXCl4BVTfhNZjm
 nVQtzKoeo0kFoZZJIWLJv9j1QRcrgR48NDY6OVvN+R490X0+fGwHaOLLzd+tl0aufJpK
 HZSiXS2J5q6WDY+nsWvLCVfYKRhHjYTMyt+HMunehHgrP3Ha2fjxSq4aa5Dc0aYDx6oB
 osHQ==
X-Gm-Message-State: AOAM533CJyy82HY/pW9K/2gZIZtkbSTodYBk7fai9JSPy6ABtLfKatR/
 ln7LKQ+gI8QmUFxnbHfqi8Aj4U9WhW4=
X-Google-Smtp-Source: ABdhPJxivnwaMZcTWu0GxOb6rtm1iBHeYrqsC3N2rM7p4CLX5DN6Nra3nR4sLtzMe1Ad90ReiiZOAA==
X-Received: by 2002:a5d:5253:: with SMTP id k19mr1549458wrc.224.1611878050375; 
 Thu, 28 Jan 2021 15:54:10 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id n5sm6373398wmq.7.2021.01.28.15.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 15:54:09 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
To: "Grupi, Elad" <Elad.Grupi@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210128152758.114112-1-elad.grupi@dell.com>
 <2c2a3aa6-ca43-e9b0-7928-28c6962ea1bc@grimberg.me>
 <DM6PR19MB40113530FCB4DF6F52E8C752EFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
 <9d974783-dc05-61b1-902e-a0cbe13199f0@grimberg.me>
 <DM6PR19MB401116F68376949D24B6803AEFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <53c6c0f6-99f7-ca1b-c205-05f7a03c1785@grimberg.me>
Date: Thu, 28 Jan 2021 15:54:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB401116F68376949D24B6803AEFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_185411_917072_3F50390C 
X-CRM114-Status: UNSURE (   9.74  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Release work might get invoked if nvmet_tcp_set_queue_sock is completed successfully and set sk_user_data, but sk_state_change is triggered by network stack before queue_work_on is invoked. That case - there is a race between release_work and accept_work.

This is just like any other case where release_work races with io_work.
That is not an exception from other cases which release_work will need
to fence from.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
