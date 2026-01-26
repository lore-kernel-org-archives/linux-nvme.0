Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFC6D19510
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jan 2026 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yYH7JXhTcEvtygVuGJmyaFI1fwvDwf21x8TUEydHGUg=; b=Vbtgqt9Tl+m+FAnufInCg46Igk
	afUhIQNNX31IFxQwDcr/iSGA9/1v5XkYKwPX1RQT3wZKam8zqUAWgmqtI/s0mZW8hmscPXdUvRdyF
	iTdHPWLs6Dz/c4IsjdstmxF+K5bjvKPHcVTeDe5nF3vsA7Pl8ihu60JcEEskOmOCZzqr1Q1StL6ue
	2CkoLjscuufnMaSNmvN3+JoaxJFhzSiUVhXS/TbFyQVcIVfvxwihzoutB4nJmgE9EHQMhoN3GK4VE
	+Ns7GvFz/AKgGjq9K4ex6KBbYUhfqr6E+iWtB0SgKFdbiHiojixGmqoex+tH3kF1g0g3l945M+pfI
	oFABKnzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkRAn-0000000D3z7-3edp;
	Mon, 26 Jan 2026 18:18:49 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkRAl-0000000D3y8-0kre
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jan 2026 18:18:48 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-78fba1a1b1eso72027167b3.1
        for <linux-nvme@lists.infradead.org>; Mon, 26 Jan 2026 10:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1769451525; x=1770056325; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yYH7JXhTcEvtygVuGJmyaFI1fwvDwf21x8TUEydHGUg=;
        b=tMvW2jrovMBFJdVPoijyeokoZRHK/hT8LZYspQMYCvnm8uyPRVKBf3IcZf48Ayzedy
         cQB0NFI/ZDyvAuA/ov7U+qx3TO/HE3IVciHweYjP6m5agRvtRiAE5Dm4yv6+bZX/wWpv
         jxOBJ6gKeKVLWuQ9SN1ssKgCr+MDdfFI7vwMGGrfh9Vzna4qVrsBycJI3JqldryKAV1j
         s9Rp9iHCMbMoUu9ClKJZSQfN0iZkGLaTplJzuoz0u5XLONQBqZrGYqgNjTTfjIQKbNl8
         MMBMEvQPGWQ6MsoAJ8UMqizeXzCfUwzexl5iUE0jGusq/gDg59VRcd85S6B885/XIRbc
         r3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769451525; x=1770056325;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYH7JXhTcEvtygVuGJmyaFI1fwvDwf21x8TUEydHGUg=;
        b=SiCJeLm12XS29Nznzy/ptBLxQFVM+Ys/NyDXthxWbljfqPO+/vAKHIw6W60iNr1rkM
         OdY1sOja0/rCesywA0ERNEe+6GG+xpK2JT04TFYrPFAl6N5Fj7Esdmvc1BSSEvLkW+Q5
         ThCY9qRusx3gV2DQOW3+jNREnyW9z+QMWhxLf3LEaQlm4S25o8jZCrtkgF/LEfDPGtQi
         p8LWaddfuWLDaowMliN5tE9NOt46Et2sGjASYOLK4AafYIT8vW/ptF3hRXx6rePF5rNb
         3CnPkKQ/K+F0CN1Neb/estpKfjhWdrvyARUTranfgqaHYMNC22ZAwduCJSzZvdRiIhWc
         oEow==
X-Forwarded-Encrypted: i=1; AJvYcCXvGTHbg6mNpKjAjjvenSToxmwzrPIpYa0/sXqEh1QBjNw1UfNDbnnG/7fl+JP4urUND91/buEKC5lX@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+tHJnB9easYmgCH1PlE9hBQjBHVKdv8Onrrf0hD5JooD1muZj
	LhbVICTOw87Q3NWeKh0KSCusbYcx/PHMnPUtjDfYfg5m+4F8p+xtfVIPHdVDy5l+gqk=
X-Gm-Gg: AZuq6aJjCqqxB2QWTVv3S/znn75DUQMJNMcuvLZmbG5rcLtC9NacyfFwIwpfBk/o7t1
	BWgtEWLyTLhvqu/YIq4o9DtvZ4Kj913JBuPm+naMY2DWNjXQvb3r+9sSvjmnlolIvWzZf7Yy3qp
	dmgG6Bx4anzC5gy/i8P9DprVOO/GCxqsU7olgpXj46HTYtkEs2rYaqMSFKGBM5iMTer+IzR07x4
	j7h1rSWM9sHz4vx8J5++4+Y9xIn7dU/93i+H/RmogJ78HpOuvLGw4TCvykhpOVJs5qoywRrNyVu
	hUzCn45ZzbCB19Ky3ShALdbYTulboSqD45yYv7elnyusITDs10oZqT64RoYTi5C5yzisP93XPT6
	Qq4MqivHURnOEYP8fXeEpFpGJJgwr3Bfl9xYwWIAa27iAc8E89XRtWlFjnl9KWju1qTyJjr1Eby
	v6yncEuNyqoyf/DstsmdcK9o+b0Yti3wO/W5FzDrQC/4kA/hhXXyYFlx+w0R5rNvMzEq8ubpmaR
	24rTnHV4359vfAKyudK8g==
X-Received: by 2002:a05:690c:25ca:b0:790:6486:83b2 with SMTP id 00721157ae682-7945ad6f19amr36544627b3.23.1769451525300;
        Mon, 26 Jan 2026 10:18:45 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:d578:f21:8e2f:7e3c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943af13d26sm50771927b3.1.2026.01.26.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 10:18:44 -0800 (PST)
