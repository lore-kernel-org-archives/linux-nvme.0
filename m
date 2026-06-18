Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E2FCD98F0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2026 21:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MHeE9gSz/1T0NL4o3NPZo9mrwnldmtumUWG12dasCNU=; b=ctKUSU1xqyOAngECfqgvUe/ql7
	qEirALIArbTTh9HBWaXXZJCQH+rRZQbTbQtV6jm4tDOOLue6lp7qfc2Ie9SRz+nKSJpmJGh7ggO/3
	8RE4xvklgAzVBdtDT4Adk6n9GKm2dPn+8LpZmnxFWH1Ll/cAC8OM13LAo6lYTXTD/GvISsurFs+mx
	p5lBWJZ9TQGxMXAzIEDNZfVg+FayUwvMjBQhu8scUSycgT+W3yQejXkRJ+ei6FeCPQd7EWJtrUlaU
	tI6qCb4NeYo5+5hCWchATcMlsXlpuA14T7IFblWnFkEoNtSygSludA/GEojaQy4En7tD5AJB8s+Ux
	B5bvsP1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waKi5-00000001oyD-39gm;
	Thu, 18 Jun 2026 21:55:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waKi4-00000001oxy-0hCI
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jun 2026 21:55:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4AA41601E1;
	Thu, 18 Jun 2026 21:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1BF1F000E9;
	Thu, 18 Jun 2026 21:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781819739;
	bh=MHeE9gSz/1T0NL4o3NPZo9mrwnldmtumUWG12dasCNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LaZdDqJQFQM/+fHlbtHBfljdpJ2L9v4z6KKjR0sTW4MM8+0CQwn4aUgC3JMpBj2/S
	 TCXsVgv9SzdCQNP/151G3Nsmkf1OUXgvmaSNSk6Dme77MgB3E2+KDAqSwJYhWKlBod
	 WYAxzqrrSIe8+hLeh26LqNvgUwYOKHnHXnP3ZGJQ5Rq8lAP2T7zpPzXFW9jM07Bpox
	 Ok8wfSBnn+jaOAvUEXcvpYqKYFDl4WEAZjhugZW+Pm0Ik+LS5ByGzMfk8IUFOLwDQL
	 +5NiRdD+r4h5q4aZNAm/Iy+5i1e7RvHuvNEKCgGlMHyxikj883bDpg+JZQXzvaCCil
	 EXrsUDbQvs+zw==
Date: Thu, 18 Jun 2026 15:55:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>,
	Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de,
	chaitanyak@nvidia.com, bvanassche@acm.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	James.Bottomley@hansenpartnership.com, emilne@redhat.com,
	bgurney@redhat.com
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during
 async scan
Message-ID: <ajRpWLqaEyA6cwkJ@kbusch-mbp>
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp>
 <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
 <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
 <aaCNtpPzP9TIDNjE@kbusch-mbp>
 <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
 <aaXE4s3AT45UIAN8@kbusch-mbp>
 <DJBICZU143X2.3S261SDT21N0V@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJBICZU143X2.3S261SDT21N0V@arkamax.eu>
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

On Wed, Jun 17, 2026 at 07:41:58PM +0200, Maurizio Lombardi wrote:
> Did you manage to find a solution for this race?
> I just wanted to check whether you had any patches ready for testing since
> this discussion.

At last month's LSFMM, I heard concerns that this would break something.
I don't remember the specifics as I wasn't trying to push the issue. I
think this feedback was from the more fabrics focused folks, maybe Randy
Jennings, Nilay Shroff or John Meneghini remembers?

