Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EF5C021BB
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YmcXnyAEBGhnoPeAVCPY5KdswW6od8plB/NG0IIBw5k=; b=V546ArvAWC2JK1gQy2N7emf4iQ
	v9nZVI+3X+Kzaz3ZgsRUp6TnVv3V14ufCRjLZEeLVYOQYTkhGUpXywmWG/+OL0Y5mXrIF3oMUzGu2
	pz+D9/JdkQcwd41HuRGeQlJhVZb/3TP11ijVhvAndSqOSqYsPGU559uGje8YhAjExeoeZOETZQmPK
	gOyPh/35K3FpSUyQuCMCEpbVrEjenBmfeiiMDYM/P5Ash+QVWpxI8tjp554MisPUcAJlQaVpybtQs
	5JgsEYjPe0f9eiY1Bqc0jIo6Azxz6HyRXhLdPh1i3nyaX9AQG95ikzYh2mi+e2Ay2E5pg3hFwM1Ew
	yRqVZVXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmZhP-0000000E9Ri-0o4o;
	Mon, 24 Feb 2025 14:44:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmZJ9-0000000E4Q4-11Zx
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 14:19:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C0BD68B05; Mon, 24 Feb 2025 15:19:38 +0100 (CET)
Date: Mon, 24 Feb 2025 15:19:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/8][next] nvme: target: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250224141938.GB1088@lst.de>
References: <cover.1739957534.git.gustavoars@kernel.org> <ef7a6920384ab2f8f83c0f630f94edc73cd65997.1739957534.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7a6920384ab2f8f83c0f630f94edc73cd65997.1739957534.git.gustavoars@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_061943_421427_B50EEBEA 
X-CRM114-Status: GOOD (  16.95  )
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

On Mon, Feb 24, 2025 at 08:30:10PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Change the type of the middle struct members currently causing trouble
> from `struct bio` to `struct bio_hdr`.
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure `struct bio`, through which we can access the
> flexible-array member in it, if necessary.
> 
> With these changes fix 38 of the following warnings:
> 
> drivers/nvme/target/nvmet.h:455:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/nvme/target/nvmet.h:462:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 

I'm not sure where you bio_hdr structure comes from, but maybe that's
because you annoyingly split CC over the series, and by the number of
patches probably also bundled unrelated changes.

In general our first resort here should be to move embedded bio to the
of containing structures.  If that's not possible you'll need to explain
why.


