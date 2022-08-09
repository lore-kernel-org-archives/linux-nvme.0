Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCDCC19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 07:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MsbGf3n6Cur2omuW3vAdFbGHw9nbNe3qRDvCxqx5pqQ=; b=wo5y/iNDi8GxL54w1IzoAuUmg6
	s8X+Cvcmiu3zpMVRGWrcxp+CHeXnK2+6j9lgLB6knlucEVzW2/ClnyM5anXHNiS8/9miqBtXqxzSH
	9zr/4CHkYDBjGUMP5bjHWRVBzg1Lf8kZEXFYTmeu2gZasN9Aq0nfmsxxciVGykgjMeJlhu1gVobja
	nV3M1fWvYAM/tinCCnzx6Yj8DiXVKWQ0eKoER/cSsR1bljn1rxi5sR+Zr6PFD+LIiYU3RfQMEt7zC
	F+QFGkYpj8ChMwJDIkTP1ftkDbXpoGS4i2pyx18rnGvo1JZebzML8+4FSxJjvgTlQIDHu9Lyy84JI
	JCpvEwBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJWj-002Jj1-IY; Tue, 09 Aug 2022 07:19:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJWf-002Jh3-Sy
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 07:19:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2163668BEB; Tue,  9 Aug 2022 09:19:39 +0200 (CEST)
Date: Tue, 9 Aug 2022 09:19:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v2 06/20] nvme: Fix reservation status related structs
Message-ID: <20220809071938.GC11161@lst.de>
References: <20220809000419.10674-1-michael.christie@oracle.com> <20220809000419.10674-7-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809000419.10674-7-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_001942_118783_780FE8D5 
X-CRM114-Status: GOOD (  14.21  )
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

On Mon, Aug 08, 2022 at 07:04:05PM -0500, Mike Christie wrote:
> This fixes the following issues with the reservation status structs:
> 
> 1. resv10 is bytes 23:10 so it should be 14 bytes.
> 2. regctl_ds only supports 64 bit host IDs.

This doesn't actually seem to be used by the kernel at all.  Which
I guess means I need to go back into my todo list and tackle the
discussion if we want to have non-kernel bits in nvme.h to start
with.

