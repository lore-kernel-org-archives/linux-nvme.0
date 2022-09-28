Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E005C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lRxYs2MZcafibIh6Hp6iB7Wb9noIHDpjKPwzlk2u42c=; b=FO5hB72VtjwOlmvUbbWuO01PSc
	DBDC6WxiL4nnS/IfdhA+nCWJhzbnzMMEcTWdpL39NXedLqD7D2XT8UTTMHJdskNkms4DfHibirtKG
	mqRASKcAkjOl8rzlGQpyraN+DwfWCJN8h6Qi8lcz499Ajz7OfVFNXrXaNEGyE4cPiQcE8qP938yAD
	79/kODGrATwmcI0H58+8Smrer8I5ZWswzR3kTSSoc5Od73rZe/S8vRAk/OpsPstRBE09sYQi7ZQQr
	q2dgVPvEeqNwK/Zf7clIW9eJODmjo32/tRGgTVzfKynBMmi1W0ya3nUyGnhKf/K93zTIkCIO3nXhE
	3mCwTmow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXxy-00GfA3-Ob; Wed, 28 Sep 2022 14:23:14 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXxv-00Gf8S-LW
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 14:23:13 +0000
Received: by mail-wr1-f45.google.com with SMTP id r6so2769097wru.8
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 07:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lRxYs2MZcafibIh6Hp6iB7Wb9noIHDpjKPwzlk2u42c=;
        b=uhNy80dQlr0wGKa8MJf2tcnKBq/Np1gHewBmPeqAUxWwADMJ07CaY6rihwvLX2jokB
         GJjEEhFfvylll76gqPKMyq86LrAmUpuEgQPJQsrwEcWQlkYQQzpXSa4dMj7JW6fmoscc
         aeqJHTX6mLR+9J/fkzqFeZA8Oqwp8FvpTT/ZNR5Ku/mF82FlOarodJ0RFaa4y2BHAmnG
         76A7/DTGp9fyzihAk78Mn/AX78ifszJaNHHsJqfWXCbuaIBW6fEM2TLZwNbKEd2iHd8O
         Q7xGXMqdtfR0YGyvBtfidSaW6r4+GI8e2F9gsBSH0XMPtn477ufNwm2ksWjUhqoy2mhZ
         R0gA==
X-Gm-Message-State: ACrzQf2+dMst365T4DJqVE/OBEndtOcPmaJEI9t0i90krjEieA4KSm9f
	EtvKp3UZP70TIFZLv6fcZZ4=
X-Google-Smtp-Source: AMsMyM5cicggTxoIE+jstc5OBBdVRVqQqEj/j6GZOysnF/GLpVtcbWjO6OhFyd+3F8nQZwm2lGw9Hw==
X-Received: by 2002:a5d:49ca:0:b0:22c:bc93:a9b6 with SMTP id t10-20020a5d49ca000000b0022cbc93a9b6mr6288843wrs.10.1664374988998;
        Wed, 28 Sep 2022 07:23:08 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n43-20020a05600c502b00b003a83ca67f73sm2032052wmr.3.2022.09.28.07.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:23:08 -0700 (PDT)
Message-ID: <b121c092-cecc-b891-be3c-b32c2a3e611d@grimberg.me>
Date: Wed, 28 Sep 2022 17:23:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>,
 "Knight, Frederick" <Frederick.Knight@netapp.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "hare@suse.de" <hare@suse.de>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <20220928135053.s6h6xr3llhp6riwr@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220928135053.s6h6xr3llhp6riwr@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_072311_739368_65F619E0 
X-CRM114-Status: GOOD (  32.64  )
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


>> Would this be a case for a new AEN - controller configuration changed?
>> I'm also wondering exactly what changed in the controller?  It can't
>> be the "Number of Queues" feature (that can't change - The controller
>> shall not change the value allocated between resets.).  Is it the MQES
>> field in the CAP property that changes (queue size)?
>>
>> We already have change reporting for: Namespace attribute, Predictable
>> Latency, LBA status, EG aggregate, Zone descriptor, Discovery Log,
>> Reservations. We've questioned whether we need a Controller Attribute
>> Changed.
>>
>> Would this be a case for an exception?  Does the DNR bit apply only to
>> commands sent on queues that already exist (i.e., NOT the connect
>> command since that command is actually creating the queue)?  FWIW - I
>> don't like exceptions.
>>
>> Can you elaborate on exactly what is changing?
> 
> The background story is, that we have a setup with two targets (*) and
> the host is connected two both of them (HA setup). Both server run the
> same software version. The host is told via Number of Queues (Feature
> Identifier 07h) how many queues are supported (N queues).
> 
> Now, a software upgrade is started which takes first one server offline,
> updates it and brings it online again. Then the same process with the
> second server.
> 
> In the meantime the host tries to reconnect. Eventually, the reconnect
> is successful but the Number of Queues (Feature Identifier 07h) has
> changed to a smaller value, e.g N-2 queues.
> 
> My test case here is trying to replicated this scenario but just with
> one target. Hence the problem how to notify the host that it should
> reconnect. As you mentioned this is not to supposed to change as long a
> connection is established.
> 
> My understanding is that the current nvme target implementation in Linux
> doesn't really support this HA setup scenario hence my attempt to get it
> flying with one target. The DNR bit comes into play because I was toying
> with removing the subsystem from the port, changing the number of queues
> and re-adding the subsystem to the port.
> 
> This resulted in any request posted from the host seeing the DNR
> bit. The second attempt here was to delete the controller to force a
> reconnect. I agree it's also not really the right thing to do.
> 
> As far I can tell, what's is missing from a testing point of view is the
> ability to fail requests without the DNR bit set or the ability to tell
> the host to reconnect. Obviously, an AEN would be nice for this but I
> don't know if this is reason enough to extend the spec.

Looking into the code, its the connect that fails on invalid parameter
with a DNR, because the host is attempting to connect to a subsystems
that does not exist on the port (because it was taken offline for
maintenance reasons).

So I guess it is valid to allow queue change without removing it from
the port, but that does not change the fundamental question on DNR.
If the host sees a DNR error on connect, my interpretation is that the
host should not retry the connect command itself, but it shouldn't imply
anything on tearing down the controller and giving up on it completely,
forever.

