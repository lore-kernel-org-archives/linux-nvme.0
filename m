Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855E4C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jan 2022 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQmwdNINXozDaR2t5Az+hi+GUgRHY6I+xOJefRZROWw=; b=YBKVmt34+PYrr6PGZR/sh/Yi5r
	twoKoeyG7fsyWetODJ4njes0lUIK8Rq+/MMLKe8+9QnNedx8FODtN0XdbGXiZPopAUDCZGXl3ngMI
	eppLm8t93T9ZfjNr7hqf/fwMehJfdHU2SgKE+IQTqacqB23XY8HT7rtRXcjL0Brr9YXxWc+W1Gk8G
	vq2or2adKoonqxV6eO03dATVs1klzHsnGt0NyjbdMgYHsji/PrRQiYsOM09G0D+1Yw/b/qPJre4g2
	mUAWgvLJSk+YKsRba9aSedrn9txHhjKGDFVL5R0KfxTMiwc6P5FQjiTlxkFPNEzVN3jpqxf9UOuQB
	IGc80zbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEZB9-009m2j-M1; Mon, 31 Jan 2022 16:05:19 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEZB7-009m1j-0y
 for linux-nvme@lists.infradead.org; Mon, 31 Jan 2022 16:05:18 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 bg21-20020a05600c3c9500b0035283e7a012so4730421wmb.0
 for <linux-nvme@lists.infradead.org>; Mon, 31 Jan 2022 08:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jQmwdNINXozDaR2t5Az+hi+GUgRHY6I+xOJefRZROWw=;
 b=d+Yvx3q9Ftk204i+0iwgEzrYgmMbD2YstfHGEGXVEhMTPiU64j0f8Ny8XirXfmgLVC
 7bL2tg/qIpPfP/e2idrauEkvHGVIgu4TiZjNukfyV6cSES78zWOxjiS08SRpPEbwUda7
 wMxuagYPm0t2e9vjcOlGCTcIx/5p0+aq8hISGy5e/Q5DM57TByrjlcaAwum5D5HqHQKQ
 XfeICxxZHg5mna9aviDmBBNtoFOisZ/ZqK7EXeSeQOVmlkC0hTfh8fKH26h/jMZAG8Vl
 YChczmfqhk3ZeQz5FPcRafbKK4zCYYDn3rVntZdVud+JGhoOKV8sZ/aZ2ktIpEPCb1mS
 sUfQ==
X-Gm-Message-State: AOAM531xrGHpI8r6f1QS7H9XpB98SsAMBDKqxUs7WteTAOZlBLr66o+f
 S28xXIxhYG7xOV/KkmiGEUQ=
X-Google-Smtp-Source: ABdhPJxxP4hUUJtjwT3g2xPmLF8aOO4y8YpsEBHUqcpeS+0gFtx1tCPljcnTlwzFY2YJrzANMwvwnQ==
X-Received: by 2002:a1c:f719:: with SMTP id v25mr19553027wmh.76.1643645114757; 
 Mon, 31 Jan 2022 08:05:14 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id o2sm9883956wmq.21.2022.01.31.08.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jan 2022 08:05:14 -0800 (PST)
Message-ID: <9c5e4cff-2a5e-c1d2-34ed-ac7918c3991b@grimberg.me>
Date: Mon, 31 Jan 2022 18:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] nvme-fabrics: add tp8010 support
Content-Language: en-US
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
 <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <37587400-076b-059f-f163-fd90babde443@suse.de>
 <SJ0PR19MB45440F98F8693F571669C012F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8527332c-3126-1297-f161-f2cb818a3061@suse.de>
 <SJ0PR19MB4544DE97C58FDCDA5930985CF2239@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <e4c48b97-8f79-a373-96ea-13286632624b@suse.de>
 <13c327cf-8f04-e005-298f-0e43bb39b89e@grimberg.me>
 <SJ0PR19MB4544E634C5B347F231783B20F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SJ0PR19MB4544E634C5B347F231783B20F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220131_080517_091336_5E1BE132 
X-CRM114-Status: GOOD (  13.97  )
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


> Hi Sagi. Thanks for the code snippet. I just had a question about your comment.
> 
> You say that you don’t see any point to send an event on the disconnect
> because it is async.  I don’t quite understand that part. For example, I've
> observed that when connectivity is lost the kernel will try to connect every
> 10 sec. And it will keep trying to connect 60 times (i.e. 10 min) before
> giving up. Wouldn't sending an "offline" event when connectivity is lost
> give user space apps a heads up that the nvme device may not respond.

Why does userspace need it?

When the host will disconnect it will send event asynchronously, so
userspace cannot reliably do anything before the host disconnects.
Other than that I don't understand what would userspace do with
"offline - I/O is going to fail"...

