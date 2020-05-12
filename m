Return-Path: <SRS0=WsD/=62=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D172C54E4A
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 09:27:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB88F20714
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 09:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nm41kQSt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+3TTTt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB88F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=uBprUM7hbMCJuqfjUdEpbDvpaV5IYRVJKYm49JJDz3c=; b=Nm4
	1kQStwL/JuyX4EDEolCTL0Ahzb6PCEbtSeajH6GgbXzqrXD61RssczhSconIHjr+hdj/aOCCs1Juj
	55SrJrtkRwgjdnTI0VOHpjGCvb0rXtTq6y2TNpWKGuXEJT8hqvFs82qE2/GxJ+/ibSaVUFm9aaW8L
	/Lgzn8DMhPL8kPSn4VfYqYtnNfFBLkUzfs36ZLxDwSFXD4YNWSUnVrIsmmhJImmiRWAUQnB5P7d35
	RzVvBTGr+0P1wq0WOJ0UivTQ4fANLAi6R9NCF+c6wmqMlS8OcZ+dsRdQUeXCwUPf1KAUZmuL+gbQy
	JK0UQyhKU58UELaSEQsEjYf73FiUgcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYRCH-0002pU-Ur; Tue, 12 May 2020 09:27:33 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYRCE-0002of-Ts
 for linux-nvme@lists.infradead.org; Tue, 12 May 2020 09:27:32 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id z9so3913824qvi.12
 for <linux-nvme@lists.infradead.org>; Tue, 12 May 2020 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=8LgU6Ubw/EnY9IJENxh2ISFRJ9CwHsYvJHAtfBK9kNo=;
 b=t+3TTTt+NF6+dOgfIxF2LYDq7TadtnS3XaAwUGkBjyXM2N9kcL6F66nMUO43rGrYpi
 P+hz7mjQDHvZc7SEQCemoKVX6IZR2ttkRaBwpPZ3jh2Tr78j6IUQBsKvuU1oddkFnHWd
 D5+Omq4rB5/sCz7EdpPiPpbR6B5RHd9Be0gy4M1IomV8BdWYgUuh6oY8vjloWABSj2zX
 heukNFzMEw70hmTUl1b6VENxyvwox8AMTQKqxAUp9x4Lu5t7+ADTWR9Cz2iKQyuUF02j
 IzFs7BevU/s4shBRMB/3NlWh8aeSlgSOUu3ijJS0//U0nL2qhWYbnt7WqvUWsEbDSHzu
 HewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=8LgU6Ubw/EnY9IJENxh2ISFRJ9CwHsYvJHAtfBK9kNo=;
 b=hn8py2i6HroZ84OBK6A5sz7+/h4XkSrcHL9k/YyhtSG05PrX/BnS4FwgutURXQ2qku
 h9+ci2yKEP3vOHGW6XLYwspAk26XG70dduxraOKQO/4G2o9nwu6d6SAi4yAdnvw8ZmKT
 EnWoReWy+ss0XyxoxCXzhuQfS6ISPuFAYc4hkAIbcPZnIPvKk+mH9bxDhdXfE1ezOJgu
 zvk0zhw+a/eguGAMb3/Vmd1Z8b2Cod23LeoEklXQWsbgGUe5oteD4j0mVMuIxaJ8Srmi
 k6WgXMIiQjJePH65LjGb9mgXY82cO8J4DOdukRdttkqcr7hzFx8ZCihY7BLNjKhLhLKd
 +sdQ==
X-Gm-Message-State: AOAM5320D6OUPKhk1vV7uC6ivQdT4+DrgK2DVA48LEzEe8+EWhjNyVCR
 M0I9EixQU5o62o2a+cQEzkT5JNxFP8Y7j9HgEo+TmPK67sw=
X-Google-Smtp-Source: ABdhPJwLrJ5B2aKcdyFk8XJsoK/GfePWam/ZvVn+deBn2Tv4AQCZ+urm+zpZlVwk0uw/kXsThWTc40/Soot2cY1d6+s=
X-Received: by 2002:a05:6214:1ec:: with SMTP id
 c12mr6063838qvu.11.1589275649003; 
 Tue, 12 May 2020 02:27:29 -0700 (PDT)
MIME-Version: 1.0
From: Peter Walker <peter.walker9520@gmail.com>
Date: Tue, 12 May 2020 11:27:18 +0200
Message-ID: <CAGkZ3m9UE_T2RDM=TLTERopuA+AjHenH_9AkTYF8f5R52W5_FQ@mail.gmail.com>
Subject: Problems in Samsung PM1733 SRIOV
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200512_022730_989831_7ABF7E49 
X-CRM114-Status: UNSURE (   7.78  )
X-CRM114-Notice: Please train this message.
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello All,

