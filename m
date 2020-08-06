Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E10DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:41:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A232177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0vgMZmD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A232177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+ljiSYZoENPMFCyKz+h2IV0hioGXbh49fwEsfFjd/I0=; b=0vgMZmD+OQM6cY2i2Ms8SWt8T
	E1GEnuEPuS6PyT9HeeM3p+7eJe+MO8E94GnQItogdaICsoHvK+yLDGkTFWzSa+/P15v/WM85NwtrA
	cwaA5s6CsEcLjYkKmsYBPJAflemUDpHJh2UX/v6csSYjaZNtfdMVYNY0R1kMhcP6bMGHcvwziKhYP
	MJs7eaUODPbm9dy5ld5+hwoLhQt0CKcz1NtVZvKjltRPuMlWi3FqZ7IFRCVr+eMbsbDX5gynYN+dW
	hn89WL1Y+OzXQj+109WIvJjVNuGO64WyxxfK16MXa58FZDIX64TXZN0VKdSd/EClKzOGdLoth5kup
	AOjCnJ+PQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3llE-0007SK-Cf; Thu, 06 Aug 2020 19:41:08 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3llB-0007Pq-8L
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:41:06 +0000
Received: by mail-pg1-f193.google.com with SMTP id p3so27497507pgh.3
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PDBzchCT1VJ0qqeiuiG3hlhy9llqUW7JMYhe/J6VYzI=;
 b=BXQcUQpreur7iaH9/+Leq10kzbgo1qG9vvM36NLtdgABARCEA+so1qlSJrZrmjrmHs
 l+1XYB90SfmiNswoOv6dtYF/oWdNye++AGQy72LYeCfo4Q3tyyfJNem1wQeF5DRk/inO
 4odPfGvlUbWxsapYVM6J+vwdus22iDQvIChNPUS6hWXNeK2pUa8D5L56o2jJARUVNr8k
 eJ+LInHhuLAKEz0/mu8eBfPJ7unw06Sf5/X2gU6rL13PS/CI7W6Jv9OpOF0wu+OgucsO
 YsVIDQ5XK73CpIGfZDm5cCvacZA6O0C5Wy484ooEOHzbPRREG60pXjUGeHVLWRIT4R6c
 +Ijw==
X-Gm-Message-State: AOAM533+7treHW64hj8dYjHvMzKROHxrbpKfImO2U/9JyaxnKqzGx8HK
 +dpWoX3VYUKqw9NRp9H+PaMo8kc4
X-Google-Smtp-Source: ABdhPJxtuhSEh/cZdc8d+A/8ahc0fdMECMijxql25FraQFxTr2PICmL03MHq1ZuVVajs0rPwP3lMwQ==
X-Received: by 2002:a63:4956:: with SMTP id y22mr8657902pgk.380.1596742863125; 
 Thu, 06 Aug 2020 12:41:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id r7sm9346734pfl.186.2020.08.06.12.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 12:41:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Logan Gunthorpe <logang@deltatee.com>, Keith Busch <kbusch@kernel.org>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
 <BYAPR04MB49659642F181754E06FF02DC86480@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d09e3ca6-4589-25a2-6b54-10a3b076ccfe@grimberg.me>
Date: Thu, 6 Aug 2020 12:41:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49659642F181754E06FF02DC86480@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_154105_346207_656FD638 
X-CRM114-Status: GOOD (  16.96  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> I don't think this is quite accurate either. It looks to me like it's
>> just a bug in the error path logic. If the namespace is invalid, it
>> doesn't even try to allocate the request so it should really just order
>> the cleanup correctly and skip it, if it's not allocated.
>>
>> I think a fix like this would be cleaner:
>>
> 
> Christoph, Sagi how guys would like to have this fix?
> 
> I personally like to avoid introducing new labels unless they are
> extremely necessary.

I think that having an explicit and reverse-ordered target error labels
are always better.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
