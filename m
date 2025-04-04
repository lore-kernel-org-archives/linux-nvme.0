Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1CDC36010
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YRJ2txO/2Fn0ZqqJA/GggYGUGFSmyPMRNVvrdDHJdZY=; b=ftsN10zR/tfnvWW9nOWJmWkReg
	mH7v1v1RpgVm7qPgydFr7wcndzHFu+13sfZwxusH33OeC2MyaL705FqknYYvix4mtuuMzz7b9f/B+
	UYeNBCbntOrHyVreoYlt3ZjZGNmPevcad25iF8FU64WJ00j8vmFAms9nUHxSNDfAFCH/cwgExobqJ
	3/Xn4Q6IGIOS93/biW3lukYsSIm7/5+AV8liX6kEgNuLgz0tgrjQez/DAEsCYUEHsdlBs/6Taodlr
	QwxkoAsBycXf+y8qzQGpYmZ8kiFiaq39/emjhyR8sOnHgdCZIIZABJIkVlm5ESD00N6tl8kTdy6z8
	n4qsMO5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aPh-0000000ArOq-2C29;
	Fri, 04 Apr 2025 06:20:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aOe-0000000ArLf-392r
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 06:19:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF8D568B05; Fri,  4 Apr 2025 08:19:15 +0200 (CEST)
Date: Fri, 4 Apr 2025 08:19:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] nvmet: improve 'read-only' handling
Message-ID: <20250404061915.GA31468@lst.de>
References: <20250403144747.43043-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403144747.43043-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_231920_933856_20ABD011 
X-CRM114-Status: GOOD (  12.47  )
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

On Thu, Apr 03, 2025 at 04:47:45PM +0200, Hannes Reinecke wrote:
> Hi all,
> 
> there was a request (Hi Lennart)

which Lennart?  There's none on Cc.  Not that it really matters, but
I'd love to hear a bit more about the use case.


