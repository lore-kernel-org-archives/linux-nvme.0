Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98FDCC6B08
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ATesUpfoELygj/PzWaAAcN11fXAS2I+HkmDj9kte9RY=; b=z71gvrrbeJHMvU+031lH0Vl9iq
	UFX4wLSoXEzeG7lh27XGQz9TDzHc6x6+laawfP5hMtrAByjJt3af/hgbY6iR77N5CnmByBtWnuxgA
	7h8S+GzNg7mynj+miGfrK5q4v4SCDLg0XgGbnKIpA1sgl5SDi1WGQ8zsAq/xjK82Cosg/UdF2vROO
	ChVakjRiKSa5j4mSfAyAB9bWrrdH71of3CnwrMAo4m+CkPE15YIbFNlCoML4Yi6RoNuXOfY+3g1Vs
	HPNW7Je7laDyZhyFhR4RmycZZlhEa6oNwShgFonk46OwwHB9WT4qPbjA2/lRdCjpmxAMMeXNtnHqV
	3f4Qp4fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdWo-0000000D6eT-36yT;
	Tue, 13 Oct 2026 14:30:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdWm-0000000D6d8-0x44
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:30:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2DC1227A88; Tue, 13 Oct 2026 16:30:48 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:30:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: free the bvec on file namespace range errors
Message-ID: <20261013143048.GD15192@lst.de>
References: <20261007192745.160060-2-Jeremy.Jean@oss.cyber.gouv.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261007192745.160060-2-Jeremy.Jean@oss.cyber.gouv.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_073052_589748_91966D8C 
X-CRM114-Status: GOOD (  12.82  )
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

On Wed, Oct 07, 2026 at 07:27:46PM +0000, Jérémy Jean wrote:
> nvmet_file_execute_rw() allocates the bvec before
> nvmet_file_execute_io() checks whether the request fits in the backing
> file. If the request extends beyond the file, nvmet_file_execute_io()
> calls nvmet_req_complete() to return an error. This skips
> nvmet_file_io_done(), so the allocated memory is never freed. Repeated
> requests can exhaust memory.
> 
> Use nvmet_file_io_done() to free the bvec before returning the range
> error to the client.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


