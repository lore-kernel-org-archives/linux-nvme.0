Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2EEC49ED6
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 18:46:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2402075C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 18:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eO6Icn2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2402075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7ik5M/vPMXK7VA0Oiz5Eren9D3hnK7ANQ83UbX84Njw=; b=eO6Icn2mbm9pAY
	H1mGhn0uoe93iiWTOAMdSUnFYKlWc4frGliOqi4eTjnZboqHu0tBkZYjweAnvWS1rtaupBxHRwiwd
	e66zcLMYcMg3qE+9ASd4s/7cOBWmDUYaRa8m7XQRgWvZRw/n7ULiczse2EsblTkG+DsPr5QF+qWCG
	DQBqZjfnHRGdoHoSINNWiF+nBQb/3cT7PQwe+oT2vwnMtQWKp4nm5t2wUrNSygwL0+wLtOItF5E3V
	mLTfpWay1Ze9XM9za3uAf6r6ybjRoNhvRmtmfldVCJu8akdfU0lcJC4ZTNDMrZaR3X9Vrdtk/3XhN
	u2E/uGbxeu7JTqAR9rGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i87dN-00057q-Br; Wed, 11 Sep 2019 18:46:29 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i87dJ-00056s-Ae
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 18:46:27 +0000
Received: by mail-wr1-f67.google.com with SMTP id h7so24742942wrw.8
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 11:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=LNPwMCPSMYGEO8xHwi+oDLk13Qc/fqScZ9u7BVqGB3E=;
 b=mzMbTuXk9LplvH1Gy2LO5erQiDkIzGOuu0bdgq5e5IQtFYmqHXDP2XU5O0uW5S5oOr
 ibg0J3hNM44s8VFV7P9gdW9L+YreLADPQOY1pw/PJFhMffxtdAXnNJn2IhTYl91LHQ9d
 Q41VmS7eDF/sogPWBfMvqbUFc/cMZboPsiUcXDk6XW7uEOmoyfMvfbo+gePxGBXSCqrf
 Dzds82HJNxjDIPbjfdiE62D+ztFKfsIzNcOI6Kw47U8tXPi3ubGjm5UPZ1m8NUDXOu7j
 oGPjhdc1SNQWzdBzouJmCQRXmYT0Osxf7DNKDCaZ3eUcuoQ7ojKZruqs5keLEH3gj/Os
 B4SA==
X-Gm-Message-State: APjAAAVujpt5P17ZEMqrqvi3PE2IgizzBN31rdLwd9Fg0Z+QumiEiKn6
 1ZBPGo7FUpz/zJkcbRTPS/s=
X-Google-Smtp-Source: APXvYqyOEe/z9YJqAMsM/vruYYi2aMP6pMiYHLfL8LZ4dNjDoMXg535dQC0PyUZh7DcX44Z96t5YGA==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr5426483wrj.52.1568227583557;
 Wed, 11 Sep 2019 11:46:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id d9sm27552067wrf.62.2019.09.11.11.46.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 11:46:22 -0700 (PDT)
To: Keith Busch <keith.busch@intel.com>,
 linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: panic in pci driver
