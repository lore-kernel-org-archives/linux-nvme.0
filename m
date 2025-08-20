Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3C0CA0EDC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QM3AMUnt3Mwh5VELHWJ1rf97myD8v/Yo+QXct5bUreA=; b=ONztBxbZMHJKOMSUUs2vryfUYI
	DbX9CzGfq+r1YLugCJr86cWbu9cRkl5XDZcSi4on+VkoVhUXUi5gc2QezuTr0WfNSnBAHHS3uEZdB
	R4qYJHq3dzhyOWSg49s7eqdg5Az6CYpmPCI0yZBrqER7pZr4/wFtKfjg5WjJlqo4wCLoFwQBV6xe+
	wKot4PWN8dcKGi23ckqtLsJYK/uQEyj4+jQ2YwfoFD3Xa3N3MMwcGnZT9GVEnfqJyCjILi0hvC6zN
	CF5ZpI+GeusdljFH/893nkUKjOySGB81K01BqpOKUqBS4cRZXRjnPNpMUXJL9JWsUcmBhEVb2a5O/
	i510AR/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoepu-0000000Cr9q-2Nxp;
	Wed, 20 Aug 2025 09:10:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoe48-0000000CiXk-2sls
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 08:21:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755678062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QM3AMUnt3Mwh5VELHWJ1rf97myD8v/Yo+QXct5bUreA=;
	b=PrWzykArcOEQZ+NV/UKPkieExZ1hHpFDZp1klvLnWK0476eoh1Zs7hGougmiK8iWx3b0sR
	7iU5SQkL2Rtk5NXhMhGD9R9S/MWY92AAx0ut5h7hti9FmBVP114CR4QVtibkyrpD2jAG2f
	jqnk9wgfsWSiJPxzcfjAZHSkAEgEC68=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-L9SN308bMCWNemj1XY3gjw-1; Wed, 20 Aug 2025 04:21:00 -0400
X-MC-Unique: L9SN308bMCWNemj1XY3gjw-1
X-Mimecast-MFC-AGG-ID: L9SN308bMCWNemj1XY3gjw_1755678059
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-333f8cb855dso20885251fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Aug 2025 01:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678057; x=1756282857;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QM3AMUnt3Mwh5VELHWJ1rf97myD8v/Yo+QXct5bUreA=;
        b=Q+LWeN5+MQapS2Zz1hR+lnP5f2li+GVa0JHUYum+68KNuFlIu7Qbq6/zXem7WaLcdJ
         vy9jWkvqRHJs1BD6E4S2ME0ix8cHvUH2/zXHMU7luM5/93XTRLjwg8j9SglHTokyie2Q
         F7ZJMKOB9JT20uStHHVpmFw2xEnYphFVVVLeUJzL23/ofhorpxRuIj6wVHoWT0te2Nor
         5Kb//ol3AOF3R0QUbykLi8nltTZZu+taIq3ul9+brvt717FOA39OUwvghVt7WEU5qq9Q
         LjUaLaicXtOTX0xVPjJ1XAdGdmkaLctXk9X7o0BbOEmLO0oHjnXPUqL1yzsA2d1NBegc
         hNmQ==
X-Gm-Message-State: AOJu0Yz9wbLVJXIKFrEReGZwmzceVrY9yKVEyuxzg0szMIc79cayvCVm
	Kw19z+NKFTOdCqeX9wNy6gn9N83Fc4jXL/Q5w1gDXyFVXs79XiX1XrRW9elzArRRFUohwso5n7z
	m28Xm+3pPGFUZWyO5gO41ChF/4w1/W2PGGbFqRPjkc6km++oS3pISI5u4u9xI+IQAatEZrQwKSM
	6jZj72y1JhZnBvEsusLcUgKn/EG1DVscXzsuMW1nHqE0PH39IexSVjolg7
