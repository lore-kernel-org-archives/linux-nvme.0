Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9770C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 18:33:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F6B613C4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 18:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F6B613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XXfbMO7xTFUa8Z6NroFA4Qi7lHsY5bcdwdZgwsxtIt4=; b=crBVsM/BY5R0qJAZwJcz2/Aa0
	T76WApo0lHdcI7ZgBkeacoOzhFKScQgd45HkXjYK0TgRE+BgCwDNhbjalBdGjs0zz7iEEo8YlboVo
	dex59i6ts2sU7U9hpoD+ZM+S31JMtSIWi58IfJG0TqhHc+iBfFC235saPztabjnZXdqOw2ivdMAN+
	ylFzSLD7LRTOOlRsUp6o/Zck9N3kY6ZSblWV+LIfGZbNRRRUBECHRWg0B/Zx0F2oTVexyM9UjTahF
	nJC4SN1D4N0oJt2cQxUHXrKH/qzA+sfBH+5XqHIPRrct2mHwRhO6ZPPL9JBWUXJmGZq6sAlRpqRHF
	dvIg2Tz5w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leMKz-0022um-JT; Wed, 05 May 2021 18:33:33 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leMKw-0022uc-Hy
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 18:33:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=T4CQSfuCafXBH+1+C/+R71xfaIwIqoiril5T3MNkRLA=; b=M+EtZ3Nc9jw/6/1nz286W3/bnh
 jxZP+lkRbSehJy1gacv9lFMGR2JuUKw5aOvd8rJX5Hbff9iA0ECZkxnw/fiqBJTIzWKGVTBTHYiU0
 cFXNL1oRxWvgfVGSAPYx7GBY6tv874pYuSexyKqhv9AuZGSJxpLnQjrYl/02WA/2ZeqnUFyvnGzQa
 jwMJunYjUa6HgHm/Vns23p7h+Xu74x6xPYg8yx4VoGEZi1lq1LkncyDt/7DP6hjB3ILWOEkMdWUWi
 OUBPELZgSxS2I7ozYeqmB6i4igOdynTnmwPeMxDH0lAjh9A229jFQs0ThczO421YbobLapPe2ro5/
 qvMPOnag==;
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leMKs-0059K4-8C
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 18:33:27 +0000
Received: by mail-pj1-x102b.google.com with SMTP id
 fa21-20020a17090af0d5b0290157eb6b590fso1349046pjb.5
 for <linux-nvme@lists.infradead.org>; Wed, 05 May 2021 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T4CQSfuCafXBH+1+C/+R71xfaIwIqoiril5T3MNkRLA=;
 b=ARYsT5II8wC+29fQfB1PoR7kT7Qaz+XkejNccFI+qr83xCq3FsaWzw/VLBRnhYyyp4
 8nwaqIPbtRbZoPkYL2DNRrd5TieYsgAyfj7pAh9qm2HBwv+xtANbPOvE9I24fUSfIrDS
 AXfnYOkkxmGJofT8Mdi2xRA6CjY1YJkYvjquFAqjulBgsRx7QMszKDHjCmxzJMsvFHhR
 AvDGRaSSUJNXeoPWdAx+7x1v0GA+gFRDSTJ4ZijfkGnifzObe/I19AiGOCqJSB1mZp3i
 A1SpOziXbuzeTIMkEJOPan+5U+d56zXrfCxhdjEFuzGiZeIvp00kH5dYg+s2goIvIL2v
 YJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T4CQSfuCafXBH+1+C/+R71xfaIwIqoiril5T3MNkRLA=;
 b=dlSVLIrSHchkJdqOglM00Pl8LK+K65ym3EKb6BkBB8R+CtCwWzok2YWdOg6JYySQdv
 6R8vfTrX5s7Ozd6JyCzkyyFw0oI5NUIT0yK4wBd/9Z7ha/0jybSyVQAAU//Hr1hM4JSN
 N+QdL8U2XNkI7mOsWHBI5GyyweyinKtpP4ewsAr9UfGnEXz4O/tYhBnZZJ/4yBXdOp01
 gnSooXydDoTLkDhODg38JP0kF1lUI6WhJ3KE2aBhY6iiGkso1F8gXm4L3f501jyxDFei
 8ofAhgtuD1rZheoP7uadEGxap/5SbpchKhrqSz06+bsYt6n0PsKvf53wxGd7pyiIgJrU
 srLw==
X-Gm-Message-State: AOAM532xQq6nRHB8kXxb8wzjgUlu1Nel5VZvC0xw8vYDtRkUnekBJKYY
 9rb4zssa9KmIHqtX3Zrm2ky9jeGE4Mw=
X-Google-Smtp-Source: ABdhPJyb/lrTsU19US1lwp4oSjTSsaqzMzBogQs4GCFeunJKxCPVV4/+X16KG8/uU8LZMci161xBMQ==
X-Received: by 2002:a17:90a:fe04:: with SMTP id
 ck4mr35686639pjb.10.1620239604612; 
 Wed, 05 May 2021 11:33:24 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a7sm8549874pjm.0.2021.05.05.11.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 May 2021 11:33:24 -0700 (PDT)
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
 <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
 <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <577d471c-1564-4291-919d-f448a73e56ab@gmail.com>
Date: Wed, 5 May 2021 11:33:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_113326_324361_E127159D 
X-CRM114-Status: GOOD (  23.32  )
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

On 5/5/2021 7:31 AM, Belanger, Martin wrote:
...
>>>
>>> Given that this was the original intent for host_traddr, why not have
>>> host_traddr resolve the iface from the address and set sockopt
>>> SO_BINDTODEVICE on it?
>>>
>> That was my question, too.
>>
>> I would vastly prefer to not have another option to deal with (as it raises the
>> question whether to add it eg during 'nvme connect-all') And one could
>> argue that this was the intention of _having_ the host_traddr argument in
>> the first place ...
>>
>> Cheers,
>>
>> Hannes
> 
> Hi Sagi and Hannes,
> 
> Correct me if I'm wrong, but it sounds like host_traddr was primarily added for FC (at least it wasn't tested for TCP since it does not work in its current state). I'm not an expert on FC and maybe specifying an address is the right (and only) way to specify and interface for FC. For TCP, however, it's not advisable. Specifying an interface by its associated IP address is less intuitive than specifying the actual interface name and, in some cases, it simply won't work. That's because the association between interfaces and IP addresses is not predictable. IP addresses can be changed or can change by themselves over time (e.g. DHCP). 

HOST_TRADDR exists only in linux and has no strict definition other than 
what we define for it. I fully expect its value, just like TRADDR, will 
be transport specific.

For FC, we didn't want to use names based on driver instances, or on FC 
link addresses, so we chose WWNs that were specific to a FC port to 
identify it. The transport has the mechanisms to map the WWNs to a 
nvme-supporting FC host port.

Define whatever is necessary for rdma or TCP and what they put into 
HOST_TRADDR.

...
> 
> In conclusion, I believe that for TCP we need 2 options. One that can be used to specify an interface. And one that can be used to set the source address. And users should be allowed to use one or the other, or both, or none. Of course, the documentation for host_traddr will need some clarification. It should state that when used for TCP connection, this option only sets the source address. And the documentation for host_iface should say that this option only applies to TCP connections.

I don't like seeing 2 options. I'd rather you stuck with a single option 
and added formatting to the option so you could specify one or the other 
or both (or none by not specifying the option).

-- james

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
