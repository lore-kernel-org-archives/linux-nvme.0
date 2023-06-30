Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C057CEB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 13:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9qwS/nJZGMP8Lt21UZh5+1uA66f33YQA7IfXtY5NVNY=; b=39nUg2nU5oQJ2NrfdI4hCRKPLz
	X8cYu9Cj3i6i8SdgRaqEMrtU2jh1kDzkItA6kW58DB6dRRvc9KtUXFbiKO+3xFeRVnTxQh80EhaWD
	GRaRnp1hWl51ekrG82sOXegrGpM2tz+fKzggL7ueG4y7EZmpxTzuiwIran4eagRcqbnUDU/2NJdnm
	t9O/+fX61UR36oOaMuwTnAFooDUvyjXEXzfx/UKm0FHYI6zhBN6GIqgr9fEAH0EG2d/QWtSNF2DDh
	HgAeGssGW9mJ+iXZlWKEQo5umaG8aAkoh0OoUYipmktO9RC8lKvREvQ3KqdV2wrmeU8ZuTBFI+zOb
	kr6pMcrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFEID-003mXs-2X;
	Fri, 30 Jun 2023 13:36:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFEIA-003mWu-18
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 13:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688132161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qwS/nJZGMP8Lt21UZh5+1uA66f33YQA7IfXtY5NVNY=;
	b=A9v19JHc9tkuh6uAn4TO99pOtRPlGN8MUqt5wyfmfUllyKMcs/0eS3dWEspBHt9hw6h3Iv
	/SwYYn2Ei1DXjSLOvBg9/glKPuCnmA7HMXm71HJCW6MwBjPIo6JV/XaDKieZiygHUvmAQ4
	6+o/frGlaccn7oQINThb3Vp+n5UXDRE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-ZvsvicDxNyelIhmZS0Cjig-1; Fri, 30 Jun 2023 09:33:41 -0400
X-MC-Unique: ZvsvicDxNyelIhmZS0Cjig-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31273e0507dso1047694f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jun 2023 06:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688132020; x=1690724020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qwS/nJZGMP8Lt21UZh5+1uA66f33YQA7IfXtY5NVNY=;
        b=iqduaQ7ADeI54IddWcXJkt1o43lW3MRDgwVk4D1POQD3+Nf+p7U5tYpKcazjsNd1aq
         OsvyWWgP3FcfXKSUYhl1qLGU6jPRtIVLDYz4BovspNS+Kq6ePFp3Nt6+Py3zxYa3cBBG
         IDOwCd4ChHL8s4wkcX36LAmpvgkTBTfP/A0TDkE1hQGi87sr/m4X998GeljGiOtP4U5P
         oy5mo7cC7HJ8VjhCaJej4iZ3PptF0v+J2ncOgghiLhbozj8jgLMsOQxSfUvpQz0lmhEy
         BNA1m/RCeBvSeMg/nZ25YtNEJDGUK9izlR4k2sdnJyPdH2ymW0I6mxrFSUCyDV2NwuAc
         bJUQ==
X-Gm-Message-State: ABy/qLbyvJr7VGBseYEX2JZlcRcz/CHcdLA5TEjtbtLaoWVovxigKbDo
	+4HGcB2ZSHQYM37cX5yw5urHreL6UZkre30FIZmH+xl4ylyKu7fceu7NNwWPLsmhJCuk5XZ9JE+
	VgtEng4T34Aapo3xX4YFcjjo5FhT6ppzllh5jTGcvMZg=
X-Received: by 2002:adf:fe8f:0:b0:314:fe8:4df3 with SMTP id l15-20020adffe8f000000b003140fe84df3mr2160778wrr.43.1688132019787;
        Fri, 30 Jun 2023 06:33:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEaKUBlb5wTtfacwxkRc4ZUr+ITlXMNS77Pfa0rZbzyg0YadUwPlxHmE6tWU15Qi3guX4SNTH+ClCldzyd0Foc=
X-Received: by 2002:adf:fe8f:0:b0:314:fe8:4df3 with SMTP id
 l15-20020adffe8f000000b003140fe84df3mr2160762wrr.43.1688132019432; Fri, 30
 Jun 2023 06:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230620133711.22840-1-dwagner@suse.de>
