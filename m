Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D809CC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 13:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:Subject:
	From:MIME-Version:Date:Message-ID:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8esgQ/u38FP+CJWwoIIuTOWhn/SogybRp3XwForXs+s=; b=KXf5a9Gg1HvfKzy3hm/x/pCqnQ
	FMddIFXU7Vt6pVm43dxlp0dmJvFUGJUSSeQxh/swpf5ecmAkAuRaLo1+oqYhvUN7+KEgvn1OnqNws
	4PfdjEKkyevGDIi9uv49izuyGRDGyjYjZuLpG5fisfyi4lJYSHZaQD5y+i7xaWUm41Gk8JNNCDFsj
	Qmdj7V9He8nlQHtX/xJCi94m586yrbw+1xURvCHSptPY6oqTLm4LbBSt+P7kLdFfCEaf+HxD/DCkt
	zm0k1KfAmc4kjf+HRWweMjCDdl5Rfjcv7l2pvVTvcBt2fV72xpjDfcq+i2Sru4094k4XRws5uG43S
	+N2JlppA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5oMo-009aaH-JR; Thu, 15 Dec 2022 13:33:42 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5oMk-009aXT-4C
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 13:33:40 +0000
Received: by mail-pf1-x436.google.com with SMTP id d82so6688470pfd.11
        for <linux-nvme@lists.infradead.org>; Thu, 15 Dec 2022 05:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8esgQ/u38FP+CJWwoIIuTOWhn/SogybRp3XwForXs+s=;
        b=iRFR9B02QJSabHg0rGIpFyvdnF1d1HfqLRq0On+MH1DcbLtiJALpS/l+38XoV7RGlF
         symIyJLk3wyahXg3FcoIC5yIXQuqnloFxOj0uCSuykX3kABaFmg82PgxqoU6ocwiN+2P
         BdXtFqQiXQWn2b1amTt0AOLdUs6K1CX6E76BeQyiY/ILmO7OyZIjg/BwiY6S27pcxv1B
         m1Db2gJQXkEhV9ldSxK37G+qSERMjsbbZxvH+PD1GWWvqBOp3JBJbvP+pkLnKOJl5dD2
         +weMrZyh01L11qnPJQT8hwJ65enwf1T8l/2tdlsxVaOWi9mha8pYnF5vG8aVBawk3gkc
         m8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8esgQ/u38FP+CJWwoIIuTOWhn/SogybRp3XwForXs+s=;
        b=vyeLpy4Mzr2huDjiNcc8HUSIE/Yhb+9lc4mx/jPJ0fWJBEI+tCRbsmz8jFM1Jejr8r
         SdDE/9KUHq9jYgTKCoogtnxpq4OdJ0O2LHTniB0M4Jk/huDDR3Edqz+bULp8MJaTm3wc
         /XAHJ1PIFJGywmNOAgO+ER67nZPM7bxY5oaMR8/PwiJ0BaOE1fB7qrMOqnSETzS3Bik3
         I7KR1PURb8vYg/aAZ38flWUZpMCSD4gF+uxn/K+Zs5VOJMOo+3+wrxted+3SxcCzMNM1
         CyD3rMLtNI54cxfoirXfW60U+3NBCqM8eiJ+gXcC/d2CmPLGlURgrkJv5dCvvU83Fywe
         EGuA==
X-Gm-Message-State: ANoB5pnIC4FblIZKrfxGRq4SFLJ17ez4fSUsnDwDerwTe1nMgavyUVVI
	nZwHotLpGaXe/Jq1WwIkLmo=
X-Google-Smtp-Source: AA0mqf7d/BIvGF3tPpasV5oaJOaU/0S0QTzISnax1SJQNc9SDrknOHC6YeUJRhEl48QnBdJHNaF2UQ==
X-Received: by 2002:a05:6a00:a93:b0:56b:6c05:3da6 with SMTP id b19-20020a056a000a9300b0056b6c053da6mr36854390pfl.8.1671111214394;
        Thu, 15 Dec 2022 05:33:34 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id b10-20020a621b0a000000b005771475561bsm1702181pfb.163.2022.12.15.05.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 05:33:33 -0800 (PST)
Message-ID: <3c22a234-f042-4859-a3ab-f911874696b1@gmail.com>
Date: Thu, 15 Dec 2022 22:33:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: "J. Hart" <jfhart085@gmail.com>
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, jfhart085@gmail.com
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
 <20221215082344.GB3816@lst.de>
 <d4c4eea9-e573-df0c-cca5-536bcff6c0a9@gmail.com>
 <20221215090941.GA5062@lst.de>
