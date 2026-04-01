Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B53CD2ED0A
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qes3Lu9Mli9wRZoNEy/hI5au1DO4/mQkEDEb+0U0cNk=; b=RKDsn4h/iRcpWoZ+CRNZIKbnys
	12O9jnPZnfIjesSMHdYz7AkXNMBKr560asfLoplkmH1vVLP3rwb8POnOY79aIq2LypH8pzUrQepdw
	e3zTh1wHS4hYLlpRGyhQr4vPyU5fRCzthEpDyL35afZgL2a8jMBxtBwmSaJqBeALI4FHYK3BXD2UQ
	Uy4ET1FCgFPXqLQzPAOQnWMoB/lpt+D1Vu7Y0p+UUXs+6F5n2L5xhwPubSzbqj+1ckDWdwdSQEU89
	5d18X62aRHdEasV8QbdP0u4pWZPAzpM8nou3o26KWS2Al0lXkrOSZVYP9use7yYP7Wa+zxT2sTJok
	eY4JPklA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wPL-0000000FTJB-1uDx;
	Wed, 01 Apr 2026 14:18:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wPK-0000000FTIO-0AgB
	for linux-nvme@bombadil.infradead.org;
	Wed, 01 Apr 2026 14:18:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qes3Lu9Mli9wRZoNEy/hI5au1DO4/mQkEDEb+0U0cNk=; b=h9Ei5xYIZ/bzAV4OeH3GQVYjHc
	RduTnPkUgwasY62pKiqJVmoTa8kT54sD9dckRXP21VUY+WsOxflGd54Kqw16qaEGAWGr2udCrctDa
	D5Ce4s4XKgS0/nUl6g3sfZTn2qEyshaDNTWM3Y4rYZ0bO4caFQZ2qJ4Ot24sTobI2csOkKgLxE1yA
	E8oPhk8wH8x72fgxUdVkdFpZwZ1W/PUXWnXjAq3gOOeCpWQb/2OBr/Mxz7RLTYCaDatTWaWIcV+6S
	OPC4v99btF1NoJ14PbjGH4ToMRRjP16pT2gBcZaIXUjYzrov2+BKI/da4FdqG6PT9jqJ3IqZU0b5P
	Gd5/davg==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wPF-00000000aTh-3tJy
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 14:18:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 84FDE68C4E; Wed,  1 Apr 2026 16:10:35 +0200 (CEST)
Date: Wed, 1 Apr 2026 16:10:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, smalin@nvidia.com,
	linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] nvmet: introduce new mdts configuration entry
Message-ID: <20260401141035.GE21703@lst.de>
References: <20260401101355.163294-1-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401101355.163294-1-aaptel@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_151854_187985_AACCF146 
X-CRM114-Status: GOOD (  12.48  )
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

On Wed, Apr 01, 2026 at 10:13:55AM +0000, Aurelien Aptel wrote:
> Using this port configuration, one will be able to set the Maximum Data
> Transfer Size (MDTS) for any controller that will be associated to the
> configured port.
> 
> The default value stayed 0 (no limit) but each transport will be able to
> set its own values before enabling the port.

The ZASL calculation in zns.c also needs to take this limit into account.
So maybe add a helper to calculate it?


