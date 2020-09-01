Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B05C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:18:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC31207D3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gl5wMvdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC31207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=izZGCsvRmj4z2jUGb4o9C8ThFwvq+LOROyQ0BQsYIXo=; b=gl5wMvdU5QLvrzNdohmI7/rWX
	sCVGdph0xVJTFznXcutm6/pGHaP4S9NNg4m55pjzyQn++fVfiAvjPvskz1REurgmbr0V27mabRAS8
	4j1LKNybAi98kUQEOIE9TswHNytSFv5TXCv9UWnbwiezcEnTXdM+lOT4uMJ7VByZlv7gYhAykGKCr
	WB4Qctb+3gs60rY+CaX1K7hB3MN/RviEKlOLDIMo4Lqbp95GMRzr4I1bxi6jnGAIwscZH+lsCVY/m
	WjcmVSaMRvH8TPiP+EJqnI26xSyNRQGzlmnKI8AOMoVedqarHUij1KhKV+5lVWEn6fzyoDDaf+6GP
	rrtFKpheg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD9vR-00043r-BW; Tue, 01 Sep 2020 17:18:29 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD9vO-00042u-SF
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 17:18:27 +0000
Received: by mail-pg1-f193.google.com with SMTP id u13so101207pgh.1
 for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2020 10:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V4ApLz4tVjehVAehmfZxviqHXkau92ALpQ8Cd5I+mXQ=;
 b=I2dJa1O6y6rD7EqfjsP6vgWRRPrGf3moAUdOr1vBhC/J5a7e3MhDNtmDUO+zmpZkV+
 /nIZBxgHsZ052zQsH+TXmJ9inb3Mhc3qzddlfCowVma8Htq6RbrYKVEY0OnH05Gb02sE
 2DHjd80QUhSob+7120Gss9cD5yYcoI8yDSy7FYsZVsuChWDwXXXGb8t1Sj1KvBhfMuJf
 pKZvaZweRzzr1C7ZCsszcr8/xzN6CbVM1TrcN5AAr5KcxXrpNkfhlBDYhMj3YSfYwT2c
 Jlnh5xFJhCn66w/DUAIsvlrZa6w/Kz1cUy9aXYILOfwRzpr9fOAjo2GJuBRihrq3WjcP
 +kAA==
X-Gm-Message-State: AOAM533zhvS+M4EjiRaSAvj8RgtfTu/tpVPLdN0v8XyEK4kqSaUTs1Zd
 pM/hEWTp27dFwnwhyEQWNS8=
X-Google-Smtp-Source: ABdhPJzCwjj+hfqnUEV3pMtEUi+4HOJ7g9w6pNfYo5001B2KpxTFGfTk+W8C4hMsXH7bW0qWEuMc/A==
X-Received: by 2002:a62:5e04:: with SMTP id s4mr2851024pfb.67.1598980705770;
 Tue, 01 Sep 2020 10:18:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61c1:4660:c489:2347?
 ([2601:647:4802:9070:61c1:4660:c489:2347])
 by smtp.gmail.com with ESMTPSA id gm3sm2068976pjb.31.2020.09.01.10.18.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:18:25 -0700 (PDT)
Subject: Re: [PATCH V2 08/12] nvmet: move get/put ctrl into dev open/release
To: Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-9-chaitanya.kulkarni@wdc.com>
 <7310435c-5341-d95b-55e7-605c0dc7130e@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <92a8029f-88e9-abbf-a30a-a339df3c6dff@grimberg.me>
Date: Tue, 1 Sep 2020 10:18:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7310435c-5341-d95b-55e7-605c0dc7130e@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_131826_918818_A625A120 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> @@ -3327,6 +3337,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>>   static const struct file_operations nvme_dev_fops = {
>>   	.owner		= THIS_MODULE,
>>   	.open		= nvme_dev_open,
>> +	.release	= nvme_dev_release,
>>   	.unlocked_ioctl	= nvme_dev_ioctl,
>>   	.compat_ioctl	= compat_ptr_ioctl,
>>   };
> 
> Seems like everything above this is necessary and fixes a real and
> obvious bug and should go in separately, first.
> 
> Everything below this is rather unrelated to the bug...

Lets overall split bug fixes from any enhancement. Bug fixes
should go directly before we handle enhancements.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
