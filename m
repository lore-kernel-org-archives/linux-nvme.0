Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0F8C3DA63
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8qpXauxaGNLkA5MijO5Aei/g7Qc/NpkP5e9CiDtWQFE=; b=WV2Qrf9fNeIZ01W3JSCX6qMSdv
	HOTtV72sRecPyyYnwiAVpXRZHJG5AUxWv+o/I4T88Sn8I0c7mph9RLBJ2vzZyYFpJAT5TvpCW8jsO
	BapG1F9mBGAooP4rGu2rKs2AVSGNI+wOmkK6Qmv8i6vPA1Itvb7PiSEgSACZr8Hn97BY4K/GFLg3J
	BQy0Jj93bsuuz8BQ8FC0QQUmF4+bL095h5KzNxYBHNdxyBK/sePxWFVDVzCZvItNJ0k89HXOSVb+W
	CxXMpe/PU+ZaZ1fsRxZKLaHpmBvK2Tmwa52L91tKUvQDDD0dQNl6aqSIR0SdMaUd1P77YkixSYR6G
	JIzzSIgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWK55-0000000DDHF-3cx4;
	Tue, 23 Jul 2024 18:17:47 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWK52-0000000DDFd-050W
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 18:17:45 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-427b9fca517so6276285e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 23 Jul 2024 11:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721758662; x=1722363462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qpXauxaGNLkA5MijO5Aei/g7Qc/NpkP5e9CiDtWQFE=;
        b=uGSPXw5dcvsUKp3vhVP2CeVQA7tUyxaGEeF30QgIqguFFATBAbKWzXLPCLt2ec2MDO
         mBB8L1Skjbd76BSAVRg3dUlQ9o/eGHB+Y7vbAl2TytzIQXcpEqCdmdCm4KViJPIpRria
         dU4mO/ys8aLaUEUb1BEuiAMkK/727R6fvxD3g7+1TVICfnvbaMoo12J9dO5BKx0V7sXv
         nUqX+lrHvYIDR1r57HLU16q+egTWOZ6YBmDhSq5qhOnk6OK8qZcojalOeaZkuh14FoeP
         aZHBN0bpPUVH3oB1bXauDVvrqimul6vETetqD/n1TCl+0kOKLAUIXCAJWI30Mcmfd+u4
         1jvA==
X-Forwarded-Encrypted: i=1; AJvYcCXADbRujZzxwCoAb4lgKbsd1BXe5tARGvD4EG3TRdVl2feR2Z6SGYoyCFMfJ81hjKaMX9/2tqrvomlQeF8adLyUmdrxrJ6EwcEnTUKgUY0=
X-Gm-Message-State: AOJu0YzJm6YEkBXzLAr+ebDbZ/Vh4CtVN/7BJq5aG5FwJGNIbUBV1Va5
	cBovOjcHWIE0n67PNQaQqCKsYbQ6jHvNAhei00LzIkFhl7GsRdTQ
X-Google-Smtp-Source: AGHT+IGPiJsFh71fEIBnBFmx5ZOSsTLO/N8/C77235sDJvGnL6lelAp5xz8OLMscydHa9q3BBKe44A==
X-Received: by 2002:a05:600c:3542:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-427daa683eamr52185315e9.4.1721758661986;
        Tue, 23 Jul 2024 11:17:41 -0700 (PDT)
Received: from [192.168.68.149] ([70.90.172.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a721b7sm206339395e9.27.2024.07.23.11.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 11:17:40 -0700 (PDT)
Message-ID: <74ec44d6-4cf0-48e5-bfb6-3477d361004e@grimberg.me>
Date: Tue, 23 Jul 2024 11:17:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] nvme: split off TLS sysfs attributes into a separate
 group
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240722120226.88737-1-hare@kernel.org>
 <20240722120226.88737-6-hare@kernel.org> <20240723144905.GC20994@lst.de>
 <210a37b2-cc26-43ee-99f3-19dee796e677@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <210a37b2-cc26-43ee-99f3-19dee796e677@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_111744_087879_131397CE 
X-CRM114-Status: GOOD (  14.17  )
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

>> I would have also kinda expected that this attribute group lives in
>> tcp.c, is there a good reason to keep it in the core code?
>>
> I knew this argument would be coming.
> Thing is: these options depend on CONFIG_NVME_TCP_TLS, so
> they will always be encapsulated in some #ifdef, be it in sysfs.c
> or in tcp.c.
>
> And as we always will have to have an #ifdef in one of the files
> I thought it easier to keep it in sysfs.c, and save us having to
> have an exported attribute_group which might even be empty.
>
> But if you insist ...

I think that tls awareness has already leaked to core code (for good 
reasons I think),
so at this point I'm fine either way....

