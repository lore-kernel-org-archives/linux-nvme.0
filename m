Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EEAC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rU56Y1fG3H+uwwSkG7DlvK2Wvg/PyPUewfFEtRZxGQc=; b=Dx+pW3mMm9bfKt6niUrwZr/IYC
	fVPPxb3yAcGayF7cwfC109HjlR+omdkzfbAWeOlGfxd7nO2n04on9Gvg5tpxv6mGoZPk9VI+30e/S
	3tipv+cLxw1pJb9jpXbWTwCw2o7yer2DYWWt5+ryIR6A7YNNndQFWtrD0MeaUlxzG1lEn/bN+KTpr
	1gxAYCTiWcyePnPq3RfNBqMQ9/j3lmLeETDMTycxtNZ++VXpuDlEygBaV9JtRRPtP4u355PBiyRQH
	fWbA/530gfvqz9hybtYmYB71pgvfn9Hr++w5PaE0D1qPippKAyZNK3Qw4Kh9ex/DhnH7gzCyhxJqp
	h8YXhRpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYxP-00AzMZ-Rk; Tue, 22 Feb 2022 17:28:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMYoh-00Aw75-97
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 17:19:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7C2CB68AFE; Tue, 22 Feb 2022 18:19:08 +0100 (CET)
Date: Tue, 22 Feb 2022 18:19:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org,
 Ran.Anner@dell.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Message-ID: <20220222171908.GA15057@lst.de>
References: <1642870664-3401-1-git-send-email-varun@chelsio.com>
 <23ddf451-2540-86c2-c403-2614477c130f@grimberg.me>
 <98f61e6a-5bc2-788a-a0e0-557001adcf51@grimberg.me>
 <337cec23-c9ee-1cfb-89fc-e6aec649623c@grimberg.me>
 <20220222171826.GA15042@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222171826.GA15042@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_091911_512233_91DD93B3 
X-CRM114-Status: GOOD (  12.28  )
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

On Tue, Feb 22, 2022 at 06:18:26PM +0100, Christoph Hellwig wrote:
> > out to cause any issues we can address those as they come...
> 
> Is this a Reviewed-by?

Ah, we already had one.