X-Gm-Gg: ASbGnct+TGu5XwxmCu2zEY2582ccPO+qL3mnJ+Y0P6IHyw9xwJHL37th7AgZRYYU8oq
	JQKW4VPn2zD40g8BE8moPZ9C5Sl720Z5EPwE+NvpR5OhMe7lfEma/xJJQ/qLMH/fT4ADsv0RZJw
	2Tylh21tmB64hrivNd95czfw==
X-Received: by 2002:a05:651c:3255:10b0:332:2d5a:db98 with SMTP id 38308e7fff4ca-3353bcab987mr3932681fa.12.1755678056247;
        Wed, 20 Aug 2025 01:20:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGddboNC1bF4jwOq6zg/2ev2hrNgjrbKUowrPEZ/W6H/nm2PSVBAexJKwsdvD25l4JmG8PK2EXUxyqwkDcRaoE=
X-Received: by 2002:a05:651c:3255:10b0:332:2d5a:db98 with SMTP id
 38308e7fff4ca-3353bcab987mr3932531fa.12.1755678055489; Wed, 20 Aug 2025
 01:20:55 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 20 Aug 2025 16:20:40 +0800
X-Gm-Features: Ac12FXxPK3LlwPTCHlH6-oF5G4g1HCQGYnqMY_rBfXc9HsdzG8RCQwrv8Oy4hIM
Message-ID: <CAHj4cs9U48Xjd-ZShsP6GjZFyp7_Sp7i2gFdT-Btfvpouu4akQ@mail.gmail.com>
Subject: [bug report] blktests nvme/fc nvme/057 triggered kernel panic
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: james.smart@broadcom.com, Maurizio Lombardi <mlombard@redhat.com>, 
	Ewan Milne <emilne@redhat.com>, Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CWQ1WHz3w5y4SM7ljaskMS12DZLTXaQ_ODqIEmnw994_1755678059
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_012104_876102_268AE030 
X-CRM114-Status: UNSURE (   5.97  )
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

My recent blktests testing triggered the kernel panic issue with
kernel 6.17.0-rc2.
Please help check it and let me know if you need any info/testing for
it, thanks.

[1] reproducer
stress blktests nvme/fc nvme/057

[2] console log
[ 2604.418664] run blktests nvme/057 at 2025-08-20 02:30:52
[ 2604.752380] loop0: detected capacity change from 0 to 2097152
[ 2604.820868] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2605.894085] nvme nvme6: NVME-FC{0}: create association : host wwpn
0x20001100aa
 rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 2605.909355] (NULL device *): {0:0} Association created
[ 2605.915164] nvmet: Created discovery controller 1 for subsystem
nqn.2014-08.org
ress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0047-5a10-804b-cac
33.
[ 2605.934576] nvme nvme6: NVME-FC{0}: controller connect complete
[ 2605.940672] nvme nvme6: NVME-FC{0}: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.d
y", hostnqn: nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0047-5a10-804b-cac04f514a33
[ 2605.970207] nvme nvme6: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discover
[ 2606.003303] nvme nvme7: NVME-FC{1}: create association : host wwpn
0x20001100aa
 rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[ 2606.016847] (NULL device *): {0:0} Association deleted
[ 2606.017327] (NULL device *): {0:1} Association created
[ 2606.030110] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1
 nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2606.047386] (NULL device *): {0:0} Association freed
[ 2606.053937] (NULL device *): Disconnect LS failed: No Association
[ 2606.057971] nvme nvme7: NVME-FC{1}: controller connect complete
[ 2606.066052] nvme nvme7: NVME-FC{1}: new ctrl: NQN
"blktests-subsystem-1", hostn
.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 2606.411263] nvme nvme6: NVME-FC{0}: create association : host wwpn
0x20001100aa
 rport wwpn 0x20001100ab000002: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 2606.426442] (NULL device *): {1:0} Association created
