Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ABFCD3447
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ifF8VJh2AbUshPExvgDKjK4OEdpRQl804VjIRkqNLLE=; b=RwglvDM1bhrO5Zjq8qMfWi4CAm
	25NovCPx+qRzmC0eyZPSaD0WVIVzWmveXmTcn/+2uqbXHWht3oagAVlw5JKbZVe5pOTBKbcHrquB/
	l4NmSHKbxwLQyCNOlParHRRrKT2gk2KC+r4nXuTx5xT9jMkuoNBD/LmNcn8kI9gbCuYdjMg3a/hWD
	jZtqQ5cVHznAIkGtBf0lfb5Ze8ciOIgJARjUg+8DNY7TKBHBSxw5oPDCQxNutmiT7G9A3V/Hm9qKu
	XY305X6Q6U2u45F5zYlH0TSMF+8TgqUIPhwM7GgXs8Rvr9MvF+lvGKJ6x67t0TftcjLKgeKVkYzFL
	z/Zw303A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL1lQ-00000004M6M-0n2W;
	Thu, 07 May 2026 16:39:52 +0000
Received: from out28-58.mail.aliyun.com ([115.124.28.58])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL1lN-00000004M53-2TWG
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 16:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778171984; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=ifF8VJh2AbUshPExvgDKjK4OEdpRQl804VjIRkqNLLE=;
	b=pozJD6RS66ByJteNcWuCD+TYit4I7dSOWpBV7qzeMt/LE/A9v4+igtokGaNWi4qnudEVWjVir676QJY3I82B9pv3qrC+knvm6mHcIPjJCsUFM37Au9Zm4Pz9eitJqaTzm8bYWbxAJLO1dLhcG9SxbGq0KcpOMJlR4+ljIudpTvmIpw7AMc2xSWm92gNSfTvyryCBzju+jZD42B1mh+F4TDGDY2+ZJ73gn0BTNTq14ikY8ojJpHmr99rDFViuSIW5FkRb1HVPZEUbbWVba8CpxVIPR+wCttFMo2PwJ0hmuuvvsxKN1cObg5QiiM1LIpmdBofZFAChjNMk9NCZLvwZWg==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.9243594|0.09915012;CH=green;DM=|AD|false|;DS=CONTINUE|ham_alarm|0.00756983-0.000387579-0.992043;FP=1468833389486074295|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.hRsCWtn_1778171981;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hRsCWtn_1778171981 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 00:39:41 +0800
From: AlanCui4080 <me@alancui.cc>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: make prp passthrough usage less scary
Date: Fri, 08 May 2026 00:33:21 +0800
Message-ID: <ttGgA0rLSfuUm9B7NLF6ig@alancui.cc>
In-Reply-To: <20260506131839.2364791-1-kbusch@meta.com>
References: <20260506131839.2364791-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_093949_974220_FED65118 
X-CRM114-Status: GOOD (  15.11  )
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

On Wednesday, 6 May 2026 21:18=EF=BC=8Cyou wrote=EF=BC=9A
> From: Keith Busch <kbusch@kernel.org>
>=20
> The warning is a bit alarming, and it only prints for the very first
> non-sgl capable device that receives a passthrough command. Just log an
> informational message on initial discovery for every device.

Since we decide to show this warning at device initial discovery stage,
here are some similar warnings that I think are essentially the same.

Those are not really "a problem", but as I said:
> The asymmetry can be misleading to users. If all devices in the system re=
port=20
> the same issue, it might not be a problem, but if only one device reports=
 it,=20
> it might (especially since the user has two identical drives).=20
(Yes I did have two identical drives) and here is the warnings complained by
the kernel nvme driver.

May 07 23:01:34 archlinux kernel: nvme nvme0: missing or invalid SUBNQN fie=
ld.
May 07 23:01:34 archlinux kernel: nvme nvme1: missing or invalid SUBNQN fie=
ld.
May 07 23:06:34 AlanArchDesktop kernel: nvme nvme0: using unchecked data bu=
ffer
May 07 23:06:34 AlanArchDesktop kernel: block nvme0n1: No UUID available pr=
oviding old NGUID

The first two warnings is not misleading, since they are both reported for =
the both
two drives, but the next two messages is not, i checked the firmware revisi=
on and
the hardware revision, but they are identically the same, makes me really c=
onfused.

So,

