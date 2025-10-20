Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B083BCCD193
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:Message-Id:Cc:To:From:Date:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N567dQrS7YauDt3kUs4UraXaPwOCX21b3ym/k+A1Dlc=; b=N5H1s20stHd828qCzL+aU3BrSJ
	vSPf4mCQfJnDsr++smX2x++5JTRExm22DJ4Jw8/KqdnevgqCIM879nGXm942weWsfHVoAg50v+xeM
	bQg4N8sWpqmsYocn/AYr+WHlu9H/tSZy+f0v6b67cUGkd5sYlNg1j6T+7DE/WxAO+jDWK6UyVZ8lf
	gl8DBWcSn9Ql3KyYAYMUnDYzGor+RGrfvt2g+k9jspZmyGQRA/IWOrZw0hl/cMx6lTZHkMAKEEqFf
	zPT0Co/RKNlfOEtX8psqe2TDoA2aM7w+v3cdzmZB+5Hdml88uANqLoz2j96a7BumvxC/JnGeEBDdb
	LiVFjvrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAoPW-0000000D7pn-15PO;
	Mon, 20 Oct 2025 11:50:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAoPR-0000000D7oz-0fTM
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 11:50:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BD6C84872B
	for <linux-nvme@lists.infradead.org>; Mon, 20 Oct 2025 11:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7076DC113D0;
	Mon, 20 Oct 2025 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760961026;
	bh=N567dQrS7YauDt3kUs4UraXaPwOCX21b3ym/k+A1Dlc=;
	h=Date:From:To:Cc:Subject:From;
	b=JWwJhxtIlqYKATiURZd4gqMUhOJZAiJ5ndsEH+ZNbc4+TrEaUfGhOHBd2vMJP5TC1
	 JZGmeaL3nklqzDqKS1Lv1dyYxXkkq7+tzpK9QN5X+tMrNTZ5ghlH9Lru2K2+SZk0Od
	 kLdKLafR819ztaLPAEVF+rsBIcl7aGlqEyioVtY0YFROrnY+FCfFMccVcC7Zzr/rBA
	 ywgKkj0+KjBDg+MgrdAn5c/CN0/0gx+ryqS2olYXp5WVBfSZzylyfRNMIrtlRve8HQ
	 GBokFiSPSwrYd2K+TdawLFKBKpUGbn8AwObXEjc5qftKsC+TgVMyHU9oEpwQD+5DRV
	 seLowePNz7Ecw==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6CE8EF40068;
	Mon, 20 Oct 2025 07:50:25 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Mon, 20 Oct 2025 07:50:25 -0400
X-ME-Sender: <xms:ASL2aOwmUoP8PYsAHHK-wRNricXLpvVeCERXg9OsjjlPd1cmHEpwew>
    <xme:ASL2aFFuER4QZIDIKcoomGvMnwzP7HG2XwJlEsIoaCJ2qk65sQq83sQ3q9Uea4KcE
    USYLf4WwWHa0jYmBb7LfqmXwdTFONYSzvBK9q3SYLK4JcEhPq3-eK2q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkffutgfgsehtjeertdertddtnecuhfhrohhmpedfnfgvohhnucft
    ohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepgeeujeevteehieeiudetveekhfehkeduhffhgefgudfhhfduteduveeijeef
    tddtnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheplhgvohhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdduvdeftdehfeelkeegqddvjeejleejjedvkedqlhgvohhnpe
    epkhgvrhhnvghlrdhorhhgsehlvghonhdrnhhupdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggurdho
    rhhgpdhrtghpthhtohephhgthheslhhsthdruggv
X-ME-Proxy: <xmx:ASL2aOM3_8lw6JGapgNOZ50K6p2YipXmMow3Ct7ypp2IMyCNiwN9YA>
    <xmx:ASL2aEtB75XgYfdAI899w1zHkk9uv_K4iHg0lEfjHFX-EDXXtrHJwg>
    <xmx:ASL2aIWqDXEKexRLSJz5mtpeVvm_KnH6kRJjH43_hgfvBHAXEMbmRg>
    <xmx:ASL2aMuZMv25ogz0vVTFJi2XcwV9Vf9QtCV135b0Mljw2Hb_iHXCog>
    <xmx:ASL2aEXnroOItBf4mufH-SZk0G6rYNKnKcv0AccbGW1jYNYk9NNoy_Ud>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 317E62CE0072; Mon, 20 Oct 2025 07:50:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 20 Oct 2025 14:50:04 +0300
From: "Leon Romanovsky" <leon@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Christoph Hellwig" <hch@lst.de>, linux-nvme@lists.infradead.org
Message-Id: <73609a88-b98f-474a-8872-673cf5ca0581@app.fastmail.com>
Subject: Metadata integrity, single segment and peer-to-peer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_045041_222145_6F5AE794 
X-CRM114-Status: UNSURE (   3.62  )
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

Hi Keith,

I'm looking on the nvme_pci_setup_meta_mptr() implementation [1] and don't see is_pci_p2pdma_page() which exists in nvme_pci_setup_data_simple() [2]. Is it intentionally? Can single segment be p2p transfer?

Thanks

[1] https://elixir.bootlin.com/linux/v6.18-rc1/source/drivers/nvme/host/pci.c#L1111
[2] https://elixir.bootlin.com/linux/v6.18-rc1/source/drivers/nvme/host/pci.c#L989

