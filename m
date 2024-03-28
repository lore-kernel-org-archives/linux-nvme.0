Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A01C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7091ojoqPYHRA8GyhRTro+BjuwGArgUNnpzQ08TaQqM=; b=4u0lxhVq+XzELS7YWbpwMfLZOO
	alqEIpvMuihP3F/Ui7J6ADbeUiD9kj2VhFoYfzmWVbsYbjnUhwD0hHUFh1fucKzvBf81eNz9zZq7m
	F0R5vb//vG6nKY8FTDCJdA2PY4QcAXgfxNRAwCW233DTGoQXGh1PkrpNcbqbHxnB3ynkEvc45TcLe
	AzDA3lB7gBn4cIisOFrKpB7TGPrpqTCUIbaCZFLPqtIEjt6F8e304+ACgc7an/mAZyN7PxDylPsnn
	k6+UZ9sz4g4uzJ71AagZfUgt/XD+Li67KncJlS+GDNr+tTQlKosB9dt6bDc7noa4US4/a4IQH8mid
	moVILaLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjzS-0000000CpH6-42H0;
	Thu, 28 Mar 2024 07:15:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjzQ-0000000CpGE-3WKa
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 07:15:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65B7768B05; Thu, 28 Mar 2024 08:15:52 +0100 (CET)
Date: Thu, 28 Mar 2024 08:15:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@fb.com, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node
 and print error
Message-ID: <20240328071552.GA18319@lst.de>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_001557_036909_28257037 
X-CRM114-Status: GOOD (  11.88  )
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

On Thu, Mar 28, 2024 at 12:00:07PM +0530, Nilay Shroff wrote:
> One of namespaces has zero disk capacity:
> 
> # nvme id-ns /dev/nvme0 -n 0x3
> NVME Identify Namespace 3:
> nsze    : 0
> ncap    : 0
> nuse    : 0
> nsfeat  : 0x14
> nlbaf   : 4
> flbas   : 0
> <snip>

How can you have a namespace with a zero capacity?  NCAP is used
as the check for legacy pre-ns scan controllers to check that
the namespace exists.