[ 2606.432034] nvmet: Created discovery controller 1 for subsystem
nqn.2014-08.org
ress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0047-5a10-804b-cac
33.
[ 2606.451952] nvme nvme6: NVME-FC{0}: controller connect complete
[ 2606.458055] nvme nvme6: NVME-FC{0}: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.d
y", hostnqn: nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0047-5a10-804b-cac04f514a33
[ 2606.491497] nvme nvme6: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discover
[ 2606.536804] (NULL device *): {1:0} Association deleted
[ 2606.555181] (NULL device *): {1:0} Association freed
[ 2606.560228] (NULL device *): Disconnect LS failed: No Association
[ 2606.853228] nvme nvme6: NVME-FC{0}: create association : host wwpn
0x20001100aa
 rport wwpn 0x20001100ab000003: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 2606.868538] (NULL device *): {2:0} Association created
[ 2606.874128] nvmet: Created discovery controller 1 for subsystem
nqn.2014-08.org
ress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0047-5a10-804b-cac
33.
[ 2606.893149] nvme nvme6: NVME-FC{0}: controller connect complete
[ 2606.899115] nvme nvme6: NVME-FC{0}: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.d
y", hostnqn: nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0047-5a10-804b-cac04f514a33
[ 2606.931064] nvme nvme6: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discover
[ 2606.972800] (NULL device *): {2:0} Association deleted
[ 2606.991308] (NULL device *): {2:0} Association freed
[ 2606.996338] (NULL device *): Disconnect LS failed: No Association
[ 2607.175111] nvme nvme6: NVME-FC{0}: create association : host wwpn
0x20001100aa
 rport wwpn 0x20001100ab000002: NQN "blktests-subsystem-1"
[ 2607.188856] (NULL device *): {1:0} Association created
[ 2607.194504] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1
 nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2607.219022] nvme nvme6: NVME-FC{0}: controller connect complete
[ 2607.221950] nvme nvme6: Found shared namespace 1, but multipathing
not supporte
[ 2607.225010] nvme nvme6: NVME-FC{0}: new ctrl: NQN
"blktests-subsystem-1", hostn
.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 2607.286172] nvme nvme8: NVME-FC{2}: create association : host wwpn
0x20001100aa
 rport wwpn 0x20001100ab000004: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 2607.301459] (NULL device *): {3:0} Association created
[ 2607.307118] nvmet: Created discovery controller 3 for subsystem
nqn.2014-08.org
ress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0047-5a10-804b-cac
33.
[ 2607.327420] nvme nvme8: NVME-FC{2}: controller connect complete
[ 2607.333405] nvme nvme8: NVME-FC{2}: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.d
y", hostnqn: nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0047-5a10-804b-cac04f514a33
[ 2607.366899] nvme nvme8: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discover
[ 2607.397391] (NULL device *): {3:0} Association deleted
[ 2607.414340] (NULL device *): {3:0} Association freed
[ 2607.419388] (NULL device *): Disconnect LS failed: No Association
[ 2607.814890] nvme nvme8: NVME-FC{2}: create association : host wwpn
0x20001100aa
 rport wwpn 0x20001100ab000003: NQN "blktests-subsystem-1"
[ 2607.828629] (NULL device *): {2:0} Association created
[ 2607.834493] nvmet: Created nvm controller 3 for subsystem
blktests-subsystem-1
 nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2607.861053] nvme nvme8: NVME-FC{2}: controller connect complete
[ 2607.863641] nvme nvme8: Found shared namespace 1, but multipathing
not supporte
[ 2607.867183] nvme nvme8: NVME-FC{2}: new ctrl: NQN
"blktests-subsystem-1", hostn
.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 2607.899097] nvme_log_error: 14 callbacks suppressed
[ 2607.899105] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x

[ 2607.914204] blk_print_req_error: 14 callbacks suppressed
[ 2607.914211] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1
lass 2
[ 2607.928462] Buffer I/O error on dev nvme8n1, logical block 0, async page read
936687] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct 0x3 /
sc 0x2) MORE

944798] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags 0x0
phys_seg 1 prio c

953252] Buffer I/O error on dev nvme8n1, logical block 0, async page read
961453] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct 0x3 /
sc 0x2) MORE

969655] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags 0x0
phys_seg 1 prio c

