Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8D8C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 06:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kPz/c0J/AfNRZ6xVbLFCmTSiS4LbsTdB6+SuKrwBbOg=; b=tCkFgqCwOKgSu6IZg5OVVoy75i
	1bMPX66btkYIms5dq4ca0fwLpHF3F6CltWl+FCsAAAP+sHANqQSAyZVPqlMz3fhYzage/zdkXoi1O
	S0W8c9jQPFj8bFMXQkGIUFkmhsDkClYGyMA6R+gQcEssaz2DJqjmguOq8c11NcH932X4z64MvdJeY
	gGT22+LJXaQxkR7ybcOftaI/99KGftUGyjbXF3XFFSyZ9xKmlVwmMbM+Wvan25I8FRPqMkkqhTmfO
	zRm6ush4aep7q8cn2iGt5Igyq51YUsmGgKRbiDkJsjdwjGYiFqTqXDalpzxY2d+BcMss/6M8f5RVz
	+gHoxp4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxN4T-0058KU-MG; Tue, 22 Nov 2022 06:47:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxN4N-0058HR-8r
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 06:47:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53AC568D05; Tue, 22 Nov 2022 07:47:43 +0100 (CET)
Date: Tue, 22 Nov 2022 07:47:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <20221122064743.GA14698@lst.de>
References: <20221116130104.2186334-1-hch@lst.de> <256d34ff-3979-9780-4426-6d913a3a9707@kernel.dk> <20221121074647.GD24507@lst.de> <Y3uazieJ5xRR8jg7@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3uazieJ5xRR8jg7@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_224747_473751_F81C02C4 
X-CRM114-Status: GOOD (  11.72  )
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

On Mon, Nov 21, 2022 at 08:35:42AM -0700, Keith Busch wrote:
> It's not like just anyone can do this kind of craziness. It's like a
> soft equivalent of pulling a cable. There are usually access
> restrictions for untrusted people.

Yes, there are.  But that doesn't change us having to deal with the
fallout.

