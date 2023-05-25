Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1E4C7EE29
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WX6Q3krLeXnyU1ErGKnaGEj0J5rvRDqnfROl5WFYUIc=; b=z0bWzWcJRyq5B4xqNi8gE4jvhF
	IsjgYqZPwzpRmf7NZeCx83hz2DHyNiMpuk/ZCtweeFoXxeLjB1mVs1zOXC6I84asdPRQxJg1nS7tk
	CxuSRB03OrBJ43KCWm/tv/IDzWNPd820E+jXMUxzbqEbPj+5oXS/uaJl4Wjnzi4JRxl1hYbCANlGl
	hLixA/jBeFg2Cgj2jRXynYAssull8xoc1t2epXgn044wGeGBfe66R1f0uS8S2z5+OFQjcz1nAtDk/
	A4/WZGnaAIFI6UVzvKMr3HRZpTxPBDB4QAFmDwM5n4cCIVk/Yox4neJ6SDRYyIbfqZhyFTYbcT837
	b8LDptLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FIA-00HJuI-35;
	Thu, 25 May 2023 18:02:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FI8-00HJtT-1B
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:02:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EA03464829;
	Thu, 25 May 2023 18:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F7CC4339B;
	Thu, 25 May 2023 18:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685037743;
	bh=WX6Q3krLeXnyU1ErGKnaGEj0J5rvRDqnfROl5WFYUIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBiCsIsDLy4WPXgsOkAbA4gn4FCBMGjLsFpiA1raKtxrrqxIDhryJM8TgOf0ll42O
	 IgVGf6lvNrpEO3L+4qhp3zvUe6nLOytYDtKx/1F8BPVaF/RSPe5OY8wutIVDglh4/9
	 4+/ikUnh58ENbCc9Icz1bivQ42AUsPfpnT0InH7EM+5mVXHjbsKnvk+8/BpZ0vgzoc
	 ZSULGRQdgSlqUfCyLOQxgo4CYkRbi9A6XQBRxhb9rDcmFsPq3d0I1bV4RMLKttLly5
	 DfGNx8XhEomvZkhd3cGehepGqGFNeAHBkb+m8LXd9OkjmpnVr1Sr4AY7r8NqP7sExN
	 qa17uXZ/y032w==
Date: Thu, 25 May 2023 12:02:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-auth: remove some dead code
Message-ID: <ZG+irWuexM05RNsN@kbusch-mbp.dhcp.thefacebook.com>
References: <e6f0e506459eaec9dad74946c1e01aac74874054.1681764032.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f0e506459eaec9dad74946c1e01aac74874054.1681764032.git.christophe.jaillet@wanadoo.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_110224_440944_DEA909A4 
X-CRM114-Status: UNSURE (   7.95  )
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

Thanks, applied for nvme-6.5.

