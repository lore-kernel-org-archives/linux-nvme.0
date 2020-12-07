Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD16C4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 11:48:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039EA23340
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 11:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039EA23340
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/EWqRO2D61nsbwWyHf1SAqX6Bx7NnIFGNgrA6ZQNIr0=; b=rEWvJ30YGEbOON486PDQov8wT
	Ni4sMuaYhYX8XaMqijJ14y3DNEjsmcXNQ1wC39KghZC3K2z1PObx5u7oTtf9YEfGxAoSv6wLSyUM5
	dPdQq3vkPLAjKn4QBDDfcvaXpG4Rr357WUr6zLro7IB7dGpHennhcPqXcvxVemqAP1T6LBLKZ0Glq
	5aL5DevMmHumpTAl2wxFe7JMoxYzusLfFFEaW69Zgg8+ppJ7GTNESNNeiQDyZ/Iy8Egj5abn35sQI
	uTcoiX5eszxQLNZzkUnPP/3mETTkV0NDouHR8IagBDw0wCd/q3PtDaKf2SXd14u8iLXUeGIjoQdrZ
	CiM4rlrfQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmF0A-0003OR-5u; Mon, 07 Dec 2020 11:48:22 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmF06-0003NX-IN
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 11:48:19 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id C16FFC0C;
 Mon,  7 Dec 2020 06:48:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 07 Dec 2020 06:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VhnFKp
 DiphrJTeyL0PhwYlSNQ41mGFxTA7aWgbPmEDc=; b=kYstMaR93WoKQpgs1xGB1v
 u9LyJQqTLVLU3CNfwVWrGK0/P5P2OWzVOE7+kNyYJBJZKCSHhKsd4xEcIeABFYRv
 GLg+tV7hcuq2U5bNKIhlSv8bR57waWCBUljxbf5ZJSkDiMdhvhkaugxXios9HoG8
 KcwIWkrXjs+kfg4g0r0oi2W9fi8PvI0lzhNbciV4HbFRtmg2eskh6hqbDAwYn6Mz
 +C2BsqBXN1Qi29BDAqSZ/miKK2kpFu1zCmz0zy73kqd467jn5D04DYcqdjd5bdbP
 U5I6GswpXlxQCBZ6bQDrKvCDCKbzyt49jMxuTfMY5JSxqvABVH9G8aK2MNbncaAA
 ==
X-ME-Sender: <xms:ehbOX7GMM_WOYhUwXBXIedB4CMTTax14bSu6rlninFTWUiv4c3ejWw>
 <xme:ehbOX4UJfDBuPgJHJL5mmYgs6VO3K5mSPC16niKZ9YuMWsEICT37QN0JP43GzVBap
 FyMNF8heAIINg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedgfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
 ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
 hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeetveff
 iefghfekhffggeeffffhgeevieektedthfehveeiheeiiedtudegfeetffenucfkpheple
 durdeigedrudejtddrkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
 rghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsg
 drtghomh
X-ME-Proxy: <xmx:ehbOX9LjWSlIXbg_zSEP4oUbl4kBVRv3lD8KzYXNRjih85obAG7n9A>
 <xmx:ehbOX5EYcMT16r5_MhWenfCab1gvXZt4ddGaU8w9Z4p5WUWEXitzJA>
 <xmx:ehbOXxWAvPlGL7he-Qn1OQCwUcMq0mUN3TMCg_8zO0nahZT0YnZD8g>
 <xmx:fBbOX_f0ub5Da5BwZDC4pZhWM4hB2bMrjEycHvneSb-T-eQ-Q3vYmg>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de
 [91.64.170.89])
 by mail.messagingengine.com (Postfix) with ESMTPA id A0883240064;
 Mon,  7 Dec 2020 06:48:09 -0500 (EST)
Date: Mon, 7 Dec 2020 12:48:05 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9
Message-ID: <20201207114805.GF1244@mail-itl>
References: <20201129035639.GW2532@mail-itl>
 <20201130164010.GA23494@redsun51.ssa.fujisawa.hgst.com>
 <20201202000642.GJ201140@mail-itl>
 <20201204110847.GU201140@mail-itl> <20201204120803.GA20727@lst.de>
 <20201204122054.GV201140@mail-itl>
 <20201205082839.ts3ju6yta46cgwjn@Air-de-Roger>
 <CAKf6xpvdD-XJoRO91B+Lwc=0Sb6Luw2X8Y9sH_MQsAWhZmj+hw@mail.gmail.com>
 <293433c5-d23b-63e7-d607-9d24f06c46b4@suse.com>