Message-ID: <a1242213-47f1-ffa1-d71a-1b0abb1e1049@grimberg.me>
Date: Wed, 11 Sep 2019 11:46:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_114625_474545_4806542C 
X-CRM114-Status: GOOD (  10.61  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey,

Just hit the following bug on a simple test case with Qemu nvme emulation:

for i in `seq 100`; do echo 1 > 
/sys/devices/pci0000\:00/0000\:00\:0a.0/remove; echo 1 > 
/sys/bus/pci/rescan; done

Keith, is that addressed by your series with the reset_prepare stuff?

trace:
--
[ 3696.109765] nvme nvme49: pci function 0000:00:0a.0
[ 3696.141230] nvme nvme49: failed to mark controller CONNECTING
[ 3696.141235] nvme nvme49: Removing after probe failure status: -16
[ 3696.197746] pci 0000:00:0a.0: [8086:5845] type 00 class 0x010802
[ 3696.199445] pci 0000:00:0a.0: reg 0x10: [mem 0x40000000-0x40001fff 64bit]
[ 3696.203237] pci 0000:00:0a.0: reg 0x20: [mem 0x40002000-0x40002fff]
[ 3696.207154] pci 0000:00:0a.0: BAR 0: assigned [mem 
0x40000000-0x40001fff 64bit]
[ 3696.208583] pci 0000:00:0a.0: BAR 4: assigned [mem 0x40002000-0x40002fff]
[ 3696.210642] nvme nvme50: pci function 0000:00:0a.0
[ 3696.217295] pci 0000:00:0a.0: [8086:5845] type 00 class 0x010802
[ 3696.219726] pci 0000:00:0a.0: reg 0x10: [mem 0x40000000-0x40001fff 64bit]
[ 3696.226710] pci 0000:00:0a.0: reg 0x20: [mem 0x40002000-0x40002fff]
[ 3696.248463] BUG: unable to handle page fault for address: 
ffffa99fc0a0201c
[ 3696.248601] #PF: supervisor read access in kernel mode
[ 3696.248727] #PF: error_code(0x0000) - not-present page
[ 3696.248839] PGD 3e537067 P4D 3e537067 PUD 3e538067 PMD 32eec067 PTE 0
[ 3696.248961] Oops: 0000 [#1] SMP PTI
[ 3696.249074] CPU: 0 PID: 1316 Comm: kworker/u4:5 Tainted: G 
O      5.3.0-rc3+ #325
[ 3696.249259] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.10.2-1ubuntu1 04/01/2014
[ 3696.249383] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[ 3696.249497] RIP: 0010:nvme_reset_work+0x16d/0x1550 [nvme]
[ 3696.249510] pci 0000:00:0a.0: BAR 0: assigned [mem 
0x40000000-0x40001fff 64bit]
[ 3696.249646] Code: 00 00 48 81 c4 c0 00 00 00 5b 5d 41 5c 41 5d 41 5e 
41 5f c3 48 c7 c6 ff ff ff ff 48 89 df e8 0a 2d 6e e1 49 8b 86 a0 fb ff 
ff <8b> 40 1c 83 f8 ff 75 12 48 89 ef bb ed ff ff ff e8 6e e2 aa e1 e9
[ 3696.250543] RSP: 0018:ffffa99fc0903da8 EFLAGS: 00010246
[ 3696.250769] RAX: ffffa99fc0a02000 RBX: ffff926f7c1780b0 RCX: 
0000000000000004
[ 3696.251016] RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 
ffff926f7c1780b0
[ 3696.251335] RBP: ffff926f7c178000 R08: 0000000000000002 R09: 
0000000000000107
[ 3696.251573] R10: 0000000000000050 R11: ffffffffa325c908 R12: 
ffff926f7592e1c0
[ 3696.251820] R13: ffff926f7592e000 R14: ffff926f7592e5f0 R15: 
ffff926f7c1780b0
[ 3696.252056] FS:  0000000000000000(0000) GS:ffff926f7ea00000(0000) 
knlGS:0000000000000000
[ 3696.252356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3696.252561] CR2: ffffa99fc0a0201c CR3: 000000003073c003 CR4: 
00000000003606f0
[ 3696.252778] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 3696.253058] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 3696.253357] Call Trace:
[ 3696.253662]  ? __switch_to_asm+0x40/0x70
[ 3696.253900]  ? __switch_to_asm+0x34/0x70
[ 3696.254197]  ? __switch_to_asm+0x40/0x70
[ 3696.254215] pci 0000:00:0a.0: BAR 4: assigned [mem 0x40002000-0x40002fff]
[ 3696.254380]  ? __switch_to_asm+0x34/0x70
[ 3696.254759]  ? __switch_to_asm+0x40/0x70
[ 3696.254944]  ? __switch_to_asm+0x34/0x70
[ 3696.255205]  ? __switch_to_asm+0x40/0x70
[ 3696.255402]  ? __switch_to_asm+0x34/0x70
[ 3696.255594]  ? __switch_to_asm+0x40/0x70
[ 3696.255778]  ? __switch_to_asm+0x34/0x70
[ 3696.255988]  ? __switch_to_asm+0x40/0x70
[ 3696.256227]  ? __switch_to_asm+0x34/0x70
[ 3696.256369]  ? __switch_to_asm+0x40/0x70
[ 3696.256503]  ? __switch_to_asm+0x34/0x70
[ 3696.256658]  ? __switch_to+0x7a/0x3d0
[ 3696.256805]  ? __switch_to_asm+0x34/0x70
[ 3696.258092]  process_one_work+0x1f4/0x3e0
[ 3696.258738]  worker_thread+0x221/0x3e0
[ 3696.259292]  ? process_one_work+0x3e0/0x3e0
[ 3696.259778]  kthread+0x117/0x130
[ 3696.260251]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 3696.260718]  ret_from_fork+0x35/0x40
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
