Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB08C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OrxFCIt6v0tfn77Vqoqq8pOw1yEEtVFZjJQJlP9Orec=; b=lgjVekhEj1dCDqXu+yjN0kRYKM
	VpRVf9uhpMdMRJGDQtV2b66x4uRKtTlxlV2ncxBLLL8dqlKFFCdp85levO8eW0YCC+jwvrwPkNP/u
	kxNcDbj4ed5zdm893IDn5o6X651dagZAK4cv5KNamDlBeFG0EFN2iB3fersSnv7x/H5Q1RfpPIu0B
	sEy5Nqhf/hEL5zZ6r8csWdIgYasytosNIRNQIg8QjexeEQD1vUtxbYqrI7iwJdGctDQDYMAiSxnUk
	ejulhOD4R0Crvo6yRrRjNt2B1oo6VYN8jH4LSOwY7MVhLEgfOYigW3QRUwEUR/SZkawxQH5EPrjK3
	Oa2TEBtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntUKi-0083yB-Hu; Tue, 24 May 2022 13:12:20 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntUKf-0083wy-Vy
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 13:12:19 +0000
Received: by mail-wr1-f54.google.com with SMTP id p10so7028636wrg.12
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 06:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OrxFCIt6v0tfn77Vqoqq8pOw1yEEtVFZjJQJlP9Orec=;
 b=dMQhMoX2xKyj8M2NMCSePFPFgq/gRt2+j9ryLq/0CdR7lSQT451HR4PF3n2wkvsp1S
 mWJVLZ9U+cZqAyN1FDqFo6iXynkKsdciax+lwK2lIgJ9DU1qjgspu0vkpb3DPmFsJSo6
 JdLEMYlGXp1Hx6AAVSj4lrAI2HrpIqceI5oOl4j1krF2nJkBozicrQhALvVDuWRWyzgz
 tW1t4xkpXr8k4UI59r/sI4gVhBJF+uLIVmODrIPDy28JKhZlMRHzD/2XgC2iGWB8OG1B
 v+ji//XxnRtMjzo4MN9FiyVwECHv5H+JWRaGp0FPYKJP5h/E+v0wJhYpd7XMTV/lu3x2
 s0Ng==
X-Gm-Message-State: AOAM533fz3S4MXhh6hb5ppNqvp7Gf/aeO8+Y5p213WqXegRWRaI5jz+e
 FopPWZZoEaklL724sQscUj4=
X-Google-Smtp-Source: ABdhPJzk0J8hOP8AyQWL5mNhBX9TuM5ETAZ8NqcIxkbFxp0a4j9YeF8KM8Pp0X+XHMy2Cskwmb0iFQ==
X-Received: by 2002:adf:cf06:0:b0:20d:1236:b1ff with SMTP id
 o6-20020adfcf06000000b0020d1236b1ffmr23517434wrj.496.1653397932969; 
 Tue, 24 May 2022 06:12:12 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 i4-20020a7bc944000000b003974cb37a94sm2121034wml.22.2022.05.24.06.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 May 2022 06:12:12 -0700 (PDT)
Message-ID: <c3e5bad8-8cca-8058-38d7-0eea2ddfd6bc@grimberg.me>
Date: Tue, 24 May 2022 16:12:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC] nvme-rdma: Stop queues when starting with error recovery
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20220523152102.41000-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220523152102.41000-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_061218_076193_4CEFA3F7 
X-CRM114-Status: GOOD (  15.38  )
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



On 5/23/22 18:21, Daniel Wagner wrote:
> When we enter error recovery we should stop all queue activities and
> all armed timers.
> 
> For example, we could arming an ANATT timer right before we enter
> error recovery but do not successfully recover before the timer
> fires. The timer is supposed only be active when the controller is in
> LIVE state hence we should call nvme_stop_ctrl when starting with the
> recover activites.

This takes me back... IIRC the main reason why the error recovery
handler in nvme-rdma (and nvme-tcp) does not start with nvme_stop_ctrl()
is because back then, nvme_stop_ctrl() could block until an
admin_timeout expired on an inflight admin command (I have a vague
memory that if cancelled/flushed the scan_work), which delayed I/O
failover, hence we just cherry-picked what needed to be stopped to make
sure I/O failover will not be blocked by anything and progress quickly.

If I look at nvme_stop_queue it does not touch the scan_work, but it
does flush ana_work which includes I/O, so it can still block on it
to fail after admin_timeout expires... also flush failfast_work is
taking the namespaces_rwsem (although read access). The fw_act_work
is probably meaningless for fabrics...

Maybe we need to have something like nvme_stop_ctrl_fast, that will just
stop the non-blocking stuff, so failover can work quickly, and then
after we have failover, we can do the full nvme_stop_ctrl() or the
reminder of nvme_stop_ctrl_fast...

thoughts?

