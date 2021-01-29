Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ECBC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 18:54:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1A364DE2
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 18:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1A364DE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DzUVPRfhWCzs0dBjNl3P3YRuOJAs8b3PtODH78/V/aE=; b=kKZAFWzT2MrOri+KggCs5v2i5
	xYptS4gGgzS3jjYKNKF3vfwq/H+HLBtGUdXA741G/W+7GiNtMH0ZFzZ9/lYEuJZg+Im7oXdhvKFxM
	LhqJYyPwPQX1aBKQu1y+N3mhcKdJ25+3Lm8cAVpLHELaa4VvDPxO7cS/VMV7UE7Q9o1C7Mc06lolu
	KueNotauMyKJDQ1StT53CHpGznp2eHQ6Dr7/pyi1e0J3H+uxK9VaIvY3tf4xCq5Zb4UBnhreebRpg
	D/ks9+jkPeqv7PyamYLrRzpcsd0zjAnfkPO7dkinmONqVO9MmGYTn3GACb/wOwRA5HznGYh1O6DQS
	clQ4ButdQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5YuK-0004mm-JS; Fri, 29 Jan 2021 18:54:12 +0000
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5YuH-0004lv-Iy
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 18:54:10 +0000
Received: by mail-pf1-f175.google.com with SMTP id q20so6798014pfu.8
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 10:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nRCwH1i0bS2bZFhC1/5kOL3grlN+Gx8hjfTznPaBZf4=;
 b=U4Rw0ilufu07wN1jcNYUEOimtJWNQUg+qnIRfB6A98nEdsg5e17052kyjiCgmQa2y/
 p4K1sbqLn4esnM3NRhuOr9eiohWObm3QrOuoZU0Gi9moeAEHAjiZFyfI2ovyL5PhH1gm
 5Sc6d7+g3iKeP7f1zRi97zpDyiSkaLKulfw1Olc9Xsdaj7c5gG595KfmNJqisnYJPinS
 DVBQ1VxrdtOcwY3TjHNRzOyjmUsQ36QwNF7rAvZEGEaJOrAWKNKC53hY3lYAlC52zC+r
 ENnu8mtxZCSUjq4YW6gOCvDJb/2ujwmtS+wrrni+YxwhGJaVxgsX8N6YflJX/KInPy6P
 seJw==
X-Gm-Message-State: AOAM532ckoTJQiyI3x4MEhyjwcIk5peSeKe9sQqVo0ywQ06b5Wvx9deS
 OdQznN7c54YbySvpKqFeQfs=
X-Google-Smtp-Source: ABdhPJzcneLTv8Dj12qouJj5/c2VnKWxLyrfrpCXLbbWIUFbeyblDp4jfJvn1kpQb993iDqzyvBpgw==
X-Received: by 2002:a63:f21:: with SMTP id e33mr6358857pgl.84.1611946445949;
 Fri, 29 Jan 2021 10:54:05 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id y186sm10125672pgd.61.2021.01.29.10.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 10:54:05 -0800 (PST)
Subject: Re: [PATCH 13/35] monitor: disable nvmf-autoconnect udev rules in
 autoconnect mode
To: Martin Wilck <mwilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-14-mwilck@suse.com>
 <8990bb65-fb2d-7ab1-82cd-210c4c4dba13@grimberg.me>
 <f6d3cc4105475207eab760d1d2e1c1693f3c3e16.camel@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c8f2138f-be9f-41b3-2fb9-083ed65927d7@grimberg.me>
Date: Fri, 29 Jan 2021 10:54:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f6d3cc4105475207eab760d1d2e1c1693f3c3e16.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_135409_639046_8185831D 
X-CRM114-Status: GOOD (  16.27  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> On 1/26/21 12:33 PM, mwilck@suse.com=A0wrote:
>>> From: Martin Wilck <mwilck@suse.com>
>>>
>>> If autoconnect is enabled, disable the respective udev rules
>>> by symlinking /run/udev/rules.d to /dev/null, in order to avoid
>>> the connections being set up by the monitor and the udev workers
>>> at the same time. This is probably the preferred mode of operation
>>> for the monitor.
>>>
>>> Users can override this by copying 70-nvmf-autoconnect.rules
>>> from /usr/lib/udev/rules.d to /etc/udev/rules.d (/etc/udev/rules.d
>>> takes precedence over /run/udev/rules.d).
>>>
>>> If the symlink can't be created for some reason, autoconnect will
>>> be disabled. There is=A0 only one exception: If
>>> /run/udev/rules.d/70-nvmf-autoconnect.rules already points to
>>> /dev/null at startup, autoconnect can be left on, but the symlink
>>> isn't removed on exit.
>>
>> Can't we just document that just one should be enabled and skip
>> the entire thing? Especially when its not critical if both run..
> =

> It's not critical, but it makes no sense to have the rules enabled when
> the monitor runs. And having to mask/unmask them manually is a pain.
> =

> It could be done in the systemd service file using ExecStartPre /
> ExecStopPost, with small restrictions (we couldn't distinguish whether
> the rules were already masked before we started). That would be more
> transparent for users.

Maybe 'Conflicts' can help here?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
