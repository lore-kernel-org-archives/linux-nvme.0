Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41887C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:23:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5FB221E5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vp5SbAgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5FB221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Dj6LZvNWiOFWYCBLJaid0OTcZFcwTpJcTwPeaKOU+Fw=; b=vp5SbAgi7Bwy71JJfJE35X01l
	aUb+INTMDkfwAKEVP/1VOdCsn+UKZ1Qh/BWZYqruZQ3/UOXx1izO9dqolweZHf5bZlW8qbiFQzVfI
	YhtBv0JodXf36JqJt0nsPsCUy5RRGKB1xSfC9cUZqvkrVCkLr1fNgdH78+CuSQ14rdQP3CZybV5NY
	Os4j3JHx8LE8yDij1IRhfVIgIz4nWJCKn1cG3aa5kc7OLYX8iU+YkE1ZbVT8IqJscTozQuaiDgrPf
	zzRbqWZmCOGbTjnlb+JpZflkZuADtSxCd0FokE4tzl+4ykpAXpTOoalWCgQ/kxtC93+s7A6wS8Shr
	B54PPucIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k465Z-0001Xf-UR; Fri, 07 Aug 2020 17:23:29 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k465X-0001XD-LP
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 17:23:28 +0000
Received: by mail-pj1-f65.google.com with SMTP id mt12so1210815pjb.4
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 10:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+yOXZvZf5Z6iGb9WbiP3azFYbI/Merq7JlcODjLgC08=;
 b=RuTE3xxsirx5O0vSn7Lj+nFSrsXkL52F58f0j6D21HWFl+avmz2863KJDhoqfgXLlN
 miSCAj1USkWTLBSYmfqM417230uvJI/yDwVHLqBKjOvEqAMb+INmVrjmtKdOti2PTu1P
 OtnkzoJhQwUXAjWgYqLPl8E27fmg8Do5e6Av6k0LAUaFgw3yM8KryfDiwQnWsDOhgumt
 qrif9VN/+iqyCHybxy24NheiUzBrlQbLMs27Qe2HuGz1HUqSr9LHI0PUoCWAKSnZFLvo
 VhXo1WKzA8XiIw7AB3IpEwzBkYt++POOjjg1vrGYYG47CqheSrnreSAz5e1QjKoElijq
 OtnA==
X-Gm-Message-State: AOAM532Dve4CaOIlXG42OCiRytdB8rTQWzu5fGevhhDEfuxeZ4beH9rj
 1wz69spkM2dXnEd+aJy14OU=
X-Google-Smtp-Source: ABdhPJzFStox2TGynJvnNPJ+3raN+8mXfnDTFGC29p5ftg+giyhihkM+BsHEWymB53wnKvwvhfUAgQ==
X-Received: by 2002:a17:90a:36a7:: with SMTP id
 t36mr14855295pjb.36.1596821006839; 
 Fri, 07 Aug 2020 10:23:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c?
 ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
 by smtp.gmail.com with ESMTPSA id mr21sm11372690pjb.57.2020.08.07.10.23.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 10:23:26 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] common/multipath-over-rdma: don't retry module
 unload
To: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-7-sagi@grimberg.me>
 <925e1ac6-38fa-6fe9-c0b7-7e665559a989@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <155cb916-062f-e23f-9790-35dee850687b@grimberg.me>
Date: Fri, 7 Aug 2020 10:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <925e1ac6-38fa-6fe9-c0b7-7e665559a989@acm.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_132327_755006_7848E9E9 
X-CRM114-Status: GOOD (  15.53  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> There is no need to retry module unload for rdma_rxe
>> and siw. This also creates a dependency on
>> tests/nvmeof/rc which prevents it from using in
>> other test subsystems.
> 
> If it wouldn't be necessary to retry module unload I wouldn't have
> introduced a loop.

I thought it was to work-around a driver issue as these drivers
traditionally had plenty of stability issues.

To be honest this retry loop to me indicated that either the
driver has a bug or the test. But maybe there is a need I
am not seeing.

> How about moving the unload_module() function definitions from tests/srp/rc
> and tests/nvmeof-mp/rc into common/rc instead?

Don't have an issue with that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
