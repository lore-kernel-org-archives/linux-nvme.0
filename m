Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9644EE57D7
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sasckX6b7u18K6WDQHmpQpoGwYnwoVcA8/TWuUcDKqc=; b=XrGdUVeMyECDLQlccWA3vQrlhJ
	wN7E+pY2UfMl23Lekz9O1ZEYRsVa6Rw5PM38B7VUj42+AXiqwhxL5ocCFXTlk+MdabHUoreraeSFN
	ZHIJc4KkVp922g5t7K4p3DQnUYFimahzzOHwMp+dxVtGIEHpuAHM4eX1rKvK8KGWi4JIsm0Y7xG4r
	+celkWRcUK3LxWdV5Z8S/f3wVHT2MEL7f8xmLBp/CAEBnWnjSwYubEVAX+aSHQrT0YwwbxPbifqHw
	5sYOM0t7EGcdMgkYUg3BjheG9r5mBxEkXqbpMNuhMBCubMP75k5J4JJQwo0lWEsxmTmXoQrvovBb6
	0d2tmoPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vay5Z-00000006505-1N4R;
	Wed, 31 Dec 2025 15:26:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vay5X-000000064zG-0HHP
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 15:26:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767194773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=sasckX6b7u18K6WDQHmpQpoGwYnwoVcA8/TWuUcDKqc=;
	b=bhO7a4R+wO/4P65cr48062roq28/rOWY+TU91wDQnPrnlvZGurv+VyZgpiYK6oCH7IhFgC
	EkTz7jIRX+7zB59TuQ6sASTvvAvOhMg1zBh+J9+Zu3DqS8EK28I7tziLibWDZzi3Omol41
	t1KXaSFfTIxIG/i8u/2kCS3WcRC/iWQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-OnkbnYa7ORa2ssOcc7weLA-1; Wed, 31 Dec 2025 10:26:12 -0500
X-MC-Unique: OnkbnYa7ORa2ssOcc7weLA-1
X-Mimecast-MFC-AGG-ID: OnkbnYa7ORa2ssOcc7weLA_1767194771
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-595892a3910so9021187e87.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 07:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767194769; x=1767799569;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sasckX6b7u18K6WDQHmpQpoGwYnwoVcA8/TWuUcDKqc=;
        b=nFNQKOQmuj/EzM1rTc2E6IvNX+BdsLwpbtT0VokvHTgjGRMvh7LZyelBhUeKqxSABJ
         NbXbsNyvgrQTHgftZ/lO+Vp5/onc68Q5AsbM3xbYkTBLACYvFnPuOrSeqiITTPaFDfPZ
         LXQDJ+jCoHIRuA13BX95PnN/TfoYo0+SFS46IpShoWsWKBm0uxtQYdeaAeM3ZijNcnqT
         PavyQtTgYyCrg/MKZaTkx01ESUs+m7sUNJ8hxexKkmrzdURyyv8EHFFtmhx8JdD0dBfB
         Haa+xbMeDJBKmpEFBPCDqzkq4ofFp+59992WOh1a9wBazZC05dPHVbp5af85pAI63y2R
         Ru8w==
X-Gm-Message-State: AOJu0YyKhl6hwZ79J8BOGkP3VZmxWmyR63rYyZKduHghq3pQKNw302zD
	az7/cCn6KQV5SUXp3dI78l7eN31bUym+i8UhxqHPUq5psFiZ5cgZm29PoSilbK6xTI6DePXiMBf
	Xpoa4bGwD8IRkUmODx9xrLavsd9X2F/8QDXFuQPPB/GkQQWdMOwl/iCAxZkJ4pz5EpAHyAifH6K
	WSxvM76nCw492BE+6BwQ16JgKmZTS3Bh/0Cdxswp2p709QEMBaBrlQOg==
X-Gm-Gg: AY/fxX4bVBk4a3elP6FAArmOQj3ElMyK89E4sM6SOC1fOjCVq/C+jLSPX6N8XzQ0UBL
	f9xBM9yiZxQwax8gb8HcgEabypmuYSx+JlLUY0BYMrUn35U7lGongo9ajaAV9Dd9baCjy8Hcokj
	z8GNH9jFMSsIJ8Ahuh9tgfdGfgGAy90tPL8L/7z7FkkLJhLey1iZRdzhC2HJSRY4OA7v8=
X-Received: by 2002:a2e:be84:0:b0:37e:6a32:9085 with SMTP id 38308e7fff4ca-38121689c42mr125781251fa.40.1767194769078;
        Wed, 31 Dec 2025 07:26:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUCqJFxv9b9vpagdlXQ0kZa1ZKUzqbhqfqsY+xMqxu0J5nCjAPc/O3HQCgX18oW1OUWNEVgini25/wg15WC0I=
X-Received: by 2002:a2e:be84:0:b0:37e:6a32:9085 with SMTP id
 38308e7fff4ca-38121689c42mr125781141fa.40.1767194768605; Wed, 31 Dec 2025
 07:26:08 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 31 Dec 2025 23:25:56 +0800
X-Gm-Features: AQt7F2r1BSXyoTkzTl3Kk5RhL27QX1eMw62K3QRQAwE0BmBZZnok9lAl4ZVK9hs
Message-ID: <CAHj4cs8ECGUHZFpOfNwfBsN2WzTUogo1gjXXSjbLxfGDiUW-FA@mail.gmail.com>
Subject: [bug report] Oops: general protection fault observed with blktests
 nvme/fc nvme/058
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: linux-block <linux-block@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CzbcjbzVpumOTAo__rWzjm5nub6mYg_6ywBjbidqbyk_1767194771
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_072615_175792_0B9ED160 
X-CRM114-Status: UNSURE (   6.70  )
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

