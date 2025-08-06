Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484A3C87FCB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 01:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OqUoh3I3BDccAUBqCY48AqRN2HWxXASUn79xbObtqew=; b=A9yWbGQQ3zLZYqRBKtqbHQFrr/
	gIKdpslVsNwGexp8lMoJwyJkseG5rPybi1uT+DizF84HgMRmodXH1F/MxSXo5fxovyaGStm1ZE70+
	Rp1q5RNze/iwx1CFtqablxGP91j2urXBb2CCMT7aGrlhnf+nbe857tsIsxo95/W11BIOUaZ9achDt
	aIb3zABqoo9o6JOMXDPxdEtwCQN8D+ZPsw9ofe+VT/UZZ4C2wDVMP4y+z7+nSNOHP7TwQbd//suMh
	1L8bG340bHMvIXyvYEKcS3VKp603tvUchcAjceTpYpuwuI2NmOGnqnQNTcrnB2eGAYbugVoUwdA7f
	6Ir+TTSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujTPv-0000000E98h-0ye4;
	Wed, 06 Aug 2025 01:58:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujTPs-0000000E97s-2sO5
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 01:58:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754445486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=OqUoh3I3BDccAUBqCY48AqRN2HWxXASUn79xbObtqew=;
	b=Lg1ltH0BGEXZQyOA/gVAGc+idQEnYER2ykbat6BTlYc1l5e/XPdJrpeZqmU2130kpiPfr9
	KLsNh8XU6LCOUU4bBtIuucaeLxCrQ3MWjAEqhlDPghNud6eNHwDWbfgJxvfGb/P7mQAE/U
	PDe9NmoLiCT+QDtSiFVugXK/vucOw/8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-_bB4atX1PKykc_1Kzm-9Rw-1; Tue, 05 Aug 2025 21:58:04 -0400
X-MC-Unique: _bB4atX1PKykc_1Kzm-9Rw-1
X-Mimecast-MFC-AGG-ID: _bB4atX1PKykc_1Kzm-9Rw_1754445483
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-332326aa250so29107861fa.2
        for <linux-nvme@lists.infradead.org>; Tue, 05 Aug 2025 18:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445482; x=1755050282;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqUoh3I3BDccAUBqCY48AqRN2HWxXASUn79xbObtqew=;
        b=hpCAF5vjv5hZfpgMpNUQHkGipLRlCZXuU9X9EQDWLURRsG4J5ngcEvptO2XkX3hZnJ
         xMKPIuGrOvyCFXWgajZOUqBVh8YufvIwT3LPNJi1lNb+CDyLxv9w7gq/i2jUB2bExWmp
         MGKm2ixMLgQ7Ytpw+vkLpeM7IDf5VU4Fr5jxu0qaFriowQdwg2KB8ZRlEDCZeLXP8lVc
         NdEiBMu2MOJ83vICCP3pYZSMAU5Jlumlse2OyS5AH8ci4ChZCZHWyWs/Rh50liusf9+F
         gKfSboPVepAg2oWap3Liob8Iyfe935HY8JZk3YWVStfpu3mcuhQx51/EtsUdYbg9EzoY
         a0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXni6crKBiBjLtDgdbS1xGYVwwjbVzgPxV2BMMPvo15XzL92vxLEkmM2WlJuzQgqD3oPHTVNHAEqEtv@lists.infradead.org
X-Gm-Message-State: AOJu0YwLnBq27kB6dxlMnmV1KP/33zl7Dw1Q4TX62d211zkfoFV7AD1M
	qbJWsOIuf8ZRQBIe1xBmeOZPnVNuKQ834uFPgxKdcydhOVjeQ5j10mkfbK900dPOogzoCi0ikzv
	3sefDgYhKgdKh4zfpFn4t1gIQE2MnIpFsh2h7URDhGTW2g4Yb4ypG9V+PQDtHxzekRBC4NKUk1u
	sGyLeBXVEX9h7q4cgRvHA+h4ASyNlJsR0vGqPqkWhbrbfbfwuwOUmBcg==
