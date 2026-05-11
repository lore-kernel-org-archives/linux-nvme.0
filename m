Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1B4CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 11:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OZ5xkZ0e9jXp+Xj5me4+7ysOceTyBfYL7/NAgZi9VAw=; b=fMjUYg/pRHGlroVPbBokYlTDAn
	68Kn+X/AH0iD9iNCbjpbjGl5fFnOGRHnnNZXN/gxMwMqeMI53ADtkXqfcsMWA2bX5N7eY55vcyV83
	t0hr1gU02XVS2GzkhDuoGVZRCOLP/tXX9ygAK5tPtwpIHwPEUgY07409L482g7uydkWgTNYi6yOCD
	DqeuXTREF9BreDmShqBF1r76D1C124pCZ8qak7z7Qpgh1MHevuJeVe2s7199Om6Xd7Wa2bptf6Xfs
	AqWv3yqodkuvyROG4JVab+/12iHx7KdMgp2JxevlHjyVITqbIcg/XFzCLR6St6ffKYiMrNk7ox0w1
	nz5I6OSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOms-0000000DJgD-2ybN;
	Mon, 11 May 2026 11:27:02 +0000
Received: from out28-58.mail.aliyun.com ([115.124.28.58])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOmo-0000000DJfR-3TNE
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 11:27:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778498814; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=OZ5xkZ0e9jXp+Xj5me4+7ysOceTyBfYL7/NAgZi9VAw=;
	b=E9kV7+WHN9fVsIphGKn8UCNcsZKpWJBXvxZe951Rr5inrTpJV3/yZ6nxHpOzM4/vLFU6vk3MGj3tP/t3BYO0PLl/Cv4iMpURdOHutfUTemup33SacquJCZUsHpQCKl0T2ZPsni1T1nUbBP3yHONz4xZpcM+FokIsQuVKNE7ZaDGMO1taG8nYJeA1x2wqNVeckzghcmY8DG0++Yyhih+VVC3v/MnWuDMbt8ZMn8TEfk1bNObshE6nsIGBWoMSz6HX4EPMHuu5hHsA9v/5v8vC6gBG30KvMf2gsioREUGPtrf71hnchD0F/Z2+wNUQXYHDvOnzLuTU9wHHHqHvFZHDDg==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07439868|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00681409-0.000823098-0.992363;FP=3488414299476266387|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=me@alancui.cc;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.hUaJPPo_1778498812;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hUaJPPo_1778498812 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 19:26:53 +0800
From: AlanCui4080 <me@alancui.cc>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC V2 RESEND] nvme: make providing NGUID as UUID usage less scary
Date: Mon, 11 May 2026 19:26:52 +0800
Message-ID: <Zst0-NsAQXycTiAgqZMfEA@alancui.cc>
In-Reply-To: <p3A0AxbHQ4aKNhfIeaPQng@alancui.cc>
References: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc> <p3A0AxbHQ4aKNhfIeaPQng@alancui.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_042659_275260_D85DAA61 
X-CRM114-Status: GOOD (  24.00  )
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

[see https://lists.infradead.org/pipermail/linux-nvme/2026-May/062762.html =
for full thread]

Hi everyone,

About this patch and the discussion above, I just did a survey on
kernel commit history:

Long ago, the kernel sees NGUID as UUID.

2b9b6e86bca7209de02754fc84acf7ab3e78734e (NVMe: Export namespace attributes=
 to sysfs)
> 	if (ns->ctrl->vs >=3D NVME_VS(1, 2))
>		memcpy(ns->uuid, id->nguid, sizeof(ns->uuid));

Then, the kernel begins by retrieving the UUID from the driver and,
in a backward compatible manner, reports the NGUID as the UUID when
the UUID is unavailable, and throws a warning.

d934f9848a77be4afe0ca336ea419dd066c934f3 (nvme: provide UUID value to users=
pace
Now that we have a way for getting the UUID from a target, provide it
to userspace as well.
Unfortunately there is already a sysfs attribute called UUID which is
a misnomer as it holds the NGUID value. So instead of creating yet
another wrong name, create a new 'nguid' sysfs attribute for the
NGUID. For the UUID attribute add a check wheter the namespace has a
UUID assigned to it and return this or return the NGUID to maintain
backwards compatibility. This should give userspace a chance to catch
up.)
>    static ssize_t uuid_show(...)
>	/* For backward compatibility expose the NGUID to userspace if
>	 * we have no UUID set
>	 */
>	if (uuid_is_null(&ns->uuid)) {
>		printk_ratelimited(KERN_WARNING
>				   "No UUID available providing old NGUID\n");
>		return sprintf(buf, "%pU\n", ns->nguid);
>	}
>	return sprintf(buf, "%pU\n", &ns->uuid);

