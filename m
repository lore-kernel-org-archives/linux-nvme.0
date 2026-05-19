Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48B1CD4F57
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UmSipEw3DKI1cD/dJKRPNB00iEPargDN8m8Wa8XhwbI=; b=Yu39anqXyvxTni2WXA7eYPbLMz
	3jste88DpejgRIhVr08rMQxVgJW1FEW+cAmmrKo2AGykq1XrXoXfvezkPuzhfuZqmb9jEZOO22Zs0
	rtCUNqVbtjRWJChk5LemyPAF7qP+ZmihBG05FhJ3uvDVFhu9mwrc4q3qFIW/HBA773B++g7kIeikm
	L4FMulck9/Aufp9RDhVyQ+GOBya7XkR2+R9IKBTmzREcm7Mlmamz2U0S4NR+yUPdV2j8ggZ8/MqXm
	8kjJj1IPvVY6sdtmuH9DXFpIk0TKxO2fPao8Ax34Cu5d1W3oAstQu0B8dhtsspVtyFPcyJ+6XOy8F
	G+OLxBCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPJ3q-00000001OTy-05JR;
	Tue, 19 May 2026 11:56:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPJ3n-00000001OSn-0fh0
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 11:56:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1CD868D05; Tue, 19 May 2026 13:56:24 +0200 (CEST)
Date: Tue, 19 May 2026 13:56:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Hannes Reinecke <hare@suse.de>, Maurizio Lombardi <mlombard@redhat.com>,
	kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mkhalfella@purestorage.com, chaitanyak@nvidia.com,
	hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V5 7/7] nvme-core: warn on allocating admin tag set
 with existing queue
Message-ID: <20260519115624.GA31422@lst.de>
References: <20260514083255.41109-1-mlombard@redhat.com> <20260514083255.41109-8-mlombard@redhat.com> <9776f677-df3d-4258-90af-ea464f8cfca8@suse.de> <DIMJT6826UO7.5S1W29JK9I7D@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIMJT6826UO7.5S1W29JK9I7D@arkamax.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_045631_343614_8E3B0C02 
X-CRM114-Status: GOOD (  15.54  )
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

On Tue, May 19, 2026 at 11:33:28AM +0200, Maurizio Lombardi wrote:
> >> +	WARN_ON_ONCE(ctrl->admin_q);
> >>   
> >>   	ctrl->admin_q = blk_mq_alloc_queue(set, NULL, NULL);
> >>   	if (IS_ERR(ctrl->admin_q)) {
> >
> > Why don't you return an error here?
> > The WARN_ON() now introduces a memory leak (at best); I'd rather
> > not do that here as we can easily recover here.
> 
> Ok if I just do the following?
> 
> if (WARN_ON_ONCE(ctrl->admin_q))
> 	blk_put_queue(ctrl->admin_q);

No, please keep it as is.  The whole point of the WARN_ON is that
it should catch impossible conditions.  Leaking a reference is the
least of our problems when it triggers.


