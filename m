Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DC9C10F14
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 10:06:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0D821D56
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 10:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pI8if3Zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0D821D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=63xi6POTDzbvstIAaUxj9BJweTmRQPC6qZTGysSZ3xk=; b=pI8if3ZwVGISBf
	oYveFaJdCsfYgzo6zReQRnzhn8CK6dKjgxcOSWoRn7OeZx/NOAZ1uDFSXH9UvZpNq3Ew1OYv3K0J+
	IDjM0E9AoI4Hg27/mOwRKNB8Gnj3m69P0lucpgjRQMWnTAgDziRqHV7yFMe74nCCLxXbtsdqaxHqu
	4je8pkagr0KjCc3UJsWt2L4s2Uq2cHd8Z7IaDngJUJMo0chGI775TAAhT0YNreprubOjTWU/WA5Ic
	O2/Bhl0Fk2yy9Fg4fpTJTnx3cTY4drj0BzT/9GM90s8jXw525QbLiISRzKh5a1YA3mIOTY2zobAzb
	JJHaszDK3sPmdkAnM2uA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIVKi-0006RQ-3S; Thu, 10 Oct 2019 10:06:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIVKf-0006Qv-Nh
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 10:06:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EA25668C65; Thu, 10 Oct 2019 12:06:02 +0200 (CEST)
Date: Thu, 10 Oct 2019 12:06:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v9 11/12] block: call blk_account_io_start() in
 blk_execute_rq_nowait()
Message-ID: <20191010100602.GB27209@lst.de>
References: <20191009192530.13079-1-logang@deltatee.com>
 <20191009192530.13079-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-13-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_030605_919535_798D4964 
X-CRM114-Status: UNSURE (   7.22  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 09, 2019 at 01:25:29PM -0600, Logan Gunthorpe wrote:
> All existing users of blk_execute_rq[_nowait]() are for passthrough
> commands and will thus be rejected by blk_do_io_stat().
> 
> This allows passthrough requests to opt-in to IO accounting by setting
> RQF_IO_STAT.

This kinda goes along with the previous patch, so I suggest you
merge them.  I also think you just want to send that merged patch off
directly to Jens ASAP.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
