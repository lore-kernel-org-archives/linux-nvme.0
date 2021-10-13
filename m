Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F709C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 13:06:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B650610FB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 13:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B650610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M+sy7OUYXVClijic+hQLUNtqObPWGrpjDZvxkjUQ+ys=; b=al5nFCvRbArqsLw+oOaLbsAbRk
	cqn50Vr24hfQssV/w0QOXxRqGmYcsw9OX0r2Iv+T08LP/rz0Y3NbKKCI4y3ZEnS5gIzYyN0rJ1TdB
	bAuHT0++crNInTOCu2DrS44E5X/T6Jslh4SbQvKKB0oBrw6JqdHvhf1TToirUIBquq4qWSyuoyJbU
	ZYzCrMxA5z6rRV2jvO+GgTevHGQa0d8RPoMe1JfKZVlcuvW2juGuFfkzUqS8ek+fnOVMkU3lv7Rod
	1zoIV2FaU8qnwI+Lohk7WfsrAKHfzaUJgOVOVcj2WYnQBXbgy6ityOms2u5k6WNn+5HBR1e57xM0P
	ygZxa7OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1madxL-00GlOm-Fs; Wed, 13 Oct 2021 13:06:03 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1madI5-00GWvK-9b
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 12:23:26 +0000
Received: by mail-wr1-f54.google.com with SMTP id m22so7933427wrb.0
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 05:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8HqoT6QO2zaRfcgy0j9QTM+ExP2pCgdEYCJfJSGrEgQ=;
 b=p1izcJpOMbuIg96eXaNIXXaBSHOoQjWhwAbqM9VJuhXB7EgavLr84IunzEXlc8IEYa
 TjJuCdY7Boy/ECeXCp082nzbLqp3eBzGkMzDhwGEoS6SpIz46sDeEwZLfb7cSJj0IjB3
 CBmDk4r+mO3lasFk0t1H49DI/Tx5eN6vHk23kn6N/8DJhFugYYIy02R1abZAyvJAqgHX
 lo+NfE6Eo36wCVZpvvMI4I7dlL9fZpQkGoLsfNsga8qNx1sVmOotvHvggYghHStr9RfK
 A5TUa+CFbPDPKrpIatf4rnepfLshHMc68w6p9LUKGmmmmSKDkV14+15hSjIQnNCQvwrU
 pocg==
X-Gm-Message-State: AOAM5329Jw58RKr4U0IKlOXkd9dFwN6fy1VGQjPqM7CYPo6xo7eoyz5d
 gcQ0uQpdBGynqL4PlHuLrVk=
X-Google-Smtp-Source: ABdhPJyBpMzV8+iJPFvo+cKhdx4EU43xBBccsWlSa5HU4f9PjYqzyb/xbNHZwe+BbpwcuGNQxb4PbQ==
X-Received: by 2002:adf:bd91:: with SMTP id l17mr39598282wrh.261.1634127803106; 
 Wed, 13 Oct 2021 05:23:23 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id t3sm5031647wmj.33.2021.10.13.05.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 05:23:22 -0700 (PDT)
Subject: Re: [PATCH V3 4/6] nvme: paring quiesce/unquiesce
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-5-ming.lei@redhat.com>
 <20211012103620.GB29640@lst.de> <YWWjXN3GEzypVFZ/@T590>
 <20211012150741.GA20571@lst.de> <YWWnEvX2uT4mUDpE@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <37e70e26-7ae7-2ed9-abaa-7242444b659e@grimberg.me>
Date: Wed, 13 Oct 2021 15:23:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWWnEvX2uT4mUDpE@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_052325_393508_44057CD7 
X-CRM114-Status: GOOD (  17.37  )
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


>>> There are lots of unbalanced usage in nvme, such as
>>>
>>> 1) nvme pci:
>>>
>>> - nvme_dev_disable() can be called more than one times before starting
>>> reset, so multiple nvme_stop_queues() vs. single nvme_start_queues().
>>>
>>> 2) Forcibly unquiesce queues in nvme_kill_queues() even though queues
>>> are never quiesced, and similar usage can be seen in tcp/fc/rdma too
>>>
>>> Once the quiesce and unquiesce are run from difference context, it becomes
>>> not easy to audit if the two is done in pair.
>>
>> Yes, but I'm not sure a magic flag is really the solution here.
>> I think we need to work on our state machine here so that this is less
>> of a mess.
> 
> Frankly speaking, I am not sure you can clean the whole mess in short time.
> 
> At least the approach of using the flag is clean and correct, and it can
> be reverted quite easily if you finally cleaned it.

I agree.

The assumption today is that quiesce/unquiesce are stateless in the
sense that they don't need to be paired.

At least for fabrics, the state-machine should be sufficient to
serialize the setup/teardown, but if we break the above assumption
we will need to remember if we are setting up after a reset (which
quiesced) or if we are setting up the controller for the first time
(or we artificially quiesce the queues in the first time as well).

As Ming pointed out, pci changes are more involved with non-trivial
scenarios.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