978275] Buffer I/O error on dev nvme8n1, logical block 0, async page read
[ 2607.986930] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x

[ 2607.994964] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1
lass 2
[ 2608.003844] Buffer I/O error on dev nvme8n1, logical block 0, async page read
[ 2608.011720] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x

[ 2608.019837] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1
lass 2
[ 2608.028303] Buffer I/O error on dev nvme8n1, logical block 0, async page read
[ 2608.036210] nvme8n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x

[ 2608.044242] I/O error, dev nvme8n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1
lass 2
[ 2608.052695] Buffer I/O error on dev nvme8n1, logical block 0, async page read
[ 2608.059860]  nvme8n1: unable to read partition table
[ 2608.081704] nvme8n1: I/O Cmd(0x2) @ LBA 2097024, 8 blocks, I/O
Error (sct 0x3 /
) MORE
[ 2608.091772] I/O error, dev nvme8n1, sector 2097024 op 0x0:(READ)
flags 0x80700
g 1 prio class 2
[ 2608.102246] nvme8n1: I/O Cmd(0x2) @ LBA 2097024, 8 blocks, I/O
Error (sct 0x3 /
) MORE
111117] I/O error, dev nvme8n1, sector 2097024 op 0x0:(READ) flags 0x0
phys_seg 1
ass 2
120095] Buffer I/O error on dev nvme8n1, logical block 262128, async page read
468906] nvme nvme9: NVME-FC{3}: create association : host wwpn
0x20001100aa000001
wwpn 0x20001100ab000004: NQN "blktests-subsystem-1"
482652] (NULL device *): {3:0} Association created
488505] nvmet: Created nvm controller 4 for subsystem
blktests-subsystem-1 for NQN
14-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
513373] nvme nvme9: NVME-FC{3}: controller connect complete
516394] nvme nvme9: Found shared namespace 1, but multipathing not supported.
519470] nvme nvme9: NVME-FC{3}: new ctrl: NQN "blktests-subsystem-1",
hostnqn: nqn
8.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 2608.554075] nvme9n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x

[ 2608.563267] I/O error, dev nvme9n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1
lass 2
[ 2608.571733] Buffer I/O error on dev nvme9n1, logical block 0, async page read
[ 2608.579659] nvme9n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct
0x3 / sc 0x

[ 2608.588038] I/O error, dev nvme9n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1
lass 2
[ 2608.596500] Buffer I/O error on dev nvme9n1, logical block 0, async page read
[ 2608.604352] Buffer I/O error on dev nvme9n1, logical block 0, async page read
[ 2608.614480]  nvme9n1: unable to read partition table
[ 2614.025131] nvme nvme6: NVME-FC{0}: io failed due to bad NVMe_ERSP:
iu len 8, x
4096 vs 0, status code 0, cmdid 24581 vs 24581
[ 2614.025242] nvme nvme6: NVME-FC{0}: io failed due to bad NVMe_ERSP:
iu len 8, x
4096 vs 0, status code 0, cmdid 32774 vs 32774
[ 2614.025353] nvme nvme6: NVME-FC{0}: io failed due to bad NVMe_ERSP:
iu len 8, x
4096 vs 0, status code 0, cmdid 20487 vs 20487
[ 2614.025520] nvme nvme6: NVME-FC{0}: transport association event:
transport dete
 error
[ 2614.025529] nvme nvme6: NVME-FC{0}: resetting controller
[ 2614.025688] nvme nvme6: NVME-FC{0}: io failed due to bad NVMe_ERSP:
iu len 8, x
4096 vs 0, status code 0, cmdid 8 vs 8
[ 2614.025739] nvme nvme6: NVME-FC{0}: io failed due to bad NVMe_ERSP:
iu len 8, x
4096 vs 0, status code 0, cmdid 24583 vs 24583
[ 2614.025785] nvme nvme6: NVME-FC{0}: io failed due to bad NVMe_ERSP:
iu len 8, x
4096 vs 0, status code 0, cmdid 24585 vs 24585
[ 2614.131777] nvme nvme6: NVME-FC{0}: create association : host wwpn
0x20001100aa
 rport wwpn 0x20001100ab000002: NQN "blktests-subsystem-1"
