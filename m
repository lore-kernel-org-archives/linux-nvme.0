Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FC7EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=; b=EvpxDBAu8GnSwiDySsu8ivQnyW
	0cGSjlH3tATdSSsdyvHCURUKGfIyc/6RGXoLmmHm1La9xDUvwmwOcOag/if3PvxVbSUpxDTvsI1Tb
	6zB1uSi6SEOU7ceLTx907OZOeFhl6Q9cX+K4vtKyt1HtMO8lXQVC7Wj0qHW9rB1EK/Cvq/MZLqkM5
	PbL1xzMlAEMGBKmczwHvcO7h7K+3grxZ5ChIhXvcpJwZ8TgZlE2goi9HMHcgl0YpFsYCFOy6THYW7
	G58cf0jc6bO2GURWVc9SwGZ+ZokTtA8LB9Ucrqehq4uZM+GcTUMCL+H8lN269aWd5dSQqXRK9R8L6
	9G59uZSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcjR-000ajH-1Q;
	Wed, 12 Jul 2023 16:30:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcjO-000aiN-1s
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:30:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C667F617FF;
	Wed, 12 Jul 2023 16:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2756C433C7;
	Wed, 12 Jul 2023 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689179421;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DurC5gkvY43hrGPPXzuFhFH+g7XvyTmzNJgVHV/tpEbdZ0Pvv5umPh5RzSKVweMJM
	 3imm518JirOWdYLivSPSU/iWhnBB9+ODidEbCtniuhL7j1gyZnsuX6UlGuPvYu0R+C
	 JyBP0TQvKKtUlPWxfWCj9jKYSw5+zeltsiTbSQiepkpox7vSxLOBFqTmk//IVCzaql
	 ggLaMttFwpSHjVgqUf5yuSjpcuUkqcK+7ZrrDs9GxONZVI65GpXOf98xcqBGm2RiqU
	 aUV0JVWY6MmtLwVdP9FBUOmspbEqIFd9WRNazgdBgfIfKbz8AgWt8f7VDW8IfmeAaD
	 LmQwL3yOVDQfw==
Date: Wed, 12 Jul 2023 10:30:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Michael Liang <mliang@purestorage.com>
Cc: linux-nvme@lists.infradead.org, jsmart2021@gmail.com,
	randyj@purestorage.com, csander@purestorage.com,
	ushankar@purestorage.com, psajeepa@purestorage.com
Subject: Re: [PATCH 0/2] nvme-fc: enhance transport error handling when
 create associations
Message-ID: <ZK7VGgNLPdDGBPxe@kbusch-mbp.dhcp.thefacebook.com>
References: <20230707212157.1158725-1-mliang@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707212157.1158725-1-mliang@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_093022_661213_3B8450D6 
X-CRM114-Status: UNSURE (   5.76  )
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

Applied, thanks!

