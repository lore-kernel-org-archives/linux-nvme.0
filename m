Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5473C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:33:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623B264E38
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623B264E38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2x/hZJXhsYTRqvCj2Myk3mxQ2/QBdITvQ4uVaeELeGk=; b=NtqjMTK4/9SFp3/Lb446sS6Nc
	0Gu9XgFHjWumF02Ov4FBOf5cUcSD/w7Ud5P+WjEnM4bKOoSjRZbSq/xvusgm7ybHjEg8kM8BqKK97
	AnRAtpfWe9EZ8Z3spl3Y7Eutp4GAntJC+rQe5MhT92oLWVr0UhJa7BQcWyTsmu7oENXpnEbHLd9aE
	XrH/UTgJeWix7heMpNMnI1V6YUWZMt4sS2JLGByX4tz7I9TNM+Cb4aOA0UtxdUjCHZPzxit3BZxmw
	vA+77dd4iFRjYnjAYbb/g6vtxe6ijQxEGfxeBBKvm3f0ZnXqlqodEZ58YDdUIb3J++lyULkzw/R+5
	/OO9AWmVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9y3O-0006gc-Ev; Wed, 10 Feb 2021 22:33:46 +0000
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9y3M-0006g6-20
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 22:33:45 +0000
Received: by mail-pl1-f178.google.com with SMTP id g3so2042683plp.2
 for <linux-nvme@lists.infradead.org>; Wed, 10 Feb 2021 14:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qIHKPh6Q9tIZRl/WLviMPCf9UoJuuNooXCtFmpPPjf0=;
 b=VCA14yKvxGsNI+9FMxmWMsBgAITlg/XcowutSXPvJfcZhRHIA9V5YcpqHS4ZuDY94E
 CgDRpXVQdaIwOLeZhAibuTweHd6pMTGy43AMNkfUJuEAOSnjNlEusaZDtVltI9sWc4tZ
 3dKsUQlhbOJk3DF8RTIKf11k3ghnoDbfUcJqhukGdaPPW3RloLqtu4lbTC738MBPWYXh
 bY8NU28KAFxsuLmLtR+r/qAsAzT3x0lsG7sNQ4Ptv5OXYR+Fpms9d2KnDzy5/6+GNVBF
 XuzPwCDzAAsJr+5PBk/nlNez/N+CGLloYV9H8i11odripkQ5hEs5YDxLEvsBTquMFzaH
 1R+w==
X-Gm-Message-State: AOAM532M6qH9EeW+cq4aZn9lv81ORpQE7vOiBaIkSMG3OD6ANbYFvFth
 AN9onUi/lmWX8WKY4XfbS3EnZ7AJozQ=
X-Google-Smtp-Source: ABdhPJwsh+IaxIsh0CiCMXE80N5Gc1EjA1wg7GQFS0dw1rx8UDSzvaAu7AoTpyV6WrlY3xw6WKvYLg==
X-Received: by 2002:a17:90a:fe89:: with SMTP id
 co9mr1069325pjb.83.1612996422178; 
 Wed, 10 Feb 2021 14:33:42 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:d52b:e830:d3b2:ec6f?
 ([2601:647:4802:9070:d52b:e830:d3b2:ec6f])
 by smtp.gmail.com with ESMTPSA id s23sm3345964pfc.211.2021.02.10.14.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Feb 2021 14:33:41 -0800 (PST)
Subject: Re: nvme-tcp bricks my computer
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <42f94a06-cc66-87dd-3a92-de793a228d22@grimberg.me>
 <SJ0PR19MB4544B86790800C6371E7F96AF2B49@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ccb20293-efdf-ee96-d97f-405ced9b67a5@grimberg.me>
 <69e0073c-35cd-552d-eccd-2092ab49c38d@grimberg.me>
 <SJ0PR19MB4544A3DF2B1B2A1EEB8D1B41F2B39@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <43ca75a5-e751-6b9b-2a0d-336dbbc207a1@grimberg.me>
 <2251aa94-0d6c-1405-b1d8-185bcd714d8c@grimberg.me>
 <SJ0PR19MB45442A0B8E171B55A8AACACEF2B29@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8937148e-f667-9a05-3828-58114dca6da3@grimberg.me>
 <SJ0PR19MB4544A653D3A84A19A28D3984F28E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1a430561-498c-70dd-f14b-8fab10673f65@grimberg.me>
Date: Wed, 10 Feb 2021 14:33:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB4544A653D3A84A19A28D3984F28E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_173344_120991_3BA149B7 
X-CRM114-Status: GOOD (  18.10  )
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


> Hi Sagi,
> =

> I was finally=A0able to get back to the crash issue.
> =

> Using Wireshark, I compared the PDUs from the nvmet to our home-brewed =

> Central Discovery Controller (CDC). I did not see any major differences =

> in the data itself. However, there is one significant difference in the =

> way that the nvmet and CDC indicate that a command has completed =

> successfully.
> =

> The NVMe-oF spec describes two ways that a Controller can indicate to =

> the Host that a command has completed successfully. One way is to send a =

> Response Capsule with the "status" set to 0. Another way is to set the =

> SUCCESS bit to 1 in the last C2HData PDU. This approach eliminates the =

> need for a Response Capsule PDU. Ref. NVMe-oF specs, section 7.4.5.2, =

> 5th paragraph.
> =

> The CDC sets the last C2HData's SUCCESS bit to 1 instead of sending a =

> Response Capsule. nvmet sets SUCCESS=3D0 and sends a separate Response =

> Capsule. Could this be the cause of the crash?

Don't think so, but did the host ask for this in the connect?
The host should explicitly ask for it when connecting. With nvme-cli
when connecting one should specify disable_sqflow (this optimization
is only possible if sq flow control is explicitly disabled).

In any event, even if the controller is misbehaving, it shouldn't crash
the host. I'll look into that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
