Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B34CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 09:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZiSuFxK7oRdvS4lTujD6rn4SccoqPBNy/rT3Y6wh7Y=; b=sf6rpj4uh4p5C6zim6Xz6UHhDG
	98hA5ZvsKLyvX2wJAcjEEfIy6z9kKbcpAW5KGIF64zltwVoNKbkIPCG9di9N7A+z0EtCuCYJ0hcFW
	4QILCgXcP/Lhh/oc30pgMaDsFe2CqxAi7B8f993XzO5tQ+vMOWIkl6MzjrleKKtqZ2LBnKXX4AQkU
	PBX3Lqzbr5z0NzPFcETqITyIHS20pUjrF1lX5/WR9cWNNg5r9NSpngmBO/mBqy+/3sWoHq+G+I41U
	XxveLmSLUDthdQ71aRY6VVcXVwH2PMwbJk7NTviMxCuz38i3OzGy1AIk4GbnJdz7+PVzx0YfvEN+r
	8RlAcf4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMMkQ-0000000Cs0G-3TQd;
	Mon, 11 May 2026 09:16:22 +0000
Received: from out28-83.mail.aliyun.com ([115.124.28.83])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMMkN-0000000CrzI-2xZw
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 09:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778490975; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=lZiSuFxK7oRdvS4lTujD6rn4SccoqPBNy/rT3Y6wh7Y=;
	b=v6QVD96gzyzuxj18Ifi3/dg1WZilDN1XkLW0O1j1gG/iP58c1ZQ7/FI7VO/tkSluO2iH+pAAaSnEaBdLAhPd3id3q+FzSmzIZ3ufrJ5eXka4dxIg/i23jqYgjQCSeqJD48NDO9e1i79IR4DIG2WlgLF/8wAAGSbl5pO6k1iYVhlGCIspcDvn33EggYpFNmvKLLeRsR8ZrftQXjQNrAvAYV8m5sFI8NGH/H8xF/POnSTeKOTK2bM2it0OMflxzlCUSoIuQAjmcBwOZYIBSbxjUHtWilUAap8KvsOtH/OxcXOlQ2vLZp2bpOOdA4v4F4JS7dxs/zAH6IykjNLFs2U1eA==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2772371|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0810706-0.00106815-0.917861;FP=8126976764260691903|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=me@alancui.cc;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.hUcTGHb_1778490972;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hUcTGHb_1778490972 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 17:16:13 +0800
From: AlanCui4080 <me@alancui.cc>
To: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: make providing NGUID as UUID usage less scary
Date: Mon, 11 May 2026 17:16:12 +0800
Message-ID: <tIi1LbbYTSGqFm10GNZi8Q@alancui.cc>
In-Reply-To: <2MLVK7hsTb2JIM2tKTgqIg@alancui.cc>
References: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc> <agGQZU4NwAgSzHLD@infradead.org>
 <2MLVK7hsTb2JIM2tKTgqIg@alancui.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_021620_020368_C9B41AED 
X-CRM114-Status: GOOD (  11.00  )
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

On Monday, 11 May 2026 16:59=EF=BC=8CI wrote:
> For NVMe spec revision 1.3, there is no UUID yet.
>=20

> If it's mandatory for userspace, why the nvme2n1 has not, if it's not
> mandatory, why should we create the UUID sysfd attr. then put NGUID in it?
> But for a NVMe 1.3 device there is both no UUID and no NGUID, while kernel
> is not reporting warnings at all?

Sorry, I checked the 1.3 specification and found that there is
NGUID and UUID in it.

The only difference between revision 1.3 and 1.4 is Revision 1.4
states that UUIDs should be reported when neither EUI64 nor NGUID is suppor=
ted.

It seems that for an NVMe 1.4 device, its UUID is mandatory when EUI64/NGUID
is not supported. However, the kernel chooses to expose both the UUID and
NGUID of a device with an NGUID but no UUID to sysfs, then warns us every
time we read the device that an NGUID is being used to impersonate a UUID.

But for an NVMe 1.3 device, its UUID is optional when EUI64/NGUID is not
present. However, the kernel chooses not to expose either the UUID or NGUID
of a device with an NGUID but no UUID to sysfs.

This is incredibly strange.

Alan.



