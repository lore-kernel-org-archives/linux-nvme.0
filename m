Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4B1C433EA
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 23:28:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB5721702
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 23:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SqSyN8xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB5721702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LWRt8hI28NEQowaCkKO0pbncJExigeTwLBkwFOpmijA=; b=SqSyN8xwErVAzToVK5t68zMVh
	AM+U8dWLHGlr1r3lU/E2IsAWCIRpQFjYLtq9bjG8SIzmOLTNO6yjc9VE0Y7q/l9XzZ3iTvT+lnsmt
	OD0JKAhajuGQAgSugWv9XbhI8CJwqEvw19Ikpv0WoUNVKiaMZIFMY3BLxriGIL38wYL4PK3q8P1bi
	FCW1XafwFxXCx7AMB7u4DMoDHlo/9Q2EhQSNT9qZp+GMyK1Ld6BiGK1o0FtgZmA7/uDYq+F+BnDui
	J3d+8NNdWhiV+SYYIKbdshSDam/J4oNqiUB++6P0KG7JZgtST651WW3zzr6yY2Wy5i1/t+6a6LnBI
	5/I2ztCMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxfCy-0002Rm-3Y; Mon, 20 Jul 2020 23:28:32 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxfCv-0002Qa-6Q
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 23:28:30 +0000
Received: by mail-pl1-f195.google.com with SMTP id t6so9416635plo.3
 for <linux-nvme@lists.infradead.org>; Mon, 20 Jul 2020 16:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sIfyFvfqHZ+qa2NLs8qwPqjhpDOmDh/lGN1827apR70=;
 b=pEwfJUdipBM01HVHz8tEQp6bOjQ36zTdlIP+gSB5T6p0sk344KEwIr7MfipGBb2Rp4
 M5UBfEDY1UinVydDG75sUHZZbYLjm6VQKezw/hsLK8krfRSkd6Jvh0TVYuMAx4yyxdTg
 NkfATHOXRa3Fs9MsrxNs6CWm5de/17menNVR1DXyOun2n+REUVgi7dqFjtQyD5e6enQF
 YSb90ROi2BAU/sy+0JVBoAXkYAiHt9HVEqDBELo006L/hxnBmoR6UpKOWt1JHPWjC8E8
 LL9/WEC8SBXF7HwkXNNV0Vpa+p45ZfwAl3TgbabytPoK+jAWfSZ77uxN7Ld0kh9FDGF3
 fNww==
X-Gm-Message-State: AOAM532USkwge+apFJu0dDB0goVkoYV+kyiAn0Fo8gthcrkJEC6nKjSS
 MiRXwwiyc99hs2c5RgGFHHU=
X-Google-Smtp-Source: ABdhPJxkUk+ewAsf2iX7NQ1DfinhMORAq1Wmdh2HMcvooKPGLXvtlkxgsRlW/i8v2MuCEUkJhRG2ig==
X-Received: by 2002:a17:90b:390e:: with SMTP id
 ob14mr1533589pjb.221.1595287708205; 
 Mon, 20 Jul 2020 16:28:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef?
 ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
 by smtp.gmail.com with ESMTPSA id o129sm18689520pfg.14.2020.07.20.16.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 16:28:27 -0700 (PDT)
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
To: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
 <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
 <20200720231701.GA682160@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d7596065-f33b-5533-7254-153b82e6b88b@grimberg.me>
Date: Mon, 20 Jul 2020 16:28:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720231701.GA682160@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_192829_275390_659334F5 
X-CRM114-Status: GOOD (  13.76  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 7/20/20 4:17 PM, Keith Busch wrote:
> On Mon, Jul 20, 2020 at 05:01:19PM -0600, Logan Gunthorpe wrote:
>> On 2020-07-20 4:35 p.m., Sagi Grimberg wrote:
>>
>>> passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
>>> means that the driver shouldn't need the ns at all. So if you have a
>>> dedicated request queue (mapped to the I/O tagset), you don't need the
>>> ns->queue and we can lose the ns lookup altogether.
> 
> We still need a request_queue to dispatch the command. I guess you could
> make a generic one for the controller that isn't tied to a namespace,
> but we lose the fair shared tag allocation.

What do you mean fair shared tag allocation?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
