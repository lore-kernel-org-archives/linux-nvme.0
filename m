Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EC2CFC5E2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YbWnMgdjL7PL9Vvu/TqawEabNVh6+KGm4jHURWePAP8=; b=B+hPGsnk0yN7RyWqUMFUyqjHQX
	wYA86cQti7R/S0phTpup6POH8kkH6oTEPxaGss+Vzf46+ha1xoRZenlmE0anHgB63rGSbmYjmXNPQ
	uGpFPphusLmdyxopgbC4aJ8YVUupB47Ld+D8H7RLuibncLrKwDjJRRkScASi6oGh70ksqKZ51NSU2
	e+M0jVspnXOAviGmAONFt1qfBL88BTOXQvtQI6g/IN6jgCZPsvWYj5AHVMc2jJB0pcXKNBcpYB+Qj
	0uehmWoyroywThFKlM6wve+A/Lk1qc2OCUcf0M7HbDC3CvdsavFsha5NQKeoUC7V7V+I0wW+uWtmJ
	lyWDpJ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syw86-0000000DXy1-10hG;
	Thu, 10 Oct 2024 16:35:10 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syvqW-0000000DUXS-2buJ
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 16:17:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1329DA44BA0;
	Thu, 10 Oct 2024 16:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7672DC4CED0;
	Thu, 10 Oct 2024 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577018;
	bh=O1qoxjo9AINaGF98jsPXLm4EAhwXf3dSg8csuLl8gu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgGsmUID+TmWd5DEjZbbRvyaqjQVpPcGGnibvgolmppBD4Ss1A3CDgnYhvFPK8pLz
	 FD0arHQknyGJnysSkWpBM5o7ZGMew06CCEOu0jsc3rpWjAl3gzz6YB9uc3O33z0n+B
	 DM0tPIsxPIf6oeFJQoFGjxietjZ6yc4kEPa5etZUbSYz95XJUD+cHR4xcxvbUjTOVt
	 tjrYlAHsXbrQCQpOs7gt6ggw3Nccvs4kmzz9E8j7dsi2eWD+GmsbmZREnQWwWtN/Ys
	 LnwNXtsg6iBoGYSDjj3QOBIMgb1zZ8CBgZ0tyPK1Xxu8V+WuMa6ee2AVuCNhYt78ud
	 5W2OTMyhjeBcw==
Date: Thu, 10 Oct 2024 10:16:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Greg Joyce <gjoyce@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
	jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com
Subject: Re: [PATCH v2 1/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
Message-ID: <Zwf99zAv0mqRnVTB@kbusch-mbp>
References: <20241007193324.5846-1-gjoyce@linux.ibm.com>
 <20241007193324.5846-2-gjoyce@linux.ibm.com>
 <Zwb98YIioIGRAQBe@kbusch-mbp>
 <d82996a73ba89098bbf2b61733849633612c090a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d82996a73ba89098bbf2b61733849633612c090a.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_091700_744632_97DE574C 
X-CRM114-Status: GOOD (  19.16  )
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

On Thu, Oct 10, 2024 at 11:11:43AM -0500, Greg Joyce wrote:
> On Wed, 2024-10-09 at 16:04 -0600, Keith Busch wrote:
> > On Mon, Oct 07, 2024 at 02:33:24PM -0500, gjoyce@linux.ibm.com wrote:
> > > +	/*
> > > +	 * Setting CRIME results in CSTS.RDY before the media is
> > > ready. This
> > > +	 * make it possible for media related commands to return
> > > the error
> > > +	 * NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY. Until the driver
> > > is
> > > +	 * restructurade to handle retries, disable CC.CRIME.
> > > +	 */
> > > +	ctrl->ctrl_config &= ~NVME_CC_CRIME;
> > 
> > We could just delete this section entirely. Nothing else sets CRIME,
> > so
> > no need to explicitly clear it here. I guess it serves to provide a
> > place for the explanation, I think we can remove the flag setting
> > anyway.
> 
> I went back on forth on that. What I do like is that explicitly shows
> that CRIME is not being set and why. But you're right, it's really more
> of an elaborate comment. 
> 
> I have no problems with removing it. Would you like me to send a new
> patch?

Let's just leave it. It's already applied and I ought to send out the
next pull request soon. I did, however, fix the restructured spelling :)

