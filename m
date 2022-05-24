Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01113C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ppX5dza8SxwT4aQOVxG88sRc5T+kwxaarBbdaDEV/Ck=; b=evMjaaLamUXr7+G5Xv88kPh/E/
	4ExTUgCWMNplif3NDlMVv5NbvLVfu63kTTHk53XB6UQskYMxTf2wdTUlgsbco67wliBc6p1AMNvpX
	MgRMPgrt5pSyqp/VMpl8F3ngDvs1/NjGSU/6Q5t/zAckRjuS1fLwQRC8jjGs1uQZBzow3TkDymtB7
	GanK8n46RbfdbtG9HwZuHtGaHaepc6HvgxaMV2vXA7le5OF43A3dv5Z6eEJ7iUY7Tw9oaeb2ux1WQ
	RDytrv5eZJvH97ne1CdFxL2w5cxB2YaUKhYIc6RgAuHkhJ4iaE4bTel/6UFuHt1FHF92yepmpMemD
	6m1uVHlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntUtw-008AH8-OB; Tue, 24 May 2022 13:48:44 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntUtt-008ACx-SV
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 13:48:43 +0000
Received: by mail-wr1-f44.google.com with SMTP id u3so25824971wrg.3
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 06:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ppX5dza8SxwT4aQOVxG88sRc5T+kwxaarBbdaDEV/Ck=;
 b=WQsL0TVkoBMkaJRYnjVdvDTeN65u8nc3uD3bQLvfW3gHTdcC4AWVlU3p7qIkZCK5n7
 +klcZ7lOUWSJZanG/szKdj6NSjKPav+doJZpeH+M4dw/wsDups0smp9ub93kbY50aAWF
 OE1+NA3qqdyqswz4h4QD45VsiinEJ8mSwuFGtNYRNz2n7W72c3NQDi84bn8GUFJz8XDy
 N1YVnA0APccUsR9pBQ//XAPZJ1L4YdF0oQELPLdvY/yFHHCZOUeBIaXqj87gMJHYNsfU
 DvHiFs9jAL8NVjLeD6SoadW8j4yw76A1KcieKkyzBoLKYu30D6UFGgUX9QVVtJ42CFO6
 vAPQ==
X-Gm-Message-State: AOAM531eHGcld9nOWFF73GxzSsjudCxaW3KuEsau5/r1KzG7NynB75tU
 65TuEeW7OBDFTvAHQMO/L46iHgFDwZ0=
X-Google-Smtp-Source: ABdhPJw4auQq0nnx5MDmTRxqm/Jdtk+ACuhMnIRnIOdfN6gONULwvpOVPngGrqBaQaLXTBrnCkG8yw==
X-Received: by 2002:a5d:64c5:0:b0:20f:f372:13fd with SMTP id
 f5-20020a5d64c5000000b0020ff37213fdmr2230078wri.302.1653400108839; 
 Tue, 24 May 2022 06:48:28 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 e7-20020adfa447000000b0020fecaecb0fsm3062868wra.50.2022.05.24.06.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 May 2022 06:48:28 -0700 (PDT)
Message-ID: <f1143d78-107a-bef0-626d-df71ca431584@grimberg.me>
Date: Tue, 24 May 2022 16:48:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC] nvme-rdma: Stop queues when starting with error recovery
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20220523152102.41000-1-dwagner@suse.de>
 <c3e5bad8-8cca-8058-38d7-0eea2ddfd6bc@grimberg.me>
 <95e18f3a-7997-ccbe-7889-18585bb72ff3@grimberg.me>
 <20220524133803.3f6dql3waflypl5q@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220524133803.3f6dql3waflypl5q@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_064841_972211_1C43CC74 
X-CRM114-Status: GOOD (  15.90  )
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


>>>> When we enter error recovery we should stop all queue activities and
>>>> all armed timers.
>>>>
>>>> For example, we could arming an ANATT timer right before we enter
>>>> error recovery but do not successfully recover before the timer
>>>> fires. The timer is supposed only be active when the controller is in
>>>> LIVE state hence we should call nvme_stop_ctrl when starting with the
>>>> recover activites.
>>>
>>> This takes me back... IIRC the main reason why the error recovery
>>> handler in nvme-rdma (and nvme-tcp) does not start with nvme_stop_ctrl()
>>> is because back then, nvme_stop_ctrl() could block until an
>>> admin_timeout expired on an inflight admin command (I have a vague
>>> memory that if cancelled/flushed the scan_work), which delayed I/O
>>> failover, hence we just cherry-picked what needed to be stopped to make
>>> sure I/O failover will not be blocked by anything and progress quickly.
>>>
>>> If I look at nvme_stop_queue
>>
>> nvme_stop_ctrl obviously...
>>
>>   it does not touch the scan_work, but it
>>> does flush ana_work which includes I/O, so it can still block on it
>>> to fail after admin_timeout expires... also flush failfast_work is
>>> taking the namespaces_rwsem (although read access). The fw_act_work
>>> is probably meaningless for fabrics...
>>>
>>> Maybe we need to have something like nvme_stop_ctrl_fast, that will just
>>> stop the non-blocking stuff, so failover can work quickly, and then
>>> after we have failover, we can do the full nvme_stop_ctrl() or the
>>> reminder of nvme_stop_ctrl_fast...
>>>
>>> thoughts?
> 
> I suspected that nvme_stop_ctrl() might have unwanted side
> effects. Maybe factoring out the common bits from nvme_stop_ctrl() into
> nvme_stop_ctrl_fast() and call it from here sounds like a reasonable
> thing to do. The function name could be better, but naming is hard.

The only name that comes to mind is nvme_stop_ctrl_noio, which is
arguably worse... Or maybe just __nvme_stop_ctrl.

Maybe others have better names.

