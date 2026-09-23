Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC49DC98302
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:Message-Id:Cc:To:From:Date:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Li+z3luhpebsISbklx2gY0FprM1+elRGcyqmF+pdx5I=; b=bUEZttOXurG7wJKLvZyn39T4h9
	JKu2hBYAEVC91rQbhEcOoBYOoLyb3szeIk9sgyTTklaAlKrA9QfPIjNz2l5UO5POytmhhw4W+2qsz
	JuzfHOQqAQGeSkEB24Or2WRadkW6lYcdhe6CuCzJyyNLtf4p7kb5goHZ6lPp+IxMXyDWStIpE+R/Z
	5E/4vG0yHkUSuVukwF2SKzxlnBq1P1HUQ2U2ZH5CXwPkmAPRLSWmWsxg7dBKDOjGelttJSHZQc3Pc
	VFB9V+ZPOIeIx17ComHKeoz5PziLwbooTPmfk6VyxteFpxouKkbki0nVu2Y0lk/7Ak+vxYdDRcSQZ
	IlifYedg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Ngg-00000008V5d-0yCX;
	Wed, 23 Sep 2026 14:11:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Nge-00000008V5L-22ez
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 14:11:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 018DF41419
	for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2026 14:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC841F00898
	for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2026 14:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790172663;
	bh=Li+z3luhpebsISbklx2gY0FprM1+elRGcyqmF+pdx5I=;
	h=Date:From:To:Cc:Subject;
	b=T2crP8ZVLxlVlBBvbtRRMX2XsP5W4fP+N9zMWtOVvkNGs4iqfIwQh7NgIZA34l3Ut
	 NvkO0T0ecbx8oNrmxKNUwGzme64iC4ha79bugyCCYi7UcqN1nq6ALrU1XvrQ9wO5fk
	 dTIj1FAfw7rKtL31xGbth+k/VK6cWnkxv3kWB4p2CfxR8vYzOHlzLZivWUJBZpk2Ef
	 Ewi2cWtOrguPNPVnqOJSJcifFoPk6fufpmE7ZmqAUZv9EDw/tro2T9Cu8rHiYi+xa+
	 h5hRwm4362OXJ8/AdkjR4KlHlw1X7amR8TWcX0g0FMMkci2dMq1y6DtGLHZ/ptGe1N
	 zWRL62LuGodeg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id AAACFF40066;
	Wed, 23 Sep 2026 10:11:02 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 23 Sep 2026 10:11:02 -0400
X-ME-Sender: <xms:9t2zaqIbad-KuGLOuCGMOIGMaBzxLO5mXpwrx_y9tdflJWgz2i04hA>
    <xme:9t2zas8je19ebbvDyxQgtbljdcVOGKQdJpUBBdnOiOZBALNFyQUvSrj9QI56LgRsY
    OGJwhwB3or6CqZ7ogMxQMm1KES_IgwMzuv-R6JS3AXP3PDuT8SzerbS>
X-ME-Proxy-Cause: dmFkZTGAuDRVOdY94hnFTsU7RLRxBH44odXl49kKuep+65Fnns6Y3OBUZE7qZWwcEFPuJ+
    XnRj04ITJxU5G7H/kaIA7/5CUlaxCVMO92H8XNPLlaqeLOSTTJCpwFNZXMsQxGvaQRUmp/
    4nE8huqUNxo571v5hNoD0eNiIdsPa55bI23WxcurUHe8XjjQHyxMIKXLhzsh/RX6BJEJRf
    AxG5PpuB6xU8hqHZDK+5PLRfQrzXhDcbcerwThVGvpm48fccw3RMfMawBZKLibp4COUGYA
    E6GK4sWgIdO+nBFCi23R2a/oVBLR7JhGVNdQhHf/zOGmFcmBz1PtW1QSkP/7xvBPoBS1Gv
    9KlBIOImn2ietZnVI1YFtWFYcok7sS758kO4+eBYTTImS+aKQH4qYi75StTlfXN+jBT7Uq
    g/GHMztt4lBG/u2nhY0PBDSUmkef6Oq84auUzj+tVK58IyMFdhgZ5Nwoo4kOKHen85HsVt
    HllwXsDgakGMIpD4ou4u4KeZuEwO4SXF4SioXaPU13tyBp9AxGWnt3FY7LY4wt4Qgg0Im7
    fDOyTxPdIeMhhqZCwhLB5r95A8Oj18X6+G420AbMkx2cpytj9AYMlzvcyzZFsP/LQ9UGsC
    k1l+aJ21v6UOKX1yMEG/Nv/b10pCvG1R0UUInYjDBGDcflybOKvyaXL6Kr6w
X-ME-Proxy: <xmx:9t2zaiv2R-gjNtTqpGMavWRxGbFUgM8_Xpgfht2rn1haXo6Awz60iQ>
    <xmx:9t2zaucyoSqa37_6k1FW6JKR2BA5zMInBNFB3LAoN9t2FAjATD9TNw>
    <xmx:9t2zaixEPKfbt7tNY8SNUalIR7q8-E1mJIKF5noB_UR8boORxpoBjw>
    <xmx:9t2zasGcmDMwfNJC4Er49t93ETOByZ4valEgNQ1Jmdq8pgoVs1vmHg>
    <xmx:9t2zauxZ_aE8tFVSFab9nNnX-pNQxIFY_tIAHgqlBzFGax6b9iQZ8S5F>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9169A780070; Wed, 23 Sep 2026 10:11:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Wed, 23 Sep 2026 10:10:32 -0400
From: "Chuck Lever" <cel@kernel.org>
To: kernel-tls-handshake@lists.linux.dev
Cc: linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org
Message-Id: <56c0423c-bba9-460a-871f-c22fc2d5af23@app.fastmail.com>
Subject: [ANNOUNCE] ktls-utils 1.5.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

[ Although the email displayed in Thunderbird as a plaintext, it
  was sent in HTML format from chuck.lever@oracle.com. Resending
  as 100% plaintext with my apologies. ]

This email announces the official release of ktls-utils 1.5.0.

ktls-utils 1.5.0 adds DANE authentication of server certificates: tlshd can now
validate a server's certificate against TLSA records published in DNS, with the
new behavior governed by DANE configuration options documented in the tlshd.conf
man page. A new nfstlskey tool manages the NFS client's mTLS identities, and
tlshd now links the NFS keyrings per handshake rather than once at startup, so
identities added after the daemon starts are picked up. Private keys may now be
named by GnuTLS URL, which enables keys held in PKCS#11 tokens and TPMs. The
post-quantum ECDHE + ML-KEM hybrid key exchange groups are enabled. Kernel
capability detection now reads the handshake netlink policy, so new kernel
features are recognized without a tlshd update.


Official source code repo:

https://github.com/oracle/ktls-utils/


Release tag:

ktls-utils-1.5.0


Release artifacts:

A source tarball created automatically by GitHub:

https://github.com/oracle/ktls-utils/archive/refs/tags/ktls-utils-1.5.0.tar.gz

A source tarball created with "make dist":

https://github.com/oracle/ktls-utils/releases/download/ktls-utils-1.5.0/ktls-utils-1.5.0.tar.gz


Issues and requests for enhancement:

https://github.com/oracle/ktls-utils/issues

-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

