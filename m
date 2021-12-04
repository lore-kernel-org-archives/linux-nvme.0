Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B9BC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Dec 2021 03:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Fg21z4HWRrnGfVx0ChGSiSzsxzAGO0T2bD7rH2Iy6BU=; b=NrIC9STtHYdN/tPGDXtlLYBaDW
	gSP4QZmbPiqZWeyGyKeTU3LlwMzt9EtILbn6z3wtZqvzkdXgVV55Wt16GlTU++Y1VHS9HBvl3UIuI
	OnSbx35gYSHjKKS/df3b6p8d3oCkCzo7Qjg1nEPZq1AfBoG4YmUDiVRDDWMCpyO9cqr3RMCJbedny
	U1ZanXrxl3dlHpJzLKoGRYSZK1PwPCw+NzEhGJOz17s4piw8m7RIyXeZbUFxo3fQGDgpH+VTByXwE
	57h0c530zrI5xKL6GlsNVInchak1hOlLkvJx3mEd2pTHuFFKz/4o/1RNMtbvX4IhB9fPcZrF+J4Yf
	b1uQIiCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtLKY-00HRKD-HI; Sat, 04 Dec 2021 03:03:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtLKV-00HRJh-30
 for linux-nvme@lists.infradead.org; Sat, 04 Dec 2021 03:03:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638586991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=Fg21z4HWRrnGfVx0ChGSiSzsxzAGO0T2bD7rH2Iy6BU=;
 b=AYVlmwrvqCj6L6CoftbydkeC5YUhsK6NcE9Zr3geizquMjdODni/Hpc9MR1lcI7x3RmyBO
 Wdnqtbr0Nh4k1jPDYUy41m50vw6o0M4AsKjYKnOKxvH2ktTbFtWIU5VM2ezE4xz0wc+kq9
 VxVQuBhqxagBKst0BocjtOHO0hMvx3U=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-585-7jRixfjwN4SO0Dkqd_bt2Q-1; Fri, 03 Dec 2021 22:03:10 -0500
X-MC-Unique: 7jRixfjwN4SO0Dkqd_bt2Q-1
Received: by mail-yb1-f199.google.com with SMTP id
 s189-20020a252cc6000000b005c1f206d91eso9861841ybs.14
 for <linux-nvme@lists.infradead.org>; Fri, 03 Dec 2021 19:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Fg21z4HWRrnGfVx0ChGSiSzsxzAGO0T2bD7rH2Iy6BU=;
 b=LKVb6WLGL6EsLYFgAIwAYaiS5q8DLueoHvUcCiWoO/AVBPpT3IkpK0xX3cXLAGhP/D
 DMYZEKFwDa9AQsOhRqEyy93OgGluHNjWk4pG2tp12IdPfhNB2+AjaUVUd1XEKmG0DyP1
 DyvwuRxbjA4wCGgu39tHtEgeC5FPG5qexwcF9MI+WD4SGJari7jrqih01B1n96XO6msf
 i1lPcvC7I6xFU0AVp1XT8StqI951+oT0vU7QipZ+FVDAyO4optA1I0xAjwm8DTpBZNDW
 0aTSK+QZuNKoJCZ6u0UztYVBGXaOV70U39dagw648gFwDKc8NZw67wbj1htczShk9hjO
 Cl/w==
X-Gm-Message-State: AOAM533ckl4WwnZrp9qT86/gXrfSwM0HvJhibBUZrVgWCenqIfG2yizR
 SZtTI6yuakHGevQOsMHBeOwJi7qDA7TSR1C2m8UuZvIEHvSs9y+cq455nmvV+UdQTLmDbtSq6Sc
 yk/siEmUmvjW1ePGWwnQ3ttYrPWyz4T13rHbPBhjO4VI=
X-Received: by 2002:a25:c091:: with SMTP id
 c139mr29006265ybf.275.1638586989744; 
 Fri, 03 Dec 2021 19:03:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7WhL1Grk0b76BeRVpxZMnNXB2LfmSUay3qEX7Zjt2B6DMH5MC5Cs50UqFfl6wfsnsYGokv6rDj0tNsqaFBUk=
X-Received: by 2002:a25:c091:: with SMTP id
 c139mr29006242ybf.275.1638586989483; 
 Fri, 03 Dec 2021 19:03:09 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 4 Dec 2021 11:02:58 +0800
Message-ID: <CAHj4cs8_tVET3_8ERuH1zVb7_T6sJ8b8fwQ5eUHN3JQWAr6Z8w@mail.gmail.com>
Subject: [bug report] blktests nvme/014 flush operation failed with
 "Interrupted system call"
To: linux-block <linux-block@vger.kernel.org>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211203_190315_387862_7BF64348 
X-CRM114-Status: UNSURE (   6.26  )
X-CRM114-Notice: Please train this message.
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

Hello

I found blktests nvme/014 failed on the latest 5.16.0-rc3, and it also
exists on the previous 5.13 kernel, pls help check it, thanks.

# nvme_trtype=rdma ./check nvme/014
nvme/014 (flush a NVMeOF block device-backed ns)             [failed]
    runtime  97.035s  ...  83.405s
    --- tests/nvme/014.out 2021-12-03 00:46:30.921272359 -0500
    +++ /root/blktests/results/nodev/nvme/014.out.bad 2021-12-03
20:39:24.005327680 -0500
    @@ -1,6 +1,6 @@
     Running nvme/014
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NVMe Flush: success
    +flush: Interrupted system call
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
# use_siw=1 nvme_trtype=rdma ./check nvme/014
nvme/014 (flush a NVMeOF block device-backed ns)             [failed]
    runtime  83.405s  ...  120.337s
    --- tests/nvme/014.out 2021-12-03 00:46:30.921272359 -0500
    +++ /root/blktests/results/nodev/nvme/014.out.bad 2021-12-03
