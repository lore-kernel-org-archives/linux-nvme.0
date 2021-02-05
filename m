Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23FCC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 18:49:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7788864EE8
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 18:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7788864EE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CdOXr9zM/4QM8B6I/UQMDebmBRaTV8i7ds1KCjYDQOU=; b=AlEobPhlVXPIAm67UsuWsB4/B
	VSGL6gUP0rlIxDZlrvzunhd1vCHB8ec1LiKbaxXL0pSx/W3xjEthFqoNRMyaQDNHrLkjdGlv2SrDE
	PvAg8Q8oDGh22eT9G+o7K630snmJ9C/WJYu730hvXRdNH2AAqYQKOa7piPUpWOTKvyOfWUNVVulmW
	4I2Bqp2EE7EblRdUZtTGQjYnN2G7FhH2Ibfm8eRZCa3YrbMW/ELJJDjwBioYJyvpJ2Cm+w2LdFA4k
	OzLTw3nkigvDyAb5qgz5DxtawAyaDHBFmQy9PSMjgiC6meTlIkfaSY6BSlaLICht29ErY1RwI09Fx
	ZlCLSYH1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l86Al-0006On-FM; Fri, 05 Feb 2021 18:49:39 +0000
Received: from mail-pf1-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l86Aj-0006OO-9i
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 18:49:38 +0000
Received: by mail-pf1-f177.google.com with SMTP id j12so4910109pfj.12
 for <linux-nvme@lists.infradead.org>; Fri, 05 Feb 2021 10:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nyVbD93W7cT7vZxv4kJQsJmwkBH7gyw0vaWsO7sTIHY=;
 b=CGLrP0ofQNMNk67VYu9dWHkA0LSmJzSlGJwF7LYG5miZZNWhKd+pZLwYtoSKOZkX5K
 Z+2scSBpxmwy1QCKfOBUTcjiPmvpGb48VkGQJzv9rUunqTLkrqWDzG00C2okT5XexqIE
 Z5Qhe2ML4Nd3ZRsaYUDYuQdAGF76F/yNuoUmpqpeMwA1PsbJ8cTN75xWrzpZaSLDzdTu
 MvdJ7drYbpwjR6OwtcSIBg99UvUUd1wAWHJUy1ojh7KB7b6byqnHrOPifG2Q4ICrYpPo
 15DJ5Ir8tk3NSzCOVl5berZvW6CIhJ+MbL6DiVlJHjDiq5NElHq7yyoOZ+YJwOEjR2b2
 c64w==
X-Gm-Message-State: AOAM533sxkOJ/IrWSKWS62fHsS9eZw3rWARM138nZaKO901hQrnmGyJ8
 ixWsOQxr9nhqs/yBM+34qJ7sWdUMKoU=
X-Google-Smtp-Source: ABdhPJwTpVdHQrIo2A7uFpk71KKQjuPCiNFVX9AQZOlJkp7CTfL4dhFfzmZ+4tPHLCjggYMjC86/jA==
X-Received: by 2002:a65:624a:: with SMTP id q10mr5710534pgv.2.1612550975561;
 Fri, 05 Feb 2021 10:49:35 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e569:9026:928e:73dc?
 ([2601:647:4802:9070:e569:9026:928e:73dc])
 by smtp.gmail.com with ESMTPSA id 6sm8919731pjm.31.2021.02.05.10.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Feb 2021 10:49:34 -0800 (PST)
Subject: Re: nvme-tcp bricks my computer
From: Sagi Grimberg <sagi@grimberg.me>
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <42f94a06-cc66-87dd-3a92-de793a228d22@grimberg.me>
 <SJ0PR19MB4544B86790800C6371E7F96AF2B49@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ccb20293-efdf-ee96-d97f-405ced9b67a5@grimberg.me>
 <69e0073c-35cd-552d-eccd-2092ab49c38d@grimberg.me>
 <SJ0PR19MB4544A3DF2B1B2A1EEB8D1B41F2B39@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <43ca75a5-e751-6b9b-2a0d-336dbbc207a1@grimberg.me>
Message-ID: <2251aa94-0d6c-1405-b1d8-185bcd714d8c@grimberg.me>
Date: Fri, 5 Feb 2021 10:49:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <43ca75a5-e751-6b9b-2a0d-336dbbc207a1@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_134937_366209_9AC98EDF 
X-CRM114-Status: GOOD (  17.93  )
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Hi Sagi,
>>
>> I was able to capture a bit more info. Again, because my computer =

>> freezes (i.e. no keyboard or mouse response) I could only take a =

>> picture of the screen (attached). This does say NULL pointer dereference.
>>
>> To answer your questions:
>>
>> Q)=A0Does this happen if you directly connect to a normal nvme controlle=
r?
>> A) I still need to try this. All I know is that it doesn't happen when =

>> the controller returns=A0OAES[31]=3D0.
>>
>> Q)=A0What is your target implementation? Is this the nvme target thatis =

>> built into Linux?
>> A) I work for Dell, and I'm on the same team as Douglas Farley and =

>> Erik Smith, whom I believe you've had discussions with. Dell is =

>> currently developing a Central Discovery Controller (CDC). That's the =

>> target I've been testing with. I need to find different targets I can =

>> test with but working from home makes it a bit difficult. I will check =

>> with my team tomorrow to see if I can connect to a different target.
>>
>> Q)=A0Can you share your kernel config file?
>> Q) Can you run gdb on vmlinux and share what this provides?
>> A) I'll get that tomorrow (both questions).
> =

> For the record, I compiled Fedora 33 kernel and ran it on my VM
> and it doesn't happen. I also modified Linux nvme target to
> report the same limits as your target and still it doesn't happen.
> -- =

> [=A0 162.006049] nvme nvme0: Failed to read smart log (error 24577)
> [=A0 162.006060] nvme nvme0: queue_size 128 > ctrl sqsize 32, clamping do=
wn
> [=A0 162.006063] nvme nvme0: sqsize 32 > ctrl maxcmd 31, clamping down
> [=A0 162.006778] nvme nvme0: new ctrl: NQN =

> "nqn.2014-08.org.nvmexpress.discovery", addr 192.168.123.1:8009
> [=A0 162.008939] nvme nvme0: Removing ctrl: NQN =

> "nqn.2014-08.org.nvmexpress.discovery"
> -- =

> =

> So something here seems to be specific to your env.

Hey Martin, any updates with this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
