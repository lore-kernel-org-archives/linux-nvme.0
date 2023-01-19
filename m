Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC99C38142
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 08:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YsFHS9iuxImQzaqS3t502btvXcbtbNvOVsRzAS8hMtU=; b=PJG5iBT9yJ69HJOUJggM4gZheE
	k6WlqFJ0Ei5lIeIIlOR4eUgrXzEfNAbNaU156DxJ/ABc6Zle3ldvM3tgUpZNoLoCAVLnvedRCnPPh
	imQIVrHNDF4FbnL/FO0kj6BXDjMbbT48n0FXeOuF0FA1B9JyY5PZt0FZC0uRLPo7ls7wJDdoT8IQT
	P2QANoolMAPf5xEfNei2bPSRDuy0eTdJXvfK65c3Orjy5D3/HXfFiExphnFPJC9MYqo8lrLXTW0zY
	uhablwO7yOTz2UK3NbvNGvs/H0pOzQyfycvOXw6PYMNCcSgl4/njT2nXudXMu1ZKYkGIWl1ZFr5VA
	KYTcXl6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIPyh-0043PQ-T1; Thu, 19 Jan 2023 08:08:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIPyW-0043Eg-Hf; Thu, 19 Jan 2023 08:08:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4F0967373; Thu, 19 Jan 2023 09:08:39 +0100 (CET)
Date: Thu, 19 Jan 2023 09:08:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin marcan <marcan@marcan.st>
Cc: Christoph Hellwig <hch@lst.de>, Janne Grunau <j@jannau.net>,
	Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Eric Curtin <ecurtin@redhat.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-apple: Reset controller during shutdown
Message-ID: <20230119080839.GA24679@lst.de>
References: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net> <20230114-apple-nvme-suspend-fixes-v6.2-v2-1-9157bf633dba@jannau.net> <20230118052450.GA24742@lst.de> <20230119061452.GA17695@lst.de> <60A924B7-9F29-4AF1-9DF8-EA90DBA48B3E@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60A924B7-9F29-4AF1-9DF8-EA90DBA48B3E@marcan.st>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_000844_746213_473CE35E 
X-CRM114-Status: UNSURE (   7.84  )
X-CRM114-Notice: Please train this message.
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

Thanks, this looks good.  Updated commit here:

http://git.infradead.org/nvme.git/commitdiff/c06ba7b892a50b48522ad441a40053f483dfee9e

