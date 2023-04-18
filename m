Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF05C77B76
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 01:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QfT5nLzEjO4aqdvzuaBAWtexnphLaruwJjQ0lGkpQLg=; b=O+SW4VCHq4OXkvcBhr9PoiaAtK
	VtgKGAS5azI5HrMxiizxE8gz1bDerxjcVgkRsrbJVgoNIi1M81gCQhExm49PBjS/DPj5yPGtSfsHS
	z/8v/xcJvbqa9rmGwlBGymqmrJxGUjbydZ18Dbut5YFB/85gp3ajak076g6h8CIsxpwKEtN1rJVAZ
	Mv5xd/RdW0CrjdNu8L6fUAKen2bK7CNn0Ew01M7+frHGpP5oOFlRjaOJoBjjvImDUNDOXZ4NmY7Vw
	nqWN6gNbuClq/dRZULOa7Fza0gjqwHGFIWp+/7WqrZvG75+vyF/pwGLTkfBCDoQgVnjZ3fD647kpZ
	iijMNBHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poZkp-000Xor-0z;
	Tue, 18 Apr 2023 01:03:31 +0000
Received: from new3-smtp.messagingengine.com ([66.111.4.229])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poZkk-000Xmn-1d
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 01:03:30 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.nyi.internal (Postfix) with ESMTP id E07B85823D6;
	Mon, 17 Apr 2023 21:03:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 17 Apr 2023 21:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1681779791; x=1681780391; bh=Qf
	T5nLzEjO4aqdvzuaBAWtexnphLaruwJjQ0lGkpQLg=; b=Jed0VkGXvq7AekqiT2
	lbZx5V+lRPcQXMtpH0ahnA0fKFFOwfcqEZifgjPkPTlYuEouxcE2f/Oovkmg7JQQ
	Xm8QucQhNBDnv0/cZ3FOYUqu9pvB209/DXKkB4Ag4qgy+e5uT/RYWDlnzscMn8Sv
	45x7lOsn2XDPepkzcqsbd/hHPqLvCs2JbFRUpG2sRjOAVJl8czwhc8Uz+OzXIbvG
	68nH6VznjHrHUlBlht+NclaT40mNlefyPYX7M0FwDEsRO5ce5bOg1NQeIK4b/qS/
	bhHbdklCqz/C9UbdpSMSLWJU4gWxRerYvZMxUxRziJ0S9sT0SlLb0GzfOg/uC/Hk
	tRqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=ie1e949a3.fm3; t=1681779791; x=1681780391; bh=QfT
	5nLzEjO4aqdvzuaBAWtexnphLaruwJjQ0lGkpQLg=; b=UWcmHsgXRQuP9zW1/0i
	xMUVS/0R+sW2OspL/h+qEOtoK0cnjdJI4VpN+TVRmhl3h6Tcrn9G4VzSTZeNaRV4
	GN/cpTgn2h6ceQFm43ff00p5szhOOlxm6SRvUyTQSFh2p4hviwXrqvcPj1+b291h
	Bd19Sp+fKssvkv6Zxl1rwWD+tUAkF8oBJfrUon3IkOyxAqw2bH9PvRPagSfjXUfJ
	N9P5DBFIAH+bmy9HcaYxeA2NmBWgVudliEtKv15dDzSBlN8lcj5i2aZsDAuTyNn4
	FaOeTmxAXx3xcKCW00P1A8Yvg/B2fDavL7fcl3yNYLco+X8I7l8WNA++EQG/6x8P
	UrQ==
X-ME-Sender: <xms:T-w9ZC8GL5Qx1swKuGuAis5TYYcubTYAaT-7DkH_35mmzT3pPe3clA>
    <xme:T-w9ZCv43RTaxziRshArmA_a8UmFaoYhEnLMszV7PbFy905-4qUdhOvzR2UDS3Pan
    wVASW-1S7HolmSD0yU>
X-ME-Received: <xmr:T-w9ZICkfViCu3eNApewoCpB7ASzEGDutiPd54UlTSRR6GEQXjA6P--fWyBio_RRhtCkbrXJHoH_ux_sDdJYCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeljedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepufhhihhn
    kdhitghhihhrohcumfgrfigrshgrkhhiuceoshhhihhnihgthhhirhhosehfrghsthhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvdegtdfgvdfhgfekvdektdfgfeeljeel
    gefgkedujeeiteehgefhgeethffgheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhhihhnihgthhhirhhosehfrghsthhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:T-w9ZKd2LXrrYq_mnAsYHgEKoyHbahX8BoE9GMSy4Ku7G8r6-JD48g>
    <xmx:T-w9ZHNTLU6b87JN_IBxzpDhP62_ovTaXZmGDD5WL7XnJib6v0kAaQ>
    <xmx:T-w9ZEl2MCsH-YaLWieh_1CBNlRVRXXRPs8ReTtKK3gl3xqmpm37_Q>
    <xmx:T-w9ZN0PCPeFJDux_quvw8N9MOz3OAVVlTsg2UIvnPWiE-oVfyCluTDw5VY>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 21:03:10 -0400 (EDT)
Date: Tue, 18 Apr 2023 10:03:05 +0900
From: Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v3 0/2] nvme uring-passthrough test
Message-ID: <w7jlffsost472fk4c6cyn5rfrj7yudkim54zvl2v5cswj5mcya@dmjzfc2fe7am>
References: <CGME20230413085116epcas5p3ced7bf2b1b85bf59ff36e5440065a808@epcas5p3.samsung.com>
 <20230413085024.49750-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413085024.49750-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_180327_064786_938DABD3 
X-CRM114-Status: UNSURE (   4.75  )
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

On Apr 13, 2023 / 14:20, Kanchan Joshi wrote:
> Patch 1: contains a little helper for fio version check
> Patch 2: contains few tests for uring-passthrough on NVMe device

I've applied them. Thanks!

