Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37050C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SrTiIqlvg00+skM4kgBJYNVwj7IOV4m/U4xoNC+evE0=; b=mUHY2qoI7LLWYuruVF6nZKX95x
	H43SzPUs28r4e5N/tLRUmaWGKy2cvSbO3sDeTJRXEjS5W1st6Eqr2tH3drpXtEXte+1nqOHs8c/A2
	NmPY+PyCLVqO59scQNIzu/vY9omBbfxqWNLeSuTbyqtI8gAGqP1fpVcd6BxF5Ecf4XVLftF83+1+S
	6OMR1asJ68NzMojaHX0REal7WFdGlv6GjQEq+Ln5wWpaRPBXR82xGCumoOQqnuTmHggaLviAgPmwy
	3BKIhBt/eF+ajDqylAMN8SC2nNO+crcdINoVAX0D2b7QZfGwkdGEHm2Aq+XNSjdbkL0cPW6TeevSk
	siiO+jFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4NCF-00FPwI-A2; Thu, 23 Jun 2022 13:48:35 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4NCD-00FPu2-CM; Thu, 23 Jun 2022 13:48:33 +0000
Date: Thu, 23 Jun 2022 06:48:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <YrRvMdRIWC84FcAe@infradead.org>
References: <YrRpb4LlxotvjCML@infradead.org>
 <49f60048-1307-6860-794a-82020c9f2ffd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f60048-1307-6860-794a-82020c9f2ffd@kernel.dk>
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

On Thu, Jun 23, 2022 at 07:44:08AM -0600, Jens Axboe wrote:
> On 6/23/22 7:23 AM, Christoph Hellwig wrote:
> > The following changes since commit 2645672ffe21f0a1c139bfbc05ad30fd4e4f2583:
> > 
> >   block: pop cached rq before potentially blocking rq_qos_throttle() (2022-06-21 10:59:58 -0600)
> > 
> > are available in the Git repository at:
> > 
> >   ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.19
> 
> Usually I'd just turn that into the right git://, but it seems it's
> missing the signed tag this time too. Can you generate one?

Will do.

