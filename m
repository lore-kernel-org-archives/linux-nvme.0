Return-Path: <SRS0=D3NM=F2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CCDC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 19:59:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85AE20705
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 19:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85AE20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+DgOKauyDzAEgH2o6vyhVK4ieFzc/JXS9EWtGLDfvO4=; b=C1iZWjlhPOM8ADTmgCpQLuUl8
	HbgpySYuSprylXG9LcDyS38jReCTzVQ8O7GWYiDY7+/a9Mw/GWeRJ4MAyHpT02D1hVyMOal8coxrz
	Ve/AFyv64GCCXA/kXB7nrqiIoC553x11Fi30L4e0v+pj+7i07v07a/Mji9dNQ+a/TlYn56QOE5oRH
	OYkgo7vFjRZ3tVLfMe9Ij4g5vEcFe7oprm0r1qqo7110MkbWZ4VwPdDHSjC950th9sbdwvI+WxYe1
	lfLb3O6fR+UiCCuzy7LPWBA5Irkka9QMIwq2tZN0yprVmAfs9YbvhAih5Fi/JumDsXgwlZCEtp6yi
	pQpmTdfFw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krnoK-00045s-Ih; Tue, 22 Dec 2020 19:59:08 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krnoH-00045O-3v
 for Linux-nvme@lists.infradead.org; Tue, 22 Dec 2020 19:59:05 +0000
Received: by mail-ed1-x533.google.com with SMTP id u19so14068401edx.2
 for <Linux-nvme@lists.infradead.org>; Tue, 22 Dec 2020 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gVtFtY4XEvJR1m8AuVQyDJBolIl/2VKWdlicJgLuXFo=;
 b=AbsHeduJ/WPfSNo9Qt5Qrz4+12W0S8XjCUYjfbrrn76e2UpM2RNY4MkjFbmErEgGNb
 8abJmFoNzPH9SeOd3EXHD6bxmhmpIndK2MMen54QYk/uLlRZL7KZrRlq9Wc+ykNl8OuU
 gUxvHa4UIKFTrXrra5rnIdu4G4f6mYLalxD9qV56iWc/z1sKxkbTaVAzfoZ/VIDWp1e0
 CGEWEvpl/sYxoDeohloH/1t/mIzW0XWTdXbLX6t8LBVruTCkVJdQa5Uo6VSwUuLy8aXO
 JRkCANHP1wnQRWR/64E/0aJo0K30JB0iSK+bfLR+u2Z5oTzxmu2aL0Qhifb9mURMTfmt
 wkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gVtFtY4XEvJR1m8AuVQyDJBolIl/2VKWdlicJgLuXFo=;
 b=Bl9dU/6HpmKszpBtSwZzZIJ4IVFhbqAaYLsLpRIdSA2pTpPJCgh8eVN5/C+hJwCcam
 M2jvoFIflt1+lcAIZ/Uxj+0GISc3hsKLfsyxutjdU/Ybxk9303UaHSp1ZUfxh1QMfV4q
 34i0ZnV6PPJAQ7Jei8rgxMKZ2DXoyi0dIbkLN3+uE6DhHnvfsWRbyuZOV/rnvwpY0Joi
 wGId4vgbRGrqZ8hYikHG57qzu79HfrKxbsefYmRv2FRp1Ac65xlq+w264aj8BbzZkiuG
 Gdy50NfSOoGlcBHvgzmHr7FU57gkiJ6iv4GoRtrGWLAYcXeU7SKAgpFMRmttoTRhArEt
 k8fg==
X-Gm-Message-State: AOAM5310EwwX3KlxAICcTqw897f+XN0oMUIU2RSJ7gug2UboBZM2vNBp
 gm2iIQyfB12/TJtrUZ/KrZROgpboWDMSyzK2OyWlvRtGV04=
X-Google-Smtp-Source: ABdhPJxywLoyZ1JBMFtVZkJ79ti40oRHbVsc0IkO5ETBivvzPVODGSrYUrgJaV6mjPXp1IhYU+FqX61qS/q31GvvbiI=
X-Received: by 2002:a05:6402:17:: with SMTP id
 d23mr21929454edu.341.1608667143139; 
 Tue, 22 Dec 2020 11:59:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
