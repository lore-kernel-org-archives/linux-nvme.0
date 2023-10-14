Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197DECDB465
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Oct 2023 09:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g4SMTb693pxutFd1rZmtdpkvzw7HxP/4Iwdp4VvcK2E=; b=pLFpw8FvaVJskLi3DBMG5Q1WXI
	iYtR3xT+MzWNHLrPeel7MHnQp0ItyoYqV9MmeLKdQNEO/rxPUrk1TRdQ01cP5mGGUhnO1OHuqmKhD
	DRpxgDeUlqHK1vq/ZXb8zjzayCpNN36atHxCc9oZelg7Osdng06coYd4QAdxaBGTkwLH/1PM0vuFd
	WcSXIuUmDYCkF1+ziceu5BV3T+p2bAAggY203u60Z/qA9o5lpgC33CfbFQVPSppt81g6iUwbuFZ12
	cNDzjPez07WXM7631aP9rRXP9pxRXi9kBw+Euu2oa6yaBv5sv2OXSP1a6qK5rSTaV5kEruEXm3CBu
	hT8gMw4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrafx-0051EV-1s;
	Sat, 14 Oct 2023 09:11:13 +0000
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrafr-0051Cr-2M
	for linux-nvme@lists.infradead.org;
	Sat, 14 Oct 2023 09:11:12 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 8DE7532009C4;
	Sat, 14 Oct 2023 05:10:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 14 Oct 2023 05:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697274659; x=1697361059; bh=g4
	SMTb693pxutFd1rZmtdpkvzw7HxP/4Iwdp4VvcK2E=; b=a02Nj30JQimAFgcwCb
	muVUYQKSNq2/JIdErFTo6DT1NI4rZITa0vw7cUfCVv8sPp5NBRNxoZY3kvRZE2yD
	HES7CwAaMmZOj6Wsn+jamlyqZUzctF4axsTcq6eUZSxF3AVAiiHthAXc6myGu/yF
	h+dT29LA0IWy7WOCYITwAftE12iVUps8IrbiV9qicvGvFk2VcXWwqhoYd/dNQ9Ic
	oC7JgeWv6IE72mNef7wU+XWIz6AvUAeSMfFIInE9VkmS6e8FbKR+GgW09zDFoqOJ
	CY2f0cOoF2KbBHftktLtWYXm3tWhOUTt8GvB+3dUzEFHy6OYG+qfyMI0xotV0GgS
	CyTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697274659; x=1697361059; bh=g4SMTb693pxut
	Fd1rZmtdpkvzw7HxP/4Iwdp4VvcK2E=; b=MO3Cj6pY7uUHeDvlpuVp1R4uGRZaO
	amnRcaaLEI27h/ES/3oT4MBySUGqgV4ewxFvZOn4t3L0LikQtmMM6DW9mMszBTlt
	1DNyYRNt/JtVFXcq6ujwIqKNhHfelx9y7qh+OHb27eVnd4yHpdeidivpLX4R028p
	xydsP4J5dsfh7X+bvPRamug/kPoVM+1NUYVbx0ZPEN8DJCoM2tc9LXrzHFfHFfZH
	Te23sSQ1EfiN7oanMNTI1d9hFa1AGZLWudkSwosh5pcSfnomUYuHTm00MfxSY078
	hgTbD4con7FfLv8bN8HFCNpAlUsmPGcz9rZGj2L2EFNj4cN2w6uNZX6fA==
X-ME-Sender: <xms:IlsqZVN7kUVV9sIbn9_vwGA5DAyIduecOjzheQTPDuQZnjF6cPwWqQ>
    <xme:IlsqZX8wOEbjAv3qizbxugjIyGaYLEDRHylSHCkSO35J93vLa5pvN8xf76Z0jdA7A
    EGwQbrAs4Z_sg>
X-ME-Received: <xmr:IlsqZUQY8y8Z8avkMko--egK1f6gnlOwJ0GyveMh79Asemgm9W1X89IpxvQRC-v7frqPIbuClmlBOZ8L8D1sVoBa9pI4kaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieehgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:IlsqZRvZ4W1NieaDaq3k4Ry1BdqRZMQjeA5yN7uuXNlEtXpE3czk1A>
    <xmx:IlsqZdd2X31z0I0u2Uxg9t2_NVMFGE3WZ_a7ASyIaxDjPkAoF1K3lw>
    <xmx:IlsqZd1fhadJLaEfVRMKcvJq_AYZI6OpEZb0uNTAStb-8pLv8hL-0g>
    <xmx:I1sqZQU2Kx3FrxPJwjkl1OnEVi2DV8dUtP-eVjCwS4tltpa3O7orDA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 05:10:58 -0400 (EDT)
Date: Sat, 14 Oct 2023 11:10:56 +0200
From: Greg KH <greg@kroah.com>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme: remove unprivileged passthrough support
Message-ID: <2023101437-external-paddling-8786@gregkh>
References: <CGME20231014090724epcas5p443807b5d724c97645a8a85fc627bf1ad@epcas5p4.samsung.com>
 <20231014090108.128809-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014090108.128809-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231014_021108_135622_77FF1DF7 
X-CRM114-Status: UNSURE (   9.59  )
X-CRM114-Notice: Please train this message.
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

On Sat, Oct 14, 2023 at 02:31:08PM +0530, Kanchan Joshi wrote:
> Passthrough has got a hole that can be exploited to cause kernel memory
> corruption. This is about making the device do larger DMA into
> short meta/data buffer owned by kernel [1].
> 
> As a stopgap measure, disable the support of unprivileged passthrough.
> 
> This patch brings back coarse-granular CAP_SYS_ADMIN checks by reverting
> following patches:
> 
> - 7d9d7d59d44 ("nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool")
> - 313c08c72ee ("nvme: don't allow unprivileged passthrough on partitions")
> - 6f99ac04c46 ("nvme: consult the CSE log page for unprivileged passthrough")
> - ea43fceea41 ("nvme: allow unprivileged passthrough of Identify Controller")
> - e4fbcf32c86 ("nvme: identify-namespace without CAP_SYS_ADMIN")
> - 855b7717f44 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
> 
> [1] https://lore.kernel.org/linux-nvme/20231013051458.39987-1-joshi.k@samsung.com/
> 
> CC: stable@vger.kernel.org # 6.2
> Fixes <855b7717f44b1> ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")

Nit, this should be:
Fixes: 855b7717f44b1 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")


