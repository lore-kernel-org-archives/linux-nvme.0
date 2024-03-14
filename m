Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDD1C54E60
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Mar 2024 18:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LpfTV5XjBJ9sHwYJz26O9mfseXwEJhoub09jqnezpfU=; b=cTHvCPcv4pCVSNZrqmgyZia+Ok
	mqZ3pvsS+sVs1D2YiJV4jxW9n/HKUKix+9irREPQaBO33l416BhKZ+h+Tr4MCTIjTptMKJu+3bskX
	0Ctcgm013ExVJYRTL1ExpmwrIB+Jq/6WBcdyJHEUV27dMjE8TwCpYpNMXaBSLWfTOxKSxyD+1ZIbO
	JYXgB274OhfH1x13Gmv0g07NGZWN3AU/5oaEXB0N5/R/2z4SGaobY1AtpBKjppM6lH1eV1RRsLN8G
	0a20C6bgNc8P/HzUq0sgfcGtK342x/aIxYt3BblHEzDdDuRwpjTOmaDoLXWNK/VuPLQdWfxJLiJV6
	NRix31Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkq2F-0000000FLMH-2IsX;
	Thu, 14 Mar 2024 18:42:35 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkq2C-0000000FLLZ-1I5k
	for linux-nvme@lists.infradead.org;
	Thu, 14 Mar 2024 18:42:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 94DCCCE1E13;
	Thu, 14 Mar 2024 18:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413FAC433F1;
	Thu, 14 Mar 2024 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710441748;
	bh=LpfTV5XjBJ9sHwYJz26O9mfseXwEJhoub09jqnezpfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+9AzhMGcaS24aNopJoJlsfbdwwg44ev1LpYW/Lx5T8jPjFS9zRDXRpEMWpr4SWsZ
	 MXupfq18PfGPsut0SzMOUFFmENeLtIfPJGA2FDk7RSHPMGUM93orOg6Ez1dJ/dv5w7
	 Q5AmK4wfhdfdYaIAfpyMEBCBrcYYA1z8Lxd+1cpn1QlQ6Bmy8q6t85pQl7jdpHBVBv
	 AonSTTX2wzmqzcJEGAHqj5Q0eLWpH5uDRuCBDNu2qCRiHbTXtx0agGIx6dfpAD6AN+
	 hNmj+nnomBMAMiPEUOejQL4oFPQegzpk96Ho71Qp3St2OzNcXj01PIoNXwninOE/WW
	 aCAdoH/QSNPuA==
Date: Thu, 14 Mar 2024 12:42:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nvme: fix reconnection fail due to reserved tag
 allocation
Message-ID: <ZfNFEjPgL2udEEE6@kbusch-mbp>
References: <20240311020927.85482-1-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311020927.85482-1-brookxu.cn@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240314_114232_553728_CCF81E28 
X-CRM114-Status: UNSURE (   4.60  )
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

I've replaced your v3 with this one in nvme-6.9. Thanks.

