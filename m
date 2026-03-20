Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BD51093182
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qPXaBFYyeNdQRjjOfifm//mmyNXwt1mHjdUkJvzUmZ4=; b=Q2dRIl19EFFtsUlhFDPE3CH5vm
	A3ReinbccwVGN5k1DN3muvqQ6Mp2JOTlh6Dn+mMEooQjyofdpeWGLnNba7cFZiHJdNMV/gpYS4eaP
	NgofF+npa2nXgOI1QaDARD0u8MhxdTdjtFBJmwc1QUIzfFJCxCFRnTKkhuwsh0k4pYCM+b6+UuyxW
	HiHyIsIZgUZnb1slK47QoWvE+2lgZSvKGXp3euEYVAA5y8tQZ67KhbHTBdjp0T6aL6t1no8jaCWF5
	CmcvVJd83gl3jZHC331xskdj7RV5RIISAReqK1sDpM9d5LwCU8qBE6NqyaQvnzgCXYcuwtsaXfeYK
	SqE4zvtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Uat-0000000CHoQ-18eH;
	Fri, 20 Mar 2026 07:48:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Uar-0000000CHo6-0SoR
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 07:48:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D95826732A; Fri, 20 Mar 2026 08:48:25 +0100 (CET)
Date: Fri, 20 Mar 2026 08:48:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>, gregkh@linuxfoundation.org,
	security@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: bound sgl->length check in
 nvmet_tcp_map_data()
Message-ID: <20260320074825.GB14485@lst.de>
References: <2026031805-stretch-skid-ae5b@gregkh> <20260319012630.1802025-1-kumar.shivam43666@gmail.com> <DH6LLP692EBM.4N82LTNB60WV@arkamax.eu> <CA+ysrSLau_52n+4JMvQ=EtqY-cyWhhZ_pLOyeNL=mwkjkNvoUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ysrSLau_52n+4JMvQ=EtqY-cyWhhZ_pLOyeNL=mwkjkNvoUw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_004829_344519_E0C5CED4 
X-CRM114-Status: GOOD (  13.00  )
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

On Thu, Mar 19, 2026 at 02:00:27PM -0400, Shivam Kumar wrote:
> Hi Maurizio
> 
> Thank you for the review. You're right, I was conflating the per-PDU
> H2CData limit with the total transfer size for the command.
> And the error handling should trigger a fatal transport error rather
> than completing the request with an NVMe status code.
> 
> Would setting a sane default for MDTS be the preferred approach here?
> If so, I'm happy to send a v2 implementing that instead.

Yes, if we want to limit the I/O size we have to limit MDTS.  Which all
other transports do anyway, so I'm kinda surprised TCP doesn't.