In-Reply-To: <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
From: Hao Wang <pkuwangh@gmail.com>
Date: Tue, 22 Dec 2020 11:58:51 -0800
Message-ID: <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201222_145905_232215_E5E1883B 
X-CRM114-Status: GOOD (  25.74  )
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
Cc: Linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Also really strange to me. This has been burning me 16+ hours a day
for 2 days doing

And for your question, yes I did.
Locally on the target side, no data corruption happening, with the
same process of creating a partition on each device, creating a
2-device raid-0 volume, and creating a filesystem.
I have also tested on multiple sets of machines, but no luck.

Another point I should've mentioned is that corruption does not always
happen. Sometimes if I only copy one .gz file (~100MB), it seems fine.
But whenever I copy a large directory with many .gz files (~100GB in
total), there are always some .gz files corrupted.

Hao

On Tue, Dec 22, 2020 at 11:29 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> Hey Hao,
>
> > I'm using kernel 5.2.9 with following related configs enabled:
> > CONFIG_NVME_CORE=y
> > CONFIG_BLK_DEV_NVME=y
> > CONFIG_NVME_MULTIPATH=y
> > CONFIG_NVME_FABRICS=m
> > # CONFIG_NVME_FC is not set
> > CONFIG_NVME_TCP=m
> > CONFIG_NVME_TARGET=m
> > CONFIG_NVME_TARGET_LOOP=m
> > # CONFIG_NVME_TARGET_FC is not set
> > CONFIG_NVME_TARGET_TCP=m
> > CONFIG_RTC_NVMEM=y
> > CONFIG_NVMEM=y
> > CONFIG_NVMEM_SYSFS=y
> >
> > On target side, I exported 2 NVMe devices using tcp/ipv6:
> > [root@rtptest34337.prn2 ~/ext_nvme]# ll
> > /sys/kernel/config/nvmet/ports/1/subsystems/
> > total 0
> > lrwxrwxrwx 1 root root 0 Dec 19 02:08 nvmet-rtptest34337-1 ->
> > ../../../../nvmet/subsystems/nvmet-rtptest34337-1
> > lrwxrwxrwx 1 root root 0 Dec 19 02:08 nvmet-rtptest34337-2 ->
> > ../../../../nvmet/subsystems/nvmet-rtptest34337-2
> >
> > On initiator side, I could successfully connect the 2 nvme devices,
> > nvme1n1 & nvme2n1;
> > [root@rtptest34206.prn2 /]# nvme list
> > Node             SN                   Model
> > Namespace          Usage                      Format           FW Rev
> > ---------------- --------------------
> > ---------------------------------------- ---------
> > -------------------------- ---------------- --------
> > /dev/nvme0n1     ***********     INTEL *******          1
> > 256.06  GB / 256.06  GB    512   B +  0 B    PSF119D
> > /dev/nvme1n1     ***********     Linux                       1
> > 900.19  GB / 900.19  GB      4 KiB +  0 B     5.2.9-0_
> > /dev/nvme2n1     ***********     Linux                       1
> > 900.19  GB / 900.19  GB      4 KiB +  0 B     5.2.9-0_
> >
> > Then for each of nvme1n1 & nvme2n1, I created a partition using fdisk;
> > type is "linux raid autodetect";
> > Next I created a RAID-0 volume using, created a filesystem on it, and
> > mounted itL
> > # mdadm --create /dev/md5 --level=0 --raid-devices=2 --chunk=128
> > /dev/nvme1n1p1 /dev/nvme2n1p1
> > # mkfs.xfs -f /dev/md5
> > # mkdir /flash
> > # mount -o rw,noatime,discard /dev/md5 /flash/
> >
> > Now, when I copy a large directory into /flash/, a lot of files under
> > /flash/ are corrupted.
> > Specifically, that large directory has a lot of .gz files, and unzip
> > will fail on many of them;
> > also diff with original files does show they are different, although
> > the file size is exactly the same.
>
> Sounds strange to me. Nothing forbids mounting a fs on a raid0 volume.
>
> > Also I found that if I don't create a RAID-0 array, instead just make
> > a filesystem on either /dev/nvme1n1p1 or /dev/nvme2n1p1, there is no
> > data corruption.
> >
> > I'm wondering if there is a known issue, or I'm doing something not
> > really supported.
>
> Did you try to run the same test locally on the target side without
> having nvme-tcp/nvmet-tcp target in between?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
