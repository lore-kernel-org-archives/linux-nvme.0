Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B689C35274
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 02:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hBAw4W9eOcWY8QiJrtgichFrCjMMDhIkp9AlU4B40/g=; b=QWjJfP5/w09dHIcUwBUuleBCEt
	wpxCwbSvHVjPyPpX/Jr6pM8S/l99iGEshr0FdggGqVO3z1MPiW4A5S2dzE19kirSad2zua7vluAZk
	36yYRPPPy5OD3/mZc1EBSfAQAsls6d+ZSYmZfXp/YlVAzhbyQoKE9VIOKXmrsVjFks9qHChutusrQ
	8X585UcYE2JfLoSbUeXQkn7PNZkqxZhZUL7gvsvVP5iPve+e3GCK3jEJMiL/q1VG+5qywO2mgkHR3
	lOuq+r1YS+4eNv2XVL/KiECj1FFP4y/5T/gFiSFPGc0SLkDK46wemTH8XXMjgwN4SEfXVoYHlKHXX
	4OGIIj/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFPr4-00CaHF-0h;
	Tue, 19 Dec 2023 02:29:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFPqx-00CaDx-1E
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 02:29:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702952940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBAw4W9eOcWY8QiJrtgichFrCjMMDhIkp9AlU4B40/g=;
	b=CJPU0mkhgT2EBFz7wDg5bus8+QnDA7SINSdYi//NYaT/9hVTObtYaAKBEuiIfTPqeNoM+2
	SOUXCr7mmQB7RU5SVuOCUdIsCqD4p5UBRXFVF8cZ3PElzXivZ7BR8LIjb61UCCwNfArSv9
	wLbGutwHWWNM8DD6fHYU2QA/lWDtZzg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-oApdb8jdMSuH07bwity6QQ-1; Mon, 18 Dec 2023 21:28:59 -0500
X-MC-Unique: oApdb8jdMSuH07bwity6QQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-59127c4e538so4011530eaf.0
        for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 18:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702952938; x=1703557738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBAw4W9eOcWY8QiJrtgichFrCjMMDhIkp9AlU4B40/g=;
        b=syUvueUB+DVjwCr2kY3mVp0NJ3pUaeqSBfInXJonLtMMsiUDxKybBrvb4UvKwFluyK
         DI/awGqhhiI6onBTdQ1xV/E4SYvAPjbnTSJatMOV6ovfVzh4+oX2Ed2UbEG5av0DZPuT
         5DsYS3ntxt4gVJMLAHi86w7nDI6nivyv6nxlzL8zR3057Aeh3v+owrX0T5YYmYLr5ucd
         ZpU6gUpu7JmOxbHE6a87RHpqMI6sVpDjeNSE4/r51V7s7sBeYxkCzkAAsYHlsqokm03P
         CX7muSMQmshsOQoS6DHn82yN5B+ycqSc3E5sSEwnTb7vivWVOKJLcm8IIUvkycCL2TwG
         W0Sg==
X-Gm-Message-State: AOJu0Yy6F3BFdmjB8ZIm/2KdfGyvbD5ojczLOitC6UKv8ypCzA+C11rW
	SHceL38nAO4CjwACXdblTWqQ+Wonj7Zqq4Yj+kz/qgv70f9VI7UwZjI8FLmCi50DRJBXLO9WWDb
	k43BE4vK+oO2z4lThC9l057566mVVwkCcfEK+pYF9Z+E=
X-Received: by 2002:a05:6358:a1b:b0:170:17eb:14d1 with SMTP id 27-20020a0563580a1b00b0017017eb14d1mr8898514rwa.65.1702952938067;
        Mon, 18 Dec 2023 18:28:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj36R74z1jAoIxVoSTuiEkdX3dE2Ixs3DSOL3wTDmZNeElxybfN5gczKcylyqC7Z6BAFIF6+A6Vfh2D5fBDDg=
X-Received: by 2002:a05:6358:a1b:b0:170:17eb:14d1 with SMTP id
 27-20020a0563580a1b00b0017017eb14d1mr8898509rwa.65.1702952937667; Mon, 18 Dec
 2023 18:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20231215143136.252497-1-mlombard@redhat.com> <ZXyMCcq7I0ZBNU-K@kbusch-mbp>
 <CAFL455=U3g4QJNYGW76A8nAiTes2BEW9vhtU+ivQOVDK27ZWhA@mail.gmail.com>
In-Reply-To: <CAFL455=U3g4QJNYGW76A8nAiTes2BEW9vhtU+ivQOVDK27ZWhA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 19 Dec 2023 10:28:45 +0800
Message-ID: <CAHj4cs8rGk3KxYsahP6FhdsyeBCbrT5GE5ZPqLZ0WW5rQsv0jA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: fix sleeping function called from interrupt context
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_182904_775666_8EC10468 
X-CRM114-Status: GOOD (  16.15  )
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

