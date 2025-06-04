Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D521AC61CE7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 08:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8TdChwZIMHRDgGcFW6bQ7Aol94TxXhErTTWlTjECR4=; b=pdrjxDU7mJTqETkOH6V4j7e7a0
	AT9nKHhy5HNbSrMVMjfL/2Uc1VLV/WK1ta9SyvWaZ/BCNWitYN9MbkekUbbslaqjONZb+htOa3Ma7
	cLf6jipisGKkUoQG5/IPwvX7XVIyEwD42DgkpY9lKg5oY8+PakR+x3gnXo2F7CKnSigUhpncWXE1l
	4YjyQBYAT+ZzBSTZcQ31cQtGc3FXyX4P8FcR23n6X933LVC5iiibjHQpv1aQ7dZ7RNmSXHvjV08gM
	+c54vx0gpKTIzgz/MBj0qlifFnaBGKD5CS1QSAClh9j5XOvED3y6uozxciUOxxpsw3IRFQZI3QS+S
	LYDLPk5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMjjv-0000000CvgF-1tvi;
	Wed, 04 Jun 2025 08:44:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMj9z-0000000Cqeo-2yNx
	for linux-nvme@lists.infradead.org;
	Wed, 04 Jun 2025 08:07:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4395F68D0D; Wed,  4 Jun 2025 10:07:37 +0200 (CEST)
Date: Wed, 4 Jun 2025 10:07:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Allow sending of admin commands to inaccessible
 paths
Message-ID: <20250604080737.GA15609@lst.de>
References: <20250530120142.130469-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530120142.130469-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_010743_891955_CF4BFF93 
X-CRM114-Status: GOOD (  13.15  )
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

On Fri, May 30, 2025 at 02:01:42PM +0200, Hannes Reinecke wrote:
> The NVMe Base Specification (Section 8.1.1.10) specifies that admin
> commands should not be affected by ANA states. So implement a function
> nvme_find_admin_path() to return the first non-disabled path irrespective
> of the ANA state.

Nothing in here explains why we'd want to support passthrough of admin
commans to inaccessible controllers.  What problems does this solve to
justify all the extra code?


