Return-Path: <SRS0=iTsx=OX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED08C433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Oct 2021 09:29:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5E961206
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Oct 2021 09:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF5E961206
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qZa8ucdyDBQP9S3e8iNh9AwHMscuKeZQWiG5yW7oJAI=; b=OGkzsAsh06hWyfvUhFgNVJACoi
	Vzigpg6EV0e9lcaXsPPkwV/yyij7VLK2rcfsCTJoruoN2PNHy1LZGInMa3loX4GTlSkkCzDBdoTe9
	Xa19lrkudcN+3RZMww4R52+4ewsPX+w3blr//eHwZ946xKC7DI3fvD2KGUeDJ6MV4HPa1RF769NtU
	4TA6gWuPQ/GOSjovD3YlyCJJkj0Q1WAemOkfSklTH7ZwRzY0QzdqfMVa9cmhtpyQln4CUYglncNnG
	NavnKerp9ogYIFwAeMJb7AkPJolHvaNtzszC9Vkfbq5TMw3vQlBKew/L0xsvBtywa5tELDn/e1BG7
	AV1KvdtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mWxoH-003VJH-1D; Sun, 03 Oct 2021 09:29:29 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWxoE-003VIx-Kr
 for linux-nvme@lists.infradead.org; Sun, 03 Oct 2021 09:29:28 +0000
Received: by mail-wm1-f41.google.com with SMTP id p21so1132251wmq.1
 for <linux-nvme@lists.infradead.org>; Sun, 03 Oct 2021 02:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GggRRnmWlhH6C9Vs1UHXp1pUk4jP4nsZJ81+cipIwbo=;
 b=qddW/bmUDAGha3FWuPG7TTiucH3FyllavR4pmUXz3eyxk6H5yDxWZ3m1eiOGAg3Kav
 rDlZ5a4fAKMLdIvIn5TWgD9uwB7kDjNZAdjvkATwuJrAdJ8Hw3W5o9VndIl9+i+Cv60A
 7sSOCPtVESYsUUWQxi2XweLwh1eHf0ZsYRoFNbd66LQ+hbII50fZbhd8T0XJbIUkGeqd
 hM+XQie7M9oNM0RD0UXoLB7CA8LqJpVwlungH4U3G6OQ3Fvg1kt3LIB50uHsqx8ejhjU
 HgFPllIbKdDSUlYUQrGZeBDLg/aEqiA80ojtK/BGGMgxTbcI7MGxfeZbd1H8eHAgDi4r
 IiyA==
X-Gm-Message-State: AOAM532mbhsbX3pcRCre2yxfs4zOBslSnZvo8uBCTT1m0zrfxDGMqdFz
 TuneptMBae8XTABFY+AfXjM=
X-Google-Smtp-Source: ABdhPJzptMQnKh1ZIJZBjgio2siQUeZpuIdQSZHHxgKiiT9aaRkVzslb0+ouKPBjCf6p9dUbVcxwSA==
X-Received: by 2002:a05:600c:210e:: with SMTP id
 u14mr641618wml.70.1633253365140; 
 Sun, 03 Oct 2021 02:29:25 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h9sm5902290wrw.46.2021.10.03.02.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Oct 2021 02:29:24 -0700 (PDT)
Subject: Re: [RFC PATCH] nvme: allow specific passthrough IOs without
 CAP_SYSADMIN
To: Logan Gunthorpe <logang@deltatee.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
 David Sloan <David.Sloan@eideticom.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Kanchan Joshi <joshi.k@samsung.com>
References: <20211001234017.4519-1-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f1e00f76-235a-e4b0-ce98-3eabe0a50ea3@grimberg.me>
Date: Sun, 3 Oct 2021 12:29:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001234017.4519-1-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211003_022926_744396_9C35FF3F 
X-CRM114-Status: GOOD (  17.09  )
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


> The passthrough IOCTL interface allows for prototyping new non-standard
> NVMe features in userspace. However, all passthrough commands require
> full CAP_SYSADMIN over and above file access to the device. This means
> applications must run as root when running proof of concepts which is
> not often desirable.
> 
> Instead, relax that requirement for vendor specific commands as well
> as identify and get_log_page admin commands (which both have vendor
> specific components). Identify and get_log_page only query information
> from the controller so users with this privilege shouldn't be able to
> cause any negative side effects and vendor specific commands are the
> vendors responsibility to avoid dangerous side effects.
> 
> Users that want to send any of these passthrough commands will still
> require access to the NVMe char device or namespace. Typically, the
> char device is only accessible by root anyway and namespaces are
> accessible by root and the disk group. Administrators are free to
> add udev rules to adjust these permissions for specific devices they
> want to allow.

I don't understand what is the difference between VS commands and normal
commands? Why do you consider VS commands safe to relax privileges as
opposed to any other command?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
