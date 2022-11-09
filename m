Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E62C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bsrzh8jzUE4SzLM4o3FKQ+VzLtBD9J4xN0fe1W93zJY=; b=TUthPHsBr7b1CGOuBDv8ZHCKQV
	jLaKsrdZn8y44xtajpq5pG69e/hKD5nuMscdoW1ogFjXfvLoO31mEo7lAbjFLcYDJieC0mhrm5ld8
	9coYjZvEX7PQTRLCUIc07g295z9mwOowoNJbAmrs90PkV2naB7oM3mNuN/2iCQKKP78LYHfsfl/e1
	NyaRNIzX3Iz6iYaRqClvZEr9KEGChPMJXd6cHo1K4Y66vFPoEdZrnJE4bMsk/KiYWdZh2u3ki1/eg
	AW26hpUb5NcS+aIYD7ifPvCQO8Kqb+uzr+3WN9ROla7xGMk2KCwosSderYoMla5xmqFntdM60+axL
	Aq81cuvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osnMe-00Emik-Hl; Wed, 09 Nov 2022 15:51:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osnMP-00EmVC-C2; Wed, 09 Nov 2022 15:51:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D017461965;
	Wed,  9 Nov 2022 15:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A03C433D6;
	Wed,  9 Nov 2022 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668009088;
	bh=Vk2ZZ3agqZ4nabmZlagJmePBsOimEQy2GQK/lbJ9HbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYCBDGte88HHfnc9cGKfhc2BNWmUwzzobQugNDgpGi+A7FsvBnngRJny6JgSifEDW
	 m3fB2FtrOMtp9P7R903WZgliqDy0wKdZKDuJ7i7ms0kIvHSj/9IwkwQwfi9oIbm7zR
	 QFkOe2mL1zOSeIRuzzmOL+bWCk19QxzORBHRAuXO2vIgLrgi5Dnmvvi6UCWphIUnri
	 +5UTZyf0dss1mwfOVS1roY6btvw7nkFGaLSFbUHMtPrAn0xQ0OrGwp9KBKeRmOEANz
	 g9lXuVFg7xVrFbtWxZFJn4If0Yfe4AlnLFTD9kGDxosB+WltXmwuvf72IThvfYfjOf
	 kXqP23r47QyRw==
Date: Wed, 9 Nov 2022 08:51:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 11/12] nvme-pci: split the initial probe from the rest
 path
Message-ID: <Y2vMfSCjCj8sCMj/@kbusch-mbp.dhcp.thefacebook.com>
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108150252.2123727-12-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_075129_465435_1C35CB87 
X-CRM114-Status: GOOD (  12.61  )
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

On Tue, Nov 08, 2022 at 04:02:51PM +0100, Christoph Hellwig wrote:
> nvme_reset_work is a little fragile as it needs to handle both resetting
> a live controller and initializing one during probe.  Split out the initial
> probe and open code it in nvme_probe and leave nvme_reset_work to just do
> the live controller reset.

By enabling the controller in probe, you are blocking subsequent
controllers from probing in parallel. Some devices take a very long time
to complete enable, so serializing this process may significantly
increase a system reset time for one with even a modest number of nvme
drives.