On Sat, Dec 16, 2023 at 1:33=E2=80=AFAM Maurizio Lombardi <mlombard@redhat.=
com> wrote:
>
> p=C3=A1 15. 12. 2023 v 18:25 odes=C3=ADlatel Keith Busch <kbusch@kernel.o=
rg> napsal:
> >
> > What async event occured to cause this? It looks like the only AEN
> > handling that cancels anything is the FW activation one, but that only
> > applies to fabrics, not pci. Still, that AEN hanlder sets the state to
> > "RESETTING", but we only cancel work when transitioning to "LIVE" from =
a
> > CONNECTING state.
> >
>
> It has been hit by Yi Zhang (added to CC now, if he wants to provide
> more details)
> during an nvme drive firmware update.
> He also said that he is able to reproduce it reliably.

Yes, it was observed during NVMe SSD FW update, add the full log here
in case it helps.
[  432.740505] BUG: sleeping function called from invalid context at
kernel/workqueue.c:3341
[  432.748751] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:
0, name: swapper/3
[  432.756582] preempt_count: 10001, expected: 0
[  432.760951] RCU nest depth: 0, expected: 0
[  432.765059] no locks held by swapper/3/0.
[  432.769081] irq event stamp: 505030
[  432.772582] hardirqs last  enabled at (505029):
[<ffffffff8c789e61>] cpuidle_idle_call+0x1f1/0x280
[  432.781550] hardirqs last disabled at (505030):
[<ffffffff8ec3e059>] common_interrupt+0x19/0xd0
[  432.790252] softirqs last  enabled at (505010):
[<ffffffff8ec7d59b>] __do_softirq+0x5db/0x8f8
[  432.798779] softirqs last disabled at (505003):
[<ffffffff8c657afc>] __irq_exit_rcu+0xbc/0x210
[  432.807394] Preemption disabled at:
[  432.807399] [<ffffffff8c56c8e0>] unwind_next_frame+0xb0/0x2030
[  432.816736] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.7.0-rc5+ #2
[  432.823011] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.9.3 08/05/2022
[  432.830584] Call Trace:
[  432.833048]  <IRQ>
[  432.835075]  dump_stack_lvl+0x64/0xb0
[  432.838754]  __might_resched+0x367/0x590
[  432.842702]  ? __flush_work+0xb3/0x180
[  432.846463]  start_flush_work+0x2e/0x870
[  432.850399]  ? __flush_work+0xb3/0x180
[  432.854167]  ? __flush_work+0xb3/0x180
[  432.857931]  __flush_work+0xef/0x180
[  432.861516]  ? __flush_work+0xb3/0x180
[  432.865284]  ? __pfx___flush_work+0x10/0x10
[  432.869519]  ? srso_return_thunk+0x5/0x5f
[  432.873535]  ? find_held_lock+0x33/0x120
[  432.877473]  ? srso_return_thunk+0x5/0x5f
[  432.881491]  ? local_clock_noinstr+0xd/0xc0
[  432.885688]  ? srso_return_thunk+0x5/0x5f
[  432.889708]  ? find_held_lock+0x33/0x120
[  432.893644]  ? srso_return_thunk+0x5/0x5f
[  432.897664]  ? local_clock_noinstr+0xd/0xc0
[  432.901866]  ? srso_return_thunk+0x5/0x5f
[  432.905887]  ? try_to_grab_pending.part.0+0x23/0x5d0
[  432.910862]  ? __pfx___lock_acquired+0x10/0x10
[  432.915328]  __cancel_work_timer+0x31a/0x460
[  432.919612]  ? __pfx___cancel_work_timer+0x10/0x10
[  432.924419]  ? __wake_up+0x44/0x60
[  432.927840]  ? nvme_change_ctrl_state+0x148/0x370 [nvme_core]
[  432.933626]  ? srso_return_thunk+0x5/0x5f
[  432.937651]  ? do_raw_spin_unlock+0x59/0x1f0
[  432.941935]  ? srso_return_thunk+0x5/0x5f
[  432.945953]  ? _raw_spin_unlock_irqrestore+0x46/0x80
[  432.950928]  ? srso_return_thunk+0x5/0x5f
[  432.954948]  ? nvme_change_ctrl_state+0x148/0x370 [nvme_core]
[  432.960735]  nvme_complete_async_event+0x270/0x4e0 [nvme_core]
[  432.966600]  ? srso_return_thunk+0x5/0x5f
[  432.970633]  nvme_poll_cq+0x253/0x10d0 [nvme]
[  432.975042]  ? __pfx_nvme_irq+0x10/0x10 [nvme]
[  432.979508]  nvme_irq+0x91/0x100 [nvme]
[  432.983364]  ? __pfx_nvme_irq+0x10/0x10 [nvme]
[  432.987820]  ? __pfx___lock_release+0x10/0x10
[  432.992197]  ? __lock_acquired+0x207/0x7b0
[  432.996314]  ? srso_return_thunk+0x5/0x5f
[  433.000333]  ? rcu_is_watching+0x15/0xb0
[  433.004274]  __handle_irq_event_percpu+0x1f3/0x630
[  433.009104]  handle_irq_event+0xaa/0x1c0
[  433.013047]  handle_edge_irq+0x211/0xb70
[  433.017005]  __common_interrupt+0x99/0x180
[  433.021126]  common_interrupt+0xa8/0xd0
[  433.024976]  </IRQ>
[  433.027088]  <TASK>
[  433.029212]  asm_common_interrupt+0x26/0x40
[  433.033405] RIP: 0010:mwait_idle+0x53/0x80
[  433.037514] Code: 31 d2 48 89 d1 65 48 8b 04 25 40 54 20 00 0f 01
c8 48 8b 00 a8 08 75 13 eb 07 0f 00 2d 86 de 3e 00 31 c0 48 89 c1 fb
0f 01 c9 <fa> 65 48 8b 04 25 40 54 20 00 f0 80 60 02 df e9 09 a5 03 00
0f ae
[  433.056268] RSP: 0018:ffffc9000035fde0 EFLAGS: 00000246
[  433.061502] RAX: 0000000000000000 RBX: 1ffff9200006bfbe RCX: 00000000000=
00000
[  433.068641] RDX: 0000000000000000 RSI: ffffffff8f0e82e0 RDI: ffffffff8f3=
81020
[  433.075786] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed11c79=
c009d
[  433.082924] R10: ffff888e3ce004eb R11: 0000000000000000 R12: 00000000000=
00000
[  433.090067] R13: ffff888100d437c0 R14: dffffc0000000000 R15: ffffffff911=
ca560
[  433.097248]  default_idle_call+0x67/0xa0
[  433.101185]  cpuidle_idle_call+0x1f1/0x280
[  433.105298]  ? __pfx_cpuidle_idle_call+0x10/0x10
[  433.109933]  ? srso_return_thunk+0x5/0x5f
[  433.113950]  ? tsc_verify_tsc_adjust+0x23/0x2e0
[  433.118491]  ? rcu_is_watching+0x15/0xb0
[  433.122439]  do_idle+0x13f/0x220
[  433.125690]  cpu_startup_entry+0x55/0x60
[  433.129623]  start_secondary+0x210/0x290
[  433.133560]  ? __pfx_start_secondary+0x10/0x10
[  433.138018]  ? srso_return_thunk+0x5/0x5f
[  433.142048]  ? soft_restart_cpu+0x15/0x15
[  433.146078]  secondary_startup_64_no_verify+0x17d/0x18b
[  433.151354]  </TASK>
[  433.848442] nvme nvme2: controller capabilities changed, reset may
be required to take effect.
[  447.145607] usbcore: registered new interface driver usb-storage
[  448.847188] usb 3-1.1.2: new high-speed USB device number 5 using xhci_h=
cd
[  448.944597] usb 3-1.1.2: New USB device found, idVendor=3D413c,
idProduct=3D0003, bcdDevice=3D 0.00
[  448.953264] usb 3-1.1.2: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[  448.960842] usb 3-1.1.2: Product: iDRAC VIRTUAL MEDIA
[  448.965943] usb 3-1.1.2: Manufacturer: DELL INC.
[  448.970595] usb 3-1.1.2: SerialNumber: 1028  123456
[  448.985241] usb-storage 3-1.1.2:1.0: USB Mass Storage device detected
[  448.995572] scsi host10: usb-storage 3-1.1.2:1.0
[  449.057487] usbcore: registered new interface driver uas
[  450.045215] scsi 10:0:0:0: Direct-Access     Linux    SECUPD
   0001 PQ: 0 ANSI: 0
[  450.061871] sd 10:0:0:0: Attached scsi generic sg1 type 0
[  450.062322] sd 10:0:0:0: Power-on or device reset occurred
[  450.075276] sd 10:0:0:0: [sdb] 61440 512-byte logical blocks: (31.5
MB/30.0 MiB)
[  450.203155] sd 10:0:0:0: [sdb] Write Protect is off
[  450.208140] sd 10:0:0:0: [sdb] Mode Sense: 23 00 00 00
[  450.322600] sd 10:0:0:0: [sdb] No Caching mode page found
[  450.328074] sd 10:0:0:0: [sdb] Assuming drive cache: write through
[  450.584913]  sdb: sdb1
[  450.590688] sd 10:0:0:0: [sdb] Attached SCSI removable disk
[  470.432864] usb 3-1.1.2: USB disconnect, device number 5

>
> Maurizio
>


--=20
Best Regards,
  Yi Zhang


