Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9459C43217
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 17:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IIO0D0kV0kC6d6t3CNBJiQk8iztHZYQDVT51yInx5rI=; b=Kr3LFfIpBHF4lLW9835ti4vOJw
	VrGO5rCzGvkxGsGa94dWfNtNRlKMUyfuuFFosvpk9Nl4LUTRmJedoALTxsCHzVO1Vyl6/Nn3c7E/A
	ODz7YSOI2vN6zlCMhC/XwnUYfyhkIi7gEMlZxCbLNI44GrJWLgyJmSlMa+eEPnd+dNc1DC+dKfnhE
	Ufxmj27BidmQwKYBj8PMFNHXFYsvA05U0HRd+/egeKCTGP5AOZUshaA/F9KJ01d9LYvmRrlkjv6bE
	XeUyGzL7ReVyNVUbHMNQQ/UDFnc218i/9e2eChOT2pldXA0orGR2cHzjDeZaoBXWGKkLdl1fHCaVt
	RmnmSaJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okql5-009b8A-G5; Tue, 18 Oct 2022 17:52:07 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okql1-009b1W-Qg
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 17:52:05 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 79E675C00C3;
	Tue, 18 Oct 2022 13:51:58 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Tue, 18 Oct 2022 13:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1666115518; x=1666201918; bh=II
	O0D0kV0kC6d6t3CNBJiQk8iztHZYQDVT51yInx5rI=; b=of0lhuBsdewkvzroYm
	pr0kZIH+RZYDL0Wo1FEHRDsFfoAphN+8W8rUKeN8uzEfDSb8XKDcATTjBZpqoLJW
	88Y7jFe5e9VIFfsk2XnMsIVMI7H+lfAHT//YQDZ2kOHZ3k951+KbZZe2+D0mOpBr
	X4qqRj7eu+F/h8A0g8tj3QO+fKTo2TwB6u1WSLL77r4WjiC9QKUDwoc9rqyLlLlK
	vP5Szbd3J0PNcwW6UBAj8Q5S9KlVYVWsSwrqhGMIMkeBKF8cuT5NwnTSWX29GCBc
	CjkXtjE4ptHNpjE95qgLsJNzWnBKHwtwA1D59QV6vNfgSsW9Uv1c8SgZNqDm3af+
	e5BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1666115518; x=1666201918; bh=IIO0D0kV0kC6d6t3CNBJiQk8iztH
	ZYQDVT51yInx5rI=; b=UlYD9bS4qeEFSLLB8jrYCOXfE1W0mURHWCxl88c41f9+
	tBx+9MFYwyL9ZlMmA2YuLuZQVrk26YhNRjnFnsT2EnmGAjEq5UyLGyMf0flLyhqA
	kHxfYc3du40h92bDBq+Sp5hX6hbfv0vbjiTj/UBQ0D2KaW69h8K75HGUlu9NWLuo
	TpZyaoE6jsNTAuCMaY6E71Kqo/xvoONP4rfJqLWFEU3ss0r5lx0UjmiYPxlIoHo/
	Ax15WvLX8TmFmwSXLxZE6it7VebwKk3l/+d8LFgeSyWRdUfSpWtZxjNvdO9HAi5f
	PTGvvXeM8WN1DzzVel/n9PuGjhSd8GhkXuxrdc6Y4A==
X-ME-Sender: <xms:vedOY03aEm5RuxN5Xgvx6YPvdnhK13e1paPXdR3HIcfwziU1_zbPUA>
    <xme:vedOY_E8Ghu9XMOF8I87KHM2YLAxOx4eoJTunFqXfzFty2_0MuZswbT5lE45c5H-c
    7ElpB4EaVasIYndaYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:vedOY87QeEC3wngQQwliN65m7qefEXgtxl_qvb4x-fbxg4Z5_v1leg>
    <xmx:vedOY91n1WXlMFwwMuIDMjkhxWK-0N3O0tH2hUMhATS4zxFuzm1O_w>
    <xmx:vedOY3GLLblXHQNZSKQg_GkDD9_u4rHAEQ8V5QZ3rVz4yBXTX2ijLQ>
    <xmx:vudOY85sz46vghWdJ52Ypq9szSb6fusZeMeGDI12o9KVugypb75Aig>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 63129A60082; Tue, 18 Oct 2022 13:51:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <d818d314-2b00-4667-9188-8d942665032c@app.fastmail.com>
In-Reply-To: <20221018135720.670094-5-hch@lst.de>
References: <20221018135720.670094-1-hch@lst.de>
 <20221018135720.670094-5-hch@lst.de>
Date: Tue, 18 Oct 2022 19:51:36 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "hch@lst.de" <hch@lst.de>, "Jens Axboe" <axboe@kernel.dk>
Cc: "Hector Martin" <marcan@marcan.st>, "Keith Busch" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 4/4] nvme-apple: remove an extra queue reference
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_105204_305197_42BDAFEC 
X-CRM114-Status: UNSURE (   7.41  )
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

On Tue, Oct 18, 2022, at 15:57, Christoph Hellwig wrote:
> Now that blk_mq_destroy_queue does not release the queue reference, there
> is no need for a second admin queue reference to be held by the
> apple_nvme structure.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sven Peter <sven@svenpeter.dev>


