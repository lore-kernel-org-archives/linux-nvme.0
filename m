Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8D7C48292
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 17:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Se3KdzDT4xY2GWn+kbzMAgXrcLts3BDM87d9PRb6y5U=; b=thGu7OnHZ0nouCwgGoFgRcY8zC
	EeNLZilYLLfC+EMTSs5Y1EL3xo+Vw2jnmdy+B6aGICjRh5QTrZf0nWEqzAh1RRH7BpbuKH0tcs6+y
	3kfJkDMQJpfvKw3q2MA100sM/oYMYEdIQq7vElSqXrtiH4S9Q+I6p/Tb7tzFz27g58Sxd9pOgM+f9
	0n+MthbOAlbx3e58cqvVRXYWv2cr1yC8iFfn4fsXPqspCSUdoNRkOMIEvXoC/9ip1AcCfXFUG9ayO
	Y7JaWysz84cPcI+2X11q48pI/+UttHz3Sp/KVIZ3BQNmWZKIfnDZS1pLvPX6B0xiNh+s7wtuzeHYh
	9MGlno3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX2Ki-000000043sB-0t4o;
	Mon, 05 Feb 2024 17:00:36 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX2Ke-000000043r5-128c
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 17:00:34 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 461205C0176;
	Mon,  5 Feb 2024 12:00:27 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute1.internal (MEProxy); Mon, 05 Feb 2024 12:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1707152427; x=
	1707238827; bh=Se3KdzDT4xY2GWn+kbzMAgXrcLts3BDM87d9PRb6y5U=; b=p
	/evZpgAc9YiOlhGto7k2J6HC0sKYBxSemci0cMqrgExxgp07JtQs1oSnpQ4jlk0W
	H2P9VxAa5pnvsBi+DUGLmEaUoBPOU4yDFq7aokEjfWsAEF5tPF7gei56XY/3Yjce
	1AlvxpyOEtc9kvHUVgtX2xbepHYQSv+zGnRruyRbr18uUZzS6jy6mM/z2Tx+87BI
	NyQn6at94rKsVs9+wxtKQnjbD3WYfVj/iVxlZ5CYYB0BfaqmiSooZ9KgTcAN8SJJ
	bivyk/86H6EXM1LmogCFEWRWMVLDmVoJ8UjJui1zZCg551OM5FxgihtBuxHppoaa
	wD+hzv+m/5BfZCidhsawQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707152427; x=1707238827; bh=Se3KdzDT4xY2GWn+kbzMAgXrcLts
	3BDM87d9PRb6y5U=; b=a+2YLGJrz7Vf4zB5JB6W1naouxbiL44ZukDAo/yExJWU
	VyHZGsYbg7qnOVcSFYletdDO8iB2t3AbZlG72AWepfpbEZJbErQ/weHSUsYMb7OT
	NWEw8Dl+fs6yKcNn9G+PigHvitzimwAqfdqLkZvx5Jyco1Q1coceFxAA8JmRXaMT
	m8r/1uOz2lh1yiv5Yw8aR6Zsqd+ZVjpjTeDJBOkPQp9Ujlnw7oXzrs5aI7NsieuA
	WgulyfEssII8aBSe/ppcWJm6m0skboeRq/FC0S5dsVQEe05HI9kiNvkwD/YF9xeV
	uiEeJPt2FgpzNxHMz156cyCWIqlyI8O7zRD+adouyA==
X-ME-Sender: <xms:KhTBZbHTUkc6ACDqFaeBG3Y_3V28byP1lWHZPYk6cd9cyO6yCEXxDA>
    <xme:KhTBZYVEl7WjCjzgjOlDCdnmcDGOo0CrZEEaSautdjN6VGW2f2zZ4rv0D84t0a32R
    7IZb7Qr_OiosigjVcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:KhTBZdIC9LCcmMlkYcmOd-JwZPCpU1388vUYqAbYN4msmhY-OEGsMg>
    <xmx:KhTBZZFL6YwnBXhlEyV1m-rM7-y1THxWB_jmGWCiffQmLYdb3wzQhA>
    <xmx:KhTBZRU3KT3E9MbS38ekd8BltUT7-0X-8-tpzH629Ef0up_aSMGjpw>
    <xmx:KxTBZQCjC06Xp9rcUP1ChUc1NjYs52_DiGhLz22trfXDOxaUhEiQRA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B0119A6007D; Mon,  5 Feb 2024 12:00:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
MIME-Version: 1.0
Message-Id: <97eb64af-8273-4ef4-b91a-e5d441982a37@app.fastmail.com>
In-Reply-To: <6286227a-1169-4068-8a44-1bd856be37d6@nvidia.com>
References: <20240125155213.3727106-1-kbusch@meta.com>
 <6286227a-1169-4068-8a44-1bd856be37d6@nvidia.com>
Date: Mon, 05 Feb 2024 18:00:26 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Chaitanya Kulkarni" <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv2] nvme: use ctrl state accessor
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_090032_724170_A0D23801 
X-CRM114-Status: UNSURE (   9.06  )
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

Hi Chaitanya,

Sorry for the late reply, I've been pretty busy since the winter break and
only been able to catch up on emails now.

On Fri, Jan 26, 2024, at 08:20, Chaitanya Kulkarni wrote:
>
> Based on this patch nvme/host/apple.c might need something like this, please
> have a look at [1].

Thanks for noticing and catching this, that patch looks good to me :)
Looks like Keith already pick this up in a follow up in 6d3c7fb17b4 a few days ago.


Best,


Sven

