Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC8BC43458
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 03:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1DS+OkK07L8Eap9/ZYD3L5NCnYAkX05R10505TTEdLg=; b=i+F6NlbneDEIWdSk1lQrirxWSj
	kr4R70t+oBisCYMAHdRV4WbSF3G6xlA6WS7aGfQ9y4ZcrQ0Alb69f4+1ueIzL4gHpe9MkQOu6kju9
	n6sGd5Szl3NxwDco7aDnf3hxP7pVOrpJCwvenQR0tDS+1giArWASD+nrEpbc93z7260K3hj3fukwa
	PGdvNw7+VzxwgK4WEpjNl1jpYmvCcGXlbMV1dD67/bGVoYVrJJ0j32OtCY0AP+JUa2gZNPT/XAFb3
	2m0yThus7iWh1IBZLUXOJtIcNcrFZUBkqTy1XCvA6E/MKi99hMlpWjx4VRCNk/LslRq/HfyKFIwV8
	Vf3Em7bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi1wB-000000042dS-2U9z;
	Fri, 10 Jul 2026 03:30:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi1wA-000000042dD-3xes
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 03:30:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 576AB41AD7;
	Fri, 10 Jul 2026 03:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B988B1F000E9;
	Fri, 10 Jul 2026 03:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783654202;
	bh=1DS+OkK07L8Eap9/ZYD3L5NCnYAkX05R10505TTEdLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=b7g9c12GrubGWRnAJo8Y+VAUVQe3bDOL6P10dmcMoseMWD8dMi69fPnaq4NQdw77o
	 EwLUh4Ac/IeKJndbGqF0hfz4EITmOV/ejSgOUDv9Z1EpBiPVh53y1XbWsjSem/FcyS
	 D4xAtPEzyxb3+SCbL7rKGSMgb8xsD2B6l92iFtmSX3C/zvyhMbvKWtP/U8OXoydjZa
	 FFbXlbsyk9F5eIycNDi1T1IbgTWycVUGlCs3AY4caavTm8d5JrhresoSz7zhNFM7kl
	 Rp62xtlIeLGyXE+rXnYXglSqrDBpJP/VdKL1HGrl52JmcUPIH1CHijVdt3hFDnOFxB
	 JBrfGmg6A2A6w==
Message-ID: <6e835ca9-42b8-439b-a9ab-922a0b70c6a0@kernel.org>
Date: Fri, 10 Jul 2026 12:29:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet-pci: add KUnit coverage for endpoint queue IDs
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: kwilczynski@kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260710023015.3744082-1-michael.bommarito@gmail.com>
 <20260710023015.3744082-3-michael.bommarito@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260710023015.3744082-3-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/10/26 11:30, Michael Bommarito wrote:
> Add KUnit coverage for the PCI endpoint target queue-id boundary. The tests
> model the case where target-core max_qid is larger than the endpoint
> transport's ctrl->nr_queues, confirm the common qid check accepts the
> malformed id, and verify the endpoint callbacks reject out-of-range
> Create/Delete SQ/CQ requests before indexing transport-private arrays.
> 
> This covers the regression fixed by the preceding patch.
> 
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

I am not very familiar with kunit tests, but looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