X-Gm-Gg: ASbGncu79kVtZrT6DF9dRu1xZCpkn8kCIa+ntYdI33aSl0JNMrCH9plB7sB5nuzlWmi
	3CWnqFFyC9ytLwUqHlPum1qZxGOJIjw/smBf6nZ5+hpQSQ70+f5Tzm9Icioy7HceXZ8br+jBkap
	YxhnReHq7gwVhXLCYkbTaehA==
X-Received: by 2002:a05:651c:19a3:b0:32a:6aa0:2173 with SMTP id 38308e7fff4ca-333813cb421mr2257081fa.20.1754445481902;
        Tue, 05 Aug 2025 18:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYN4bkZdO3F6XuoA4A1uWIZ2ryNf71YLTvNMpWj7RYcCDCwKboopxLHSKuq4FQtJyLIGeQlBo9LIENVgTtgP0=
X-Received: by 2002:a05:651c:19a3:b0:32a:6aa0:2173 with SMTP id
 38308e7fff4ca-333813cb421mr2257001fa.20.1754445481258; Tue, 05 Aug 2025
 18:58:01 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 6 Aug 2025 09:57:49 +0800
X-Gm-Features: Ac12FXyBhnWnJHerlSUK699FhRlGNBd51WtppFw9Q2Xvm-q5zj5m12GjXj2PupA
Message-ID: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com>
Subject: [bug report] blktests nvme/tcp nvme/060 hang
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Maurizio Lombardi <mlombard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6sp4VGIZcJ0zXwgT4LmFOUCl66llByuAwbOqsWxdfVo_1754445483
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_185808_873764_FB95C797 
X-CRM114-Status: UNSURE (   6.57  )
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
I hit this issue when I was running blktests nvme/tcp nvme/060 on the
latest linux-block/for-next with rt enabled, please help check it and
let me know if you need any info/testing for it, thanks.