I am using Samsung PM1733 and testing the SRIOV feature of the device.
There were some problems while enabling VFs.

dmesg logs while booting system are as follows:

# dmesg | grep nvme
[    1.471488] nvme nvme0: pci function 0000:2d:00.0
[    1.685264] nvme nvme0: Shutdown timeout set to 10 seconds
[    1.694565] nvme nvme0: 8/0/0 default/read/poll queues
[    1.695383] nvme0n1: detected capacity change from 0 to
214748364800

# dmesg | grep "0000:2d:00.0"
[    0.326083] pci 0000:2d:00.0: [144d:a824] type 00 class 0x010802
[    0.326105] pci 0000:2d:00.0: reg 0x10: [mem 0xe1000000-0xe1007fff 64bit]
[    0.326134] pci 0000:2d:00.0: reg 0x30: [mem 0xffff0000-0xffffffff
pref]
[    0.326368] pci 0000:2d:00.0: reg 0x20c: [mem 0x00000000-0x00007fff
64bit]
[    0.326370] pci 0000:2d:00.0: VF(n) BAR0 space: [mem
0x00000000-0x000fffff 64bit] (contains BAR0 for 32 VFs)
[    0.326517] pci 0000:2d:00.0: 31.504 Gb/s available PCIe bandwidth,
limited by 8 GT/s x4 link at 0000:2c:00.0 (capable of 63.012 Gb/s with
16 GT/s x4 link)
[    0.348295] pci 0000:2d:00.0: can't claim BAR 6 [mem
0xffff0000-0xffffffff pref]: no compatible bridge window
[    0.348542] pci 0000:2d:00.0: BAR 6: assigned [mem
0xe1010000-0xe101ffff pref]
[    0.348545] pci 0000:2d:00.0: BAR 7: no space for [mem size 0x00100000 64bit]
[    0.348546] pci 0000:2d:00.0: BAR 7: failed to assign [mem size
0x00100000 64bit]
[    0.348581] pci 0000:2d:00.0: BAR 6: assigned [mem
0xe1200000-0xe120ffff pref]
[    0.348583] pci 0000:2d:00.0: BAR 0: assigned [mem
0xe1210000-0xe1217fff 64bit]
[    0.348590] pci 0000:2d:00.0: BAR 7: assigned [mem
0xe1218000-0xe1317fff 64bit]
[    0.490257] pci 0000:2d:00.0: Adding to iommu group 36
[    1.471488] nvme nvme0: pci function 0000:2d:00.0


Then I am enabling VFs with the below command:

# echo 3 > /sys/bus/pci/devices/0000\:2d\:00.0/sriov_numvfs

Then, the kernel tries to initialize the 3 new nvme VF devices (i.e.,
/dev/nvme1, /dev/nvm2 and /dev/nvme3).
However, initialization aborted with the below message.

# dmesg
[  200.776161] pci 0000:2d:00.1: [144d:a824] type 00 class 0x010802
[  200.776785] pci 0000:2d:00.1: Adding to iommu group 37
[  200.777073] nvme nvme1: pci function 0000:2d:00.1
[  200.777149] nvme 0000:2d:00.1: enabling device (0000 -> 0002)
[  200.777204] pci 0000:2d:00.2: [144d:a824] type 00 class 0x010802
[  200.778805] pci 0000:2d:00.2: Adding to iommu group 38
[  200.779193] nvme nvme2: pci function 0000:2d:00.2
[  200.779224] nvme 0000:2d:00.2: enabling device (0000 -> 0002)
[  200.779284] pci 0000:2d:00.3: [144d:a824] type 00 class 0x010802
[  200.780146] pci 0000:2d:00.3: Adding to iommu group 39
[  200.780430] nvme nvme3: pci function 0000:2d:00.3
[  200.780460] nvme 0000:2d:00.3: enabling device (0000 -> 0002)
[  231.336804] nvme nvme1: Device not ready; aborting initialisation
[  231.336807] nvme nvme2: Device not ready; aborting initialisation
[  231.336812] nvme nvme2: Removing after probe failure status: -19
[  231.336828] nvme nvme1: Removing after probe failure status: -19
[  231.344759] nvme nvme3: Device not ready; aborting initialisation
[  231.344778] nvme nvme3: Removing after probe failure status: -19

Please let me know if I am missing something while enabling VFs here.

Thanks,
Peter

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
