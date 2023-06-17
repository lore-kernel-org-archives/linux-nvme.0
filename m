Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A42EB64D9
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jun 2023 06:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AFgSVoFMNezaOUTYf6Jsh1Dkp/6q+z4OXlYPDVdu+RQ=; b=uw4JeBIHkpDYlPUqxReZ/nO8dY
	odY+CUN+ZD1NDi9hAWyBmsQQlqcIMCeQb5ahiY+4O+owOG5KAEVJRevvCmk6jtyQfH4rZhyGp2h3M
	ke+ZedCry/RCVxrQQVWfUP1ojWBAnIjeG3P7yDnji9IZRtKAv68+d9IHck9XRPnUCuMQ08ZpYi4CN
	C+YzAiP6imYC1pNgWkQ60lYfCw8WOQZtWBEda909XF+j4KvedKlJbMiww6IkQ7lefAISsBCnPA6+S
	hsmyFK25HP/O4hMqUZDmbXrMzAndcHrlndLBgNTTRCKCjnFXeg3wOA/iozrKdfxKeFuQj3V86aXPl
	1bIHmCLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qAPQJ-002suU-1J;
	Sat, 17 Jun 2023 06:28:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qAPQH-002stP-0O
	for linux-nvme@lists.infradead.org;
	Sat, 17 Jun 2023 06:28:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4CBAA60B50;
	Sat, 17 Jun 2023 06:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCB2C433C8;
	Sat, 17 Jun 2023 06:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686983311;
	bh=1v8XsSds2AENh5sRYYNo49hls3ex26v3/B0ncB1VCZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hoFx6y8PVvbFWH2VKfmlGJNzmtHGvr88sZshrVFqGBZCq23s9qHycuonvYfjWcios
	 4PICKKiZthzSFvC4RjSwgw/eOEexjU3EOP9eh65vmZF7XjZ6tl7iKC/+prAf5gHKvi
	 XT0OLfbjOc+k9Ems0SPnqZe9LDwsNAbojOS30CCCD6SE1ZPQJ+0Cf+93bDEAc4F3ZJ
	 SCs6boWO32CaVNBJgovuufaZcMZGG/kb269y5Ro4lMjpuMzuJBgsiYoX7q4zm8SKDT
	 UxXOLLuVMD/72RissyWx2FZuHS+1yel7v6djETyS2GypbnAWh6G9lv1wkCjjkSdPVL
	 mmD3noE1yvA0g==
Date: Fri, 16 Jun 2023 23:28:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Message-ID: <20230616232830.4eec19c3@kernel.org>
In-Reply-To: <20230614062212.73288-5-hare@suse.de>
References: <20230614062212.73288-1-hare@suse.de>
	<20230614062212.73288-5-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_232833_198057_465E863D 
X-CRM114-Status: UNSURE (   6.23  )
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

On Wed, 14 Jun 2023 08:22:12 +0200 Hannes Reinecke wrote:
> Implement ->read_sock() function for use with nvme-tcp.

please take tls_rx_reader_lock() :S
-- 
pw-bot: cr

