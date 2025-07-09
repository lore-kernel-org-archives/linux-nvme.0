Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C76CC83F18
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jul 2025 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yi/9ek0bfuJ0ISD7IWW6asauruMF1n3pph+0xqar/GU=; b=CZa9Sp4K/LNVUB29ea84dn3sHt
	rUrgZMEj2DJ0x9WgDYS7y6aYRNapFA05li6CsMHaUO9ffPH1mga7NEfdZxTrSUe+I3FY+76IL4wxa
	S0R3mNEY+q4p25SXAl1515D6isWcVa7z9Jddr1sHguA+1UnunZ+p4oL5f/9KPZv3JgdKWg36WasVl
	OKgDITOn9JJ9rOjB7qfW5SN8WwY9MJSILMWLtlXvalkhDrDHPq9dxTRAkrAzQo72sDdzkW0V3qKlV
	TwHg8iiZNRKous+QuQkYTK+KA/Ik6gganndjkEGG1B6Ex2Xy6xhi7moBQN4CKxJTeXsNtiW5B3uZn
	cI86t1/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZdjE-0000000AA8x-2ald;
	Wed, 09 Jul 2025 22:57:28 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZcLH-00000009v9d-3yEq
	for linux-nvme@lists.infradead.org;
	Wed, 09 Jul 2025 21:28:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AEF08A549A7;
	Wed,  9 Jul 2025 21:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F87C4CEEF;
	Wed,  9 Jul 2025 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752096516;
	bh=wNZ6tpULyKOfLHD6cEnCg3swBF1wqgutcSf6Roj3i5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7V/AtxhfKuY+hmTibOnZVi3aYorjjKV1Wb53XJ9sWnQH9v4b1wwBZSd/HodTxjAm
	 K402hAqsr5SjDZ/9SMAgsKKVxCeTB0eJc27oXUuhAcNSYSaMqfBVapIZQzS44EFS7T
	 vZugE/kwtZSYEgS75xrtdkPVq0BV2tjf2uxTCUvi1NdDUrT6hqAuGU+wya/aq0TPrW
	 TyryBsVKA1OnTHxR7STLZyUWwgNkmLXEkNUpECzFwSOCGcWXSDoW+09x+sjCLPTNVO
	 6cWWCSBQfT0B+y7HXD7RUi5SmWPBCNvhg7tWOnHhehIclnul5QNWoZKcGuFRY34b/5
	 FbNq8hrkkpCgg==
Date: Wed, 9 Jul 2025 15:28:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aG7fArgdSWIjXcp9@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_142840_052287_DEEBDD3F 
X-CRM114-Status: GOOD (  16.94  )
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

On Wed, Jul 09, 2025 at 01:21:17PM +0530, Nilay Shroff wrote:
> I believe there are multi-controller NVMe disks in the field (including the 
> one I have) that do not exhibit such inconsistencies, i.e., they report a
> consistent AWUPF value across controllers and do not change it based on 
> namespace format. The NVMe specification states this (quoting it from 
> NVM-Command-Set-Specification-1.0e):
> 
> "The values (referencing AWUPF / AWUN) reported in the Identify Controller
> data structure are valid across all namespaces with any supported namespace
> format, forming a baseline value that is guaranteed not to change."

I don't think that's a backward compatible requirement. Controllers
often rescale these after a format command, and it was the only way for
1.0 and 1.1 controllers to report atomic sizes.

Lets say the controller can do 128k byte atomic writes, If all
namespaces used 512b LBA format, then AWUPF would be 255. If you change
one namespace format to 4k, AWUPF scales down to 31, yielding a
sub-optimal result for all the other namespaces.

> While the spec doesn´t explicitly require that AWUPF be consistent across
> controllers within the same subsystem, it seems to be implied. That said,
> I agree this should have been stated explicitly in the specification.

Considering multi-controller subsystems, some controllers might have
namespaces with only 512b formats attached, and other controllers might
have some 4k mixed in, so then they can't all consistently report the
desired AWUPF value. They'd have to just scale AWUPF based on the
largest sector size supported. Which I guess is what the current wording
is guiding toward, but that just suggests host drivers disregard the
value and use NAWUPF instead. So still option III.

