Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4F0C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rNP2Tbk8MBxF1lSmGCG9VzDsmkQ/9af3+dGcfOh8mio=; b=3qWXSin3Le+keqzysnKeePt6Jp
	ywI/kq5t926XWdi0yfPy1PFIhP2Xo2k5O+ED4W2ICqNhDC1WAluqBRiPw0Ns55jPlSBU6Anf12FmH
	zjAGXWidExTP7NpgePOWSecgQQMMsRppZNB315UyGM63t7zZZrPA+qqKoqxmc9MNHlpA1YprbSN8o
	/pA8Dm4vIWPUQeT0AzZufRgFxB8vkLFjpX9Hh+IJnpFSRJW74d4JEdzldQKome6UgE6Wh6tC1pOkb
	HIY2D91pFSstQjubuVF7vML00f4fsNjCwqqAsH4ebcQZvDnxy0Gi8qQSm8207M1+vevB3z6JWjk2x
	EQR6yQGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNd3H-005mmd-UI; Fri, 25 Feb 2022 16:02:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNd3C-005mkA-Gc
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 16:02:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AD37B68AA6; Fri, 25 Feb 2022 17:02:31 +0100 (CET)
Date: Fri, 25 Feb 2022 17:02:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv3 02/10] nvme: allow integrity on extended metadata formats
Message-ID: <20220225160231.GB13610@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-3-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_080234_763466_50D5F98E 
X-CRM114-Status: GOOD (  12.83  )
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

On Tue, Feb 22, 2022 at 08:31:36AM -0800, Keith Busch wrote:
> The block integrity subsystem knows how to construct protection
> information buffers with metadata beyond the protection information
> fields. Remove the driver restriction.
> 
> Note, this can only work if the PI field appears first in the metadata,
> as the integrity subsystem doesn't calculate guard tags on preceding
> metadata.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