MIME-Version: 1.0
In-Reply-To: <293433c5-d23b-63e7-d607-9d24f06c46b4@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_064818_768840_A87D73DB 
X-CRM114-Status: GOOD (  24.30  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Jason Andryuk <jandryuk@gmail.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>,
 Christoph Hellwig <hch@lst.de>,
 Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Content-Type: multipart/mixed; boundary="===============2913202993799560732=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============2913202993799560732==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Content-Disposition: inline


--54ZiyWcDhi/7bWb8
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9

On Mon, Dec 07, 2020 at 11:55:01AM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> Marek,
>=20
> On 06.12.20 17:47, Jason Andryuk wrote:
> > On Sat, Dec 5, 2020 at 3:29 AM Roger Pau Monn=C3=A9 <roger.pau@citrix.c=
om> wrote:
> > >=20
> > > On Fri, Dec 04, 2020 at 01:20:54PM +0100, Marek Marczykowski-G=C3=B3r=
ecki wrote:
> > > > On Fri, Dec 04, 2020 at 01:08:03PM +0100, Christoph Hellwig wrote:
> > > > > On Fri, Dec 04, 2020 at 12:08:47PM +0100, Marek Marczykowski-G=C3=
=B3recki wrote:
> > > > > > culprit:
> > > > > >=20
> > > > > > commit 9e2369c06c8a181478039258a4598c1ddd2cadfa
> > > > > > Author: Roger Pau Monne <roger.pau@citrix.com>
> > > > > > Date:   Tue Sep 1 10:33:26 2020 +0200
> > > > > >=20
> > > > > >      xen: add helpers to allocate unpopulated memory
> > > > > >=20
> > > > > > I'm adding relevant people and xen-devel to the thread.
> > > > > > For completeness, here is the original crash message:
> > > > >=20
> > > > > That commit definitively adds a new ZONE_DEVICE user, so it does =
look
> > > > > related.  But you are not running on Xen, are you?
> > > >=20
> > > > I am. It is Xen dom0.
> > >=20
> > > I'm afraid I'm on leave and won't be able to look into this until the
> > > beginning of January. I would guess it's some kind of bad
> > > interaction between blkback and NVMe drivers both using ZONE_DEVICE?
> > >=20
> > > Maybe the best is to revert this change and I will look into it when
> > > I get back, unless someone is willing to debug this further.
> >=20
> > Looking at commit 9e2369c06c8a and xen-blkback put_free_pages() , they
> > both use page->lru which is part of the anonymous union shared with
> > *pgmap.  That matches Marek's suspicion that the ZONE_DEVICE memory is
> > being used as ZONE_NORMAL.
> >=20
> > memmap_init_zone_device() says:
> > * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
> > * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
> > * ever freed or placed on a driver-private list.
>=20
> Second try, now even tested to work on a test system (without NVMe).

It doesn't work for me:

[  526.023340] xen-blkback: backend/vbd/1/51712: using 2 queues, protocol 1=
 (x86_64-abi) persistent grants
[  526.030550] xen-blkback: backend/vbd/1/51728: using 2 queues, protocol 1=
 (x86_64-abi) persistent grants
[  526.034810] BUG: kernel NULL pointer dereference, address: 0000000000000=
010
[  526.034841] #PF: supervisor read access in kernel mode
[  526.034857] #PF: error_code(0x0000) - not-present page
[  526.034875] PGD 105428067 P4D 105428067 PUD 105b92067 PMD 0=20
[  526.034896] Oops: 0000 [#1] SMP NOPTI
[  526.034909] CPU: 3 PID: 4007 Comm: 1.xvda-0 Tainted: G        W         =
5.10.0-rc6-1.qubes.x86_64+ #108
[  526.034933] Hardware name: LENOVO 20M9CTO1WW/20M9CTO1WW, BIOS N2CET50W (=
1.33 ) 01/15/2020
[  526.034974] RIP: e030:gnttab_page_cache_get+0x32/0x60
[  526.034990] Code: 89 f4 55 48 89 fd e8 4d e3 80 00 48 83 7d 08 00 48 89 =
c6 74 15 48 89 ef e8 5b e0 80 00 4c 89 e6 5d bf 01 00 00 00 41 5c eb 8e <48=
> 8b 04 25 10 00 00 00 48 89 ef 48 89 45 08 49 c7 04 24 00 00 00
[  526.035035] RSP: e02b:ffffc90003e27a40 EFLAGS: 00010046
[  526.035052] RAX: 0000000000000200 RBX: 0000000000000001 RCX: 00000000000=
00000
[  526.035072] RDX: 0000000000000001 RSI: 0000000000000200 RDI: ffff8881042=
75518
[  526.035092] RBP: ffff888104275518 R08: 0000000000000000 R09: 00000000000=
00000
[  526.035113] R10: ffff888104275400 R11: 0000000000000000 R12: ffff888109b=
5d3a0
[  526.035133] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8881042=
75400
[  526.035159] FS:  0000000000000000(0000) GS:ffff8881b54c0000(0000) knlGS:=
0000000000000000
[  526.035194] CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[  526.035214] CR2: 0000000000000010 CR3: 0000000103b5a000 CR4: 00000000000=
50660
[  526.035239] Call Trace:
[  526.035253]  xen_blkbk_map+0x131/0x5a0
[  526.035268]  dispatch_rw_block_io+0x42a/0x9c0
[  526.035284]  ? xen_mc_flush+0xcb/0x190
[  526.035298]  __do_block_io_op+0x314/0x630
[  526.035312]  xen_blkif_schedule+0x182/0x790
[  526.035327]  ? finish_wait+0x80/0x80
[  526.035340]  ? xen_blkif_be_int+0x30/0x30
[  526.035355]  kthread+0xfe/0x140
[  526.035371]  ? kthread_park+0x90/0x90
[  526.035385]  ret_from_fork+0x22/0x30
[  526.035398] Modules linked in:
[  526.035410] CR2: 0000000000000010
[  526.035440] ---[ end trace 431ea72658d96c9d ]---
[  526.176390] RIP: e030:gnttab_page_cache_get+0x32/0x60
[  526.176460] Code: 89 f4 55 48 89 fd e8 4d e3 80 00 48 83 7d 08 00 48 89 =
c6 74 15 48 89 ef e8 5b e0 80 00 4c 89 e6 5d bf 01 00 00 00 41 5c eb 8e <48=
> 8b 04 25 10 00 00 00 48 89 ef 48 89 45 08 49 c7 04 24 00 00 00
[  526.250734] RSP: e02b:ffffc90003e27a40 EFLAGS: 00010046
[  526.250751] RAX: 0000000000000200 RBX: 0000000000000001 RCX: 00000000000=
00000
[  526.250771] RDX: 0000000000000001 RSI: 0000000000000200 RDI: ffff8881042=
75518
[  526.250790] RBP: ffff888104275518 R08: 0000000000000000 R09: 00000000000=
00000
[  526.250808] R10: ffff888104275400 R11: 0000000000000000 R12: ffff888109b=
5d3a0
[  526.250827] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8881042=
75400
[  526.250863] FS:  0000000000000000(0000) GS:ffff8881b54c0000(0000) knlGS:=
0000000000000000
[  526.250884] CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[  526.250901] CR2: 0000000000000010 CR3: 0000000103b5a000 CR4: 00000000000=
50660
[  526.250924] Kernel panic - not syncing: Fatal exception
[  526.250972] Kernel Offset: disabled


This is 7059c2c00a2196865c2139083cbef47cd18109b6 with your patches on
top.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl/OFnYACgkQ24/THMrX
1yyF5Af6ArbC1PElE8gZ7vC7XIXXUjUSeaPZWNCWAyIf/WYx1mdQs64ObV2d/e1I
d5J+xK7XYnN/GUWIv99ZsLQWf1IGgk+EaEjhdr8lIQP5q9kyeoRvYQb7UMNVdX9s
rJM/H8Wl24GQtwpyelx87S8AQ9pEVZ4VWTNHZLej3YavmICs1qFHMB5zJshdX4Y3
oRXbyFtutC0qmf0CAW3GtTnWiXOlHoxQFEtJ3VEijlmuU4THtPCR+kN8HNx6o82+
xLcj6AlA+kHjuQEBWPd/2s9oATgtaM+WCz1KkhTNMTtQsOWAmGSxVVrVPpC9WaoQ
Y6nIQYU6EGeOCynIYzvv+21Hg53eZg==
=4CJT
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--


--===============2913202993799560732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============2913202993799560732==--