In-Reply-To: <20230620133711.22840-1-dwagner@suse.de>
From: Ewan Milne <emilne@redhat.com>
Date: Fri, 30 Jun 2023 09:33:28 -0400
Message-ID: <CAGtn9r=cNbNta2iJSianW2aK9r04oSFb3T1KUgufwgX60AqzHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] nvme-fc: Fix blktests hangers
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	"Shin'ichiro Kawasaki" <shinichiro@fastmail.com>, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_063606_559688_756F7DB6 
X-CRM114-Status: GOOD (  25.13  )
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

We ran this patch series through our regression and NVMe/FC boot from SAN t=
ests.
(I think 4/5 will also resolve some instability / race condition with
kickstart, since the connect
is now synchronous, but we may need some more time to full validate
that.  I was going
to pursue a userspace solution but this may be good enough.)

Notwithstanding the other comments re: error codes, etc. feel free to add:

Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Tested-by: Marco Patalano (mpatalan@redhat.com>

On Tue, Jun 20, 2023 at 9:39=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> With the additinal 3 patches and the blktests changes [1] I am able to ru=
n the
> tests in a loop for a while without failures. I expect there are more pro=
blems
> hidden but with these changes the first milesone is reached.
>
> The first new patch is actually one from a previous attempt. It addresses=
 the
> problem in unloading path where we dont make any progress more [2].
>
> The next two patches change the existing initial connection attempt of FC=
 to
> a synchronous one. Without this the auth test fail [3].
>
> Daniel
>
>
> [1] https://lore.kernel.org/linux-nvme/20230620132703.20648-1-dwagner@sus=
e.de/
> [2] https://lore.kernel.org/linux-nvme/20230418130159.11075-1-dwagner@sus=
e.de/
> [3] https://lore.kernel.org/linux-nvme/j4w7724skjsapgtp6wtll5fgsb4adhpfdt=
rif52lhc7iql4inf@3mu2gbjrrtcs/
>
> changes:
>
> v2:
>   - added RBs
>   - added new patches
>
> v1:
>   - https://lore.kernel.org/linux-nvme/20230615094356.14878-1-dwagner@sus=
e.de/
>
>
> Initial cover letter:
>
> A couple more fixes to enable blktests for the fc transport.
>
> 1) Another module unloading hanger which can be triggered with
>    the nvme/048 tests:
>
>    run blktests nvme/048 at 2023-06-06 13:04:49
>    nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>    nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000=
002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
>    (NULL device *): {0:0} Association created
>    [478] nvmet: ctrl 1 start keep-alive timer for 1 secs
>    [478] nvmet: check nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4-=
af29-2168953bfc0a
>    [478] nvmet: nvmet_setup_dhgroup: ctrl 1 selecting dhgroup 0
>    [478] nvmet: No authentication provided
>    nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 fo=
r NQN nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4-af29-2168953bfc0a.
>    [478] nvmet: adding queue 1 to ctrl 1.
>    [407] nvmet: adding queue 2 to ctrl 1.
>    [6549] nvmet: adding queue 3 to ctrl 1.
>    [1760] nvmet: adding queue 4 to ctrl 1.
>    nvme nvme2: NVME-FC{0}: controller connect complete
>    nvme nvme2: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1"
>    [478] nvmet: ctrl 1 reschedule traffic based keep-alive timer
>    [407] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    nvme nvme2: NVME-FC{0}: io failed due to lldd error 6
>    nvme nvme2: NVME-FC{0}: transport association event: transport detecte=
d io error
>    nvme nvme2: NVME-FC{0}: resetting controller
>    [478] nvmet: ctrl 1 stop keep-alive
>    (NULL device *): {0:0} Association deleted
>    nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000=
002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
>    (NULL device *): {0:0} Association freed
>    (NULL device *): {0:0} Association created
>    (NULL device *): Disconnect LS failed: No Association
>    [407] nvmet: ctrl 1 start keep-alive timer for 1 secs
>    [407] nvmet: check nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4-=
af29-2168953bfc0a
>    [407] nvmet: nvmet_setup_dhgroup: ctrl 1 selecting dhgroup 0
>    [407] nvmet: No authentication provided
>    nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 fo=
r NQN nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4-af29-2168953bfc0a.
>    nvme nvme2: reconnect: revising io queue count from 4 to 1
>    [478] nvmet: adding queue 1 to ctrl 1.
>    nvme nvme2: NVME-FC{0}: controller connect complete
>    [478] nvmet: ctrl 1 reschedule traffic based keep-alive timer
>    [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [407] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    nvme nvme2: NVME-FC{0}: io failed due to lldd error 6
>    nvme nvme2: NVME-FC{0}: transport association event: transport detecte=
d io error
>    nvme nvme2: NVME-FC{0}: resetting controller
>    [478] nvmet: ctrl 1 stop keep-alive
>    (NULL device *): {0:0} Association deleted
>    (NULL device *): {0:0} Association freed
>    (NULL device *): Disconnect LS failed: No Association
>    nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000=
002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
>    (NULL device *): {0:0} Association created
>    [1760] nvmet: ctrl 1 start keep-alive timer for 1 secs
>    [1760] nvmet: check nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4=
-af29-2168953bfc0a
>    [1760] nvmet: nvmet_setup_dhgroup: ctrl 1 selecting dhgroup 0
>    [1760] nvmet: No authentication provided
>    nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 fo=
r NQN nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4-af29-2168953bfc0a.
>    nvme nvme2: reconnect: revising io queue count from 1 to 4
>    [478] nvmet: adding queue 1 to ctrl 1.
>    [407] nvmet: adding queue 2 to ctrl 1.
>    [6549] nvmet: adding queue 3 to ctrl 1.
>    [1760] nvmet: adding queue 4 to ctrl 1.
>    nvme nvme2: NVME-FC{0}: controller connect complete
>    [1760] nvmet: ctrl 1 reschedule traffic based keep-alive timer
>    [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
>    nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
>    [407] nvmet: ctrl 1 stop keep-alive
>    (NULL device *): {0:0} Association deleted
>    (NULL device *): {0:0} Association freed
>    (NULL device *): Disconnect LS failed: No Association
>    nvme_fc: nvme_fc_exit_module: waiting for ctlr deletes
>    BTRFS info (device vda2): qgroup scan completed (inconsistency flag cl=
eared)
>    INFO: task modprobe:11758 blocked for more than 491 seconds.
>          Tainted: G        W          6.4.0-rc2+ #3
>    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messa=
ge.
>    task:modprobe        state:D stack:0     pid:11758 ppid:11585  flags:0=
x00004002
>    Call Trace:
>     <TASK>
>     __schedule+0x17b5/0x4870
>     ? finish_lock_switch+0x8f/0x120
>     ? finish_task_switch+0x17f/0x5c0
>     ? __sched_text_start+0x10/0x10
>     ? __schedule+0x17bd/0x4870
>     ? do_raw_spin_trylock+0xc9/0x1f0
>     schedule+0xe6/0x1e0
>     schedule_timeout+0x7e/0x1e0
>     ? __cfi_schedule_timeout+0x10/0x10
>     ? do_raw_spin_trylock+0xc9/0x1f0
>     ? __cfi_lock_release+0x10/0x10
>     ? do_raw_spin_unlock+0x116/0x8a0
>     wait_for_common+0x377/0x600
>     ? wait_for_completion+0x30/0x30
>     cleanup_module+0x222/0x240 [nvme_fc bda1ef6f83d00208ba257c5d0ac34dd6b=
db58bf9]
>     __se_sys_delete_module+0x388/0x550
>     ? __x64_sys_delete_module+0x50/0x50
>     ? task_work_run+0x236/0x290
>     ? syscall_enter_from_user_mode+0x2e/0x210
>     do_syscall_64+0x6e/0xa0
>     ? syscall_exit_to_user_mode+0x5e/0x220
>     ? do_syscall_64+0x7d/0xa0
>     ? syscall_exit_to_user_mode+0x5e/0x220
>     ? do_syscall_64+0x7d/0xa0
>     ? syscall_exit_to_user_mode+0x5e/0x220
>     ? do_syscall_64+0x7d/0xa0
>     entry_SYSCALL_64_after_hwframe+0x72/0xdc
>    RIP: 0033:0x7fa80811aebb
>    RSP: 002b:00007fff80ea0a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>    RAX: ffffffffffffffda RBX: 000055a0b5acf1f0 RCX: 00007fa80811aebb
>    RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055a0b5acf258
>    RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
>    R10: 00007fa808193ac0 R11: 0000000000000206 R12: 00007fff80ea0ad0
>    R13: 000055a0b5acf1f0 R14: 0000000000000000 R15: 0000000000000000
>     </TASK>
>
>
> 2) When executing blktests nvme/030 in a tight loop, I was able to
>    reproduce a different hanger. In this case the ->done() function
>    was never executed on the host fc side. It turns out we didn't
>    enqueue work items correctly and thus would only process one
>    work item.
>
>    run blktests nvme/030 at 2023-06-13 14:03:52
>    nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>    nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000=
002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discove=
ry"
>    (NULL device *): {0:0} Association created
>    [23733] nvmet: ctrl 1 start keep-alive timer for 120 secs
>    nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.n=
vmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4=
a80-8234-d0169409c5e8.
>    nvme nvme2: NVME-FC{0}: controller connect complete
>    nvme nvme2: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.disc=
overy"
>    nvme nvme2: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
>    [23771] nvmet: ctrl 1 stop keep-alive
>    nvmet: adding nsid 1 to subsystem blktests-subsystem-2
>    (NULL device *): {0:0} Association deleted
>    (NULL device *): {0:0} Association freed
>    (NULL device *): Disconnect LS failed: No Association
>    nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000=
002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discove=
ry"
>    (NULL device *): {0:0} Association created
>    [27320] nvmet: ctrl 1 start keep-alive timer for 120 secs
>    nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.n=
vmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4=
a80-8234-d0169409c5e8.
>    nvme nvme2: NVME-FC{0}: controller connect complete
>    nvme nvme2: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.disc=
overy"
>    nvme nvme2: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
>    [27320] nvmet: ctrl 1 stop keep-alive
>    nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000=
002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discove=
ry"
>    (NULL device *): {0:1} Association created
>    (NULL device *): {0:0} Association deleted
>    (NULL device *): {0:0} Association freed
>    (NULL device *): Disconnect LS failed: No Association
>    INFO: task kworker/u8:4:102 blocked for more than 491 seconds.
>          Tainted: G        W          6.4.0-rc2+ #3
>    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messa=
ge.
>    task:kworker/u8:4    state:D stack:0     pid:102   ppid:2      flags:0=
x00004000
>    Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
>    Call Trace:
>     <TASK>
>     __schedule+0x17b5/0x4870
>     ? try_to_wake_up+0xb5/0xfc0
>     ? __cfi_lock_release+0x10/0x10
>     ? __sched_text_start+0x10/0x10
>     ? _raw_spin_unlock_irqrestore+0x24/0x50
>     ? lock_release+0x2aa/0xd10
>     ? wq_worker_sleeping+0x1e/0x200
>     schedule+0xe6/0x1e0
>     schedule_timeout+0x7e/0x1e0
>     ? __cfi_schedule_timeout+0x10/0x10
>     ? mark_lock+0x94/0x340
>     ? lockdep_hardirqs_on_prepare+0x2aa/0x5e0
>     wait_for_common+0x377/0x600
>     ? queue_work_on+0x57/0xa0
>     ? wait_for_completion+0x30/0x30
>     nvme_fc_connect_ctrl_work+0x7dc/0x1a80 [nvme_fc 39e2bf78272df3a610fb1=
f9884513e99038af746]
>     process_one_work+0x80f/0xfb0
>     ? rescuer_thread+0x1130/0x1130
>     ? do_raw_spin_trylock+0xc9/0x1f0
>     ? lock_acquired+0x310/0x9a0
>     ? worker_thread+0xd5e/0x1260
>     worker_thread+0xbde/0x1260
>     kthread+0x25d/0x2f0
>     ? __cfi_worker_thread+0x10/0x10
>     ? __cfi_kthread+0x10/0x10
>     ret_from_fork+0x29/0x50
>     </TASK>
>
> Daniel Wagner (5):
>   nvme-fc: Do not wait in vain when unloading module
>   nvme-fcloop: queue work items correctly
>   nvmet-fcloop: Remove remote port from list when unlinking
>   nvme-fc: Make initial connect attempt synchronous
>   nvme-fc: do no free ctrl opts
>
>  drivers/nvme/host/fc.c       | 43 ++++++++++++++++++------------------
>  drivers/nvme/target/fcloop.c | 15 +++++--------
>  2 files changed, 27 insertions(+), 31 deletions(-)
>
> --
> 2.41.0
>
>


