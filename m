Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D11C3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 06:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KA3T2sPD9t8FDgC66LWUzuRNnIMgCU2pyme7wb8r3Ro=; b=hLQ6JuSECwres4mXmVrUAnebh9
	CsNkerBLZBRyx3OCfqaiixOdrzKx5zfJsDxFVxzSD8VpsUCWxqrGAWisgwpN0IkpachlpHO8SDJht
	2wQNeNAf0watXpGYtIPg3vX+GiiVQyE4PpKnYdVvpGGvlbCyXJ2mY/fm2wBZcZ5pPyqcqESR9vJ8S
	+7LnS9342sIZwVh33b/Bcfh8yBEkiWss0ckx3/gIys/uO17XdliUbokxGkg2o0P+TvJ9DYPARB2LO
	d8mFgOVJ8qub24FGlEqsPSV1KUrHp8jcEpJEdzWXZSDk05iDDgtnkeckYaTP5NNd37ElnVWZbYnwr
	DkmtSKzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh1mJ-0000000Bjmg-2sLQ;
	Thu, 22 Aug 2024 06:58:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh1ld-0000000BjWv-1Csd
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 06:57:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C0E85227AAA; Thu, 22 Aug 2024 08:57:54 +0200 (CEST)
Date: Thu, 22 Aug 2024 08:57:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 4/8] nvmet: Make nvmet_debugfs static
Message-ID: <20240822065754.GD3141@lst.de>
References: <20240819120020.3884893-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819120020.3884893-1-ruanjinjie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_235757_491183_06494706 
X-CRM114-Status: GOOD (  10.68  )
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

The change looks good to me, but given that you sent a series where
I can't see the other patches I have no idea what context this needs.

If this is a standalone patch, please resend it standalone, if not
make sure every recipient is Cced for every patch.


