Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0337C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 15:02:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD642075A
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 15:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fSfiSFzH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RNFJRAov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD642075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NaH1gFgKOKxAE9SbPspv/Uv+hfh6mwQZPUtK6MOII94=; b=fSfiSFzH0/yKrcwRcepaW2WKx
	1cBQFQJJobWnrk/AD3FmHHSYP5jCx0RiiU56/MInFyCKGoWPQc/jvEgBH+zJpIn5b7/oKYxee9BrI
	5Rb34JFPOdcPVhkBYKvsgSqUs57/8DLbrPtMLsSkW9hvKZ0uQgc3C5YdvbEvJPnqekwZHLu/dBKm6
	thQMpli0LALso+JjfCOuMmu7KWSBe5whpLXJCucE5QBjhYcmm4M7zAja/Nu7Ipiox6Y5WTMwZoBD9
	K+/1FPYIQqaBiscEb+0e1nFkujf5NzuMI+TIXbCbdNKMOI9+UFIVWGTfkQh0o7PiGL2lu9Wrme9D7
	xPgbX+U4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGO5Z-00072m-SU; Thu, 10 Sep 2020 15:02:17 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGO5W-000729-UY
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 15:02:16 +0000
Received: by mail-pf1-x441.google.com with SMTP id f18so4775605pfa.10
 for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2020 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=i5QVAvTBK4Vr4n/21NYVWGWQiaIb9vQll0IMNkwqXBQ=;
 b=RNFJRAovHma5mDVk1+zRTJwEUG1osqomwJ+Dw7Sssb9GspjpwflJ/Z071cehnD6De5
 zI1ZaRg3D1DJIRhKP+oJoYiA+kGIICTgEidZ0EF37ohddZAjYX4hsWS3kDSpfeSbajgX
 Jc01R3sapvDsTRVMaH5kkOvDRI5b7bCoz/Gdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=i5QVAvTBK4Vr4n/21NYVWGWQiaIb9vQll0IMNkwqXBQ=;
 b=Tm/xBTK/vqunrq/pzxE8wuxJnFlaoO/nC2m/4Xd2tlkW3tOEkasNEF6gzDQB2pbAFs
 HDalMlQVXDNYu+pDPbIvngUFcUGR7YOzM6rq7vN32lnsJJLEZtvIFeCA4FOvurp/xr/a
 dzJxTWAiT3ZFWKhOQkRV/0WDQ1GRmaV4r2yo5U4plZ8u4ACdZedzJOowvxaZgfPLbphG
 HklFbbXEUeRpmTlEScESyfppZBMhabipTceRrFLcsjvtDPBA8g77hK2pTfrvSq7XEjqV
 E4G4h2qrLv0E19A/6yzkr2Z31CdCFtv//iCYQALGimZJpEjCh2t/omcCHscCl7q+qu9p
 UC5g==
X-Gm-Message-State: AOAM530B+UFY8s7qxo/qqbb4L9V8SJBe5MZdqA6wqh5Qv1ExRcudVlu8
 5Lqr0QHP18d2CIcKCMfbr7mU07wd9+u0VzrXMDBQffanz8NRU4H6S/6Ap7fvt4j8QtBMHApABBp
 t98CfEBi3qVjn5GQ4ESdQJZ5JuRDiKtVr3E0F/O1OYgSQjnewNjRIVKT89TY9NRh4Bpy9xT43Mr
 ozZlZdG5sF1dk=
X-Google-Smtp-Source: ABdhPJxGjwWxieHRnuscASJrKHIZjgxXKQfmH+Ybyz1WYU6t3QtgNwXH+d+GIe7vq9vNKcZtJ+cnfg==
X-Received: by 2002:a63:1402:: with SMTP id u2mr4491083pgl.400.1599750131252; 
 Thu, 10 Sep 2020 08:02:11 -0700 (PDT)
Received: from [192.168.1.42] (ip68-5-85-189.oc.oc.cox.net. [68.5.85.189])
 by smtp.gmail.com with ESMTPSA id 64sm6447456pfg.98.2020.09.10.08.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 08:02:10 -0700 (PDT)
