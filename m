Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE069C67871
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jan 2023 21:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pB7OzMUP2R+eFx2+0Tb9eBFUfZ26JGznjxbwj0Je6iY=; b=yCr+0bAM5eLqgvYJdjz0abPf6m
	mHyyawR3i/kBNW8KDcbmXkJ84veN7L0ypmGjfBDwN7nw6vZtexyAj/5Wfqvfobw0hiBaCm0u2MdsW
	92IzK07lDXTRj9h1GPzLZBk1dd+vsHpPla+3mZaPwxMLnO4D1PzM6N/x3pgmoMrsVk6HHDcvQcUzs
	r+BCHGaEPBoIu+DhGZ+cor/u+imec4mdH1bidMWUBV2ovJaN5srLWCqqG87+tso5ZHEUI86XUpN2/
	9hoeVatjXmjuAzrSdONgJisDxSnAmHFwtuVF+AXivK5GJropmmWZW23GxCxKMXGqeLZItG9UICsvr
	AQ4Oe9bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHXTj-00C7dV-HQ; Mon, 16 Jan 2023 21:57:19 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHXTg-00C7d5-Jr
	for linux-nvme@lists.infradead.org; Mon, 16 Jan 2023 21:57:18 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 609505C01C5;
	Mon, 16 Jan 2023 16:57:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 16 Jan 2023 16:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1673906235; x=1673992635; bh=pB7OzMUP2R+eFx2+0Tb9eBFUfZ26JGznjxb
	wj0Je6iY=; b=K35m0ZDUtc1iU8uC+gueRpCQA3uBExWFyRcS984nW4EEtJuYe/6
	7a+z4MtSoMnOMsLUD6z4+N4WLBWOT8ieE+c3ryAecmH+i78EoyLpnVvMPTsNGaeE
	YRMWApj8F225J9Jj/NENmc8GVvMfipCZrx6SlZmCy1q9Z8Vm33Bwi+Z7BRWCHTaz
	PeCWD+f/1zgBXHg04sjloOF+NOGksZ3t+ZcMiqAsdnQUny0PSNlkjNPEhwxhExSK
	IIjybp8eINNOkwpyTsikp92TvT+Vv/QtbdVpUd3BQDUvCGfNH9G6isV600+5H2Jg
	fZDZ6S4Su32dYeQ6lT3T7IUDo4qRcmxnNSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:mime-version
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673906235; x=
	1673992635; bh=pB7OzMUP2R+eFx2+0Tb9eBFUfZ26JGznjxbwj0Je6iY=; b=C
	y5pw0QGd6gFDnxTcWPFFr2oseOmzv+OErsNmA0ftXgnlEEakrpFN7EQl8aPzO5kS
	pmmaYCsateilTsaUIDJq49YtPHa6g8jgt/3ZkT2PzDRCS3Vc7LI+g/2ha9oxHhCr
	6rWdXfhmikza83x9v7PVrBUghGKokur0AlP2byOIpBk7Wi1bH1A8XGYAlKDmb+vr
	CMrMKsCCGN4NNWmjkUoYGCLMWFWypZR1VOya+t4mCu8LG3CBYIAqoBMDQNGZN1ik
	Uv8rHyK8mWYCub1x/wkAxzFDsd+LGkpK5FCGdSHxoYGZpo4DjLpzdWTdTD+PEpS/
	IQ9n3wjNplEFR2mvNCVVg==
X-ME-Sender: <xms:O8jFY46iJbgYI921Z-tJLlZJqCEQZy5J6-d6IermOT1DGqGIyP8cDQ>
    <xme:O8jFY57m737goO0CwdwQ_sv6rJUXJ8KGyC1GaIwl63E6a6vHn7uibCalniMNH0VjU
    wYfmLcHdysWR-oh4I4>
X-ME-Received: <xmr:O8jFY3d9Xyo5fjWa-9a5keT9DNOTWj7YQdpiXsVoZbRtfSJAR7VSP4xExLHEmlPZnzMKW6LlTKS9s8w2a5wkPWzKvmc2IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfggtggusehgtderredttdejnecuhfhrohhmpefmlhgruhhs
    ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
    gvrhhnpedtjefgteejuedvkeefjefgieekueetvdduheffkeehjeevleehhedvgfeiudeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
    hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:O8jFY9LB-PWWMz1Ccm6Uu8yTZHr01hS22F8bGPNdL1IKX73e5B_wTw>
    <xmx:O8jFY8L26D5rtqfEaIzUyy0ivp-RTzvuqQVehm7hTi02xMwiLDtG4Q>
    <xmx:O8jFY-z4oU76ojKZANQEs3VsDy63lCw4C2IYcV9xAlvRxz5w9vaAag>
    <xmx:O8jFY2gqn4GXS1Ic4IAefZX8WnPfroZNrwGJggc0HYcvwlFtN4i6Hw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jan 2023 16:57:13 -0500 (EST)
Date: Mon, 16 Jan 2023 22:57:11 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: regression on aarch64? panic on boot
Message-ID: <Y8XINx8fpGPKudW6@cormorant.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wv4oHFnziRYt8pYX"
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_135717_038836_7FE8DC91 
X-CRM114-Status: GOOD (  10.40  )
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


--Wv4oHFnziRYt8pYX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I'm getting panics when booting from a QEMU hw/nvme device on an aarch64
guest in roughly 20% of boots on v6.2-rc4. Example panic below.

I've bisected it to commit eac3ef262941 ("nvme-pci: split the initial
probe from the rest path").

I'm not seeing this on any other emulated platforms that I'm currently
testing (x86_64, riscv32/64, mips32/64 and sparc64).


nvme nvme0: 1/0/0 default/read/poll queues
NET: Registered PF_VSOCK protocol family
registered taskstats version 1
nvme nvme0: Ignoring bogus Namespace Identifiers
/dev/root: Can't open blockdev
VFS: Cannot open root device "nvme0n1" or unknown-block(0,0): error -6
Please append a correct "root=" boot option; here are the available partitions:
103:00000      61440 nvme0n1
 (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc4 #22
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace.part.0+0xdc/0xf0
 show_stack+0x18/0x30
 dump_stack_lvl+0x7c/0xa0
 dump_stack+0x18/0x34
 panic+0x17c/0x328
 mount_block_root+0x184/0x234
 mount_root+0x178/0x198
 prepare_namespace+0x124/0x164
 kernel_init_freeable+0x2a0/0x2c8
 kernel_init+0x2c/0x130
 ret_from_fork+0x10/0x20
Kernel Offset: disabled
CPU features: 0x00000,01800100,0000420b
Memory Limit: none
---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]---

--Wv4oHFnziRYt8pYX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPFyDcACgkQTeGvMW1P
DekuvwgAnzpWdriYkhJke67vy04eHNX22UnTthB8dHmz1+lqaGyqak1ih8SFrzr6
t/v9UNJA/JJ/k6smupIOd0UA2DtbeoCEEOgnjXGoUBerRbzbJNyquc/2HtRKzprt
lAHHUQ5Le/d93yK9jskzkyLmZQAYUClK1JKcADg+5Kz/+K/OnrxarYJ8qMOI0pLb
I0TUBKTCEWVGOsprzfNFCJ2ug3Yjf/64wjYSohAZm9+5U+Svyl4rWTF3iHeC6eaX
whyES8dOA7bHGGr/2gWpqU0WPbPVEdrQc4yKfShDJ2PBqfn4vEGEalFjYHqqzIEE
LZsqcIfH2N5fkqRVfU5Hf+pwAQxiPg==
=ifcL
-----END PGP SIGNATURE-----

--Wv4oHFnziRYt8pYX--