Content-Language: en-US
In-Reply-To: <20221215090941.GA5062@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_053338_227082_53A9BA9F 
X-CRM114-Status: UNSURE (   9.58  )
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Here are the test results.  My apologies for the delay, as I was being 
rather careful.  The test also appears to have resulted in very serious 
filesystem damage on the system main drive which had to be dealt with.

These results were obtained as before, at run level 1 with all processes 
terminated except for the root shell under initd.  I then started 
syslogd and then started klogd.  I ran vim under the root shell, and a 
terminal from with vim.  The rsync was run from that terminal, and the 
condition monitored via top within another vim terminal.

The settings I enabled were as follows:

CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_INTEL_IOMMU=y

you also mentioned the following:
CONFIG_INTEL_IOMMU_DEFAULT

I didn't have that parameter, but I think you meant this one:
CONFIG_INTEL_IOMMU_DEFAULT_ON=y

The rsync invocation hung as before, and had to be forcibly terminated.
The system was forced down via the magic SysReq key sequence.

I have appended the log extracts here.  If these are unusable, I can 
send the extracts as attachments or upload them as seperate files.


dmesg log extract:

[Dec15 21:06] printk: udevd: 5 output lines suppressed due to ratelimiting
[Dec15 21:14] EXT4-fs (nvme0n1p3): mounted filesystem with ordered data 
mode. Quota mode: disabled.
[Dec15 21:16] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #53085366: comm rsync: pblk 0 bad header/extent: invalid 
eh_entries - magic f30a, entries 17, max 4(4), depth 0(0)
[Dec15 21:17] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #5506059: comm rsync: pblk 0 bad header/extent: invalid eh_entries 
- magic f30a, entries 17, max 4(4), depth 0(0)
[  +8.145700] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #5506082: comm rsync: pblk 0 bad header/extent: invalid eh_entries 
- magic f30a, entries 17, max 4(4), depth 0(0)
[  +7.668302] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #41180419: comm rsync: pblk 0 bad header/extent: invalid 
eh_entries - magic f30a, entries 17, max 4(4), depth 0(0)
[  +0.081111] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #41180440: comm rsync: pblk 0 bad header/extent: invalid 
eh_entries - magic f30a, entries 17, max 4(4), depth 0(0)
[  +0.037526] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #41180229: comm rsync: pblk 0 bad header/extent: invalid 
eh_entries - magic f30a, entries 17, max 4(4), depth 0(0)
[  +0.011292] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #41182425: comm rsync: pblk 0 bad header/extent: invalid 
eh_entries - magic f30a, entries 17, max 4(4), depth 0(0)
[  +0.031661] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #41178319: comm rsync: pblk 0 bad header/extent: invalid 
eh_entries - magic f30a, entries 17, max 4(4), depth 0(0)
[Dec15 21:32] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #38936868: comm rsync: pblk 0 bad header/extent: invalid 
eh_entries - magic f30a, entries 17, max 4(4), depth 0(0)
[  +0.000629] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #38936901: comm rsync: pblk 0 bad header/extent: invalid 
eh_entries - magic f30a, entries 17, max 4(4), depth 0(0)
[Dec15 21:34] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #41029460: comm rsync: pblk 0 bad header/extent: invalid 
eh_entries - magic f30a, entries 17, max 4(4), depth 0(0)
[ +22.029135] EXT4-fs error (device dm-0): ext4_ext_check_inode:520: 
inode #41029305: comm rsync: pblk 0 bad header/extent: invalid 
eh_entries - magic f30a, entries 17, max 4(4), depth 0(0)
[ +26.890018] nvme nvme0: I/O 0 (Write) QID 1 timeout, aborting
[Dec15 21:35] nvme nvme0: I/O 0 QID 1 timeout, reset controller
[ +30.719998] nvme nvme0: I/O 13 QID 0 timeout, reset controller
[Dec15 21:38] nvme nvme0: Device not ready; aborting reset, CSTS=0x1
[  +0.014796] nvme nvme0: Abort status: 0x371
[Dec15 21:40] nvme nvme0: Device not ready; aborting reset, CSTS=0x1
[  +0.000024] nvme nvme0: Removing after probe failure status: -19
[Dec15 21:42] nvme nvme0: Device not ready; aborting reset, CSTS=0x1
[  +0.000324] nvme0n1: detected capacity change from 976773168 to 0
[  +0.000010] EXT4-fs warning (device nvme0n1p3): ext4_end_bio:343: I/O 
error 10 writing to inode 6558258 starting block 27121876)
[  +0.000046] EXT4-fs warning (device nvme0n1p3): ext4_end_bio:343: I/O 
error 10 writing to inode 6558302 starting block 27335746)
[  +0.000061] EXT4-fs warning (device nvme0n1p3): ext4_end_bio:343: I/O 
error 10 writing to inode 6558257 starting block 27199501)
[  +0.000012] Buffer I/O error on device nvme0n1p3, logical block 27104980
[  +0.000006] EXT4-fs warning (device nvme0n1p3): ext4_end_bio:343: I/O 
error 10 writing to inode 6558301 starting block 26915262)
[  +0.000010] EXT4-fs warning (device nvme0n1p3): ext4_end_bio:343: I/O 
error 10 writing to inode 6558287 starting block 27335718)
[  +0.000006] EXT4-fs warning (device nvme0n1p3): ext4_end_bio:343: I/O 
error 10 writing to inode 6558288 starting block 27335719)
[  +0.000003] EXT4-fs warning (device nvme0n1p3): ext4_end_bio:343: I/O 
error 10 writing to inode 6558289 starting block 27335721)
[  +0.000005] EXT4-fs warning (device nvme0n1p3): ext4_end_bio:343: I/O 
error 10 writing to inode 6558290 starting block 27335723)
[  +0.000006] EXT4-fs warning (device nvme0n1p3): ext4_end_bio:343: I/O 
error 10 writing to inode 6558291 starting block 27335724)
[  +0.000017] Buffer I/O error on device nvme0n1p3, logical block 27104981
[  +0.000006] EXT4-fs warning (device nvme0n1p3): ext4_end_bio:343: I/O 
error 10 writing to inode 6558257 starting block 27198798)
[  +0.000193] Buffer I/O error on device nvme0n1p3, logical block 27104982
[  +0.000018] Buffer I/O error on device nvme0n1p3, logical block 27104983
[  +0.000019] Buffer I/O error on device nvme0n1p3, logical block 27104984
[  +0.000031] Buffer I/O error on device nvme0n1p3, logical block 27318850
[  +0.000028] Buffer I/O error on device nvme0n1p3, logical block 26898366
[  +0.000020] Buffer I/O error on device nvme0n1p3, logical block 26898367
[  +0.000018] Buffer I/O error on device nvme0n1p3, logical block 26898368
[  +0.000019] Buffer I/O error on device nvme0n1p3, logical block 26898369
[  +0.000092] Aborting journal on device nvme0n1p3-8.
[  +0.000057] Buffer I/O error on dev nvme0n1p3, logical block 60850176, 
lost sync page write
[  +0.000057] EXT4-fs error (device nvme0n1p3): 
ext4_journal_check_start:83: comm kworker/u8:2: Detected aborted journal
[  +0.000022] JBD2: I/O error when updating journal superblock for 
nvme0n1p3-8.
[  +0.000093] Buffer I/O error on dev nvme0n1p3, logical block 0, lost 
sync page write
[  +0.000029] EXT4-fs (nvme0n1p3): I/O error while writing superblock
[  +0.000017] EXT4-fs (nvme0n1p3): Remounting filesystem read-only
[  +0.000018] EXT4-fs (nvme0n1p3): ext4_writepages: jbd2_start: 12288 
pages, ino 6558303; err -30
[  +0.000377] Buffer I/O error on dev nvme0n1p3, logical block 26214412, 
lost async page write
[  +0.000030] Buffer I/O error on dev nvme0n1p3, logical block 26214705, 
lost async page write
[  +0.000023] Buffer I/O error on dev nvme0n1p3, logical block 26214706, 
lost async page write
[  +0.000026] Buffer I/O error on dev nvme0n1p3, logical block 26214707, 
lost async page write
[  +0.000024] Buffer I/O error on dev nvme0n1p3, logical block 26214708, 
lost async page write
[  +0.000021] EXT4-fs (nvme0n1p3): failed to convert unwritten extents 
to written extents -- potential data loss!  (inode 6558291, error -30)
[  +0.000011] Buffer I/O error on dev nvme0n1p3, logical block 26214709, 
lost async page write
[  +0.000026] EXT4-fs (nvme0n1p3): failed to convert unwritten extents 
to written extents -- potential data loss!  (inode 6558256, error -30)
[  +0.000018] Buffer I/O error on dev nvme0n1p3, logical block 26214710, 
lost async page write
[  +0.000047] Buffer I/O error on dev nvme0n1p3, logical block 26214711, 
lost async page write
[  +0.000305] EXT4-fs (nvme0n1p3): failed to convert unwritten extents 
to written extents -- potential data loss!  (inode 6558292, error -30)
[  +0.000044] EXT4-fs (nvme0n1p3): failed to convert unwritten extents 
to written extents -- potential data loss!  (inode 6558293, error -30)
[  +0.000036] EXT4-fs (nvme0n1p3): failed to convert unwritten extents 
to written extents -- potential data loss!  (inode 6558294, error -30)
[  +0.000049] EXT4-fs (nvme0n1p3): failed to convert unwritten extents 
to written extents -- potential data loss!  (inode 6558295, error -30)
[  +0.000047] EXT4-fs (nvme0n1p3): failed to convert unwritten extents 
to written extents -- potential data loss!  (inode 6558296, error -30)