[  195.356104] run blktests nvme/060 at 2025-08-06 01:50:45
[  195.578659] loop0: detected capacity change from 0 to 2097152
[  195.620986] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  195.681508] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  195.904991] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  195.919199] nvme nvme1: creating 80 I/O queues.
[  196.035295] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  196.175655] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  196.195731] nvme (3558) used greatest stack depth: 19248 bytes left
[  197.786460] nvmet: ctrl 1 fatal error occurred!
[  197.789337] nvme nvme1: starting error recovery
[  197.932751] nvme nvme1: Reconnecting in 1 seconds...
[  198.980348] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  198.985848] nvme nvme1: creating 80 I/O queues.
[  199.318924] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  199.423818] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  199.556572] nvme nvme1: Failed reconnect attempt 1/600
[  200.075342] systemd-udevd (3501) used greatest stack depth: 17888 bytes left
[  200.496781] nvme nvme1: Property Set error: 880, offset 0x14
[  200.977968] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  200.985964] nvme nvme1: creating 80 I/O queues.
[  201.076602] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  201.189249] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  201.206511] nvme (3741) used greatest stack depth: 17712 bytes left
[  201.867978] nvmet: ctrl 1 fatal error occurred!
[  201.868127] nvme nvme1: starting error recovery
[  201.986566] nvme nvme1: Reconnecting in 1 seconds...
[  203.049519] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  203.056878] nvme nvme1: creating 80 I/O queues.
[  203.399239] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  203.569429] nvme nvme1: Successfully reconnected (attempt 1/600)
[  203.918129] nvmet: ctrl 1 fatal error occurred!
[  203.918261] nvme nvme1: starting error recovery
[  204.026795] nvme nvme1: Reconnecting in 1 seconds...
[  204.423104] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  205.336507] nvme nvme1: Property Set error: 880, offset 0x14
[  205.855722] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  205.861038] nvme nvme1: creating 80 I/O queues.
[  205.944537] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  205.965862] nvmet: ctrl 1 fatal error occurred!
[  206.053046] nvme nvme1: starting error recovery
[  206.147337] nvme nvme1: Failed to configure AEN (cfg 900)
[  206.147495] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  206.176163] nvme nvme1: Reconnecting in 1 seconds...
[  207.208170] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  207.211901] nvme nvme1: creating 80 I/O queues.
[  207.336799] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  207.349663] nvme nvme1: Successfully reconnected (attempt 1/600)
[  208.017068] nvmet: ctrl 1 fatal error occurred!
[  208.017201] nvme nvme1: starting error recovery
[  208.126889] nvme nvme1: Reconnecting in 1 seconds...
[  209.199440] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  209.203685] nvme nvme1: creating 80 I/O queues.
[  209.382909] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  209.503420] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  209.706412] nvme nvme1: Failed reconnect attempt 1/600
[  210.617622] nvme nvme1: Property Set error: 880, offset 0x14
[  211.158138] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  211.163794] nvme nvme1: creating 80 I/O queues.
[  211.245927] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  211.350477] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  212.097987] nvmet: ctrl 1 fatal error occurred!
[  212.098122] nvme nvme1: starting error recovery
[  212.217345] nvme nvme1: Reconnecting in 1 seconds...
[  213.280774] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  213.284617] nvme nvme1: creating 80 I/O queues.
[  213.625320] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  213.787167] nvme nvme1: Successfully reconnected (attempt 1/600)
[  214.147984] nvmet: ctrl 1 fatal error occurred!
[  214.148113] nvme nvme1: starting error recovery
[  214.248455] nvme nvme1: Reconnecting in 1 seconds...
[  214.604818] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  215.431717] nvme nvme1: Property Set error: 880, offset 0x14
[  216.014626] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  216.020186] nvme nvme1: creating 80 I/O queues.
[  216.101613] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  216.195783] nvmet: ctrl 1 fatal error occurred!
[  216.536582] nvme nvme1: failed to send request -32
[  216.537991] nvme nvme1: failed nvme_keep_alive_end_io error=4
[  280.196270] nvme nvme1: I/O tag 0 (0000) type 4 opcode 0x7f
(Fabrics Cmd) QID 80 timeout
[  280.198058] nvme nvme1: Connect command failed, error wo/DNR bit: 881
[  280.198353] nvme nvme1: failed to connect queue: 80 ret=881
[  285.369827] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  285.375603] nvme nvme1: creating 80 I/O queues.
[  285.449676] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  285.554119] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  287.344206] nvmet: ctrl 1 fatal error occurred!
[  287.344349] nvme nvme1: starting error recovery
[  287.466244] nvme nvme1: Reconnecting in 1 seconds...
[  288.479300] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  288.483283] nvme nvme1: creating 80 I/O queues.
[  288.785415] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  288.856766] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  289.066215] nvme nvme1: Failed reconnect attempt 1/600
[  290.116265] nvme nvme1: Property Set error: 880, offset 0x14
[  320.802045] loop: module loaded
[  321.017366] run blktests nvme/060 at 2025-08-06 01:52:51
[  321.220243] loop0: detected capacity change from 0 to 2097152
[  321.262034] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  321.322296] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  321.511316] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  321.524993] nvme nvme1: creating 80 I/O queues.
[  321.636336] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  321.754764] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  323.431491] nvmet: ctrl 1 fatal error occurred!
[  323.434219] nvme nvme1: starting error recovery
[  323.566948] nvme nvme1: Reconnecting in 1 seconds...
[  324.653738] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  324.662270] nvme nvme1: creating 80 I/O queues.
[  324.993712] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  325.052085] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  325.481710] nvmet: ctrl 1 fatal error occurred!
[  327.286111] nvmet: ctrl 1 keep-alive timer (1 seconds) expired!
[  390.435380] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  390.441500] rcu: Tasks blocked on level-1 rcu_node (CPUs 0-15):
P4784/2:b..l P1049/8:b..l
[  390.449771] rcu: (detected by 13, t=6503 jiffies, g=8845, q=2243 ncpus=80)
[  390.456724] task:kworker/u329:1  state:D stack:19264 pid:1049
tgid:1049  ppid:2      task_flags:0x4208060 flags:0x00000010
[  390.467850] Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
[  390.474378] Call trace:
[  390.476813]  __switch_to+0x1d8/0x330 (T)
[  390.480731]  __schedule+0x860/0x1c30
[  390.484297]  schedule_rtlock+0x30/0x70
[  390.488037]  rtlock_slowlock_locked+0x464/0xf60
[  390.492559]  rt_read_lock+0x2bc/0x3e0
[  390.496211]  nvmet_tcp_listen_data_ready+0x3c/0x118 [nvmet_tcp]
[  390.502125]  nvmet_tcp_data_ready+0x88/0x198 [nvmet_tcp]
[  390.507429]  tcp_data_ready+0xdc/0x3e0
[  390.511171]  tcp_data_queue+0xe30/0x1e08
[  390.515084]  tcp_rcv_established+0x710/0x2328
[  390.519432]  tcp_v4_do_rcv+0x554/0x940
[  390.523172]  tcp_v4_rcv+0x1ec4/0x3078
[  390.526825]  ip_protocol_deliver_rcu+0xc0/0x3f0
[  390.531347]  ip_local_deliver_finish+0x2d4/0x5c0
[  390.535954]  ip_local_deliver+0x17c/0x3c0
[  390.539953]  ip_rcv_finish+0x148/0x238
[  390.543693]  ip_rcv+0xd0/0x2e0
[  390.546737]  __netif_receive_skb_one_core+0x100/0x180
[  390.551780]  __netif_receive_skb+0x2c/0x160
[  390.555953]  process_backlog+0x230/0x6f8
[  390.559866]  __napi_poll.constprop.0+0x9c/0x3e8
[  390.564386]  net_rx_action+0x808/0xb50
[  390.568125]  handle_softirqs.constprop.0+0x23c/0xca0
[  390.573082]  __local_bh_enable_ip+0x260/0x4f0
[  390.577429]  __dev_queue_xmit+0x6f4/0x1bd8
[  390.581515]  neigh_hh_output+0x190/0x2c0
[  390.585429]  ip_finish_output2+0x7c8/0x1788
[  390.589602]  __ip_finish_output+0x2c4/0x4f8
[  390.593776]  ip_finish_output+0x3c/0x2a8
[  390.597689]  ip_output+0x154/0x418
[  390.601081]  __ip_queue_xmit+0x580/0x1108
[  390.605081]  ip_queue_xmit+0x4c/0x78
[  390.608647]  __tcp_transmit_skb+0xfac/0x24e8
[  390.612908]  tcp_write_xmit+0xbec/0x3078
[  390.616821]  __tcp_push_pending_frames+0x90/0x2b8
[  390.621515]  tcp_send_fin+0x108/0x9a8
[  390.625167]  tcp_shutdown+0xd8/0xf8
[  390.628646]  inet_shutdown+0x14c/0x2e8
[  390.632385]  kernel_sock_shutdown+0x5c/0x98
[  390.636560]  __nvme_tcp_stop_queue+0x44/0x220 [nvme_tcp]
[  390.641865]  nvme_tcp_stop_queue_nowait+0x130/0x200 [nvme_tcp]
[  390.647691]  nvme_tcp_setup_ctrl+0x3bc/0x728 [nvme_tcp]
[  390.652909]  nvme_tcp_reconnect_ctrl_work+0x78/0x290 [nvme_tcp]
[  390.658822]  process_one_work+0x80c/0x1a78
[  390.662910]  worker_thread+0x6d0/0xaa8
[  390.666650]  kthread+0x304/0x3a0
[  390.669869]  ret_from_fork+0x10/0x20
[  390.673437] task:kworker/u322:77 state:D stack:27184 pid:4784
tgid:4784  ppid:2      task_flags:0x4208060 flags:0x00000210
[  390.684562] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tcp]
[  390.691256] Call trace:
[  390.693692]  __switch_to+0x1d8/0x330 (T)
[  390.697605]  __schedule+0x860/0x1c30
[  390.701171]  schedule_rtlock+0x30/0x70
[  390.704911]  rwbase_write_lock.constprop.0.isra.0+0x2fc/0xb30
[  390.710646]  rt_write_lock+0x9c/0x138
[  390.714299]  nvmet_tcp_release_queue_work+0x168/0xb48 [nvmet_tcp]
[  390.720384]  process_one_work+0x80c/0x1a78
[  390.724470]  worker_thread+0x6d0/0xaa8
[  390.728210]  kthread+0x304/0x3a0
[  390.731428]  ret_from_fork+0x10/0x20


-- 
Best Regards,
  Yi Zhang


