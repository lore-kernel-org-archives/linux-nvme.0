Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA99606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 00:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DNdwUbsR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frOKJ8sU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PkKnr84vpTas1dxQ/9EryoZeNGAcz35NUAFuOFP6ksc=; b=DNdwUbsRfn0ecj
	SmxnMum2XtKn54CU72lJdw1ogXMjO78rA2SH++N8Mm1LVcp8dCWUxI0ZLuxGGuGBcTQ82mQUfS1mg
	Ckwqm6nuHezH0nB386iL8MysKUY3zDPLqFmj0Zv9m5nuOAa+GmNXrAnZZBMemomn6oyqAvuq75NgN
	tZ3gwhihruRtlFVOHhif2T6c0BC7vADpUExtdOaFxtc3vFQfujgX4JV29mb8p9GiJXWXFWnoNk0ls
	ZMRg4hWQ5CQBG0RAfjRRkHPT/DZZYqLp1pU3JpUhZGh08uku4vNC8DPaPocxTfek3kuhWboXzb704
	hpWhfjhAulfv75t7jh0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVHu9-00000001xvQ-1qIP;
	Mon, 23 Nov 2026 00:27:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVHu7-00000001xv4-2NMv
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 00:27:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C96C61129;
	Mon, 23 Nov 2026 00:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CA81F000D0;
	Mon, 23 Nov 2026 00:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795393650;
	bh=PkKnr84vpTas1dxQ/9EryoZeNGAcz35NUAFuOFP6ksc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=frOKJ8sUS9R2sQYpw9OeaQnXPBTZJcQAFNyPKLst9pJ9rU0Wy4kxTidq8Y8EvySaA
	 I+vY8iyv1CiGLvFiXvcirf20rNN7xZCOlIbq6BSduQ912VSQ/FVNLAvXRUzinHdK4T
	 Bw1P9S4J3IusAbbkVpp5yRW8SyrnD6Py/wUrfTsjzEKqsa6zyHYlSwKj1y+FO4d5w9
	 J06pnpm3UPWeIVuwMlrm6/T3KyRi2oeL9in3/qohJE2PogPA8dUlvhRwssIYC1ykHf
	 ROdPJ7V3YV8DmEKoy3a1YpF211T7PO9/3gw1eALXuZ/Li32XfdVYlg0AsFqSmPCiR/
	 +2OgmSgNyGk6g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5B952F40066;
	Sun, 22 Nov 2026 19:27:28 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 22 Nov 2026 19:27:28 -0500
X-ME-Sender: <xms:cIgDa5vMAPpezm0mKPgjbhZsgKBcE6nFthBzZd-AKaFEJVRpGTq3lw>
    <xme:cIgDa9QznQ4vGlve13D2BATrEZX2vme5NZHoSJkl8aFmuBwWEAvJfSQDlfo2vHRpd
    P2pLYc5Qlz1yGr_NuvV9uFwbeDL6AvoRhySe2jJ9Pu4Xw_CSAGbIM0>
X-ME-Proxy-Cause: dmFkZTGBzbpFALi7VXyuO7iXSGdiC5cVfu8R0twhtOTSHwRjw5TxVu743bHB+o9oojSSss
    IoMmPHT5dQBP/F6La/sEIZq6mV6j9BQAaQ6m/gUlOzbPbQrvrfgHf5Hy0qOHcjEOCUJMGi
    KlBUMH9zRJYV4m3sIvnwbZTprB0xuCNYaZbeMKB5Erm24xPvW52Wns9PhkHIwtlQV7bSjb
    cqRrIeEN3YuRJv5gS+hIfsuw4PIrvberQXNRp1garvvBis6VSp6UgxiO3faHRRtzeGdQrR
    sigXruVHs3s2BJvSp3MkXtWPCB4hW/F2/BqTSuKvncKEeN+Ivf9xfYkJtaBI70XTmnAScE
    aBHip7HtcoQ1Fx5rXdRfwtxpKZC7rUsPFHQRn6b9VdJsQqCp5SC8LJc0DJGQIS7Gj8oKvf
    0WIr8aaVCG7KWRw0jtOUO44lF8Trxt+l09FMAclIuQkayJiXqGh4GNTtYxOh9Xb9rdRVhw
    uiXPzZ/cVpE7Ach84hZTySbyVIGWKqgBrxCM82r0D7krvJcnUas+63M65hcAYGSqUVAEVl
    YyS6MXzE4gOI2NA8GUUw54ewwR0jNjy6R66UTS5JTNIM0K2AIziIeFhLCWpgnm0uGuormr
    R8l56vwijEYP9QLbG+BfUY2JFtnFalzTKA2Ih+yTcw3Poc5sv65QcyZPTDuA
X-ME-Proxy: <xmx:cIgDa-trtieGhi7Qf6ncjN3rU-l0kMPF--30_uVOHLk8dvOz-uxUrw>
    <xmx:cIgDa4UIlhZz0x0F-JMnizPCidqqZeyTRzaPhaKNHXnM7ger_QO8_w>
    <xmx:cIgDa3UvUfKLnGTZ5k6TYQMu-fCV-xFvUmMMxFeK3EVvD2kJYH2kWA>
    <xmx:cIgDa7Qis19F_S2LonET0D1rWQjGLlAGc1H8DIjdtkQurtuglo2Xng>
    <xmx:cIgDa-HXq2Jx9uAhdEd4vNxAR-iDXeXjwmA8GDfGmhE08YMU-jW24tfp>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 357E8780070; Sun, 22 Nov 2026 19:27:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sun, 22 Nov 2026 16:27:08 -0800
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Donald Hunter" <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Sabrina Dubroca" <sd@queasysnail.net>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Eric Dumazet" <edumazet@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 "Hannes Reinecke" <hare@kernel.org>
Message-Id: <7a0695c2-bf7a-4394-8cfe-a92deeba51e3@app.fastmail.com>
In-Reply-To: <20261121161302.69f202c8@kernel.org>
References: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
 <20261121161302.69f202c8@kernel.org>
Subject: Re: [PATCH net-next v3 00/10] Deliver TLS session tags to upper-layer
 consumers (NFSD)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, Nov 21, 2026, at 4:13 PM, Jakub Kicinski wrote:
> Naively I'd think it creates unnecessarily wide API on both ends
> (handshake and server). My knee jerk design would be to populate
> the full policy in the server, and only carry some "policy ID"
> thru the handshake. Number of policy IDs would equal to the number
> of tag combinations (which result in different behavior).

How is a tag much different than a policy ID?

It wouldn=E2=80=99t be impossible to impose another layer here that makes
a specific set of tags into a single policy, but I=E2=80=99m not seeing
that doing such adds a lot of value.


--=20
Chuck Lever

