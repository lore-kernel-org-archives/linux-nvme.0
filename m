Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDB1C25B79
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 02:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Un8QUR/OoDAegeOGSZU2tmkAkH/Qfnn42zoBkjHSFWQ=; b=lVkEhOvlOBL7IvADNaP4Gk/eAe
	4TAn/t5dOCTlDADOw30TysUul8yVVBnTuTwJZT0anxceF8B0bWO+HO46MF+02lVOTEIDbqkyb5VBp
	etdVG94Xs4mBC1gkOQZeL9T1zOf16fwTfe5hutGg7+aaJ2nZgTkPIum6f3I/W3oeJCJoLJJUULHys
	zdP7bM7zUblEwpwHZJ+ddLr+1D9TAl/DaVYqsjLiVtsfElOcseslJvCUh9e2cqAnq1ON/zLND3NV2
	3oN3be0tF1cm68DlA0fbKV1f4yGWRAsPpMlvG9gMqLdpeazVSmRX+nl5T/Rb3L2dUNbABPD9lmUkg
	FFo/I9tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9FIZ-0000000G4EG-0dUv;
	Tue, 21 May 2024 02:32:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9FIW-0000000G4Do-1NUq
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 02:32:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716258734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Un8QUR/OoDAegeOGSZU2tmkAkH/Qfnn42zoBkjHSFWQ=;
	b=Gf5PrZGoWX6X/nkX0tv8r7JgdUx65eyQd6v2S03HVsCLbvjDHCXaYhwe74m0qYhpeM43FB
	4hTUK3QuTF8tQ7v3LSBKhsQG6oIfXN85hrB+OEQVHXKdiL+mkfZCeHTEnIek8vm+wDHfsW
	pdmCaWgTbXtJEkQR8lY3UQG63BbTiBA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-jxA6zLjfPNq6lOlyTHTqrw-1; Mon,
 20 May 2024 22:32:10 -0400
X-MC-Unique: jxA6zLjfPNq6lOlyTHTqrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C6CA29AA39D;
	Tue, 21 May 2024 02:32:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 91A8D100B0C0;
	Tue, 21 May 2024 02:32:04 +0000 (UTC)
Date: Tue, 21 May 2024 10:31:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <ZkwHnw6HkGFFq7mR@fedora>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
 <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
 <87r0e7mt9w.ffs@tglx>
 <20240520153742.GB921@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520153742.GB921@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_193216_460068_EC54886B 
X-CRM114-Status: GOOD (  16.78  )
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

On Mon, May 20, 2024 at 05:37:42PM +0200, Christoph Hellwig wrote:
> On Sun, May 12, 2024 at 08:35:55AM +0200, Thomas Gleixner wrote:
> > That's expected as you pin the I/O operation on the isolated CPUs which
> > in turn makes them use the per CPU queue.
> > 
> > The isolated CPUs are only excluded for device management interrupts,
> > but not for the affinity spread of the queues.
> 
> We'll probably need a version of isolcpus that also excludes the
> interrupt spread given that users are asking for it.  And I'd much
> prefer that over adding radom module options to every driver to disable
> managed interrupts.

BTW, isolcpus has been marked as deprecated, and it can't be adjust
runtime.

isolcpus=	[KNL,SMP,ISOL] Isolate a given set of CPUs from disturbance.
			[Deprecated - use cpusets instead]



Thanks, 
Ming


