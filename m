Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DE9C282D9
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 08:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WstflJwOKcHhDHAGRoeZWYR9qd28A8X/ITaM3cnKcLU=; b=kdpaNGyl/rxUsPE6WzUuU5PzL8
	r6x9VvfFMUfaAJ2f4bvo1KQ7jy2lDR8wCVwrhIpRRwKl+v5umbDsQ9x5n2F035E/FqfHTrOEq4RRj
	xrFRBBAnPP2rUSuN9EgLlfCmKKwwExLthxdQat5ppqaiptAaSNTDbVeW3OOU+Yp3tIXe0wY52Yghx
	Ivd3/Q+oM2Fjb56FHx0dXX+Y9UdPWylqZnK7/c/DSBRX9RrI5iqgGSxtbgLFEK1wAaO+1GkZFjdsP
	0FzhP2A0a1vuNL5vXSaUmUNJv/6H//JdunUfpmW/X/H4pEuZ3sJagd48b2pQJ86TQ+Uu+IjhYRlKp
	IEG5T7bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpk2b-00000007MHt-3OgU;
	Wed, 05 Mar 2025 08:23:45 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpjzu-00000007Lwt-0bW1
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 08:21:00 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3910e101d0fso1982615f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 05 Mar 2025 00:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741162856; x=1741767656; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WstflJwOKcHhDHAGRoeZWYR9qd28A8X/ITaM3cnKcLU=;
        b=MV1kg/CdtSqLkj/ppC/utNryetdSKYE0XYWpAtrx2DnDhYbGHX1sZBW4i/MOVTfFR2
         j93QwNf9f2gtahr1cqJS+vVOrsdJ/NjRCJf4cSjnwz+0f+KX8nA/oAzLD2Y/L16AV1xU
         Vu87pOxAzM0cXOtgGCBnoqLREyLP1VDAAVc9raCB8q5dvDitjNJEdx6J8lWwAtoOgDvz
         8lbQQydOzaboOtGoZnrddWmH4MpJTnPRDqfSLgtPM81eON7vRJlEXS6RwsAKqmb/4usq
         kItwp/YlclQjGVtA7ucmxpHGzCPO42Xf7JB8O8adASTBbmf/0ryOLCeSFL8bnNHYlH02
         6HUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162856; x=1741767656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WstflJwOKcHhDHAGRoeZWYR9qd28A8X/ITaM3cnKcLU=;
        b=kqtv6+/KKJI+3IsPW2oy2cjxY/31g8tAhty4oDHcju2JJTeq60uyow2L3SCBsJIHoy
         CXHOGqORsenfofomLACXe8Fs2mIilUH3dytjFBypYanCql4D+lirLxvjQuLhyc2G0+4O
         cOQnOyRol4OShv5xp/P3wzMpdedf8kvS4XsUvuvbJS6bsvG0bqZZeKJoAU4IkC0OcReP
         sLFm8ypv/Y6enugSyA69IqvuF9sql+EtupOAwHgotizgEjV0f/HJiLLlmM6yCcJbiH2Q
         joY9G3qZajGOpi7p8L7HjleXWodfFsyFl7gVSuSFoNEEJxLeP4aArf1wpNtlwYynSzOt
         HcRA==
X-Forwarded-Encrypted: i=1; AJvYcCWTJ/05deu99nkXu/yZmRRXnSgHhLHUkn12dILEjm14HvTwKZDGMRTC4uR3U0aLHOjT+R3uEiZZbAXQ@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1FZ2FKbPH7vuBvKRrK1q0FhCO8vRX6kGfbp+L/Bp6qylO5Lti
	AavmlgexATrTE0mN9cWJRrG4+lUVtDo0Q3zGRTEwsm0GreULpYAf8wVL2QFwddukEDLm3kTEwc4
	D8yM=
X-Gm-Gg: ASbGncu5v6ycfC7srGBsCba5Ipqa1nqql8XcYfdDDU8ysAziq2Sq2dfG8211VPpa0UL
	nfz5czsr9niiPCnLHtuAg2hT2XKXQsK4JBQh/e9jPQM3oUucW6/ayErJPwv/5InACetntu7Lco/
	b2cCjkhs/iMnc9nmUhK4/h+sEMzD/R2D7K0S+SHjZq+cG44qD+YIqSk+LuKdMs3qrdlDTwc+mCF
	H8ZTjK9Wct8dkZGOZFNCxwzn44kwzCw0I7Y69uvH3dEECw5jV87NY/MXkeykeJgAxewzEnV3VpW
	ZPNPYMNGMhR+Lms7PFjaJXGHWq4v4EViC3hiAy2DY4BRVQdzoHIkzFPswMKJh7ZfeoGUcNMu30Q
	Cts+dK6zg1g==
