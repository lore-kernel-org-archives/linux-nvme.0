Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CFBC05027
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 14:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RozfXd+oEncuzvgW0RR4wRW2qW6GfSZC3oYCDkYhSKs=; b=ZAGufICe6EPcKRt+iq6qYoDP77
	UKAAWjOVWmTAgEl3WqDNsb6UvRPRy7gNGu+FelVGeofydfgZYoXQozObrDuyP6gVmVU5nDW+pBA0P
	TrFmf4dRLBNhqz9s1qRhoD/LjbQCYkfnXGt/vADHSwgHw6uxMJYBUaT7vAihUOilRoQ4rgeihQ87p
	pcVJXhYNdfd5+8VgeHJ78oBUIMV1m1qaLkzkmS4dj3+mjYPe19SFPJvUVC4r/s8n7KRRAdEmmP2XN
	iSfZwZd9r5xi/HSgR9/8xLkcSpPI78fI9qtdAI4v47Nia1bb6W0M9lZEaTTIH/3mywkt76nwHS6Zy
	qzH8qxzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNEPA-00CUiK-MA; Wed, 01 Feb 2023 14:48:08 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNEMz-00CTen-Ig
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 14:45:55 +0000
Received: by mail-io1-xd32.google.com with SMTP id e2so4239325iot.11
        for <linux-nvme@lists.infradead.org>; Wed, 01 Feb 2023 06:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RozfXd+oEncuzvgW0RR4wRW2qW6GfSZC3oYCDkYhSKs=;
        b=sX7U3uxFJvR3uZKnlVqqLxaXv62wbutjLIniRX1ojl/28d+fV9uGrYfSdiDItWr5aj
         O5Iw61ZMDfXnas6N2pgwjU2wab4/7jYR+3fuDgYdS1JVlAplXk4cktCkyMXi1qfmevJ3
         cjSBPwnkJG4nmT38j9fq3g5iaQ8mWJ/cxAIZ2Tg5keVwp6BqoRNXsSCc5uYo7sZ7dX5W
         8KnzK6nsZREhfOKDTfesJ0KPNqVdpD5OgK0aDDk76wPiznesBjN/SeNqmcjFlr5vMVOG
         qPIk6VvAczy7EPgQj32ZMPUVpNUIncRqg7J1LN/ctpEKsWxr9o9rLRchRlky4E0RtyP+
         /O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RozfXd+oEncuzvgW0RR4wRW2qW6GfSZC3oYCDkYhSKs=;
        b=iOzhShLRNQbzSdIxNoAjjvxrAKRqVP1qOdHIy/c7rkiOr+4gibO47BIuuiwJtRjLWD
         6MEs6bYaUGSablwJuHTet7xj4fjSkLWZvz924046eiS9ApESKpQRDbMsiABGOIpiPdda
         j8KOskxn+KSgb1DPZrz65w5kC3mPIplKzUj3a0CjFoh+rQmdJynlRwXulSzdc9B47hhW
         8pioTdGj2Kh27bNpwtS/GP08n702EtJXXVnLTWhqtVmKNwjSqJadOv6l5AkKEDihIyDs
         xXpvBzhnq8KBVqp4rms/UuXozOn9/i0vGZUcsxYI9SQTBAs5cEKY9v8SZe/7fM6swK2Y
         uphQ==
X-Gm-Message-State: AO0yUKXm0tKlyYAuZgDWvnjxhm54oYqKlGuFS9u2ZnJxYVplGpl7tTU/
	5pB4VorFRfZNywILYAUB+/z6ng==
X-Google-Smtp-Source: AK7set+wQ/nGTj+EX2v3MokPjNqrlPwI19+4BedBIHMpx139FgRejNoVFr/5y1dD+9b2mDRVqSOdrw==
X-Received: by 2002:a5e:de07:0:b0:716:8f6a:f480 with SMTP id e7-20020a5ede07000000b007168f6af480mr1443580iok.0.1675262750851;
        Wed, 01 Feb 2023 06:45:50 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e11-20020a92d74b000000b0030dbef81995sm5761921ilq.57.2023.02.01.06.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 06:45:50 -0800 (PST)
Message-ID: <3662f452-a027-5626-d1a3-9559d688408a@kernel.dk>
Date: Wed, 1 Feb 2023 07:45:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme: retry commands if DNR bit is not set
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20230201115001.57321-1-hare@suse.de>
 <20230201130920.GA30589@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230201130920.GA30589@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_064553_879036_1A7D6EEB 
X-CRM114-Status: GOOD (  16.39  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/1/23 6:09 AM, Christoph Hellwig wrote:
> On Wed, Feb 01, 2023 at 12:50:01PM +0100, Hannes Reinecke wrote:
>> Add a 'retry' argument to __nvme_submit_sync_cmd() to instruct
>> the function to not set the FAILFAST_DRIVER bit for the command,
>> causing it to be retried in nvme_decide_disposition() if the DNR
>> bit is not set in the command result.
>> And modify the authentication code to allow for retries.
> 
> This is missing the why.  And maybe we can find a better interace than
> a magic bool flag.

The bool addition is awful, I think it's about high time to refactor
that part of the interface rather than piling more junk on top. It's
at 8 arguments even without this change...

-- 
Jens Axboe