Message-ID: <eab078c99e17e45632c6b35e2fe1145e9459ff2f.camel@dubeyko.com>
Subject: Re: [LSF/MM/BPF TOPIC] Block storage copy offloading
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Bart Van Assche <bvanassche@acm.org>, "linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	 <linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	 <linux-nvme@lists.infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 26 Jan 2026 10:18:43 -0800
In-Reply-To: <0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org>
References: <0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_101847_397121_93851F48 
X-CRM114-Status: GOOD (  31.76  )
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

On Fri, 2026-01-23 at 14:19 -0800, Bart Van Assche wrote:
> Adoption of zoned storage is increasing in mobile devices. Log-
> structured filesystems are better suited for zoned storage than
> traditional filesystems. These filesystems perform garbage
> collection.
> Garbage collection involves copying data on the storage medium.
> Offloading the copying operation to the storage device reduces energy
> consumption. Hence the proposal to discuss integration of copy
> offloading in the Linux kernel block, SCSI and NVMe layers.
>=20
> Other use-cases for copy offloading include reducing network traffic
> in
> NVMeOF setups while copying data and also increasing throughput while
> copying data.
>=20

Idea is interesting, but...

I am not completely sure that copy offloading to the storage device can
reduce energy consumption. The storage device needs to spend energy for
executing this operation, anyway. Do you have any numbers that can
prove your point?

Also, I don't see how LFS file system can manage it. Because, LFS file
system contains a sequence of logs. And log contains as metadata as
user data. Even if one log contains only metadata and another one
contains user-data, then before sending metadata log on the volume the
user-data locations should be known and stored into metadata log(s).
So, what is your vision of model of collaboration LFS file system and
block layer? Which file system have you considered as working model of
your approach?

Thanks,
Slava.


> Note: when using fscrypt, the contents of files can be copied without
> decrypting the data since how data is encrypted depends on the file
> offset and not on the LBA at which data is stored. See also
> https://docs.kernel.org/filesystems/fscrypt.html.
>=20
> My goal is to publish a patch series before the LSF/MM/BPF summit
> starts
> that implements the following approach, an approach that hasn't been
> proposed yet as far as I know:
> * Filesystems call a block layer function that initiates a copy
> offload
> =C2=A0=C2=A0 operation asynchronously. This function supports a source bl=
ock
> =C2=A0=C2=A0 device, a source offset, a destination block device, a desti=
nation
> =C2=A0=C2=A0 offset and the number of bytes to be copied.
> * That block layer function submits separate REQ_OP_COPY_SRC and
> =C2=A0=C2=A0 REQ_OP_COPY_DST operations. In both bios bi_private is set s=
uch
> that
> =C2=A0=C2=A0 it points at copy offloading metadata. The bi_private pointe=
r is
> used
> =C2=A0=C2=A0 to associate the REQ_OP_COPY_SRC and REQ_OP_COPY_DST operati=
ons
> that
> =C2=A0=C2=A0 are involved in the same copying operation.
> * There are two reasons why the choice has been made to have two copy
> =C2=A0=C2=A0 operations instead of one:
> =C2=A0=C2=A0 - Each bio supports a single offset and size (bi_iter). Copy=
ing
> data
> =C2=A0=C2=A0=C2=A0=C2=A0 involves a source offset and a destination offse=
t. Although it
> would
> =C2=A0=C2=A0=C2=A0=C2=A0 be possible to store all the copying metadata in=
 the bio data
> =C2=A0=C2=A0=C2=A0=C2=A0 buffer, this approach is not compatible with the=
 existing bio
> =C2=A0=C2=A0=C2=A0=C2=A0 splitting code.
> =C2=A0=C2=A0 - Device mapper drivers only support a single LBA range per =
bio.
> * After a device mapper driver has finished mapping a bio, the result
> of
> =C2=A0=C2=A0 the map operation is stored in the copy offloading metadata.=
 This
> =C2=A0=C2=A0 probably can be realized by intercepting dm_submit_bio_remap=
()
> calls.
> * The device mapper mapping process is repeated until all input and
> =C2=A0=C2=A0 output ranges have been mapped onto ranges not associated wi=
th a
> =C2=A0=C2=A0 device mapper device. Repeating this process is necessary in=
 case
> of
> =C2=A0=C2=A0 stacked device mapper devices, e.g. dm-crypt on top of dm-li=
near.
> * After the mapping process is finished, the block layer checks
> whether
> =C2=A0=C2=A0 all LBA ranges are associated with the same non-stacking blo=
ck
> driver
> =C2=A0=C2=A0 (NVMe, SCSI, ...). If not, the copy offload operation fails =
and
> the
> =C2=A0=C2=A0 block layer falls back to REQ_OP_READ and REQ_OP_WRITE opera=
tions.
> * One or more copy operations are submitted to the block driver. The
> =C2=A0=C2=A0 block driver is responsible for checking whether the copy
> operation
> =C2=A0=C2=A0 can be offloaded. While the SCSI EXTENDED COPY command suppo=
rts
> =C2=A0=C2=A0 copying between logical units, whether the NVMe Copy command
> supports
> =C2=A0=C2=A0 copying across namespaces depends on the version of the NVMe
> =C2=A0=C2=A0 specification supported by the controller.
> * It is verified whether the copy operation copied all data.
> =C2=A0=C2=A0 If not, the block layer falls back to REQ_OP_READ and
> REQ_OP_WRITE.
>=20
> Thanks,
>=20
> Bart.