X-Google-Smtp-Source: AGHT+IEAkj4nFKh5XmT6XTDGea5rdD5iNWGSoZ6uQmLsfSiyS4yVckbQm32RaOrZ0zLDfWxwkT/AOQ==
X-Received: by 2002:a5d:6d06:0:b0:391:122c:8ab with SMTP id ffacd0b85a97d-3911f756724mr1275068f8f.22.1741162856237;
        Wed, 05 Mar 2025 00:20:56 -0800 (PST)
Received: from [192.168.178.47] (aftr-62-216-202-7.dynamic.mnet-online.de. [62.216.202.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844adfsm20346370f8f.62.2025.03.05.00.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:20:55 -0800 (PST)
Message-ID: <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
Date: Wed, 5 Mar 2025 09:20:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Vlastimil Babka <vbabka@suse.cz>, Hannes Reinecke <hare@suse.de>,
 Matthew Wilcox <willy@infradead.org>
Cc: Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
 <Z8dA8l1NR-xmFWyq@casper.infradead.org>
 <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
 <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_002058_191940_540E91F5 
X-CRM114-Status: GOOD (  11.74  )
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

On 3/4/25 20:44, Vlastimil Babka wrote:
> On 3/4/25 20:39, Hannes Reinecke wrote:
[ .. ]
>>
>> Good news and bad news ...
>> Good news: TLS works again!
>> Bad news: no errors.
> 
> Wait, did you add a WARN_ON_ONCE() to the put_page() as I suggested? If yes
> and there was no error, it would have to be leaking the page. Or the path
> uses folio_put() and we'd need to put the warning there.
> 
That triggers:
[   42.364339] page dumped because: VM_WARN_ON_FOLIO(folio_test_slab(folio))
[   42.364379] ------------[ cut here ]------------
[   42.375500] WARNING: CPU: 0 PID: 236 at ./include/linux/mm.h:1564 
sk_msg_free_elem+0x157/0x180
[   42.375642] Modules linked in: tls(E) nvme_tcp(E) af_packet(E) 
iscsi_ibft(E) iscsi_boot_sysfs(E) xfs(E) nls_iso8859_1(E) nls_cp437(E) 
vfat(E) fat(E) iTCO_wdt(E) intel_pmc_bxt(E) intel_rapl_msr(E) 
iTCO_vendor_support(E) intel_rapl_common(E) i2c_i801(E) bnxt_en(E) 
i2c_mux(E) lpc_ich(E) mfd_core(E) i2c_smbus(E) virtio_balloon(E) 
joydev(E) button(E) nvme_fabrics(E) nvme_keyring(E) nvme_core(E) fuse(E) 
nvme_auth(E) efi_pstore(E) configfs(E) dmi_sysfs(E) ip_tables(E) 
x_tables(E) hid_generic(E) usbhid(E) ahci(E) libahci(E) libata(E) 
virtio_scsi(E) sd_mod(E) scsi_dh_emc(E) scsi_dh_rdac(E) scsi_dh_alua(E) 
qxl(E) sg(E) ghash_clmulni_intel(E) xhci_pci(E) drm_client_lib(E) 
drm_exec(E) drm_ttm_helper(E) sha512_ssse3(E) xhci_hcd(E) ttm(E) 
sha256_ssse3(E) drm_kms_helper(E) scsi_mod(E) sha1_ssse3(E) usbcore(E) 
scsi_common(E) drm(E) serio_raw(E) btrfs(E) blake2b_generic(E) xor(E) 
raid6_pq(E) efivarfs(E) qemu_fw_cfg(E) virtio_rng(E) aesni_intel(E) 
crypto_simd(E) cryptd(E)
[   42.393292] CPU: 0 UID: 0 PID: 236 Comm: kworker/0:1H Kdump: loaded 
Tainted: G            E      6.14.0-rc4-default+ #316 
cadaa81909a6170d00e1f47f3fc0db03c6a03650
[   42.393303] Tainted: [E]=UNSIGNED_MODULE
[   42.393305] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
0.0.0 02/06/2015
[   42.393310] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
[   42.393323] RIP: 0010:sk_msg_free_elem+0x157/0x180
[   42.393331] Code: ff 48 c7 c6 d0 42 4f 82 48 89 ef e8 b3 63 8a ff 0f 
0b 48 8d 6a ff e9 6c ff ff ff 48 c7 c6 a0 42 4f 82 48 89 ef e8 99 63 8a 
ff <0f> 0b e9 c7 fe ff ff 2b 87 78 01 00 00 8b 97 c0 00 00 00 29 d0 ba
[   42.393336] RSP: 0018:ffffc9000040b798 EFLAGS: 00010282
[   42.393341] RAX: 000000000000003d RBX: ffff888110ab0858 RCX: 
0000000000000027
[   42.393344] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 
ffff88817f423748
[   42.393347] RBP: ffffea0004295e00 R08: 0000000000000000 R09: 
0000000000000001
[   42.393350] R10: ffffc9000040b780 R11: ffffc9000040b4e0 R12: 
0000000000000400
[   42.393353] R13: ffff888110ab0818 R14: 0000000000000002 R15: 
ffff88810fa669d8
[   42.393361] FS:  0000000000000000(0000) GS:ffff88817f400000(0000) 
knlGS:0000000000000000
[   42.393365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.393369] CR2: 00007f56a6ea6da4 CR3: 000000011bfc0000 CR4: 
0000000000350ef0
[   42.416071] Call Trace:
[   42.416078]  <TASK>
[   42.416084]  ? __warn+0x85/0x130
[   42.416095]  ? sk_msg_free_elem+0x157/0x180
[   42.418893]  ? report_bug+0xf8/0x1e0
[   42.418904]  ? handle_bug+0x50/0xa0
[   42.418910]  ? exc_invalid_op+0x13/0x60
[   42.418916]  ? asm_exc_invalid_op+0x16/0x20
[   42.418935]  ? sk_msg_free_elem+0x157/0x180
[   42.423206]  ? sk_msg_free_elem+0x157/0x180
[   42.423215]  __sk_msg_free+0x4f/0x100
[   42.423224]  tls_tx_records+0x118/0x190 [tls 
80cce2d02933ba636eb5845a829121ac309b44ed]
[   42.426506]  bpf_exec_tx_verdict+0x249/0x5e0 [tls 
80cce2d02933ba636eb5845a829121ac309b44ed]
[   42.426519]  ? srso_return_thunk+0x5/0x5f
[   42.426526]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[   42.426572]  tls_sw_sendmsg+0x72f/0x9f0 [tls 
80cce2d02933ba636eb5845a829121ac309b44ed]
[   42.432016]  __sock_sendmsg+0x98/0xc0
[   42.432025]  sock_sendmsg+0x5c/0xa0
[   42.432030]  ? srso_return_thunk+0x5/0x5f
[   42.432034]  ? __sock_sendmsg+0x98/0xc0
[   42.432040]  ? srso_return_thunk+0x5/0x5f
[   42.436134]  ? sock_sendmsg+0x5c/0xa0
[   42.436146]  nvme_tcp_try_send_data+0x13f/0x410 [nvme_tcp 
9f4f1c84141d3edfcd3e478eb7c2fb638b4a92b3]
[   42.436159]  ? srso_return_thunk+0x5/0x5f
[   42.439452]  ? sched_balance_newidle+0x2f6/0x400
[   42.439468]  nvme_tcp_try_send+0x299/0x330 [nvme_tcp 
9f4f1c84141d3edfcd3e478eb7c2fb638b4a92b3]
[   42.439479]  nvme_tcp_io_work+0x37/0xb0 [nvme_tcp 
9f4f1c84141d3edfcd3e478eb7c2fb638b4a92b3]
[   42.443603]  process_scheduled_works+0x97/0x400
[   42.443614]  ? __pfx_worker_thread+0x10/0x10
[   42.443619]  worker_thread+0x105/0x240
[   42.443625]  ? __pfx_worker_thread+0x10/0x10
[   42.443630]  kthread+0xec/0x200
[   42.443639]  ? __pfx_kthread+0x10/0x10
[   42.443646]  ret_from_fork+0x30/0x50
[   42.443652]  ? __pfx_kthread+0x10/0x10
[   42.443658]  ret_from_fork_asm+0x1a/0x30
[   42.451127]  </TASK>
[   42.451131] ---[ end trace 0000000000000000 ]---

Not surprisingly, though, as the original code did a get_page(), so
there had to be a corresponding put_page() somewhere.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

