Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64520CEF15B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OdwlxzeGhkCEHL52PNGpSB9t0Q+ESkxcv7YoMNWWIhk=; b=EOazhszrXbXFXRIcX3kDqbUa73
	EDfmM4OhPFLGMYy9YhltYC6rsFFm0AUljqobccZS7EXvuGEKnbNL94Cw7Kx2U/axwlXjqX+uFKsMH
	37VuTu+FLZ6Rt1ROJZe19FULuOZL3YJQQcjeoM6JL/ucDnPxo63M3XKEZvPWCXRqnSr3CPRpZw8Y1
	nl+6Z5onHchxx1RzlTeiMKni2Lz/63j9n3gWafZ1ZBG8nKUX217is+28E4IrYh7sCGPxgwVGAcdFJ
	pjPlNbUCNSSPa0K2WBRSjkpHkPKzlh0qHNN3HMiKm2Q0iQzcYOtIKCk9I20yEI+QpCXjspphfxgWy
	X+mMVIqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8fe-00000005ga8-00Z2;
	Tue, 08 Oct 2024 11:46:30 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8T1-00000005djB-1kIp;
	Tue, 08 Oct 2024 11:33:27 +0000
Date: Tue, 8 Oct 2024 04:33:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [Report] requests are submitted to hardware in reverse order
 from nvme/virtio-blk queue_rqs()
Message-ID: <ZwUYh9uJgETHAXl2@infradead.org>
References: <ZbD7ups50ryrlJ/G@fedora>
 <ZbO9T_R4lN_7WkwQ@infradead.org>
 <1e0ad5fd-2d90-4a0a-bb5c-0b270dd8ddd8@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e0ad5fd-2d90-4a0a-bb5c-0b270dd8ddd8@acm.org>
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

On Mon, Oct 07, 2024 at 03:39:42PM -0700, Bart Van Assche wrote:
> For my patch series that supports pipelining for zoned writes, I need
> the submission order to be preserved. Jens mentioned two possible
> solutions:
> - Either keep the approach that requests on plug->mq_list are in reverse
>   order and reverse the request order just before submitting requests.
> - Or change plug->mq_list into a doubly linked list.
> 
> The second approach seems the most interesting to me. I'm concerned that
> with the first approach it will be difficult to preserve the request
> order if a subset of the requests on plug->mq_list are submitted, e.g.
> because a queue full condition is encountered by
> blk_mq_dispatch_plug_list().

Note that you don't really need a full doubly linked, you just need a
tail pointer in the plug, i.g. the same scheme as struct bio_list.