In the result of "grep -C3 -rn "dev_warn_once" ./drivers/nvme/*":
=2E/drivers/nvme/host/core.c-1210-        if (ns) {
=2E/drivers/nvme/host/core.c-1211-                effects =3D le32_to_cpu(n=
s->head->effects->iocs[opcode]);
=2E/drivers/nvme/host/core.c-1212-                if (effects & ~(NVME_CMD_=
EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
=2E/drivers/nvme/host/core.c:1213:                        dev_warn_once(ctr=
l->device,
=2E/drivers/nvme/host/core.c-1214-                                "IO comma=
nd:%02x has unusual effects:%08x\n",
=2E/drivers/nvme/host/core.c-1215-                                opcode, e=
ffects);
=2E/drivers/nvme/host/core.c-1216-

Because there is only nvme_passthru_start will call nvme_command_effects,
so I think make it dev_warn should be fine and will not produce too much
warning messages on console, or use dev_warn_ratelimited considering future=
 using.

=2E/drivers/nvme/host/core.c-2736-                ready_timeout =3D NVME_CR=
TO_CRWMT(crto);
=2E/drivers/nvme/host/core.c-2737-
=2E/drivers/nvme/host/core.c-2738-                if (ready_timeout < timeo=
ut)
=2E/drivers/nvme/host/core.c:2739:                        dev_warn_once(ctr=
l->device, "bad crto:%x cap:%llx\n",
=2E/drivers/nvme/host/core.c-2740-                                      crt=
o, ctrl->cap);
=2E/drivers/nvme/host/core.c-2741-                else
=2E/drivers/nvme/host/core.c-2742-                        timeout =3D ready=
_timeout;

=2E/drivers/nvme/host/core.c-2763-        ret =3D nvme_set_features(ctrl, N=
VME_FEAT_TIMESTAMP, 0, &ts, sizeof(ts),
=2E/drivers/nvme/host/core.c-2764-                        NULL);
=2E/drivers/nvme/host/core.c-2765-        if (ret)
=2E/drivers/nvme/host/core.c:2766:                dev_warn_once(ctrl->devic=
e,
=2E/drivers/nvme/host/core.c-2767-                        "could not set ti=
mestamp (%d)\n", ret);
=2E/drivers/nvme/host/core.c-2768-        return ret;
=2E/drivers/nvme/host/core.c-2769-}

Because the first dev_warn_once is in the nvme_enable_ctrl will be unlikely=
 called
multiple times and the second one(nvme_configure_timestamp) is called only =
by
nvme_init_ctrl_finish, so I think make it dev_warn should be fine also.

=2E/drivers/nvme/host/core.c-4045-                        dev_warn(ctrl->de=
vice,
=2E/drivers/nvme/host/core.c-4046-                                "Found sh=
ared namespace %d, but multipathing not supported.\n",
=2E/drivers/nvme/host/core.c-4047-                                info->nsi=
d);
=2E/drivers/nvme/host/core.c:4048:                        dev_warn_once(ctr=
l->device,
=2E/drivers/nvme/host/core.c-4049-                                "Shared n=
amespace support requires core_nvme.multipath=3DY.\n");
=2E/drivers/nvme/host/core.c-4050-                }
=2E/drivers/nvme/host/core.c-4051-        }

Should be OK to dev_warn_once as only hint about how to deal with it.

=2E/drivers/nvme/host/ioctl.c-126-        int ret;
=2E/drivers/nvme/host/ioctl.c-127-
=2E/drivers/nvme/host/ioctl.c-128-        if (!nvme_ctrl_sgl_supported(ctrl=
))
=2E/drivers/nvme/host/ioctl.c:129:                dev_warn_once(ctrl->devic=
e, "using unchecked data buffer\n");
=2E/drivers/nvme/host/ioctl.c-130-        if (has_metadata) {
=2E/drivers/nvme/host/ioctl.c-131-                if (!supports_metadata)
=2E/drivers/nvme/host/ioctl.c-132-                        return -EINVAL;
=2E/drivers/nvme/host/ioctl.c-133-
=2E/drivers/nvme/host/ioctl.c-134-                if (!nvme_ctrl_meta_sgl_s=
upported(ctrl))
=2E/drivers/nvme/host/ioctl.c:135:                        dev_warn_once(ctr=
l->device,
=2E/drivers/nvme/host/ioctl.c-136-                                      "us=
ing unchecked metadata buffer\n");
=2E/drivers/nvme/host/ioctl.c-137-        }
=2E/drivers/nvme/host/ioctl.c-138-

Resolved in your last patch.

=2E/drivers/nvme/host/sysfs.c-148-         */
=2E/drivers/nvme/host/sysfs.c-149-        if (uuid_is_null(&ids->uuid)) {
=2E/drivers/nvme/host/sysfs.c-150-                // moved to core.c=20
=2E/drivers/nvme/host/sysfs.c:151:                // dev_warn_once(dev,
=2E/drivers/nvme/host/sysfs.c-152-                //      "No UUID availabl=
e providing old NGUID\n");
=2E/drivers/nvme/host/sysfs.c-153-                return sysfs_emit(buf, "%=
pU\n", ids->nguid);
=2E/drivers/nvme/host/sysfs.c-154-        }

Essentially the same as the "prp passthrough usage warning", the patch was =
sent
before this email.


Thank you for your attention to this matter.

Alan.




