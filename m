Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F8DC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 08:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IN4ObC42/iSI69wgHq+D+NHzsf2dwQchd32zYvS3vl8=; b=itIK7GMmWjhsCL3OHEyoLMgjqK
	uJG4apTdDSS34PI6rGUQn2C6IPjoW6N0n1EjAk1tekQR7k7Xg1hbIGyRYhskWEo0FKsqLTbz9QqDN
	rUTiX7DFt4rYdDsS7jTeR78Ym3qxk5kGui8Bf4gQYjliMMKTx//5+PkoxHIZFQUKlJLdboh3FJTUT
	HWwJOef53zCFnTpb4pd8xVcMJU4eCkqIlgYCJTXihDrMC4rCWXPZerOUD+huTzembSqCDLEN7sooa
	IVuvJorRCtVQLkP9P8qkd4Q+3UKidbe7TsaRFz/fknB5XqbWvZFLi5gfo5QLVfFh9deAEcLyCO3jy
	2WK6O0Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKq4-00E44A-2A;
	Wed, 13 Dec 2023 08:43:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKq0-00E42l-1w
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 08:43:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1172D68C4E; Wed, 13 Dec 2023 09:43:20 +0100 (CET)
Date: Wed, 13 Dec 2023 09:43:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] nvmet: fix wrong error handling approach in
 nvmet_install_queue
Message-ID: <20231213084319.GB6184@lst.de>
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com> <1702449172-8920-2-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702449172-8920-2-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_004328_781051_8EB9F7F7 
X-CRM114-Status: GOOD (  11.15  )
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

On Wed, Dec 13, 2023 at 02:32:48PM +0800, Guixin Liu wrote:
> In the nvmet_install_queue() function, do not set the ctrl pointer
> to NULL if the sqsize check fails.

Can you explain why it is wrong, and why not doing it is desirable?

