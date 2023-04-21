Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA66EC7618E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 22:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-Id:To:Subject:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ue9YlROfidQaCPW6etb3jqwAcBfs5uYfipAULEILmNM=; b=MqF1DBzpEmvaaBAj9wW8NewJrb
	/HiVsVPKQq9dLK1MxyPAvQ6jSkTqvbahb8aFkoKXAGeFtzCmTgo2QHyOGdWgywIc+9fHYgs+0p36x
	HqO8o+ETN8dRVMO2kJv+ny0gjDOcSmTgXy9sOS8lSG6M7JHk3Jcrqzgt3BQhyoUOs6QJgqyM0rPKM
	gkFLOADT2Oj0SGNBOGwfzltz2e98cGQBGY3iMufVXBvVsg8qp0o8wfLZZq1F4I5fh8Wnw4TS58SPV
	C0YC/oKHbba7Cy5gm/YOBkW+DTKL7OVfTc8P5JMo05xRmpuTn22eCo7ZOHBZYicK9An/vHU6J9HzT
	uMAysCuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppz8e-00BwV7-0a;
	Fri, 21 Apr 2023 22:21:56 +0000
Received: from mail-pf1-f179.google.com ([209.85.210.179])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppz8b-00BwUQ-13
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 22:21:55 +0000
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so2394652b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Apr 2023 15:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682115703; x=1684707703;
        h=mime-version:message-id:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ue9YlROfidQaCPW6etb3jqwAcBfs5uYfipAULEILmNM=;
        b=BPHXDdXz00MUiUhu9E4j2k0dKcfjT95tCOPFTbA0iVVhRUcfmOuuMA136PMPpIxtU3
         UDGNlH2RqTNcNlm1xinrae/Esew0LybEAjp0MZFwmnYbs97+aDBmsjoy2k8A5xCkv/F1
         pMLTMgvc1i4l/tD8HqRGQMd2X+jhWXtiOSGMayTD+Zl6bcrs0he/jdA+SNsuyjldW5ZI
         s8ST0PTlNMkQ5+wJGdKOh4RMinA2b+dCkzPyMXAHnoV3jy28qKpk2TkvKle/NE9+DH4S
         LKESvCP+BGlCYGF+lBAHjtumh4nU5ml2KHGU6StLJ7q75DsWd+VRcF+NitMQL05L3D8u
         RDug==
X-Gm-Message-State: AAQBX9ckSIJZMnhQ4hIFnCU8qWhr5c3hDP+g5LRqoB9Plx0bDtsQdk95
	KiC1w52QwZkLzJGqVH0lXtYvpPPFenpr5SoP
X-Google-Smtp-Source: AKy350a1DcZtDiVazqQLMn4OOinnr92WirxjZ4XB3KYIXKwcRqpQkR5AkCjueg52u9zKK23vNciXww==
X-Received: by 2002:a05:6a00:24c2:b0:63d:6825:d843 with SMTP id d2-20020a056a0024c200b0063d6825d843mr8517286pfv.23.1682115702987;
        Fri, 21 Apr 2023 15:21:42 -0700 (PDT)
Received: from [192.168.86.42] ([98.97.161.40])
        by smtp.gmail.com with ESMTPSA id k27-20020aa79d1b000000b0063b6451cd01sm3417131pfp.121.2023.04.21.15.21.42
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:21:42 -0700 (PDT)
Date: Fri, 21 Apr 2023 16:21:36 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: [BUG][6.2.11] WD SN770 nvme controller is down
To: linux-nvme@lists.infradead.org
Message-Id: <0SKHTR.QZGFTLD3Z8E01@lyndeno.ca>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230421_152153_386268_F369BB18 
X-CRM114-Status: GOOD (  16.23  )
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

Hello:

Apologies if this is not the proper channel for this kind of message. I 
have seen similar messages on here about similar issues so I thought I 
would send it here.

I have recently replaced the drive in my laptop (Dell XPS 15 9560) with 
a WD_BLACK SN770 2TB. I also have this exact drive in my desktop.