=====================================================================

syslog extract:

Dec 15 21:08:13 DellXPS kernel: printk: udevd: 5 output lines suppressed 
due to ratelimiting
Dec 15 21:14:30 DellXPS kernel: EXT4-fs (nvme0n1p3): mounted filesystem 
with ordered data mode. Quota mode: disabled.
Dec 15 21:17:00 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #53085366: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:17:42 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #5506059: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:17:51 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #5506082: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:17:58 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #41180419: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:17:58 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #41180440: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:17:58 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #41180229: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:17:58 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #41182425: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:17:58 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #41178319: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:32:43 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #38936868: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:32:43 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #38936901: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:34:03 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #41029460: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:34:25 DellXPS kernel: EXT4-fs error (device dm-0): 
ext4_ext_check_inode:520: inode #41029305: comm rsync: pblk 0 bad 
header/extent: invalid eh_entries - magic f30a, entries 17, max 4(4), 
depth 0(0)
Dec 15 21:34:52 DellXPS kernel: nvme nvme0: I/O 0 (Write) QID 1 timeout, 
aborting
Dec 15 21:35:23 DellXPS kernel: nvme nvme0: I/O 0 QID 1 timeout, reset 
controller
Dec 15 21:35:54 DellXPS kernel: nvme nvme0: I/O 13 QID 0 timeout, reset 
controller
Dec 15 21:38:25 DellXPS kernel: nvme nvme0: Device not ready; aborting 
reset, CSTS=0x1
Dec 15 21:38:25 DellXPS kernel: nvme nvme0: Abort status: 0x371
Dec 15 21:40:25 DellXPS kernel: nvme nvme0: Device not ready; aborting 
reset, CSTS=0x1
Dec 15 21:40:25 DellXPS kernel: nvme nvme0: Removing after probe failure 
status: -19
Dec 15 21:42:26 DellXPS kernel: nvme nvme0: Device not ready; aborting 
reset, CSTS=0x1
Dec 15 21:42:26 DellXPS kernel: nvme0n1: detected capacity change from 
976773168 to 0
Dec 15 21:42:26 DellXPS kernel: EXT4-fs warning (device nvme0n1p3): 
ext4_end_bio:343: I/O error 10 writing to inode 6558258 starting block 
27121876)
Dec 15 21:42:26 DellXPS kernel: EXT4-fs warning (device nvme0n1p3): 
ext4_end_bio:343: I/O error 10 writing to inode 6558302 starting block 
27335746)
Dec 15 21:42:26 DellXPS kernel: EXT4-fs warning (device nvme0n1p3): 
ext4_end_bio:343: I/O error 10 writing to inode 6558257 starting block 
27199501)
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on device nvme0n1p3, 
logical block 27104980
Dec 15 21:42:26 DellXPS kernel: EXT4-fs warning (device nvme0n1p3): 
ext4_end_bio:343: I/O error 10 writing to inode 6558301 starting block 
26915262)
Dec 15 21:42:26 DellXPS kernel: EXT4-fs warning (device nvme0n1p3): 
ext4_end_bio:343: I/O error 10 writing to inode 6558287 starting block 
27335718)
Dec 15 21:42:26 DellXPS kernel: EXT4-fs warning (device nvme0n1p3): 
ext4_end_bio:343: I/O error 10 writing to inode 6558288 starting block 
27335719)
Dec 15 21:42:26 DellXPS kernel: EXT4-fs warning (device nvme0n1p3): 
ext4_end_bio:343: I/O error 10 writing to inode 6558289 starting block 
27335721)
Dec 15 21:42:26 DellXPS kernel: EXT4-fs warning (device nvme0n1p3): 
ext4_end_bio:343: I/O error 10 writing to inode 6558290 starting block 
27335723)
Dec 15 21:42:26 DellXPS kernel: EXT4-fs warning (device nvme0n1p3): 
ext4_end_bio:343: I/O error 10 writing to inode 6558291 starting block 
27335724)
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on device nvme0n1p3, 
logical block 27104981
Dec 15 21:42:26 DellXPS kernel: EXT4-fs warning (device nvme0n1p3): 
ext4_end_bio:343: I/O error 10 writing to inode 6558257 starting block 
27198798)
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on device nvme0n1p3, 
logical block 27104982
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on device nvme0n1p3, 
logical block 27104983
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on device nvme0n1p3, 
logical block 27104984
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on device nvme0n1p3, 
logical block 27318850
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on device nvme0n1p3, 
logical block 26898366
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on device nvme0n1p3, 
logical block 26898367
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on device nvme0n1p3, 
logical block 26898368
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on device nvme0n1p3, 
logical block 26898369
Dec 15 21:42:26 DellXPS kernel: Aborting journal on device nvme0n1p3-8.
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on dev nvme0n1p3, 
logical block 60850176, lost sync page write
Dec 15 21:42:26 DellXPS kernel: EXT4-fs error (device nvme0n1p3): 
ext4_journal_check_start:83: comm kworker/u8:2: Detected aborted journal
Dec 15 21:42:26 DellXPS kernel: JBD2: I/O error when updating journal 
superblock for nvme0n1p3-8.
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on dev nvme0n1p3, 
logical block 0, lost sync page write
Dec 15 21:42:26 DellXPS kernel: EXT4-fs (nvme0n1p3): I/O error while 
writing superblock
Dec 15 21:42:26 DellXPS kernel: EXT4-fs (nvme0n1p3): Remounting 
filesystem read-only
Dec 15 21:42:26 DellXPS kernel: EXT4-fs (nvme0n1p3): ext4_writepages: 
jbd2_start: 12288 pages, ino 6558303; err -30
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on dev nvme0n1p3, 
logical block 26214412, lost async page write
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on dev nvme0n1p3, 
logical block 26214705, lost async page write
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on dev nvme0n1p3, 
logical block 26214706, lost async page write
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on dev nvme0n1p3, 
logical block 26214707, lost async page write
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on dev nvme0n1p3, 
logical block 26214708, lost async page write
Dec 15 21:42:26 DellXPS kernel: EXT4-fs (nvme0n1p3): failed to convert 
unwritten extents to written extents -- potential data loss!  (inode 
6558291, error -30)
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on dev nvme0n1p3, 
logical block 26214709, lost async page write
Dec 15 21:42:26 DellXPS kernel: EXT4-fs (nvme0n1p3): failed to convert 
unwritten extents to written extents -- potential data loss!  (inode 
6558256, error -30)
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on dev nvme0n1p3, 
logical block 26214710, lost async page write
Dec 15 21:42:26 DellXPS kernel: Buffer I/O error on dev nvme0n1p3, 
logical block 26214711, lost async page write
Dec 15 21:42:26 DellXPS kernel: EXT4-fs (nvme0n1p3): failed to convert 
unwritten extents to written extents -- potential data loss!  (inode 
6558292, error -30)
Dec 15 21:42:26 DellXPS kernel: EXT4-fs (nvme0n1p3): failed to convert 
unwritten extents to written extents -- potential data loss!  (inode 
6558293, error -30)
Dec 15 21:42:26 DellXPS kernel: EXT4-fs (nvme0n1p3): failed to convert 
unwritten extents to written extents -- potential data loss!  (inode 
6558294, error -30)
Dec 15 21:42:26 DellXPS kernel: EXT4-fs (nvme0n1p3): failed to convert 
unwritten extents to written extents -- potential data loss!  (inode 
6558295, error -30)
Dec 15 21:42:26 DellXPS kernel: EXT4-fs (nvme0n1p3): failed to convert 
unwritten extents to written extents -- potential data loss!  (inode 
6558296, error -30)


On 12/15/22 6:09 PM, Christoph Hellwig wrote:
> On Thu, Dec 15, 2022 at 06:07:32PM +0900, J. Hart wrote:
>> My apologies....I am not sure what is meant by "stay DMAs".  Is there
>> something I can look for here ?
> 
> I mean stray, sorry.  There isn't really anything you can look for.
> Either it really is a device problem, in which case the IOMMU should
> catch it.  Or it is a kernel problem somewhere, in which case
> CONFIG_KASAN would catch.  So maybe enable that as well, but it will
> slow down the kernel a LOT.

J. Hart

