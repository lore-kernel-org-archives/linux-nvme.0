Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95E5CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dzw2Xb8Phvncp+efnaASKEahl6Gou6Yq5bjlTkvoFsc=; b=Mmle+rJr81vKvY1V+71P2mds6Z
	pHA5+L72f5DK6VuuwCkU2K9zRqf5Vf6rL5X5TL7/SOXupMuulYqWDLAw9Z18ZdPSPkfNEnpIg0VY6
	TzT5PoNr/3kkWM6jGXVvJq76xpNz8juNhB1qRVttN+7bLnGBsBRyhENuoJfmadyMzhijV4ZcAAVrX
	uOajOqlVZcTyi4/y31+r08/B0UXYtnIRuuucvTLPu/ZNwx4/LBIyAi2zliMyyRCJ0mldrqdpP6GWG
	LXHtVrF9RsUmAuiLtgaRr1RnRwZU0UgjWzQiQ7zRkMg9LsKVDEOKbNWpCGV965HlTY3V8NuD7xnUL
	Lc04ZwYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMMU4-0000000CpBu-0Cnv;
	Mon, 11 May 2026 08:59:28 +0000
Received: from out28-87.mail.aliyun.com ([115.124.28.87])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMMU1-0000000CpAx-0QNQ
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 08:59:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778489961; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=Dzw2Xb8Phvncp+efnaASKEahl6Gou6Yq5bjlTkvoFsc=;
	b=46v0MKMS45RJLJLtbZRDyFfeoAbBpWD/cbLkeb7h0mAdIeHDPrKRMRBq49YABrtZNqpYAK/yYc/QisoQS/JXAM96gZB53inS+IFB7ITI0v/ovB4KV09Fu7E1CHc/2uUb2aACcXU7XzBXYTxC98iJYOR4sbiMWHVB751fItj4vOeZe2XDkhL7z53v13pZ9iRQlvsC7LB2AKQWoFRR6L+p1IGrAxjY3zjCCJeYkFdHKTsx1P26xOAheWUl0DCgQARLunLTGLXvVLkWuyHv8lMNtZjvLzE45nKZStqyV7iOrQcukTNNmRWvbwobCAwf1Wdu2ll6E708KmlWV3in7X+tgQ==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07602369|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0782197-0.000713954-0.921066;FP=3810281662001023922|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=me@alancui.cc;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.hUao1S2_1778489959;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hUao1S2_1778489959 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 16:59:19 +0800
From: AlanCui4080 <me@alancui.cc>
To: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: make providing NGUID as UUID usage less scary
Date: Mon, 11 May 2026 16:59:19 +0800
Message-ID: <2MLVK7hsTb2JIM2tKTgqIg@alancui.cc>
In-Reply-To: <agGQZU4NwAgSzHLD@infradead.org>
References: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
 <73735bc1-9821-42d8-9594-1e9cdb03e15a@grimberg.me>
 <agGQZU4NwAgSzHLD@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_015925_308176_39AC0D43 
X-CRM114-Status: GOOD (  22.39  )
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

On Monday, 11 May 2026 16:16=EF=BC=8CChristoph Hellwig wrote=EF=BC=9A
> [the patch seem to be missing some maintainer Ccs]

Sorry, I've resent it.

> On Mon, May 11, 2026 at 01:19:59AM +0300, Sagi Grimberg wrote:
> > TBH, I'm not sure why should this be a warning or an info log. This loo=
ks
> > like a debug print to me.
>=20
> It is worse.  For some reason the commit seems to imply the uuid
> replaces the nguid and they can be intermixed.

Which you refer to?

If it's my patch, My patch is actually intended to fix the issue where
"the kernel uses dev_warn_once, thus only reporting warnings for the
first block or drive where this problem occurs". So the key is "This
asymmetry can be misleading to users. If all devices in the system report=20
the same issue, it might not be a problem, but if only one device reports i=
t,=20
it might (especially since I have two identical drives). ".

=46uther more, should it be reported as a warning? The answer is No:
According to the NVM-Express-1_4 specification p.175 Figure 251:
"Bit 9 (UUID List): ...", UUID is not mandatory. And for devices below
spec revision 1.3, there is no UUID yet.

And yes?? Because according to NVMe 1.4 spec 7.10.6 UUID:
> The Universally Unique Identifier is defined in RFC4122 and con-
> tained in the Namespace Identification Descriptor
Current way how kernel generate UUID by NGUID is not compliant with RFC 4122
and NVMe spec.=20
[alan@AlanArchDesktop ~]$ cat /sys/block/nvme0n1/uuid=20
00000000-0000-0000-a428-xxxxxxxxxxxx
[alan@AlanArchDesktop ~]$ cat /sys/block/nvme0n1/nguid=20
00000000-0000-0000-a428-xxxxxxxxxxxx

> We really need separate sysfs files for the different ids.  I gues we
> need to keep the existing one someone, but it is a mess.

I don't really know how and why user needs this UUID, because kernel said:

/* For backward compatibility expose the NGUID to userspace if
 * we have no UUID set
 */=20

[alan@AlanArchDesktop ~]$ ls /sys/block/nvme0n1/uuid (NVMe 1.4)
/sys/block/nvme0n1/uuid
[alan@AlanArchDesktop ~]$ cat /sys/block/nvme0n1/uuid=20
00000000-0000-0000-a428-xxxxxxxxxxxx
[alan@AlanArchDesktop ~]$ cat /sys/block/nvme0n1/nguid=20
00000000-0000-0000-a428-xxxxxxxxxxxx
[alan@AlanArchDesktop ~]$ ls /sys/block/nvme2n1/uuid (NVMe 1.3)
ls: cannot access '/sys/block/nvme2n1/uuid': No such file or directory
[alan@AlanArchDesktop ~]$ cat /sys/block/nvme2n1/nguid=20
cat: /sys/block/nvme2n1/nguid: No such file or directory
[alan@AlanArchDesktop ~]$ cat /sys/block/nvme2n1/uuid=20
cat: /sys/block/nvme2n1/uuid: No such file or directory

If it's mandatory for userspace, why the nvme2n1 has not, if it's not
mandatory, why should we create the UUID sysfd attr. then put NGUID in it?
But for a NVMe 1.3 device there is both no UUID and no NGUID, while kernel
is not reporting warnings at all?

The NVMe 1.4 spec Figure. 253 said:
> If the namespace does not support an IEEE Extended Unigue ldentifier
> (i.e., EUI64 field is cleared to 0h) and does not support a Namespace
> Globally Unigue ldentifier (i.e., the NGUID field is cleared to Oh), then
> the namespace shall report a Namespace ldentification Descriptor with
> a value of type 3h.

So it's really a optional parameter right?

Alan








