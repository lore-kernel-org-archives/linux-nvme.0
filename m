Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53F3C3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WlgI+yQziNGr/svlEe8KWJdXAFCKJ4ORmKspnNNNJ1I=; b=xONasShC7KAJHeJtN5TsdElEBp
	n/j/CkY+Qms5pT9mzmkNTk4oSTcq15Ykk/nlNjAEGBduVHG+u1z7W6HgNW7By1dMdMyeOUqLMhWe6
	rJG8BILASMin9JVcs4UVAeyltOBKZSyiUEslf4zQ32C7SbOCFL/x3O6djLM/PQjYzclaeows9DaF/
	d46mZEQkygXAHVixh3RMLmhFzjZXiQ3mtvTunHlM27e5KHTJbrboZtlNinHTjDTOi0V9J+oAd0Ftr
	nQLRza11m0HElL1hT51eJRIiz5WmzE1UPlhV6/WehRSN/gHaithWeHvMRsndz8qr2C2F0/q32mczr
	dKHL7Efg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFyEI-000000043Pa-0B9x;
	Fri, 16 May 2025 16:48:14 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFxpS-000000040XL-2Tty
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 16:22:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C95DBA4E9AC;
	Fri, 16 May 2025 16:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0B6C4CEEF;
	Fri, 16 May 2025 16:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747412553;
	bh=udKJhzxtc6yZ4WPwI+rX13SfMvkCpGhXug6JJUAQHis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tijm/cPEH+L3kjC2J9VNacRsSq7V6AAZFjFPqnIoIPFZxrarpj6ZBrJxu61LxG388
	 jvG0U+MzKdmDEq02gyzoL1zNG4yKIifzkICCzdt0+rSVlo0jfvAV0yE4pzIY0GwSor
	 6z6zIzO1PM5rOwE5JXvTz21fhL93K7/dUT4KUbNf1RQT/0fFdiCLJwah0Fqt54PIGW
	 8PyXbA/vYpWi5V9/+ICpe+zIQA8RcROJVAijj6P96EWZjJqlb9GwDUb5xeeVNa/X85
	 KnfaIG3eGxOOhbJ7VXDfj1YFz91iThVASK9UgIe1jXhm7oQ2Elx1v/HtzVVw3+nbdz
	 4w5F1Q8torLnQ==
Date: Fri, 16 May 2025 10:22:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	bgurney@redhat.com, mlombard@bsdbackstore.eu
Subject: Re: [RFC PATCH 0/1] enable quirks via module parameter
Message-ID: <aCdmR_5pzny8nptW@kbusch-mbp>
References: <20250516155025.44958-1-mlombard@redhat.com>
 <aCdgznvTZAJiPjM0@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCdgznvTZAJiPjM0@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_092234_699897_4B36036B 
X-CRM114-Status: GOOD (  16.74  )
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

On Fri, May 16, 2025 at 09:59:10AM -0600, Keith Busch wrote:
> On Fri, May 16, 2025 at 05:50:24PM +0200, Maurizio Lombardi wrote:
> > On some occasions, our customers have complained about misbehaving
> > NVMe devices. We had to compile and provide them
> > with a test kernel just to see if a quirk could resolve the issue.
> > 
> > What do you think about allowing users to enable or disable a
> > quirk via a module parameter, similar to how usbcore does it?
> 
> Can't we already do this for pci using the "new_id" attribute of the
> nvme-pci driver? It takes up to 7 parameters, the last one being the
> "driver_data", which is what we use to setup the quirks, and you can set
> that value to anything you want through that interface.

Oops, maybe not "anything you want", but you can set it to any value
that exists in the driver's table. That may be an unnecessary limitation
in the new_id_store() function, but let's see if that's sufficient
before considering changing that.