Hi
I reproduced this Oops issue with blktests nvme/fc nvme/058 on the
latest linux-block/for-next .
Please help check it and let me know if you need any info/test, thanks.

[ 1188.305451] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN NOPTI
[ 1188.316668] KASAN: null-ptr-deref in range
[0x0000000000000028-0x000000000000002f]
[ 1188.324246] CPU: 12 UID: 0 PID: 3504 Comm: kworker/u67:22 Kdump:
loaded Not tainted 6.19.0-rc2+ #2 PREEMPT(voluntary)
[ 1188.334936] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.21.1 09/24/2025
[ 1188.342589] Workqueue: nvmet-wq fcloop_tgt_fcprqst_done_work [nvme_fcloop]
[ 1188.349477] RIP: 0010:kasan_byte_accessible+0x15/0x30
[ 1188.354540] Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03
48 01 c7 <0f> b6 07 3c 07 0f 96 c0 e9 4e e8 00 02 66 66 2e 0f 1f 84 00
00 00
[ 1188.373293] RSP: 0018:ffffc9000b247b00 EFLAGS: 00010286
[ 1188.378528] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 1188.385660] RDX: 0000000000000000 RSI: ffffffffb7f98667 RDI: dffffc0000000005
[ 1188.392794] RBP: 0000000000000028 R08: 0000000000000001 R09: 0000000000000000
[ 1188.399934] R10: ffffffffc13e8a04 R11: 0000000000000001 R12: ffffffffb7f98667
[ 1188.407068] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[ 1188.414200] FS:  0000000000000000(0000) GS:ffff8888656c4000(0000)
knlGS:0000000000000000
[ 1188.422293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1188.428040] CR2: 000055c898cde0b8 CR3: 000000024d0ef000 CR4: 0000000000350ef0
[ 1188.435172] Call Trace:
[ 1188.437625]  <TASK>
[ 1188.439732]  __kasan_check_byte+0x13/0x50
[ 1188.443756]  lock_acquire.part.0+0x36/0x260
[ 1188.447947]  ? srso_return_thunk+0x5/0x5f
[ 1188.451967]  ? rcu_is_watching+0x15/0xb0
[ 1188.455902]  ? srso_return_thunk+0x5/0x5f
[ 1188.459923]  ? lock_acquire+0x10b/0x140
[ 1188.463777]  _raw_spin_lock+0x37/0x80
[ 1188.467448]  ? fcloop_tgt_fcprqst_done_work+0x104/0x200 [nvme_fcloop]
[ 1188.473896]  fcloop_tgt_fcprqst_done_work+0x104/0x200 [nvme_fcloop]
[ 1188.480170]  ? trace_workqueue_execute_start+0x13b/0x190
[ 1188.485493]  process_one_work+0xd8b/0x1320
[ 1188.489610]  ? __pfx_process_one_work+0x10/0x10
[ 1188.494148]  ? srso_return_thunk+0x5/0x5f
[ 1188.498178]  ? srso_return_thunk+0x5/0x5f
[ 1188.502198]  ? assign_work+0x16c/0x240
[ 1188.505955]  worker_thread+0x5f3/0xfe0
[ 1188.509717]  ? srso_return_thunk+0x5/0x5f
[ 1188.513734]  ? __kthread_parkme+0xb4/0x200
[ 1188.517847]  ? __pfx_worker_thread+0x10/0x10
[ 1188.522124]  kthread+0x3b4/0x770
[ 1188.525364]  ? srso_return_thunk+0x5/0x5f
[ 1188.529384]  ? local_clock_noinstr+0xd/0xe0
[ 1188.533582]  ? __pfx_kthread+0x10/0x10
[ 1188.537340]  ? __lock_release.isra.0+0x1a2/0x2c0
[ 1188.541972]  ? srso_return_thunk+0x5/0x5f
[ 1188.545990]  ? rcu_is_watching+0x15/0xb0
[ 1188.549926]  ? __pfx_kthread+0x10/0x10
[ 1188.553690]  ret_from_fork+0x4ce/0x710
[ 1188.557450]  ? __pfx_ret_from_fork+0x10/0x10
[ 1188.561732]  ? srso_return_thunk+0x5/0x5f
[ 1188.565748]  ? __switch_to+0x528/0xf50
[ 1188.569512]  ? __switch_to_asm+0x39/0x70
[ 1188.573447]  ? __pfx_kthread+0x10/0x10
[ 1188.577210]  ret_from_fork_asm+0x1a/0x30
[ 1188.581157]  </TASK>
[ 1188.583352] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_fc
nvme_fabrics platform_profile dell_wmi dell_smbios amd_atl
intel_rapl_msr sparse_keymap rfkill intel_rapl_common video amd64_edac
edac_mce_amd dcdbas kvm_amd cdc_ether vfat fat usbnet kvm mii
irqbypass mgag200 dell_wmi_descriptor wmi_bmof rapl i2c_algo_bit
pcspkr acpi_cpufreq ipmi_ssif i2c_piix4 ptdma k10temp i2c_smbus
acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg
fuse loop xfs sd_mod nvme ahci libahci ghash_clmulni_intel tg3
nvme_core libata ccp nvme_keyring nvme_auth mpt3sas hkdf raid_class
sp5100_tco scsi_transport_sas wmi sunrpc dm_mirror dm_region_hash
dm_log dm_mod nfnetlink [last unloaded: nvmet]

-- 
Best Regards,
  Yi Zhang