And at d934f984:

> static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
>		struct attribute *a, int n)
>{
>	struct device *dev =3D container_of(kobj, struct device, kobj);
>	struct nvme_ns *ns =3D nvme_get_ns_from_dev(dev);
>
>	if (a =3D=3D &dev_attr_uuid.attr) {
>		if (uuid_is_null(&ns->uuid) ||
>		    !memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) // ??????? Why
>			return 0;
>	}
>	if (a =3D=3D &dev_attr_nguid.attr) {
>		if (!memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
>			return 0;
>	}
>	if (a =3D=3D &dev_attr_eui.attr) {
>		if (!memchr_inv(ns->eui, 0, sizeof(ns->eui)))
>			return 0;
>	}Therefore, my suggestion is to directly remove the UUID that is copied f=
rom NGUID.
>	return a->mode;
>}

The visibility of the uuid attr is depends on if NGUID exists, I'dont know =
why.
I believe that in this scenario, if NGUID doesn't exist, then UUID won't ex=
ist either.
Therefore, the user-space assumption that UUID exists has always been a bug.
Consequently, we don't need to assume any responsibility for backward compa=
tibility.

I have hard drives that can demonstrate this behavior.

```
sudo nvme id-ctrl /dev/nvme1n1
vid       : 0x144d
mn        : Samsung SSD 970 EVO Plus 500GB         =20
fr        : 2B2QEXM7
ieee      : 002538
ver       : 0x10300

cat /sys/block/nvme1n1/eui
00 25 ** ** ** ** ** 2a

cat /sys/block/nvme1n1/nguid
cat: /sys/block/nvme1n1/nguid: No such file or directory

cat /sys/block/nvme1n1/uuid
cat: /sys/block/nvme1n1/uuid: No such file or directory

cat /sys/block/nvme1n1/wwid
eui.0025**********a2
```
As you can see, this NVMe 1.3 compatible device have no nguid,
so it has no both nguid and uuid node.

```
sudo nvme id-ctrl /dev/nvme0n1
NVME Identify Controller:
vid       : 0x1e49
mn        : ZHITAI TiPlus7100 2TB                  =20
fr        : ZTA22002
ieee      : 000000
ver       : 0x10400

cat /sys/block/nvme0n1/eui
a4 ** ** ** ** ** ** c3

cat /sys/block/nvme0n1/nguid
00000000-0000-0000-a428-**********c3

cat /sys/block/nvme0n1/uuid
00000000-0000-0000-a428-**********c3

cat /sys/block/nvme0n1/wwid
eui.0000000000000000a428**********c3
```
As you can see, this NVMe 1.4 compatible device have a nguid, its nguid
is derived from eui64, then because it has an nguid, its uuid is visible
and is copied from nguid.

According to the spec., both devices are compliant.

Therefore, I believe the core issue is no longer just the level or location
of the warning. As you can see, in the current version of the kernel,
the visibility of each attr is highly device-dependent. I think we shouldn't
retain a backward-compatible UUID attr since no userspace software should
assume the existence of any attr and The current kernel code is not backward
compatible in essence! (How can userspace determine whether a device has an
NGUID through means other than the kernel sysfs? If a program in a previous
version assumed the existence of /sys/block/nvmexx/uuid, then that assumpti=
on
is incorrect, because NGUID itself may not exist. Only any one of EUI, NGUI=
D,
and UUID needs to exist.)

Another issue is Why WWIDs generated from NGUIDs have prefix "eui."?
Seems come from:
118472ab8532e55f48395ef5764b354fe48b1d73 (NVMe: Expose ns wwid through sing=
le sysfs entry)
> if (memchr_inv(ns->uuid, 0, sizeof(ns->uuid)))
>		return sprintf(buf, "eui.%16phN\n", ns->uuid);
This should be a naming error.

Then, when the kernel changed the UUID to a more appropriate name,
the eui. prefix was also carried over. And the commit said "This
patch has the driver figure this out and exports the unique string
through a single 'wwid' attribute so the user doesn't have this burden.=E2=
=80=9D

Since /dev/disk/by-id/ already uses wwid, I don't think there's much we can=
 do,
otherwise this would destroy compatibility. This seems to indirectly confirm
that the kernel is requiring users to check the existence of
/sys/block/nvmexx/[eui,nguid,uuid] before using it.

Therefore, my suggestion is to directly remove the UUID that is copied from
NGUID. Make the visibility of UUID depend on whether the device has a UUID,
rather than an NGUID to completely eliminates this strange warning and
backward compatibility path.

Thank you for your attention to this matter, I'm look forward to your thoug=
hts.

Alan.