20:41:37.716947252 -0500
    @@ -1,6 +1,6 @@
     Running nvme/014
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NVMe Flush: success
    +flush: Interrupted system call
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete

dmesg:
[29543.065568] run blktests nvme/014 at 2021-12-03 20:38:00
[29543.376558] rdma_rxe: loaded
[29543.384075] eno1 speed is unknown, defaulting to 1000
[29543.389149] eno1 speed is unknown, defaulting to 1000
[29543.394225] eno1 speed is unknown, defaulting to 1000
[29543.400686] infiniband eno1_rxe: set down
[29543.404714] infiniband eno1_rxe: added eno1
[29543.408903] eno1 speed is unknown, defaulting to 1000
[29543.415984] eno1 speed is unknown, defaulting to 1000
[29543.422624] eno2 speed is unknown, defaulting to 1000
[29543.427686] eno2 speed is unknown, defaulting to 1000
[29543.432760] eno2 speed is unknown, defaulting to 1000
[29543.439219] infiniband eno2_rxe: set down
[29543.443239] infiniband eno2_rxe: added eno2
[29543.447436] eno2 speed is unknown, defaulting to 1000
[29543.454519] eno1 speed is unknown, defaulting to 1000
[29543.459609] eno2 speed is unknown, defaulting to 1000
[29543.467662] infiniband eno3_rxe: set active
[29543.471866] infiniband eno3_rxe: added eno3
[29543.478492] eno1 speed is unknown, defaulting to 1000
[29543.483595] eno2 speed is unknown, defaulting to 1000
[29543.490194] eno4 speed is unknown, defaulting to 1000
[29543.495271] eno4 speed is unknown, defaulting to 1000
[29543.500340] eno4 speed is unknown, defaulting to 1000
[29543.506811] infiniband eno4_rxe: set down
[29543.510824] infiniband eno4_rxe: added eno4
[29543.515014] eno4 speed is unknown, defaulting to 1000
[29543.522209] eno1 speed is unknown, defaulting to 1000
[29543.527301] eno2 speed is unknown, defaulting to 1000
[29543.532395] eno4 speed is unknown, defaulting to 1000
[29543.549896] loop0: detected capacity change from 0 to 2097152
[29543.565549] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[29543.581003] nvmet_rdma: enabling port 0 (10.16.219.1:4420)
[29543.610378] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0033-3110-8030-b5c04f505932.
[29543.624775] nvme nvme0: creating 48 I/O queues.
[29543.671829] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[29543.682993] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
10.16.219.1:4420
[29548.707044] nvme nvme0: using deprecated NVME_IOCTL_IO_CMD ioctl on
the char device!
[29578.830401] nvme nvme0: I/O 94 QID 35 timeout
[29578.834769] nvme nvme0: starting error recovery
[29578.848426] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[29578.883367] nvme nvme0: Property Set error: 880, offset 0x14
[29587.534052] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[29587.539984] nvmet: ctrl 1 fatal error occurred!
[29626.587132] eno1 speed is unknown, defaulting to 1000
[29626.592232] eno2 speed is unknown, defaulting to 1000
[29626.597333] eno4 speed is unknown, defaulting to 1000
[29626.615065] rdma_rxe: rxe-ah pool destroyed with unfree'd elem
[29626.625808] rdma_rxe: unloaded
[29639.841924] run blktests nvme/014 at 2021-12-03 20:39:37
[29640.065389] SoftiWARP attached
[29640.072754] eno1 speed is unknown, defaulting to 1000
[29640.077817] eno1 speed is unknown, defaulting to 1000
[29640.082892] eno1 speed is unknown, defaulting to 1000
[29640.089949] eno1 speed is unknown, defaulting to 1000
[29640.096517] eno2 speed is unknown, defaulting to 1000
[29640.101579] eno2 speed is unknown, defaulting to 1000
[29640.106658] eno2 speed is unknown, defaulting to 1000
[29640.113763] eno1 speed is unknown, defaulting to 1000
[29640.118865] eno2 speed is unknown, defaulting to 1000
[29640.127341] eno1 speed is unknown, defaulting to 1000
[29640.132427] eno2 speed is unknown, defaulting to 1000
[29640.138937] eno4 speed is unknown, defaulting to 1000
[29640.143992] eno4 speed is unknown, defaulting to 1000
[29640.149070] eno4 speed is unknown, defaulting to 1000
[29640.156219] eno1 speed is unknown, defaulting to 1000
[29640.161330] eno2 speed is unknown, defaulting to 1000
[29640.166422] eno4 speed is unknown, defaulting to 1000
[29640.183772] loop0: detected capacity change from 0 to 2097152
[29640.204078] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[29640.221508] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[29640.227720] nvmet_rdma: enabling port 0 (10.16.219.1:4420)
[29640.239086] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0033-3110-8030-b5c04f505932.
[29640.253493] nvme nvme0: creating 48 I/O queues.
[29640.304443] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[29640.315630] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
10.16.219.1:4420
[29645.276648] nvme nvme0: using deprecated NVME_IOCTL_IO_CMD ioctl on
the char device!
[29675.595074] nvme nvme0: I/O 83 QID 17 timeout
[29675.599446] nvme nvme0: starting error recovery
[29675.616070] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[29675.669023] nvme nvme0: Property Set error: 880, offset 0x14
[29683.786764] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[29683.792690] nvmet: ctrl 1 fatal error occurred!
[29760.282291] eno1 speed is unknown, defaulting to 1000
[29760.287387] eno2 speed is unknown, defaulting to 1000
[29760.292481] eno4 speed is unknown, defaulting to 1000
[29760.306468] SoftiWARP detached


-- 
Best Regards,
  Yi Zhang


