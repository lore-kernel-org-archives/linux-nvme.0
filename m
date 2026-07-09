Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55578C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CTrJNv+WSnSf3dMMDFzB2Ky8GMjq6SPTdnrMRMwgJ8M=; b=rIn2uttiddYUguY1NmY6bG5Qgu
	GsgZPUDtpNSuccAM1xrcTROsACSAw7UWXDu/NnTbeyeim16hx0U1bFR2puoMkJLdn0UwRgOoIb0G1
	oFQzDNcI/rhIl4pfii9qT58UzJtKrXV/gPSivjlYqGGllrfLvIwyuJrxv9R7JgGKwyXZZtKyOfcHc
	aKy8ElO1bhUgKbDnA9YsC6rv0Zzr+E1E795qW+XG2pc1qP5xDgQjfnyj9v9Cn78vOgnJQcJaRnfL5
	z/GWc8se3J5ZfRYlwHis24iXxOc2nCu9mKW3bLb+GbnXRPUcogSg+/SgAzbjyhar5okFdgVYFlwse
	sM6ppQ2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiGT-00000001AM9-0x92;
	Thu, 09 Jul 2026 06:29:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiGQ-00000001ALV-0sWp
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:29:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A56E168BFE; Thu,  9 Jul 2026 08:29:35 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:29:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v3 09/18] list: introduce LIST_HEAD_GUARDED
Message-ID: <20260709062935.GB18056@lst.de>
References: <20260706141452.3008233-1-nilay@linux.ibm.com> <20260706141452.3008233-10-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706141452.3008233-10-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_232938_394022_9FCCE6D1 
X-CRM114-Status: GOOD (  11.25  )
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

On Mon, Jul 06, 2026 at 07:44:11PM +0530, Nilay Shroff wrote:
> Introduce LIST_HEAD_GUARDED(name, lock) to define a struct list_head
> annotated with __guarded_by(lock). This provides a convenient shorthand
> for defining lock-protected list heads and allows compiler context
> analysis to validate accesses to the list against the associated lock.
> 
> The new helper also reduces boilerplate and improves consistency across
> callers that annotate struct list_head objects with __guarded_by().

Please put out of subsystem patches to the front of the series.
And maybe send it off separately to Linus and the usual suspects to
see if we can sneak it into 7.2 to make the dependencies easier.


