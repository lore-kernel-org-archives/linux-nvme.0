Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C4AC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 23:46:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBF220748
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 23:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iFlGIusc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBF220748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LHeLGowEZj80nKFfkOqqf4mVOnI49csxXIz0ncRsIpM=; b=iFlGIuscizeN2AYLhrTNpbo0/
	AP7gJc5oq/Eap4A7NwG+Z8aCAV/hV8dKqnN/IQLZeFBLIBOnHFY0XUI+LRwukFnO2wW0ssyeg3V8Y
	GSN7FOUjBvkRD8d/EQ9+z7bzhf1JxeqJetpZDhN2YecpLEAeQvWlRuALb62o1ueLsMDsZ2ioeIrsR
	APBK8UfmgZPvYWYPrxUGvPkKT9+HzxZj5jQlq9B/rvGrNp9HIWYfc5PbbV2ulTApWWL9bbJ1fp1pW
	BfHe9dJb4cGFTqTaYdy3mITirUUCrQ1Lj3FH/n3jOkK9eipUnjX9QRqruTg73rGzjqisxfwL4Yqop
	8yN8tURKA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4C4H-0004ej-Pi; Fri, 07 Aug 2020 23:46:33 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4C4F-0004eA-DQ
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 23:46:32 +0000
Received: by mail-pg1-f194.google.com with SMTP id p3so1795722pgh.3
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 16:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ANban76DzY8YtDad9UPwri3M9KHoqBxXkK+LfTFEkHw=;
 b=QkPauZ6JPWwGvrujs5POSyM36DLj22GsgxGjPYfRKLRjPQnvklNHABz2xPtlJ8g2L/
 jmmYDqbC3XR1ZurORZi+8udLkcjZN8LPkSuEoMV04IdyNQna52QY8RozAFT6hKoRMXHZ
 0rdf4TNRAa4f2be6L6FPKa5dqPfnPDWCe34txYJBhDC9Z+DuirzH1NML9LWiIoM+TI9O
 /GvjS25fuVSdmZdWBfMi2IXoH7PYbkVGj3b3wAr7btjCkdNrYBOalfgo1QNxLLGuiGoP
 Z6ul7sYhqBowoSfE9kGdXsoA81xSaR8VHWdeWkLGFvWVAQ/UocGBU4yjzsSsw8RpIbJj
 f4gw==
X-Gm-Message-State: AOAM531aDRQqiGo1GljX+ZX/gNJYC08ntYmXuDujoAe/zulBP2kzk07r
 3dKolV4CVhLq7/xsVmfqnfk=
X-Google-Smtp-Source: ABdhPJxGk8DzDCI2jMfpFfN2PpZDpXywuEjdmyN3VN9gaiXej1l879LV58XYz9SgrrcDDG7eFXK9MQ==
X-Received: by 2002:aa7:8c09:: with SMTP id c9mr15896625pfd.157.1596843987604; 
 Fri, 07 Aug 2020 16:46:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c?
 ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
 by smtp.gmail.com with ESMTPSA id v11sm11910347pgs.22.2020.08.07.16.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 16:46:26 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] nvme: support nvme-tcp when runinng tests
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-6-sagi@grimberg.me>
 <BYAPR04MB496517FF9B9E262ACD555A2686490@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bd794263-02d2-a723-44de-3a9f63723275@grimberg.me>
Date: Fri, 7 Aug 2020 16:46:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496517FF9B9E262ACD555A2686490@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_194631_468100_41C91E53 
X-CRM114-Status: GOOD (  11.40  )
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
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +	tcp)
>> +		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
>> +		_have_configfs
>> +		;;
>>    	
> Same as previous nvme-core nvmet configfs can use a helper.

So for every trtype instead of having:

	_have_modules nvmet nvme-core <trtype specific>
	_have_configfs

You will have:
	_have_nvme_fabrics_common
	_have_modules <trtype specific>

Don't see it as an improvement...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
