Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB4BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 06:07:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B113D60296
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 06:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B113D60296
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hFbyKCdw8cJhZlmPLo54PhT1ci2NEJXaJE3uZvNYA7k=; b=qnuATrPrabn1skL7ugLwBJhGpZ
	pKxnmExoanQuHqjviYXLB9NrO1UqWBhi10Oia+Ncrnki8mdCGHelrC0YFYGXDM55HWTXdht5EcPRr
	NtJCSLVa3+NcUw0Rb08Z2jnheL//H48c3bQSWXu8WzK1kVK3VO/dLDfBkh0Qq99OJaUKLCxbqGY7D
	p07uw6ptxdHaAXAonPTRxpTue3LTbCTsLq26uubcgfTLrBAXXLg+JtghFjPOs4W7sB5AvwtX4zIsD
	OgEIl3U+xCge7ucKbCWcDhr5Gl5KqCpmG5K1dGKIU7CBpCFcm50WMf2gfpLJjCRj2vTi5I7r4c5nN
	3yeNCojA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfc5s-003yIx-Ie; Wed, 27 Oct 2021 06:07:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfc5p-003yIH-FG
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 06:07:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1C21C67373; Wed, 27 Oct 2021 08:07:19 +0200 (CEST)
Date: Wed, 27 Oct 2021 08:07:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 0/3] nvmet: discovery controller discovery support
Message-ID: <20211027060718.GA9949@lst.de>
References: <20211018152138.2128-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018152138.2128-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_230721_693738_DBB5FA48 
X-CRM114-Status: UNSURE (   8.42  )
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

Thanks,

applied to nvme-5.16 with a few cosmetic tweaks.

