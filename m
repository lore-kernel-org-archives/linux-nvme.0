Return-Path: <SRS0=D3NM=F2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930BCC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 18:10:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F181224F4
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 18:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F181224F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NrDofCcHPTJSZWUkPHAhB2qyT0KHyxNyvGbmw3LrK2Q=; b=hQ+hy6hNs5nJb+twIi1yw+IJgl
	d8jLYy6A3kwztghTPipT+ykZyLwwjLUvLufJHzu+OIZBj+34YsQy+a2olFNVKngaZ5oQhc3/a7H9A
	+RjV8PwzBJDGNikeJlG4EQfuX1c8u+O8mkQXuIiGMiHaTRoS4iLLu2S2BCvaiUrcb/mcVV0Se2Sut
	ib4WnQjw1RQtAJ0SskKMGyPivTLNifj6s9eok9RH6WUianrML+YwEEFrBoF32IF8Pg3cWcJSJs353
	IEZHpjtrj5/CmQ1IQvJ0DTcBd/tSKuAJ0AtL2RQhuCbGQy9kjcVRRckufP6A3+XXuMCog3CD0UYaX
	xy+xokcw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krm6h-0001uz-1w; Tue, 22 Dec 2020 18:09:59 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krm6e-0001uf-Bn
 for Linux-nvme@lists.infradead.org; Tue, 22 Dec 2020 18:09:57 +0000
Received: by mail-ed1-x533.google.com with SMTP id j16so13823371edr.0
 for <Linux-nvme@lists.infradead.org>; Tue, 22 Dec 2020 10:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Pu6iQOZcnF95LNC1H5Gy7h82rPrBu5Hi1SWi6e53Xhw=;
 b=tZbJnQiaDKAluKQIjAv98BaLwQ5Tx0xgXHGI98I5N6/hTondSjW7dNPS6LtznF9aAM
 d/MHLTN9ld95fiBIxnXXU6fORWyOWIEasrt8U8Mdbo+dEGegUo05xOF7rHB3wXeIdXoF
 eam5w908v9SM/SPh7ZI3NhMALn7scLth1geyYamLI/TBo5NXokvf+FcVnrJ0tbB4m9LW
 qGI8/edGOYJkfIbFbCGJV5FwXzMAg//ToTM8yuDvqu8U2GlYRGoDxDxAcY9KcRvUJ9ew
 Vq65I72wNdw2i0OLxs0R60T2bY1cd26vNnlWIUTklt5KzYXcXtGvxhPzMxMQjYk4pkZS
 eWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Pu6iQOZcnF95LNC1H5Gy7h82rPrBu5Hi1SWi6e53Xhw=;
 b=I6iEWHpRMJCkDDre8FI8A9bU41APN4zuom++6onDt49R7w/rpEIQuIilcsGdeSEdcZ
 AFcFcG4W0QKmTHrbHAwASRwekGhWOhhdMD7yG7k5v5sa/Dp228WgF5ur7kObYUhNiY5/
 1gfGfyqZxsgiQJD7zODuRKcASEqxrcC00JO3CWdhLcby/+z3WzCT8ExydGW76bNT0w1q
 nqo/ozallZrGt9BVe+j/YfiB5BQXNb246E1pjhoH96p4mIZ1SoPFS9tMoE6gYvdW0dTI
 o1QhwcHGjG6OZp9f6wM5hGSUA0lFKis38aKaVSlx0w6N349W+b5eKIdmwbvCEPJVIsft
 mccA==
X-Gm-Message-State: AOAM530+paCCkNdS/mrqS0vKoRO/PIqxhuaGtZ3lKBj2/gWy+CDSOhcQ
 2zcPrEBkB0cvH3OULxukjS0uEuLz1eGJwitGG+SibMmmEmA=
X-Google-Smtp-Source: ABdhPJxtXFuyfL08eK29mboMebfzXbJHJfg0ap7LRLzxWlqgRmW6XSwcCsubavSnvVayvibLawhscHLacwNW+rID2K0=
X-Received: by 2002:a05:6402:17:: with SMTP id
 d23mr21562435edu.341.1608660594216; 
 Tue, 22 Dec 2020 10:09:54 -0800 (PST)
MIME-Version: 1.0
From: Hao Wang <pkuwangh@gmail.com>
Date: Tue, 22 Dec 2020 10:09:43 -0800
Message-ID: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
Subject: Data corruption when using multiple devices with NVMEoF TCP
To: Linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201222_130956_429797_284E43BC 
X-CRM114-Status: GOOD (  13.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I'm using kernel 5.2.9 with following related configs enabled:
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
CONFIG_NVME_TCP=m
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set
CONFIG_NVME_TARGET_TCP=m
CONFIG_RTC_NVMEM=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

On target side, I exported 2 NVMe devices using tcp/ipv6:
[root@rtptest34337.prn2 ~/ext_nvme]# ll
/sys/kernel/config/nvmet/ports/1/subsystems/
total 0
lrwxrwxrwx 1 root root 0 Dec 19 02:08 nvmet-rtptest34337-1 ->
../../../../nvmet/subsystems/nvmet-rtptest34337-1
lrwxrwxrwx 1 root root 0 Dec 19 02:08 nvmet-rtptest34337-2 ->
../../../../nvmet/subsystems/nvmet-rtptest34337-2

On initiator side, I could successfully connect the 2 nvme devices,
nvme1n1 & nvme2n1;
[root@rtptest34206.prn2 /]# nvme list
Node             SN                   Model
Namespace          Usage                      Format           FW Rev
---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1     ***********     INTEL *******          1
256.06  GB / 256.06  GB    512   B +  0 B    PSF119D
/dev/nvme1n1     ***********     Linux                       1
900.19  GB / 900.19  GB      4 KiB +  0 B     5.2.9-0_
/dev/nvme2n1     ***********     Linux                       1
900.19  GB / 900.19  GB      4 KiB +  0 B     5.2.9-0_

Then for each of nvme1n1 & nvme2n1, I created a partition using fdisk;
type is "linux raid autodetect";
Next I created a RAID-0 volume using, created a filesystem on it, and
mounted itL
# mdadm --create /dev/md5 --level=0 --raid-devices=2 --chunk=128
/dev/nvme1n1p1 /dev/nvme2n1p1
# mkfs.xfs -f /dev/md5
# mkdir /flash
# mount -o rw,noatime,discard /dev/md5 /flash/

Now, when I copy a large directory into /flash/, a lot of files under
/flash/ are corrupted.
Specifically, that large directory has a lot of .gz files, and unzip
will fail on many of them;
also diff with original files does show they are different, although
the file size is exactly the same.

Also I found that if I don't create a RAID-0 array, instead just make
a filesystem on either /dev/nvme1n1p1 or /dev/nvme2n1p1, there is no
data corruption.

I'm wondering if there is a known issue, or I'm doing something not
really supported.
Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
