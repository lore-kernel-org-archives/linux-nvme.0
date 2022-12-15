Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CC3C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 01:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AsgWPb1o6UZ8leNyj/obDYvA9PD2V1YL0BkxUMr0PWE=; b=4L8HyKQ2mLU41t
	wZ1W+UcC+knGSO9iHoiid5RlPsVLxeaW6nS62bUo1TRHuV9RTnKHEHmuQZddVCipVGBR6gY/AH+3f
	F5utd7TjNMh9cbCiBOdMXAj83NMWx+L9AGCog+2kYeV2PgO9RRwcZN6HbblcQCAWytBRzgwBbfhCP
	YC0+IkwAaMh4j20owsvZ4HiUDe2Etg14mtmT3rSYWRmhn7zuJ3DFpUnpICjvdOvT5cS82dswTQlXJ
	quJInWx+GcxxHSt5P9S6JbyPoRsYu6XBI6HU4aNJiMxwI6JntyZ91WbYKPIqZYw/RLw60RVd2DaKW
	/kIS49Wfa/OtaJz8Klhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5dCr-005UjK-Gk; Thu, 15 Dec 2022 01:38:41 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5dCp-005UiD-1M
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 01:38:40 +0000
Received: by mail-pl1-x62b.google.com with SMTP id w23so5265866ply.12
        for <linux-nvme@lists.infradead.org>; Wed, 14 Dec 2022 17:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :reply-to:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AsgWPb1o6UZ8leNyj/obDYvA9PD2V1YL0BkxUMr0PWE=;
        b=kUgwVZGRkXd6mgcfNSyTGuk+Im48CgjAYL2WJmhQcQWiV8xP9R7lVx1bzgiim5vixO
         a1xnMZHQMvXsJ1IAVOl1QIy04KVEWPb5wOb6MrzTwZF5sDoPZy3bC7KPtCDoE1A4iRNK
         OfOpF3BmVKX56+qNlx4kSoFiFUDm9uYejMaVW/rws6aM6FwiwWP1yQl7mYt0daWy1A2z
         3snQOe4ikQA1m6uBRrkKJmzJA1d16xgYmZNAC4wkNLRzhEUAdTBECY9q6FvdQvjGmsmv
         IrpVf47aYSRC37tj45WQoyH7ANnuDb3fPt3caqNDKE1RQX8y9hUxFAQqS880NkfCuVqt
         Pf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :reply-to:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsgWPb1o6UZ8leNyj/obDYvA9PD2V1YL0BkxUMr0PWE=;
        b=n9W158c88iiBk2Ah5pCzk94+Ax8aKUHDZPJuYlDlOyhj0wM7jMyXb8yVqx/i4J3YIb
         TMzHfvd8rrKUX2W3SBzG77fnLdGkIu0yhPSkT9r4YZVAJXOaoyw/JnanPoGgWABSNmLf
         7EfpKz/+2WfYdbdpmmfYZFbhXBTXf0EOF6iE5TxgLT35SxXycI2z6d/VLn7YqOrbg3C0
         mImuKDN27QtnAuzt+nxWaCH+PYwTLXVyUycSgowmDuvcY2Be65jM4oYpfqKBfvQ69p4Y
         IThl873F/ay4rAwZcNimp4SIN8XUuG9EHG5lYVV7OMOcj44vLzUJV7tJE0fBc+P+vZhj
         X+tA==
X-Gm-Message-State: ANoB5pnj3jkRL9/5J9qS9bg9KjjeClBS3o1HqYOay7k1pYVidGOix7in
	b3z9jnMzIAcUQFSnc0iDtpJUnT9hjayVWg==
X-Google-Smtp-Source: AA0mqf4WbDaw2dQVwyYSxOoVMQeI/OIYLlsvEL8QWhia7mn37kw5ykVlTNj86iJcL1zLw8lTiKqjmw==
X-Received: by 2002:a17:902:6bcc:b0:188:5b7d:738a with SMTP id m12-20020a1709026bcc00b001885b7d738amr26545486plt.29.1671068317267;
        Wed, 14 Dec 2022 17:38:37 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e80300b00176ab6a0d5fsm2494788plg.54.2022.12.14.17.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 17:38:36 -0800 (PST)
Message-ID: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
Date: Thu, 15 Dec 2022 10:38:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
From: "J. Hart" <jfhart085@gmail.com>
Subject: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
To: linux-nvme@lists.infradead.org
Cc: jfhart085@gmail.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221214_173839_119007_9C5F8548 
X-CRM114-Status: GOOD (  12.49  )
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I am attempting to load an nvme device (nvme0n1) to use as main system 
drive using the following command:

rsync -axvH /. --exclude=/lost+found --exclude=/var/log.bu 
--exclude=/usr/var/log.bu --exclude=/usr/X11R6/var/log.bu 
--exclude=/home/jhart/.cache/mozilla/firefox/are7uokl.default-release/cache2.bu 
--exclude=/home/jhart/.cache/thunderbird/7zsnqnss.default/cache2.bu 
/mnt/root_new 2>&1 | tee root.log

The total transfer would be approximately 50 GB.  This is being done at 
run level 1, and only the kernel threads and the root shell are observed 
to be active.

The following log messages appear after a minute or so, and rsync hangs. 
The nvme drive cannot be unmounted without a reboot.

dmesg reports the following:

[Dec14 19:24] nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting
[Dec14 19:25] nvme nvme0: I/O 0 QID 1 timeout, reset controller
[ +30.719985] nvme nvme0: I/O 8 QID 0 timeout, reset controller
[Dec14 19:28] nvme nvme0: Device not ready; aborting reset, CSTS=0x1
[  +0.031803] nvme nvme0: Abort status: 0x371
[Dec14 19:30] nvme nvme0: Device not ready; aborting reset, CSTS=0x1
[  +0.000019] nvme nvme0: Removing after probe failure status: -19

I have also observed file system corruption on the source drive of the 
transfer.  I would not normally think this to be related, except that 
after the first time I observed it, I made certain that I corrected the 
file content before any additional attempts, but have seen this again 
after every attempt.  The modification dates and file sizes did not 
change, but the file content on the source drive did.  I confirmed this 
using the "diff" utility, and again using a rsync dry run with the check 
sum test enabled.

kernel/distro:

Linux DellXPS 6.1.0 #1 SMP Tue Dec 13 21:48:51 JST 2022 x86_64 GNU/Linux
custom distribution built entirely from source

nvme controller:

MZHOU M.2 NVME SSD-PCIe 4.0 X4 adaptor
Key-M NGFF PCI-E 3.0、2.0 or 1.0 controller expansion cards
(2230 2242 2260 2280 22110 M.2 SSD）

02:00.0 Non-Volatile memory controller: Kingston Technologies Device 
500f (rev 03) (prog-if 02)
         Subsystem: Kingston Technologies Device 500f
         Flags: bus master, fast devsel, latency 0, IRQ 16
         Memory at ef9fc000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Capabilities: [70] Express Endpoint, MSI 00
         Capabilities: [b0] MSI-X: Enable- Count=16 Masked-
         Kernel driver in use: nvme

nvme drive:

Model Number:                       KINGSTON SNVSE500G
Serial Number:                      50026B7685D8EE42
Firmware Version:                   S8542105
PCI Vendor/Subsystem ID:            0x2646
IEEE OUI Identifier:                0x0026b7
Controller ID:                      1
NVMe Version:                       1.3
Number of Namespaces:               1
Namespace 1 Size/Capacity:          500,107,862,016 [500 GB]
Namespace 1 Formatted LBA Size:     512
Namespace 1 IEEE EUI-64:            0026b7 685d8ee425
Local Time is:                      Tue Nov 29 20:31:21 2022 JST
Firmware Updates (0x12):            1 Slot, no Reset required
Optional Admin Commands (0x0016):   Format Frmw_DL Self_Test
Optional NVM Commands (0x005f):     Comp Wr_Unc DS_Mngmt Wr_Zero 
Sav/Sel_Feat Timestmp
Log Page Attributes (0x03):         S/H_per_NS Cmd_Eff_Lg
Maximum Data Transfer Size:         64 Pages
Warning  Comp. Temp. Threshold:     85 Celsius
Critical Comp. Temp. Threshold:     90 Celsius

CPU (quad core, cpu 0 shown, others the same):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz
stepping	: 7
microcode	: 0x705
cpu MHz		: 1999.839
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ht tm pbe syscall nx lm 
constant_tsc arch_perfmon pebs bts rep_good nopl cpuid aperfmperf pni 
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 
lahf_lm pti tpr_shadow vnmi flexpriority vpid dtherm
vmx flags	: vnmi flexpriority tsc_offset vtpr vapic
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
swapgs itlb_multihit mmio_unknown
bogomips	: 5666.43
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:



