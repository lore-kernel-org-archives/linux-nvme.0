Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8E3C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YHwlFaPSVbLKKQb+IhbIFNNDjvUH1bqPX1asdjONo+k=; b=UEZLPc0PbVj0+6rUi4aJy5RdIF
	wClqPwc9bt9ZyjGNHbRKVBi10dHc+qsFEPB4dYpLzkersH3waJbWgvS6JrceD9K4lvIj/gTupvCfO
	hmGmRfhzrfjo6/Ts36qYGCCr63s2Gm5QsvFBEWEhHSiTE+ft1ky8hBxGNc3guJor7MQnKuUwNMQQm
	shig4wdDhKt5pbp/Z7n/PNdxu6J6ATYbE9CLm4qNSzqUhCJ9RTxAs5RNUNciXN+cXOoPcV2L1X+72
	GG8QGDtNCOgZI3R/7Cr9M13J50D++U3+w65pcPbYKAQ1UtYqk6UhkoktpOsYGMAhWo3DBkmafQfT5
	bW/0BftQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxS0C-008ki8-6w; Tue, 22 Nov 2022 12:03:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxS08-008kZb-Qj
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 12:03:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1EA7B68D05; Tue, 22 Nov 2022 13:03:34 +0100 (CET)
Date: Tue, 22 Nov 2022 13:03:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <20221122120333.GA3840@lst.de>
References: <20221116130104.2186334-1-hch@lst.de> <256d34ff-3979-9780-4426-6d913a3a9707@kernel.dk> <20221121074647.GD24507@lst.de> <Y3uazieJ5xRR8jg7@kbusch-mbp> <20221122064743.GA14698@lst.de> <a3bca9c6-f9d1-fd30-33c1-60ef00107997@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3bca9c6-f9d1-fd30-33c1-60ef00107997@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_040345_040073_AC9EB640 
X-CRM114-Status: GOOD (  14.38  )
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

On Tue, Nov 22, 2022 at 12:38:01PM +0200, Sagi Grimberg wrote:
> Maybe we should do the inverse?
> Whitelist what userspace is known to be allowed to do, and anything
> outside of that, we don't prevent but rather log a big fat log message
> that the driver behavior is unexpected?

Hmm, that list is for sure going to be a lot bigger..

