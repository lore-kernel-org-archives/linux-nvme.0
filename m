Return-Path: <SRS0=GEgN=O7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E655AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Oct 2021 11:46:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE8B60F0F
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Oct 2021 11:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AAE8B60F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Vqse9/FHpoFcKIVCDALgW7xyn71ZKw0aYTMHeV/30k=; b=nOvZYQ+doz1mFQ
	hrAcyIbEYVoh31dV2v+/syYOfDbjTUU7iUtlAQ+EaqtluY7BwardWZNtWCLkvP9nnnFahJk3dJ3in
	rgX8ZBO52OaIhJ95q+qW1OKDmWXHhVV+r4NOxXMrfyGwrDqfrMFw5NMGNtreqKwX7vPhvGhar5X6e
	q6IQiRcSb1KwZlHNuW5hSU3YI2fimwzmgXqXkjUFlSPIRQj9ptLgIicyK6DzLDPH4OY2eqatz5h+/
	pppgzdcStf49S6IECVqlyNNVEya0mFZ5ZuroRqwZgX7bcUVH9zLfLumVWD5+ORwfzCi7Zv7Nqetjj
	u4FGwI9Tv/9wC5cY9XYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mZtkp-009AzZ-Hu; Mon, 11 Oct 2021 11:46:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZteK-0098Ah-HV
 for linux-nvme@lists.infradead.org; Mon, 11 Oct 2021 11:39:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 15F1D68B05; Mon, 11 Oct 2021 13:39:12 +0200 (CEST)
Date: Mon, 11 Oct 2021 13:39:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Message-ID: <20211011113911.GA16138@lst.de>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-2-ming.lei@redhat.com>
 <95d25bd6-f632-67cc-657e-5158c6412256@nvidia.com> <YVu3EjPqT8VME/oY@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YVu3EjPqT8VME/oY@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211011_043920_771415_EB4801E5 
X-CRM114-Status: GOOD (  18.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 05, 2021 at 10:23:14AM +0800, Ming Lei wrote:
> On Fri, Oct 01, 2021 at 05:56:04AM +0000, Chaitanya Kulkarni wrote:
> > On 9/30/2021 5:56 AM, Ming Lei wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > Add two APIs for stopping and starting admin queue.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > 
> > 
> > this patch looks good to me, but from the feedback I've received in past 
> > we need to add the new functions in the patch where they are actually 
> > used than adding it in a separate patch.

The above is for use inside the same driver/subsystem.  Cross-subsystem
we usually do what Ming did here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
