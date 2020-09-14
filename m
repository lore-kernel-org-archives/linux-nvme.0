Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47507C43461
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 23:50:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED52208B3
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 23:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XNqFQ1ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED52208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fdq8brkBXJLpKFACBHkJH5EP17U8sZ16dWNSeAux9R4=; b=XNqFQ1ctOyMf6zVSIs0mYet3w
	yso03sPD0gYusrrvAy9O+/qTC+8EZZAA+gnOE/3pa2mQ1Crhs6ipLeLHLbtY0Rk1G/73wqYsf0Spj
	X0jBLL+gIMDsnrRgi5S/2k5A3Y8Jrm7bH5KB4HMKtyH7V64UXFCrymh3uotGZG7oIyoQm/NGT712N
	b1w33a06k4Y+3ecfSLNG/eVbsa3ysCAtNy2lpfiT0xYr1dtYTF5/sm7SJWhXx3lSHPonjQKP0YviK
	HQGLOV4Oeq8C6xlSsmHvUUGntpnMVE/TvgDvqLS796TioHJIzk7s9xDJK6WkFbnzFfBJ4tQdZD7fn
	hDWDISqYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHyEo-0004KW-9S; Mon, 14 Sep 2020 23:50:22 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHyEi-0004K7-7k
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 23:50:19 +0000
Received: by mail-pl1-f195.google.com with SMTP id f1so353767plo.13
 for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2020 16:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XTTAOoHIclN6j6FpYx1VYHMVNixblRTZPqOZeeAl2FA=;
 b=XZFV/wFFImjpLVoBvqCDuOOZ+dBvfRZVp0pebqsJSDL+QsvcLKjYDGuaIcQGOyhLB7
 3fGdSdOFN2oGGG3e4Uwq3I5fSDbQdyRY405wpK+odDcsj36lZ1zxZpJED/e5EzZF724n
 GR3zZLFayah2zuR7JMFXXqqFpslx4a4i8ymNcR0yod9G+7YfOvffOOAgBYtUGaLN1jYI
 EuHaM9le2VfbVAoi9Ukiss7T4/IS5o7enyzcOdR7Bp4In3HxEdMkQNYWjLR9yaWlXZFZ
 wC5dSYgO4g5LbC2A7jJrNxKPgX0hVfPcj5hltwoE4dT4c4XUFQV4+cUy/5uorr40Syei
 h9cg==
X-Gm-Message-State: AOAM532LJmHplJjvZfyA20H2UYA8du7+Ka3sqFVCR2eOZMNkym6bEl9c
 Z1hkBQU8CrwvAT5qv31kpF+B9BoCg7U=
X-Google-Smtp-Source: ABdhPJwztLP+l7tDbc78Rxiqcupr433Rth9wpzvqXXb98GSvJYlG9hQDICMfCNFRt7ViVKRIuXnY2w==
X-Received: by 2002:a17:90a:5282:: with SMTP id
 w2mr1622926pjh.77.1600127414178; 
 Mon, 14 Sep 2020 16:50:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3268:60da:a840:77e?
 ([2601:647:4802:9070:3268:60da:a840:77e])
 by smtp.gmail.com with ESMTPSA id n2sm10615657pja.41.2020.09.14.16.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 16:50:13 -0700 (PDT)
Subject: Re: nvme_tcp: nvme connect failed after execute stress-ng: unshare
To: Yi Zhang <yi.zhang@redhat.com>, gscrivan@redhat.com,
 colin.king@canonical.com
References: <643455136.711850.1599712518936.JavaMail.zimbra@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <34570678-f8e7-a3ce-e7a3-be887ec2d949@grimberg.me>
Date: Mon, 14 Sep 2020 16:50:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <643455136.711850.1599712518936.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_195017_656199_E323D492 
X-CRM114-Status: GOOD (  19.43  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hello
> 
> Recently I found nvme-tcp connecting always failed[1] after execute stress-ng:unshare[2], by bisecting I finally found it was introduced with commit[3], the connecting works well after revert it.
> I'm not sure whether it's one test case issue or kernel issue, could anyone help check it.

Is this failure persistent or transient?

> 
> [1]
> # sh test.sh
> + ./stress-ng/stress-ng --unshare 0 --timeout 5 --log-file unshare.log
> stress-ng: info:  [355534] dispatching hogs: 32 unshare
> stress-ng: info:  [355534] successful run completed in 5.04s
> + modprobe null-blk nr-devices=1
> + modprobe nvmet-tcp
> + modprobe nvme-tcp
> + nvmetcli restore tcp.json
> + nvme connect -t tcp -n nqn.2014-08.org.nvmexpress.discovery -a 127.0.0.1 -s 4420
> Failed to write to /dev/nvme-fabrics: Input/output error
> 
> # dmesg | tail -9
> [  700.012299] null_blk: module loaded
> [  700.073415] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  700.073923] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  715.291020] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
> [  715.297031] nvmet: ctrl 1 fatal error occurred!
> [  749.939898] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:e405e6bb-8e28-4a73-b338-3fddb5746b8c.
> [  763.417376] nvme nvme0: queue 0: timeout request 0x0 type 4
> [  763.422979] nvme nvme0: Connect command failed, error wo/DNR bit: 881
> [  763.429419] nvme nvme0: failed to connect queue: 0 ret=881
> 
> # uname -r
> 5.9.0-rc4
> 
> 
> [2] stress-ng: unshare case
> https://github.com/ColinIanKing/stress-ng.git
> https://github.com/ColinIanKing/stress-ng/blob/master/stress-unshare.c
> 
> 
> [3]
> commit e1eb26fa62d04ec0955432be1aa8722a97cb52e7
> Author: Giuseppe Scrivano <gscrivan@redhat.com>
> Date:   Sun Jun 7 21:40:10 2020 -0700
> 
>      ipc/namespace.c: use a work queue to free_ipc
>      
>      the reason is to avoid a delay caused by the synchronize_rcu() call in
>      kern_umount() when the mqueue mount is freed.
> 
> 
> [4]
> # cat tcp.json
> {
>    "hosts": [],
>    "ports": [
>      {
>        "addr": {
>          "adrfam": "ipv4",
>          "traddr": "127.0.0.1",
>          "treq": "not specified",
>          "trsvcid": "4420",
>          "trtype": "tcp"
>        },
>        "portid": 0,
>        "referrals": [],
>        "subsystems": [
>          "blktests-subsystem-1"
>        ]
>      }
>    ],
>    "subsystems": [
>      {
>        "allowed_hosts": [],
>        "attr": {
>          "allow_any_host": "1",
>          "cntlid_max": "65519",
>          "cntlid_min": "1",
>          "model": "Linux",
>          "pi_enable": "0",
>          "serial": "7d833f5501f6b240",
>          "version": "1.3"
>        },
>        "namespaces": [
>          {
>            "device": {
>              "nguid": "00000000-0000-0000-0000-000000000000",
>              "path": "/dev/nullb0",
>              "uuid": "b07c7eef-8428-47bf-8e79-26ec8c30f334"
>            },
>            "enable": 1,
>            "nsid": 1
>          }
>        ],
>        "nqn": "blktests-subsystem-1"
>      }
>    ]
> }
> 
> 
> Best Regards,
>    Yi Zhang
> 
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