[ 2614.145506] (NULL device *): {1:1} Association created
[ 2614.151208] nvmet: Created nvm controller 5 for subsystem
blktests-subsystem-1
 nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2614.151696] (NULL device *): {1:0} Association deleted
[ 2614.173029] nvme nvme6: NVME-FC{0}: controller connect complete
[ 2614.175136] nvme_log_error: 6 callbacks suppressed
[ 2614.175142] nvme6n1: I/O Cmd(0x1) @ LBA 243640, 8 blocks, I/O Error
(sct 0x3 /
 MORE
[ 2614.175846] nvme6n1: I/O Cmd(0x1) @ LBA 1659888, 8 blocks, I/O
Error (sct 0x3 /
) MORE
[ 2614.175856] blk_print_req_error: 6 callbacks suppressed
[ 2614.175860] I/O error, dev nvme6n1, sector 1659888 op 0x1:(WRITE)
flags 0x8800
g 1 prio class 2
[ 2614.176898] nvme6n1: I/O Cmd(0x1) @ LBA 1668656, 8 blocks, I/O
Error (sct 0x3 /
) MORE
[ 2614.176907] I/O error, dev nvme6n1, sector 1668656 op 0x1:(WRITE)
flags 0x8800
g 1 prio class 2
[ 2614.177009] nvme6n1: I/O Cmd(0x1) @ LBA 1636776, 8 blocks, I/O
Error (sct 0x3 /
) MORE
[ 2614.177016] I/O error, dev nvme6n1, sector 1636776 op 0x1:(WRITE)
flags 0x8800
g 1 prio class 2
[ 2614.177113] nvme6n1: I/O Cmd(0x1) @ LBA 190192, 8 blocks, I/O Error
(sct 0x3 /
 MORE
[ 2614.177121] I/O error, dev nvme6n1, sector 190192 op 0x1:(WRITE)
flags 0x8800 p
 1 prio class 2
[ 2614.178364] nvme6n1: I/O Cmd(0x1) @ LBA 122840, 8 blocks, I/O Error
(sct 0x3 /
 MORE
[ 2614.178372] I/O error, dev nvme6n1, sector 122840 op 0x1:(WRITE)
flags 0x8800 p
 1 prio class 2
[ 2614.178474] nvme6n1: I/O Cmd(0x1) @ LBA 1756216, 8 blocks, I/O
Error (sct 0x3 /
) MORE
[ 2614.178481] I/O error, dev nvme6n1, sector 1756216 op 0x1:(WRITE)
flags 0x8800
g 1 prio class 2
[ 2614.178588] nvme6n1: I/O Cmd(0x1) @ LBA 1880664, 8 blocks, I/O
Error (sct 0x3 /
) MORE
[ 2614.178595] I/O error, dev nvme6n1, sector 1880664 op 0x1:(WRITE)
flags 0x8800
g 1 prio class 2
[ 2614.178692] nvme6n1: I/O Cmd(0x1) @ LBA 698760, 8 blocks, I/O Error
(sct 0x3 /
 MORE
[ 2614.178699] I/O error, dev nvme6n1, sector 698760 op 0x1:(WRITE)
flags 0x8800 p
 1 prio class 2
[ 2614.178795] nvme6n1: I/O Cmd(0x1) @ LBA 1337888, 8 blocks, I/O
Error (sct 0x3 /
) MORE
[ 2614.178802] I/O error, dev nvme6n1, sector 1337888 op 0x1:(WRITE)
flags 0x8800
g 1 prio class 2
[ 2614.178901] I/O error, dev nvme6n1, sector 1291776 op 0x1:(WRITE)
flags 0x8800
g 1 prio class 2
[ 2614.377374] buffer_io_error: 4 callbacks suppressed
[ 2614.377382] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[ 2614.390205] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[ 2614.398066] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[ 2614.406021] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[ 2614.414802] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[ 2614.422678] Buffer I/O error on dev nvme6n1, logical block 0, async page read
[ 2614.429865]  nvme6n1: unable to read partition table
[ 2614.433994] (NULL device *): {1:0} Association freed
[ 2614.439870] (NULL device *): Disconnect LS failed: No Association
[ 2614.458824] Buffer I/O error on dev nvme6n1, logical block 262128,
async page r
[ 2634.313576] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[ 2634.414877] nvme nvme7: Removing ctrl: NQN "blktests-subsystem-1"
[ 2634.427210] (NULL device *): {1:1} Association deleted
[ 2634.524731] nvme nvme8: Removing ctrl: NQN "blktests-subsystem-1"
[ 2634.530543] (NULL device *): {1:1} Association freed
[ 2634.535874] (NULL device *): Disconnect LS failed: No Association
[ 2634.537167] (NULL device *): {0:1} Association deleted
[ 2634.599315] ==================================================================
[ 2634.606542] BUG: KASAN: null-ptr-deref in do_raw_spin_trylock+0x68/0x180
[ 2634.613257] Read of size 4 at addr 0000000000000010 by task
kworker/u68:8/7198
[ 2634.620477]
[ 2634.621978] CPU: 6 UID: 0 PID: 7198 Comm: kworker/u68:8 Not tainted
6.17.0-rc2
MPT(voluntary)
[ 2634.621986] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.17.0 12/04/
[ 2634.621990] Workqueue: nvmet-wq fcloop_tgt_fcprqst_done_work [nvme_fcloop]
[ 2634.622005] Call Trace:
[ 2634.622009]  <TASK>
[ 2634.622015]  dump_stack_lvl+0x6f/0xb0
[ 2634.622026]  ? do_raw_spin_trylock+0x68/0x180
[ 2634.622031]  kasan_report+0xac/0xe0
[ 2634.622042]  ? do_raw_spin_trylock+0x68/0x180
[ 2634.622055]  kasan_check_range+0x10f/0x1e0
[ 2634.622065]  do_raw_spin_trylock+0x68/0x180
[ 2634.622073]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 2634.622078]  ? srso_return_thunk+0x5/0x5f
[ 2634.622086]  ? rcu_is_watching+0x15/0xb0
[ 2634.622093]  ? srso_return_thunk+0x5/0x5f
[ 2634.622098]  ? lock_acquire+0x10b/0x150
[ 2634.622103]  ? fcloop_tgt_fcprqst_done_work+0x104/0x200 [nvme_fcloop]
[ 2634.622114]  _raw_spin_lock+0x3f/0x80
[ 2634.622119]  ? fcloop_tgt_fcprqst_done_work+0x104/0x200 [nvme_fcloop]
[ 2634.622128]  fcloop_tgt_fcprqst_done_work+0x104/0x200 [nvme_fcloop]
[ 2634.622136]  ? trace_workqueue_execute_start+0x13f/0x1b0
[ 2634.622147]  process_one_work+0xd8b/0x1320
[ 2634.622163]  ? __pfx_process_one_work+0x10/0x10
[ 2634.622169]  ? srso_return_thunk+0x5/0x5f
[ 2634.622182]  ? srso_return_thunk+0x5/0x5f
[ 2634.622187]  ? assign_work+0x16c/0x240
[ 2634.622193]  ? srso_return_thunk+0x5/0x5f
[ 2634.622202]  worker_thread+0x5f3/0xfe0
[ 2634.622213]  ? srso_return_thunk+0x5/0x5f
[ 2634.622218]  ? __kthread_parkme+0xb4/0x200
[ 2634.622229]  ? __pfx_worker_thread+0x10/0x10
[ 2634.622234]  kthread+0x3b4/0x770
[ 2634.622239]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 2634.622244]  ? srso_return_thunk+0x5/0x5f
[ 2634.622250]  ? __pfx_kthread+0x10/0x10
[ 2634.622255]  ? lock_acquire+0x10b/0x150
[ 2634.622259]  ? calculate_sigpending+0x3d/0x90
[ 2634.622267]  ? srso_return_thunk+0x5/0x5f
[ 2634.622272]  ? rcu_is_watching+0x15/0xb0
[ 2634.622277]  ? srso_return_thunk+0x5/0x5f
[ 2634.622283]  ? __pfx_kthread+0x10/0x10
[ 2634.622290]  ret_from_fork+0x393/0x480
[ 2634.622297]  ? __pfx_kthread+0x10/0x10
[ 2634.622301]  ? __pfx_kthread+0x10/0x10
[ 2634.622308]  ret_from_fork_asm+0x1a/0x30
[ 2634.622328]  </TASK>
[ 2634.622332] ==================================================================
[ 2634.701121] nvme nvme8: long keepalive RTT (2338697 ms)
[ 2634.701866] Oops: general protection fault, probably for
non-canonical address
c0000000002: 0000 [#1] SMP KASAN NOPTI
[ 2634.705499] nvme nvme8: failed nvme_keep_alive_end_io error=4
[ 2634.711916] KASAN: null-ptr-deref in range
[0x0000000000000010-0x00000000000000
[ 2634.711924] CPU: 6 UID: 0 PID: 7198 Comm: kworker/u68:8 Tainted: G    B
6.17.0-rc2 #1 PREEMPT(voluntary)
[ 2634.868868] Tainted: [B]=BAD_PAGE
[ 2634.872194] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.17.0 12/04/
[ 2634.879846] Workqueue: nvmet-wq fcloop_tgt_fcprqst_done_work [nvme_fcloop]
[ 2634.886726] RIP: 0010:do_raw_spin_trylock+0x6f/0x180
[ 2634.891701] Code: 00 f1 f1 f1 f1 c7 40 04 04 f3 f3 f3 65 48 8b 35
ff 1b 84 05 4
 24 58 be 04 00 00 00 e8 08 88 89 00 48 89 d8 48 c1 e8 03 <42> 0f b6
14 20 48 89 d
 07 83 c0 03 38 d0 7c 08 84 d2 0f 85
[ 2634.910457] RSP: 0018:ffffc90000bffb90 EFLAGS: 00010212
[ 2634.915690] RAX: 0000000000000002 RBX: 0000000000000010 RCX: ffffffffb50d2a7a
[ 2634.922822] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffbad41180
[ 2634.929954] RBP: 1ffff9200017ff72 R08: 0000000000000001 R09: fffffbfff75a8230
[ 2634.937088] R10: ffffffffbad41187 R11: 6f6f6c6366203f20 R12: dffffc0000000000
[ 2634.944220] R13: 0000000000000000 R14: 0000000000000010 R15: ffff88828ed45108
[ 2634.951352] FS:  0000000000000000(0000) GS:ffff88886433b000(0000)
knlGS:0000000
00
[ 2634.959437] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2634.965183] CR2: 000055a5da1503c0 CR3: 0000000151582000 CR4: 0000000000350ef0
[ 2634.972316] Call Trace:
[ 2634.974769]  <TASK>
[ 2634.976877]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 2634.981677]  ? srso_return_thunk+0x5/0x5f
[ 2634.985696]  ? rcu_is_watching+0x15/0xb0
[ 2634.989623]  ? srso_return_thunk+0x5/0x5f
[ 2634.993635]  ? lock_acquire+0x10b/0x150
[ 2634.997476]  ? fcloop_tgt_fcprqst_done_work+0x104/0x200 [nvme_fcloop]
[ 2635.003928]  _raw_spin_lock+0x3f/0x80
[ 2635.007598]  ? fcloop_tgt_fcprqst_done_work+0x104/0x200 [nvme_fcloop]
[ 2635.014047]  fcloop_tgt_fcprqst_done_work+0x104/0x200 [nvme_fcloop]
[ 2635.020322]  ? trace_workqueue_execute_start+0x13f/0x1b0
[ 2635.025645]  process_one_work+0xd8b/0x1320
[ 2635.029760]  ? __pfx_process_one_work+0x10/0x10
[ 2635.034301]  ? srso_return_thunk+0x5/0x5f
[ 2635.038327]  ? srso_return_thunk+0x5/0x5f
[ 2635.042341]  ? assign_work+0x16c/0x240
[ 2635.046103]  ? srso_return_thunk+0x5/0x5f
[ 2635.050129]  worker_thread+0x5f3/0xfe0
[ 2635.053892]  ? srso_return_thunk+0x5/0x5f
[ 2635.057905]  ? __kthread_parkme+0xb4/0x200
[ 2635.062010]  ? __pfx_worker_thread+0x10/0x10
[ 2635.066289]  kthread+0x3b4/0x770
[ 2635.069527]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 2635.074321]  ? srso_return_thunk+0x5/0x5f
[ 2635.078342]  ? __pfx_kthread+0x10/0x10
[ 2635.082094]  ? lock_acquire+0x10b/0x150
[ 2635.085933]  ? calculate_sigpending+0x3d/0x90
[ 2635.090303]  ? srso_return_thunk+0x5/0x5f
[ 2635.094323]  ? rcu_is_watching+0x15/0xb0
[ 2635.098257]  ? srso_return_thunk+0x5/0x5f
102271]  ? __pfx_kthread+0x10/0x10
106034]  ret_from_fork+0x393/0x480
109791]  ? __pfx_kthread+0x10/0x10
113543]  ? __pfx_kthread+0x10/0x10
[ 2635.117301]  ret_from_fork_asm+0x1a/0x30
[ 2635.121246]  </TASK>
[ 2635.123443] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_fc
nvme_fabrics
gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace nfs_localio
netfs amd_atl
apl_msr platform_profile intel_rapl_common dell_wmi dell_smbios
amd64_edac edac_mc
parse_keymap rfkill video kvm_amd dcdbas vfat kvm fat irqbypass
mgag200 rapl dell_
criptor wmi_bmof i2c_algo_bit pcspkr acpi_cpufreq ipmi_ssif i2c_piix4
ptdma i2c_sm
temp acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler
sg loop fuse
mod nvme ahci libahci tg3 ghash_clmulni_intel nvme_core libata ccp
nvme_keyring nv
 mpt3sas raid_class scsi_transport_sas sp5100_tco wmi sunrpc dm_mirror
