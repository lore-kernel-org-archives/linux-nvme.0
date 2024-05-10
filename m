Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB39C25B5F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DeMiFwdQ9QA/jJLjSySjLSHXkW9dTPsg8A2TY9fo14I=; b=ixQIAdbuMuJelgOPPn99Y7hm8c
	KA1sYD1zb+j1TDdARgnk1u12CDKowk5Jpv+zALbRb++QelEnHRwj6uu2QVGHjoG/uFG/YERw0jaQL
	kFt2mup0JV8rmD8liszKZ4UXBQecY/GU7CokIBvegjbpxL/TcZVUKVEESAIAobrNlGYb3GCLxBIPG
	Rc4EW+SGyhm/hrWaeUa4y92slsxS7w5uzu9TlP1ZZ9rByqKDRr4n6pgWGQnLc/FijBpHDX4sCC0I/
	j1lLn8h0hG5gwEI3q01m3im+VMcGOZWTEPod2ToLkGDVcuZvxz8YZRWdnlBTS19ZV7rBZd9k6VoDn
	Esmdu8KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Rto-00000005fUH-2ktn;
	Fri, 10 May 2024 15:11:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Rtl-00000005fPw-39lo
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 15:11:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67AA2227A87; Fri, 10 May 2024 17:10:47 +0200 (CEST)
Date: Fri, 10 May 2024 17:10:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, tglx@linutronix.de, ming.lei@redhat.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <20240510151047.GA10486@lst.de>
References: <20240510141459.3207725-1-kbusch@meta.com> <20240510141459.3207725-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510141459.3207725-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_081101_953409_89963B80 
X-CRM114-Status: GOOD (  10.02  )
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

On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some people _really_ want to control their interrupt affinity.

So let them argue why.  I'd rather have a really, really, really
good argument for this crap, and I'd like to hear it from the horses
mouth.


