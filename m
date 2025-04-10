Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409C3C369A8
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A9s/0HnqafOx07Fz15kXpOSKUp4xRZizAtqJnGFKnuA=; b=wIxH50140+1+K51CH8JH0yfiTG
	h/TRUVgfdiP2joN3c5uUNfUguslGSJ8AoHFLmM1nlpcb7ijhpLkRwZp68tdaGXneWe/NwUbZu/9xw
	g/tQSQhQmVRU6qZnz01xidADoDMDuCGUqQISGrz0ecBWJz+k5MlfT8di1W0+0QZ2h6svYwhX96jzn
	y5/jxx+I0GG/yphhaE7nxxAQb6rJ6B/qtOOm6OkQjZWvfSeOZm4UnGtZR/kg7T/v963BHZyyMflpG
	FErjw+eFc6/ZRWMpNbmjpVYHwqNWkWg6x/m+yZtDICYUcgC/LfsNUWw3Z98sKpxiN3w2B5zWsMU84
	6VUS03dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nc3-00000009oMm-3Juc;
	Thu, 10 Apr 2025 08:50:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nDW-00000009jWr-43B4
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 08:25:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4F7C45C552F;
	Thu, 10 Apr 2025 08:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122F0C4CEDD;
	Thu, 10 Apr 2025 08:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744273498;
	bh=9AImfWdmKp7mOZY/XE/n6nopo7izjA29N5eUNDIYqIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loFnklZQcJi/REocGCeI6cCy84RW3grjlmSOar8uvHZgOyr6mwy62+qXBLKZD7Tvw
	 kSBAyC6NFRKtU7CrZA/2Xa24I0n0ffGm9UQfni42/i2ehcT3E+NxID5bp4VEJSytom
	 DGdAO4n5NH3SHS12Y3uaCMoIdKTMWuLVOrKColg7vUycMNd2pb2oMfI4KrYiebJFAq
	 /91wHH38BrXKrQlOwdbUASUac+tVDs0fGtycdTyJPgJblwSigyiMiJStAhQD5hQbAc
	 hweFBceEntqhCac7epUWH884Wu259TIfJxbywbEsLEzSLfD6fYWYAloNzOBEzClj3O
	 g+PAMRd/pp+Rw==
Date: Thu, 10 Apr 2025 09:24:54 +0100
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvmet: pci-epf: Always fully initialize completion
 entries
Message-ID: <Z_eAViyjhh1saaP7@kbusch-mbp>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408024733.690966-2-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_012459_041725_225756C0 
X-CRM114-Status: GOOD (  12.43  )
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

On Tue, Apr 08, 2025 at 11:47:31AM +0900, Damien Le Moal wrote:
> For a command that is normally processed through the command request
> execute() function, the completion entry for the command is initialized
> by __nvmet_req_complete() and nvmet_pci_epf_cq_work() only needs to set
> the status field and the phase of the completion entry before posting
> the entry to the completion queue.
> 
> However, for commands that are failed due to an internal error (e.g. the
> command data buffer allocation fails), the command request execute()
> function is not called and __nvmet_req_complete() is never executed for
> the command, leaving the command completion entry uninitialized. For
> such command failed before calling req->execute(), the host ends up
> seeing completion entries with an invalid submission queue ID and
> command ID.
> 
> Avoid such issue by always fully initilizing a command completion entry
> in nvmet_pci_epf_cq_work(), setting the entry submission queue ID and
> command ID.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

