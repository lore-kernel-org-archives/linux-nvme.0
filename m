Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D03C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:38:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB142075F
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f6UC3udf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TNNmw+zX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB142075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/xeSygkT7e/bAMOawjs7kwHkfWHwy1owaVldkvqLYlE=; b=f6UC3udfvmkA2nG9/xkzfdp4g
	j/DkzZkJC/SMPqpH3QYszLnKeZpgusK+nq97ipvzleR/EB3w1lAQtey/CAQQc0iu/U/2E6Cc2+G4R
	/4sMRt5TOZqdOJ9Ie8pe6M4nhkduf7YxL7f0esftJUF8Z64foKDITTbaUicY+NbxzxJxbYEblrl/Z
	XJk8L7MqXbnJDILD+heeakcRrUzQd2cepB16Jfgs/Rk/uY/+oGwTxhhkxoDJwb95jXLgq8zCZmFMg
	DMT9aO7OR520ggqRGj2q1JhK83891zAaVzxXHIugTdEGAo6IYRAWH3DErV49Yrzr4v0tE/eGjfxkB
	7M9pqQUyg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0q1h-0001FK-Pg; Wed, 29 Jul 2020 17:38:01 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0q1f-0001EO-BA
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 17:38:00 +0000
Received: by mail-io1-xd44.google.com with SMTP id a5so10155447ioa.13
 for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2020 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5ShmMwXzkkP7njO5YzqKQMO3gMDOR/zuGA+4L2KDGm4=;
 b=TNNmw+zXBsq+YBWbnSJi8eLISVP4F/VAiSJWP8uYSltZGIz5hhQUxh4KMQno2sP/Zv
 D6jicJdBuOYNiDHC5BAtXx1eVhNq73fIBmWFyBWMhFArGHGbJRXqXE8j9HRQ4HrW+Ovb
 /LkkX1xonPjHdwO6eVcPymEEf8kOW2/VHMchVHBFWbjkUXeQb0vbFV1srwusTpeCc94G
 0n3fTh+2D5kiIAMEKjIrj4NJ3Iy4NgtsWQ+Sy2+pNPCDr3cCa2TYZWBKy+Zz//00DAWY
 0nz/gXHMdiLMIuYNSncHnnZ5NEIcOqp+is4Mzd7LWcGziYNRJrhzSbrNQ9hmBktwvuw/
 4AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5ShmMwXzkkP7njO5YzqKQMO3gMDOR/zuGA+4L2KDGm4=;
 b=HptzRvWNGXkjBlKRpWAoYBgGKrhT2s3LTnOv/ytcmMX0b4DHaWEAYdY+okyg/0zUEw
 p4PlomqjgT43fh5F33X9rJLtJV9sUYId7WJ3pojT0yZgC6mHqm9NjocbEHOtRDJEFetu
 73O0iDjYzQylLiaACYz3i+WefHVdY+KVwqU2wXlte8XIH3m/zacmYC9bmzQsIo85RzxS
 fGA4lgtYOjuMeyy4pPvDnlo/6VrVfVScg6Nfeq4JvitWgSML4GC6X1UAGqYtx8+XlXor
 o6kjdLHeGrBIYF0apOBXUb5APej10/OWthpTJsiBB78IgY8atNTc7Ibbbgk+e/p5UZSj
 e7+Q==
X-Gm-Message-State: AOAM532nwqWOyKjOCuexBvoU5vfrk7JhP9fX/X9ROePSe/NXk0Wx1Pbm
 wiluzB7pwHcutRXsv9xxnOWJ2VyJ1p4=
X-Google-Smtp-Source: ABdhPJzruCBTayo9Mb74tmi8U1AaRmn4DDDvgiPjKHcV2/0wWJZjOinznj9QoC18PIZGGvKzu0UfUg==
X-Received: by 2002:a05:6602:482:: with SMTP id
 y2mr5603582iov.188.1596044277199; 
 Wed, 29 Jul 2020 10:37:57 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id t7sm838624ili.2.2020.07.29.10.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 10:37:56 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.8
To: Christoph Hellwig <hch@infradead.org>
References: <20200729173010.GA25167@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3e9fbc3a-3e86-5d0e-5473-93485a237963@kernel.dk>
Date: Wed, 29 Jul 2020 11:37:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729173010.GA25167@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_133759_425239_BEC43C81 
X-CRM114-Status: GOOD (  17.54  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/29/20 11:30 AM, Christoph Hellwig wrote:
> The following changes since commit 1f273e255b285282707fa3246391f66e9dc4178f:
> 
>   Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8 (2020-07-16 08:58:14 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8
> 
> for you to fetch changes up to 5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a:
> 
>   nvme: add a Identify Namespace Identification Descriptor list quirk (2020-07-29 08:05:44 +0200)
> 
> ----------------------------------------------------------------
> Christoph Hellwig (1):
>       nvme: add a Identify Namespace Identification Descriptor list quirk
> 
> Kai-Heng Feng (1):
>       nvme-pci: prevent SK hynix PC400 from using Write Zeroes command
> 
> Sagi Grimberg (1):
>       nvme-tcp: fix possible hang waiting for icresp response
> 
>  drivers/nvme/host/core.c | 15 +++------------
>  drivers/nvme/host/nvme.h |  7 +++++++
>  drivers/nvme/host/pci.c  |  4 ++++
>  drivers/nvme/host/tcp.c  |  3 +++
>  4 files changed, 17 insertions(+), 12 deletions(-)

Thanks, pulled.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