dm_region_h
[ 2635.456474] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffbad41180
[ 2635.463622] RBP: 1ffff9200017ff72 R08: 0000000000000001 R09: fffffbfff75a8230
[ 2635.470773] R10: ffffffffbad41187 R11: 6f6f6c6366203f20 R12: dffffc0000000000
[ 2635.477919] R13: 0000000000000000 R14: 0000000000000010 R15: ffff88828ed45108
[ 2635.485076] FS:  0000000000000000(0000) GS:ffff88886433b000(0000)
knlGS:0000000
00
[ 2635.493183] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2635.498946] CR2: 000055a5da1503c0 CR3: 0000000151582000 CR4: 0000000000350ef0
[ 2635.506098] Kernel panic - not syncing: Fatal exception
[ 2635.512016] Kernel Offset: 0x33c00000 from 0xffffffff81000000
(relocation range
fffff80000000-0xffffffffbfffffff)
[ 2635.758246] ---[ end Kernel panic - not syncing: Fatal exception ]---


(gdb) l *(fcloop_tgt_fcprqst_done_work+0x104)
0x39a4 is in fcloop_tgt_fcprqst_done_work (drivers/nvme/target/fcloop.c:595).
590 struct fcloop_ini_fcpreq *inireq = NULL;
591
592 if (fcpreq) {
593 inireq = fcpreq->private;
594 spin_lock(&inireq->inilock);
595 inireq->tfcp_req = NULL;
596 spin_unlock(&inireq->inilock);
597
598 fcpreq->status = status;
599 fcpreq->done(fcpreq);

-- 
Best Regards,
  Yi Zhang


