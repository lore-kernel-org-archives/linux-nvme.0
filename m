Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECD0CC6B0E
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=G2OA2SuulEHIjFYJcDCt1cBwnu
	9shu1Ph8CCNeW+NeR1ksrQcnyzRCYdPvsR/FaLyVP+BmgoPe+xauXi3uCdRSd00JvgFG4rRy83OXQ
	urGaGYCQgM9nUlQGJ64TojLOhOMBvqSg0wchchMCpbj5O02VEbKqJe/Nglh6q/MCFW9ujiGglsAo5
	u93/1LYTcTgdAf6sbCHKMuITo16dEIufpGEFHHT8QQmfS9Bh2Nri5DnDrPdPITFRqHZqXPKq1/v2W
	2PcNMZ+ZRJVIAnigfg3AfN53/gJDyhVhBwFtJOc1W8RBNQUaGK7lkdxYpXt6gHyHv0XCmPrThhyUj
	DIVmbsUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdd9-0000000D8Ki-2pHl;
	Tue, 13 Oct 2026 14:37:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdd8-0000000D8K4-2oSg
	for linux-nvme@bombadil.infradead.org;
	Tue, 13 Oct 2026 14:37:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=nasVaMIhXKeZNirRJUrIOMvIqJ
	6pi7eDJDx4Ewhono/BbdIbFhtJsqO7KAjNXBcD/fgBaJ+Rt00OM7uvdOAUclZYO3ZW9tIrijaHpNp
	XNyrFbVg/uPcCvl720cgoxJYij68cv5Hq7j12iqaHORE4hEaWmYUIiP10qSW2mZvDlBWxlPUiNy/L
	5kAFUbzruu829aJmCiL/7OA6e4Y21Ilprvvn8eVQklRWHF0s4YR8KBCyChB0eqfZZf/BqJVQOWc66
	UJ48ojntk54n0j/JBJs1Vp2WvobbAv81hrgtPAtDuHhdaBo7A4+qEvxlrlhjhX2hVQ36vSIqKkF1t
	zl8mvj5A==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGdd5-0000000FeNg-3EOM
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:37:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C81B227A88; Tue, 13 Oct 2026 16:37:21 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:37:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, loberman@redhat.com,
	Martin George <marting@netapp.com>
Subject: Re: [PATCH] nvme-multipath: report "none" iopolicy for discovery
 subsystems
Message-ID: <20261013143720.GD15717@lst.de>
References: <20260930153658.4002-1-marting@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930153658.4002-1-marting@netapp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_153724_180247_7090A618 
X-CRM114-Status: UNSURE (   8.85  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