Subject: Re: lpfc: Crash on shutdown with 5.9.0-rc1
To: Hannes Reinecke <hare@suse.de>
References: <2e9bbb49-18a7-fec8-73fb-f43c72bf541a@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <f3b936f5-73d4-b1b1-e133-347474004e23@broadcom.com>
Date: Thu, 10 Sep 2020 08:02:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
MIME-Version: 1.0
In-Reply-To: <2e9bbb49-18a7-fec8-73fb-f43c72bf541a@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200910_110215_186606_907613E0 
X-CRM114-Status: GOOD (  14.07  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/10/2020 1:12 AM, Hannes Reinecke wrote:
> Hi James,
>
> I just hit this crash on shutdown with nvme-5.9:
>
> [ 3405.218638] general protection fault, probably for non-canonical
> address 0x6b6b6b6b6b6b84ef: 0000 [#1] SMP NOPTI
> [ 3405.239110] CPU: 6 PID: 680 Comm: lpfc_worker_0 Tainted: G
>   E     5.9.0-rc1-default+ #632
> [ 3405.257300] Hardware name: HPE ProLiant DL325 Gen10/ProLiant DL325
> Gen10, BIOS A41 03/09/2020
> [ 3405.274451] RIP: 0010:_raw_spin_lock_irqsave+0x1e/0x40
> [ 3405.284782] Code: 00 00 00 00 00 0f 1f 80 00 00 00 00 0f 1f 44 00 00
> 53 9c 58 0f 1f 44 00 00 48 89 c3 fa 66 0f 1f 44 00 00 31 c0 ba 01 00 00
> 00 <f0> 0f b1 17 75 05 48 89 d8 5b c3 89 c6 e8 f0 21 7c ff 66 90 48 89
> [ 3405.322544] RSP: 0018:ffffa6c804397c78 EFLAGS: 00010046
> [ 3405.333046] RAX: 0000000000000000 RBX: 0000000000000246 RCX:
> 000000006b6b6b6b
> [ 3405.347388] RDX: 0000000000000001 RSI: 0000000000000100 RDI:
> 6b6b6b6b6b6b84ef
> [ 3405.361731] RBP: 6b6b6b6b6b6b84ef R08: 000000006b6b6b6b R09:
> 000000006b6b6b6b
> [ 3405.376079] R10: 0000000000000000 R11: ffff920ff51063d9 R12:
> ffff920ff5100000
> [ 3405.390423] R13: ffff920ff5100000 R14: 0000000000000000 R15:
> ffff920fc752ee00
> [ 3405.404768] FS:  0000000000000000(0000) GS:ffff92107ec00000(0000)
> knlGS:0000000000000000
> [ 3405.421035] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3405.432582] CR2: 00007f3a0a1be960 CR3: 00000008520d0000 CR4:
> 00000000003506e0
> [ 3405.446929] Call Trace:
> [ 3405.451864]  lpfc_nlp_put.part.22+0x47/0x260 [lpfc]
> [ 3405.461685]  lpfc_ct_free_iocb+0x20/0xc0 [lpfc]
> [ 3405.470806]  lpfc_cmpl_ct_disc_fdmi+0xb3/0x3c0 [lpfc]
> [ 3405.480969]  lpfc_sli_cancel_iocbs+0x78/0xc0 [lpfc]
> [ 3405.490790]  lpfc_hba_clean_txcmplq+0xe4/0x1e0 [lpfc]
> [ 3405.500959]  lpfc_hba_down_post_s4+0x6e/0x3e0 [lpfc]
> [ 3405.510944]  ? msleep+0x29/0x40
> [ 3405.517266]  lpfc_sli_brdrestart_s4+0x62/0x180 [lpfc]
> [ 3405.527436]  lpfc_sli4_port_sta_fn_reset.constprop.49+0x5b/0x180 [lpfc]
> [ 3405.540753]  lpfc_handle_eratt_s4+0x1ac/0x5c0 [lpfc]
> [ 3405.550748]  lpfc_do_work+0xb79/0x1800 [lpfc]
> [ 3405.559507]  ? wait_woken+0x80/0x80
> [ 3405.566531]  ? lpfc_unregister_unused_fcf+0x80/0x80 [lpfc]
> [ 3405.577561]  kthread+0x118/0x140
>
>
> Is this a known issue?
> Maybe fixed with updates getting in the scsi branch?
>
> Thanks.
>
> Cheers,
>
> Hannes

I'm guessing none of the deltas in the scsi tree will help you. This is 
a rare path - kicked off by detecting a hw failure 
(lpfc_handle_eratt_s4). We'll look into it.

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
