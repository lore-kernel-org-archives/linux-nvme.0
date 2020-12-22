Return-Path: <SRS0=D3NM=F2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81552C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 19:29:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BD223130
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 19:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BD223130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=duAugGLh1RbNiQO956SxqzwXqAknVRUKdA6m5GK0Bh8=; b=PY4vdwC+02BXIU31eftj8sQ2r
	R8fgNmMPs+3+uoJNjlvGwrw8PW3MzPoD6/4Kk8S5hKkul4akKHsgIxNM//GxBZSZyz88Q950KA8Qb
	qLnrGFijsz2dV+BiTd7ihbXOvgVpydtxA6B/q3y0IIwneiqm285scbszfCi3rDYQyHc/3hos7W6q8
	MYj4GeugqVnwFjtvTg4nj0Fdg1qa/F15ElVONCASogTi17SIidw6s6fRyFLo13v+TKruRaK+G87Bo
	ko2Rn/kxns/EO+u8TEZap0DSQvWp7Dok0nTqbDYCJ9ftrEyxQKldufytCOL+jeGs7biMizcX9QQZI
	oM5ytjkTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krnLf-0000dQ-7r; Tue, 22 Dec 2020 19:29:31 +0000
Received: from mail-ot1-f52.google.com ([209.85.210.52])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krnLb-0000cJ-Sv
 for Linux-nvme@lists.infradead.org; Tue, 22 Dec 2020 19:29:29 +0000
Received: by mail-ot1-f52.google.com with SMTP id f16so12899163otl.11
 for <Linux-nvme@lists.infradead.org>; Tue, 22 Dec 2020 11:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dFzWvA2LZ7jCA7FNZKqMPemfYAiCkCvQkmT0wfHI3eQ=;
 b=PqTW4YZKFnEUthdh7iIIKLPTJXwTqyYbb6vrBsemCh4G0N6ZflcjT4zeokbWyw6SJG
 fqlnLZ5dpGRJ3WQXElrOqoH4IMShmRF+6hcj3ovNbo6v1avUwhmvAHBpiUkCCoWEJvpA
 gKVmMvtmptIVDEni/pbFzR++hsUqv538ljmR+vjPRnEJiIwE64aL5Av8CAvpQwdSaaWK
 FtBvjEFlea2MB8GJW9O8saVaScVtl7ZuUJcMEC890pmt20cLyJW/3uIsU5PZgQOxR6wY
 oJ8jB9pFr1bqWgFfs4MBd1dGYK4MGWHUmzP0rigwPRHdvfgQxS208QDK62lfhWUupVhx
 R2xQ==
X-Gm-Message-State: AOAM530n1NPNikXeAZESVPAgx0X1xfD2BFQL6QHOLX3sDebs5jo17ZAA
 /83yCVdTyjXwu5X1sKcmhN1egaaMAEU=
X-Google-Smtp-Source: ABdhPJw3LqOKlzmaOrKnHndjT7NGQvSbzWvGqUO01FWhjgMDseW/WU2FhzZwCBW+fOUCo1JLqgS44w==
X-Received: by 2002:a05:6830:11d5:: with SMTP id
 v21mr16382760otq.306.1608665365092; 
 Tue, 22 Dec 2020 11:29:25 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:a6f2:eb4b:8034:cb36?
 ([2600:1700:65a0:78e0:a6f2:eb4b:8034:cb36])
 by smtp.gmail.com with ESMTPSA id y35sm4666332otb.5.2020.12.22.11.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Dec 2020 11:29:24 -0800 (PST)
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Hao Wang <pkuwangh@gmail.com>, Linux-nvme@lists.infradead.org
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
Date: Tue, 22 Dec 2020 11:29:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201222_142927_982833_82108122 
X-CRM114-Status: GOOD (  21.46  )
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

Hey Hao,

> I'm using kernel 5.2.9 with following related configs enabled:
> CONFIG_NVME_CORE=y
> CONFIG_BLK_DEV_NVME=y
> CONFIG_NVME_MULTIPATH=y
> CONFIG_NVME_FABRICS=m
> # CONFIG_NVME_FC is not set
> CONFIG_NVME_TCP=m
> CONFIG_NVME_TARGET=m
> CONFIG_NVME_TARGET_LOOP=m
> # CONFIG_NVME_TARGET_FC is not set
> CONFIG_NVME_TARGET_TCP=m
> CONFIG_RTC_NVMEM=y
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> 
> On target side, I exported 2 NVMe devices using tcp/ipv6:
> [root@rtptest34337.prn2 ~/ext_nvme]# ll
> /sys/kernel/config/nvmet/ports/1/subsystems/
> total 0
> lrwxrwxrwx 1 root root 0 Dec 19 02:08 nvmet-rtptest34337-1 ->
> ../../../../nvmet/subsystems/nvmet-rtptest34337-1
> lrwxrwxrwx 1 root root 0 Dec 19 02:08 nvmet-rtptest34337-2 ->
> ../../../../nvmet/subsystems/nvmet-rtptest34337-2
> 
> On initiator side, I could successfully connect the 2 nvme devices,
> nvme1n1 & nvme2n1;
> [root@rtptest34206.prn2 /]# nvme list
> Node             SN                   Model
> Namespace          Usage                      Format           FW Rev
> ---------------- --------------------
> ---------------------------------------- ---------
> -------------------------- ---------------- --------
> /dev/nvme0n1     ***********     INTEL *******          1
> 256.06  GB / 256.06  GB    512   B +  0 B    PSF119D
> /dev/nvme1n1     ***********     Linux                       1
> 900.19  GB / 900.19  GB      4 KiB +  0 B     5.2.9-0_
> /dev/nvme2n1     ***********     Linux                       1
> 900.19  GB / 900.19  GB      4 KiB +  0 B     5.2.9-0_
> 
> Then for each of nvme1n1 & nvme2n1, I created a partition using fdisk;
> type is "linux raid autodetect";
> Next I created a RAID-0 volume using, created a filesystem on it, and
> mounted itL
> # mdadm --create /dev/md5 --level=0 --raid-devices=2 --chunk=128
> /dev/nvme1n1p1 /dev/nvme2n1p1
> # mkfs.xfs -f /dev/md5
> # mkdir /flash
> # mount -o rw,noatime,discard /dev/md5 /flash/
> 
> Now, when I copy a large directory into /flash/, a lot of files under
> /flash/ are corrupted.
> Specifically, that large directory has a lot of .gz files, and unzip
> will fail on many of them;
> also diff with original files does show they are different, although
> the file size is exactly the same.

Sounds strange to me. Nothing forbids mounting a fs on a raid0 volume.

> Also I found that if I don't create a RAID-0 array, instead just make
> a filesystem on either /dev/nvme1n1p1 or /dev/nvme2n1p1, there is no
> data corruption.
> 
> I'm wondering if there is a known issue, or I'm doing something not
> really supported.

Did you try to run the same test locally on the target side without
having nvme-tcp/nvmet-tcp target in between?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
