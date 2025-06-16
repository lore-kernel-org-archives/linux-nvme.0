Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA868C71136
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 05:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bmC8JA00p8+7bkJ2T63nqXzyf4E+SWNM8tyCiZ914sM=; b=ZoLUOXGp90kR21f9WOuPVaUS+B
	W7PQoHX6/5A21GSnyxTD2Ij7A7cOaOeDCO2HkvH0hq1lFs3kL2mPgpJhXBpqDMbA2s+LyywxDBqqe
	ZDrlNY5Kav1JQb/J0x7TSPvGPXTxIncGpT3s1rs6i8x2TepHUa6zUGQLtuyyVSqsysajcVrL8es+p
	4dnRnWHeSP1/q5nhR79ltPI7mmON1AEjcIGOU8TcxJvBflIvRYVLtVeKxE6PP06GSt8c/BYGqS6bb
	xdi6dDKZSrLjiZKMlRkwfJtVHHCvZ1/1QjLqELzEs7Kx/MHfVqV25KVQnh1Gtp7BwQfqijnVqhX3f
	a/UZSFdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR2WI-00000003RJs-0gW7;
	Mon, 16 Jun 2025 05:36:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR2WF-00000003RJX-2OtN
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 05:36:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9FD3168BFE; Mon, 16 Jun 2025 07:36:27 +0200 (CEST)
Date: Mon, 16 Jun 2025 07:36:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: fix atomic limits check
Message-ID: <20250616053627.GF1148@lst.de>
References: <20250611055432.2401372-1-hch@lst.de> <99248994-4d8d-4d84-9279-b657d6969aa0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99248994-4d8d-4d84-9279-b657d6969aa0@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250615_223631_770932_784469A4 
X-CRM114-Status: GOOD (  15.88  )
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

On Fri, Jun 13, 2025 at 02:22:00PM -0700, alan.adamson@oracle.com wrote:
> Some testing with my qemu-nvme atomic write setup.  My qemu includes ns 
> atomic parameters that isn't upstream yet.

> A single subsystem with 4 controllers, 1 of the controllers has 2 
> namespaces.

.. and none of the namespaces are shared if I parse the command line
right?

> Does this look right?

I think it does, at least if I understand the setup correctly.

> Before, we had a single atomic_write_max_bytes value per subsystem.  
> That's not the case now.

Yes, with AWUPF the value should be different for namespaces with
different LBA sizes, and with NAWUPF it could be different per namespaces.

Maybe we want an extra sanity check to catch a subsystem reporting
differnet NAWUPF for the same namespace attached to multiple controllers,
even if that's against the spec.

And I wonder how we can come up with a testcase to validate all these
checks..


