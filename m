Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B9DC433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:21:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E90221E5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L/4fqlOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E90221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gy8kVOCr+cQ7zk3dwh5tlcns1TeuBXCsqIUvafy1QZk=; b=L/4fqlOiibuqwjJc9Xg9fKyI9
	n9EfLcFtiY+S/IomU67y0KwjgjSNCl+oNInyuUJi+sG2z92+VvATUTR27uCgijjv2MJOcMFtykx0x
	+uZ+yzYi2UJ0ZcJyyrMHux/w/gjKqw6Xgc8ENoocU2oShPceqD8CA92S8BOmyLgNFWxPs8zy2hmM1
	nMZ8IFH23lnh0MLwdR0BmPMW/9GJ/e4nLKu0UhDKCS+j4NXlq0Zr+8uBhv9S/BctYcvze7+tUQw6V
	kNrqokNnSmloPSurwb8kwDYDvgHDq37y+fjO7ZXaR7EYwcA/lV699c8cIIJwzormhBl0h5YGe/XLU
	MVMZ8YO6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k463H-0001Il-IL; Fri, 07 Aug 2020 17:21:07 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k463F-0001IA-4V
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 17:21:05 +0000
Received: by mail-pg1-f195.google.com with SMTP id o13so1245045pgf.0
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 10:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BQI2EkcJh8fFvaX7MS/0gUqNIelTRPuoK+JO7BBcGSU=;
 b=eQq6MplDvPQZwy+phDe5A766AiXodvTg4L14EY1J/oG0qdrnh2sK4wuJPSdShVx22L
 yIfFKEPmMtOz9bYkveExgoOzEJZodXoDeY/ELmY5pxULcMs9i9JkJCQHqZqljG0TPQvE
 QnZa+LaaouicTwkGQUtNj76KY/zgzR3honfh2lJEHq3MjBYYlcbGAbPhl8H0nIZpoM7y
 mZs//Diuj1uMpGuFm66lSVHAW2gJw/Gbe6Y9C1vQRJFq/sjiDwNce379iFZ7nzGgDVxG
 xkg/fF46mqcfOv9Y29IoJ3fDpnP0eW0rTRWCkLfOT1KK/0e00gyL+sgvxpqPY+pt4l8g
 umEg==
X-Gm-Message-State: AOAM530AayHeyWXfsIythCJRuaIkChNe7MPgQkA8c1YZ+PXLG/nSnd41
 xfq0bEc6lKYFBYxrslWMRQM=
X-Google-Smtp-Source: ABdhPJz6cFtiHQztotSPH8HxyFZiudQaQ0ovLBrRlG/pQ0O38BBoNQ8J116IMfAN5ojDfP0VOBR0Og==
X-Received: by 2002:a63:9dcd:: with SMTP id
 i196mr12139102pgd.378.1596820864267; 
 Fri, 07 Aug 2020 10:21:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c?
 ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
 by smtp.gmail.com with ESMTPSA id a5sm13471705pfi.79.2020.08.07.10.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 10:21:03 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] tests/nvme: restrict tests to specific transports
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-5-sagi@grimberg.me>
 <BYAPR04MB4965E3767211F0CD3DF7CAF186490@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <abb2246d-9096-d491-5d00-5212e4e29769@grimberg.me>
Date: Fri, 7 Aug 2020 10:21:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E3767211F0CD3DF7CAF186490@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_132105_219168_47D7479A 
X-CRM114-Status: GOOD (  14.47  )
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


>> +_require_nvme_trtype_is_loop() {
>> +	if [[ "${nvme_trtype}" != "loop" ]]; then
>> +		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
>> +		return 1
>> +	fi
>> +	return 0
>> +}
>> +
>> +_require_nvme_trtype_not_pci() {
>> +	if [[ "${nvme_trtype}" == "pci" ]]; then
>> +		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
>> +		return 1
>> +	fi
>> +	return 0
>> +}
>> +
> how about instead of not_pci  if we can requires_nvme_trtype_fabrics ->
> returns true for loop/rdma/tcp etc ?
> 
> It is a same thing, just my preference to void not.

Fine with that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
