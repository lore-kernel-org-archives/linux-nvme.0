Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F573C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FLTeks8eELiIGcTY5wF4oXdJ+bPSmjNFBcw73Z/uIUE=; b=dyRRz0lL8JU+0COEte06qk2eWY
	y7qDNKxx4mZYzcNxMKgbMpdooRs2OqQFiI7Bb7d04g+LwXb9NJ9G9kF1NI5fa7n8WMr/WmfZOXZzb
	G1hlsKbkGf1r1W/h5Omz9tyb68kfLZ4BxABwxlgiphoNJxsbOMpFVyM4gPvOy3EqronKPAPHIHh1W
	R/p9dsBdfRCO4z6dgPoDAUsZJ76gsbe3Pr/bqJ7ZNiAQxs71ooHTmxMuDoeStrIJBOF1CbMg2knKV
	jbqN2C1Xg42bl38Rz3GlXkVTtbpDT58/SCksgCQaU39U1uvZbWBY4FSY1yynYPgZ1eQmeS3GpVvjN
	LjvAnm4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJAb-00FFca-2Q;
	Mon, 03 Apr 2023 12:20:21 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJAY-00FFbD-2d
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 12:20:20 +0000
Received: by mail-wm1-f49.google.com with SMTP id s13so16970579wmr.4
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 05:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680524416; x=1683116416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLTeks8eELiIGcTY5wF4oXdJ+bPSmjNFBcw73Z/uIUE=;
        b=Lh8NG1Ds7d15aaPUn0nXOM3JRbFBKCSO4A45HmWKn+chLrHB9o+jM/10D2ZD5QU8qX
         1mqkWDiaZrRdUWxsPbNx8EnMBjFl8PHmMCJxF/UN8RSPMzuNXpCmokqklox/bR4NdYKm
         IkqTnb/hqj5m13nkvJjJ5K58+U7cFbZXpzZBn6HjIJHChM2QA2QOyd0GmMfrBGvHtj+3
         UqQAUbKA9CbPGP1+r+eNpJd+zAJmqmC2CwO/YuAuqmW1wDlac+UKytR1vIpBiS0GSQqs
         KwNL1pRgyrpnV2mdOTUYBDvjPg5pZ542S/Pzb8qfjjJb17veQp1mH+C4FCn7q1jwZxrO
         kG0Q==
X-Gm-Message-State: AAQBX9dJsH1TMJ1ktY4I/dtCDCsjiR4WyP4IjeRPg9x1iQMihX2LhhTn
	aFNyyn92U1qu/YJhkhWS4PM=
X-Google-Smtp-Source: AKy350YxmO96TAvXra/msTOS7cA1FwhAgYJY37TVSY7/z3X8F/c5jraEpEwEAHhi8th5HWQB1BJOjA==
X-Received: by 2002:a05:600c:3b8a:b0:3f0:34cb:a542 with SMTP id n10-20020a05600c3b8a00b003f034cba542mr11934460wms.2.1680524415877;
        Mon, 03 Apr 2023 05:20:15 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y4-20020a056000108400b002cfec8b7f89sm9670709wrw.77.2023.04.03.05.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 05:20:15 -0700 (PDT)
Message-ID: <44fe87ba-e873-fa05-d294-d29d5e6dd4b5@grimberg.me>
Date: Mon, 3 Apr 2023 15:20:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/18] nvme-tcp: fixup send workflow for kTLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Boris Pismenny <borisp@nvidia.com>,
 john.fastabend@gmail.com, Paolo Abeni <pabeni@redhat.com>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-11-hare@suse.de>
 <634385cc-35af-eca0-edcb-1196a95d1dfa@grimberg.me>
 <20230330224920.3a47fec9@kernel.org>
 <7f057726-8777-2fd3-a207-b3cd96076cb9@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7f057726-8777-2fd3-a207-b3cd96076cb9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_052018_852316_66D47454 
X-CRM114-Status: GOOD (  16.63  )
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

Hey Jakub, Hannes.

>>>> kTLS does not support MSG_EOR flag for sendmsg(), and in general
>>>> is really picky about invalid MSG_XXX flags.
>>>
>>> CC'ing TLS folks.
>>>
>>> Can't tls simply ignore MSG_EOR instead of consumers having to be
>>> careful over it?
>>
>> I think we can support EOR, I don't see any fundamental problem there.

It would help at least one consumer (nvme-tcp) to not change its
behavior between tls and non-tls. At the very minimum don't fail
the send operation (just do the same as if it wasn't passed).

>>>> So ensure that the MSG_EOR flags is blanked out for TLS, and that
>>>> the MSG_SENDPAGE_LAST is only set if we actually do sendpage().
>>>
>>> You mean MSG_SENDPAGE_NOTLAST.
>>>
>>> It is also a bit annoying that a tls socket dictates different behavior
>>> than a normal socket.
>>>
>>> The current logic is rather simple:
>>> if more data comming:
>>>     flags = MSG_MORE | MSG_SENDPAGE_NOTLAST
>>> else:
>>>     flags = MSG_EOR
>>>
>>> Would like to keep it that way for tls as well. Can someone
>>> explain why this is a problem with tls?
>>
>> Some of the flags are call specific, others may be internal to the
>> networking stack (e.g. the DECRYPTED flag). Old protocols didn't do
>> any validation because people coded more haphazardly in the 90s.
>> This lack of validation is a major source of technical debt :(
> 
> A-ha. So what is the plan?
> Should the stack validate flags?
> And should the rules for validating be the same for all protocols?

MSG_SENDPAGE_NOTLAST is not an internal flag, I thought it was
essentially similar semantics to MSG_MORE but for sendpage. It'd
be great if this can be allowed in tls (again, at the very least
don't fail but continue as if it wasn't passed).

If this turns out to be a big project, I would prefer to change
nvme-tcp for now in order not to block nvme tls support (although it is
a hidden capability interface, which is always bad).