On my laptop I will randomly get the following in the kernel log:
[ 1753.922566] nvme nvme0: controller is down; will reset: 
CSTS=0xffffffff, PCI_STATUS=0x10
[ 1753.922574] nvme nvme0: Does your device have a faulty power saving 
mode enabled?
[ 1753.922578] nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0 
pcie_aspm=off" and report a bug
[ 1753.940085] nvme0n1: I/O Cmd(0x2) @ LBA 6278080, 187 blocks, I/O 
Error (sct 0x3 / sc 0x71)
[ 1753.940103] I/O error, dev nvme0n1, sector 50224640 op 0x0:(READ) 
flags 0x84700 phys_seg 127 prio class 3
[ 1753.940124] nvme0n1: I/O Cmd(0x2) @ LBA 6278267, 229 blocks, I/O 
Error (sct 0x3 / sc 0x71)
[ 1753.940133] I/O error, dev nvme0n1, sector 50226136 op 0x0:(READ) 
flags 0x84700 phys_seg 127 prio class 3
[ 1753.940143] nvme0n1: I/O Cmd(0x2) @ LBA 6278496, 3 blocks, I/O Error 
(sct 0x3 / sc 0x71)
[ 1753.940149] I/O error, dev nvme0n1, sector 50227968 op 0x0:(READ) 
flags 0x80700 phys_seg 2 prio class 3
[ 1753.940172] nvme0n1: I/O Cmd(0x2) @ LBA 6278499, 256 blocks, I/O 
Error (sct 0x3 / sc 0x71)
[ 1753.940179] I/O error, dev nvme0n1, sector 50227992 op 0x0:(READ) 
flags 0x84700 phys_seg 102 prio class 3
[ 1753.940190] nvme0n1: I/O Cmd(0x2) @ LBA 6278755, 169 blocks, I/O 
Error (sct 0x3 / sc 0x71)
[ 1753.940196] I/O error, dev nvme0n1, sector 50230040 op 0x0:(READ) 
flags 0x84700 phys_seg 127 prio class 3
[ 1753.940205] nvme0n1: I/O Cmd(0x2) @ LBA 6278924, 36 blocks, I/O 
Error (sct 0x3 / sc 0x71)
[ 1753.940211] I/O error, dev nvme0n1, sector 50231392 op 0x0:(READ) 
flags 0x80700 phys_seg 28 prio class 3
[ 1753.940227] nvme0n1: I/O Cmd(0x2) @ LBA 6278961, 129 blocks, I/O 
Error (sct 0x3 / sc 0x71)
[ 1753.940233] I/O error, dev nvme0n1, sector 50231688 op 0x0:(READ) 
flags 0x84700 phys_seg 127 prio class 3
[ 1753.940241] nvme0n1: I/O Cmd(0x2) @ LBA 6279090, 14 blocks, I/O 
Error (sct 0x3 / sc 0x71)
[ 1753.940247] I/O error, dev nvme0n1, sector 50232720 op 0x0:(READ) 
flags 0x80700 phys_seg 14 prio class 3
[ 1753.940266] nvme0n1: I/O Cmd(0x2) @ LBA 6277056, 141 blocks, I/O 
Error (sct 0x3 / sc 0x71)
[ 1753.940272] I/O error, dev nvme0n1, sector 50216448 op 0x0:(READ) 
flags 0x84700 phys_seg 127 prio class 3
[ 1753.940283] nvme0n1: I/O Cmd(0x2) @ LBA 6277197, 256 blocks, I/O 
Error (sct 0x3 / sc 0x71)
[ 1753.940289] I/O error, dev nvme0n1, sector 50217576 op 0x0:(READ) 
flags 0x84700 phys_seg 92 prio class 3
[ 1753.945614] nvme 0000:04:00.0: enabling device (0000 -> 0002)
[ 1753.945944] nvme nvme0: Disabling device after reset failure: -19

This happens when booting and sometimes when the system is just sitting 
there, whether idling or doing somewhat intensive tasks. My drive seems 
to reset and go "read-only" but neither reading nor writing work after 
and the laptop has to be hard-rebooted.

I cannot retrieve this log after the fact and can only obtain it if I 
leave "dmesg -w" running in a terminal until it occurs.

My online research comes up with a lot of info about ASPM and APST bugs 
and solutions, including for the original drive that came with this 
laptop.

Suggested solutions include setting pcie_aspm=off or 
nvme_core.default_ps_max_latency_us=0. I have tried one of these at a 
time, as well as both at once and in no combination does it prevent the 
issue from re-occurring.

Here is some info about the SSD power states (firmware version 
included, this was the latest when I updated through a windows-to-go 
install):
$ sudo nvme id-ctrl /dev/nvme0
NVME Identify Controller:
...
fr : 731100WD
...
ps 0 : mp:5.40W operational enlat:0 exlat:0 rrt:0 rrl:0
            rwt:0 rwl:0 idle_power:0.3000W active_power:5.40W
            active_power_workload:80K 128KiB SW
ps 1 : mp:3.50W operational enlat:0 exlat:0 rrt:0 rrl:0
            rwt:0 rwl:0 idle_power:0.3000W active_power:3.00W
            active_power_workload:80K 128KiB SW
ps 2 : mp:2.40W operational enlat:0 exlat:0 rrt:0 rrl:0
            rwt:0 rwl:0 idle_power:0.3000W active_power:2.00W
            active_power_workload:80K 128KiB SW
ps 3 : mp:0.0150W non-operational enlat:1500 exlat:2500 rrt:3 rrl:3
            rwt:3 rwl:3 idle_power:0.0150W active_power:-
            active_power_workload:-
ps 4 : mp:0.0050W non-operational enlat:10000 exlat:6000 rrt:4 rrl:4
            rwt:4 rwl:4 idle_power:0.0050W active_power:-
            active_power_workload:-
ps 5 : mp:0.0033W non-operational enlat:176000 exlat:25000 rrt:5 rrl:5
            rwt:5 rwl:5 idle_power:0.0033W active_power:-
            active_power_workload:-

I am wondering if there are any other steps I can take to troubleshoot 
this problem. I have tried taking the drive back to the store I bought 
it from, but the tests they ran all passed so a replacement/return is 
not likely to be possible. I am wondering if there are other settings 
or possibly patches I could try.

It should be noted that none of these problems occur on my desktop with 
the same model of drive (ASUS X570 Motherboard).

I am grateful for any help that can be provided.

Thank you,

Lyndon Sanche




