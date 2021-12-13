Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36818C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 08:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=INMoYHTQvODcZ8Obk9iZha6H0Qi7kvIjT3RhNva9jvQ=; b=knv1NRzWgRVwPvxLzlP64zj5Pn
	8leT7rH7HrOOrRh//o21wSVKtbY0QNfN/N3i/kBXy3iAZz3MOiAvJig89DVpwx/8dK2Q32UJzourb
	muAbLCN1dJ6m4Dnq6s96283XSvAZeAURHkwfa79CJVXBlIcD2HduZ5SPUtAXR1AgGS4i9pKQjqTSM
	tFV5/J3OJuAXfdyFI1Fo9EW738E+457r0YVr8HAlkdYh/uiiVFW0aE9l7d78UBDdsackSWVx8spcS
	OZi2RtiTpSnuCizA27aaW4TQNeja6wADLnPEFRyxX23h1NQ5+uw3nDFjNEX6DAuLL2/75wcZImd0e
	8ptpUVLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwgOL-008Ef6-6U; Mon, 13 Dec 2021 08:09:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwgOG-008Ecv-HA
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 08:08:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AED8C68BFE; Mon, 13 Dec 2021 09:08:53 +0100 (CET)
Date: Mon, 13 Dec 2021 09:08:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCHv8 00/12] nvme: In-band authentication support
Message-ID: <20211213080853.GA21223@lst.de>
References: <20211202152358.60116-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202152358.60116-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_000856_761083_1FADCB14 
X-CRM114-Status: GOOD (  11.68  )
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

So if we want to make progress on this we need the first 3 patches
rewviewed by the crypto maintainers.  In fact I'd prefer to get them
merged through the crypto tree as well, and would make sure we have
a branch that pulls them in for the nvme changes.  I'll try to find
some time to review the nvme bits as well.

