Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700B1C47089
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eCl84GOz4Hd8e+qSv4i37vYZIdnSB4zDksU7GjzxAXA=; b=mYM43LxDhRthf5me/ceaEzxEwV
	0jysd1tkZICvBjtPLxtjv6cwljfKzc71HBUk3QoOFRTN8to++Tp+48qea6cbDTxxhpAbGB8KMxnzX
	gMpiEYnHBBenKxZxMiQt/W2B966gaSVSSsCgP2prSTdaRVXSBpItGQB0avcVBsGNkC3pWOUmKu6iT
	04irwXCDWYz2rwsPi1VQISFIsLg9AMOmzTWe+AmkLKwvp0t/5jgs/i6bUhP1kqredPKT5sM45cbVl
	2e+k8Pq3VH2eMupIbkr0LE+ZEb/CfIEqXUKtwo8b5KDAKJ9G6Llg1pY0CRt3SgBDdBxGH9kkf3Wmw
	aqf9HDug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p28Fv-00074p-GC; Mon, 05 Dec 2022 09:59:23 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p28Fr-00070p-Fc
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 09:59:20 +0000
Received: by mail-wm1-f44.google.com with SMTP id i131-20020a1c3b89000000b003d1cb516ce0so1931405wma.4
        for <linux-nvme@lists.infradead.org>; Mon, 05 Dec 2022 01:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCl84GOz4Hd8e+qSv4i37vYZIdnSB4zDksU7GjzxAXA=;
        b=cNA7hiv02wk2v1mal2Rzes4EmnaSoadKJgVeXKPGOIWETMNugCh3LcVKteugB0pr4p
         h3YW0WJDPZvuXglB64UDpKRa80YzFxaQ4EEMXUvIVJIjm7iAa0vu1DojhJcDyceW9/4Y
         YreqtG3r2FqJe9Ggqd/cip+e4LU/D5eVn4HM8byNieSPVTTx7nJi4Z4+hFnFgSkyAkyh
         B0zQyeFt21sKoPSMnNbmAUwz2OdtUe34juUdE0bL4dSdtsJFfRmZnkYZG8SOV3SILTjw
         7g64qF66YFCdTNn4RmvrdQ5NA0ZYgnWYQoyhPNPV2q2otj6dxj/zbJbDC0ro1fg2t1Wp
         Lc2Q==
X-Gm-Message-State: ANoB5pk8m4QKEUoKIIj4YNBnVhZQKJdYt/NYWHFXsT8vD+epveOU8DMY
	R3Oh/QqhlV/5zXXEza+XIJWHtdvJU7E=
X-Google-Smtp-Source: AA0mqf7sUvVbADU6ObvsYUkfA8KVnAirZHzKFCysolagEElo7TmslB+mzhcJ5l9vj4ZpwmaA4DD20w==
X-Received: by 2002:a05:600c:4f45:b0:3cf:9be3:8d26 with SMTP id m5-20020a05600c4f4500b003cf9be38d26mr52213941wmq.185.1670234355684;
        Mon, 05 Dec 2022 01:59:15 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c2cb000b003c6bbe910fdsm26135588wmc.9.2022.12.05.01.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 01:59:14 -0800 (PST)
Message-ID: <9021ae71-646f-8183-7772-7dae38a60d47@grimberg.me>
Date: Mon, 5 Dec 2022 11:59:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Grupi, Elad" <Elad.Grupi@dell.com>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
 <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
 <4effaa95-0357-7d65-1701-8ec67ce7cc11@grimberg.me>
 <CO1PR19MB4885EB9E323178E235681F9EEE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <8e6fb5af-2992-dfe2-10dd-383c2c058f8b@grimberg.me>
 <CO1PR19MB4885EADF8C1E970867C71487EE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <a6fbc43b-7f7f-91f6-a157-186f2663b734@grimberg.me>
 <CO1PR19MB488579DCD958B74B2C8E38AEEE199@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CO1PR19MB488579DCD958B74B2C8E38AEEE199@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_015919_569375_9E7540D9 
X-CRM114-Status: GOOD (  14.87  )
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


> Hi Sagi, thank you for your inputs
> 
> It seems to me that logging nvme command id is sufficient and there is no need to log also tag and genctr separately
> This is due to the fact that command id is constructed as such:
> 
> | xxxx | xxxxxxxxxxxx |
>    gen    request tag
> 
> What do you think?

Yes, that is fine I guess.

> Regarding the io timeout value, I got your point..
> logging the io timeout threshold (which is the delta from allocation to submission) is sufficient
> 
> regarding nvme-tcp trace points -  I don’t believe that would help.
> This timeout log is on the host side, and we can't ensure that a customer that is running nvme host will enable/use trace points
> In addition, the whole point of this specific log is for debug, I guess - right?

To some extent.

> 
> How does this log look?
> kernel: nvme nvme0: queue 4: cntlid 1 type 4 cid 4163 opcode 0x2 io timeout threshold 30000ms
> (Including the cntlid, cid (which includes genctr+tag), opc, and timeout threshold value in ms)

Both the cntlid and the io timeout are obtainable via sysfs, why add
these to the log? The cntlid is often just an ephemeral value assigned
by the controller.

opcode is fine to add.

