Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A20EE7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 19:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=lAsc89tHut/HamRpqNqAogJXWK5AyuIXntlVsElTgMM=; b=guPc7Nnu13x9dB
	lbo1v0A2+unqxB+v7B2PRQIsgYshoLVGiClFFKGUW3tpPDs/F21CvDsuFJsJDsQbqwns5wTbLf/7C
	vJ4DNhuYb5GExvbkYP8qY481Uuj8KDzcS1OuPopK3W5yTO/OKdNP2FxSxpmuARTNr77fZt1M9jGwl
	svwrSJZaGmMbW5OgzR6/0/hiU2sqW9B+j+PQByINB2ks/SWMgr/Rwl89M9ElajIVKHT+BX9qKRvuh
	3h/qPP34AhMuItndStOjUMxg8ah62jthuunMaBtWj+RJsvWio/A9/MxpllIUlqLzB04IqM6TnR7W3
	iZqaVr6ITWkcVLbjkDaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLouM-00000001eNG-2CvX;
	Thu, 12 Dec 2024 19:31:34 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLoGJ-00000001Uw2-2j91
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 18:50:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 927BFA429C0;
	Thu, 12 Dec 2024 18:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6C1C4CECE;
	Thu, 12 Dec 2024 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029410;
	bh=1RHviLb0TyngV+uOSctErtPSXxCUi9IoilqzjkB84vQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Udxg9BO+SAlP/ucCKixftOK8VaQEbRdzIZ/B0kV3SHhsCGzSIa+uWGN1YU/KmBPc4
	 YjFlCIg6x1fHVzPFGiO329cSGhzETaE3zbnb4TQaKBjEuK9VudLqM64GNgOJHTUY78
	 n5Yz4FL92QOpbkGw5aJQmDo0qVBZniMAqjRsNYhqXEmjD31/n9ORsUtMgYrkOz/rrz
	 lrNhwZSTtFQUniYPSQF/mxHsWT/UA/rRAbdRXt7EkDQt1TbP2hOKt3Qfxr0Zc2E/Pf
	 q5XLLsvnJrAtxb/Vyz5LSWCQmVdk+EglGZaQ4gXCOq4zkDjMdyzMXlEa6tX59wbEcv
	 x5/R8dZ39+rPQ==
Date: Thu, 12 Dec 2024 12:50:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 13/18] nvmet: Implement host identifier set feature
 support
Message-ID: <20241212185009.GA3355992@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212113440.352958-14-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_105011_753787_DA2BF7B9 
X-CRM114-Status: UNSURE (   9.96  )
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

On Thu, Dec 12, 2024 at 08:34:35PM +0900, Damien Le Moal wrote:
> The NVMe specifications mandate support for the host identifier
> set_features for controllers that also supports reservations. Satisfy
> this requirement by implementing handling of the NVME_FEAT_HOST_ID
> feature for the nvme_set_features command. This implementation is for
> now effective only for PCI target controllers. For other controller
> types, the set features command is failed with a NVME_SC_CMD_SEQ_ERROR
> status as before.
> 
> As noted in the code, 128 bits host identifiers are supported since the
> NVMe bass specifications version 2.1 indicate in section 5.1.25.1.28.1
> that "The controller may support a 64-bit Host Identifier...".

s/bass/base/

