Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736A6C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ly7U3gXy+gVasbGPL0oG6S//IwI5mlzZZDgIJdDTmEg=; b=2oWb2Y1crBPR4h+4EIjPWv79ve
	lCNnFp4n9PzmFGzG8fO6/+07xXlIvaR6/akEfgdKsDO3go8oZdLursoQHNL+bCTst8sUrFMgeyK1v
	WuQOrIxj7EoI+epJXDF1KWNgoc/U4iLmokn10XOcbZYrzwL8UNBx0Psa7OeYgfoLhpfo03R8SaUs8
	70DIE/3bsb3jHTxj5i50u8QZM69x0pUdWqpZQXP7LmjXbiiMXujhRUjh6n/KSajAiIbntXZAiYPjc
	sx9TvPOYpv23ZzLg0btlFY5NRegnpPxzo9/lnEkRQmE1W81gwvpcFGLjD3WBU/zHJMIHxZhdDB7U2
	BuodMm0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxUab-003aCt-1b;
	Mon, 30 Oct 2023 15:54:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxUaY-003aCU-14
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 15:54:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A78141F7AB;
	Mon, 30 Oct 2023 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698681239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly7U3gXy+gVasbGPL0oG6S//IwI5mlzZZDgIJdDTmEg=;
	b=QvYigMZnkoK+WcoSWXuNn9sXNyEZuH3kts/4Q+DDXuTKZWF17J7FYrUpFvUG7iSeOBpna6
	H28cLmdy60gAFguUnFCSGOs88Jk+eMJDTn60drV5nLvE1jZM6iGqETkVdxhUZWoR7I7cW9
	/XXj/O5CS+u4zMnXpKq0d+mm9FtMIw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698681239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly7U3gXy+gVasbGPL0oG6S//IwI5mlzZZDgIJdDTmEg=;
	b=7UZw7RKFU/RHBOBOPdUn/vXDv+6XQwfjnHnV0lN0bADrewh25+LF5bWxilbbBh/VUYv0ul
	KPGvtnL2yx8vQkAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9763A138EF;
	Mon, 30 Oct 2023 15:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +7fKJJfRP2WueQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 30 Oct 2023 15:53:59 +0000
Date: Mon, 30 Oct 2023 16:55:35 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>, 
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v2] nvme: update firmware version after commit
Message-ID: <6xstp2bsrdrrcosddk7jcwdvcojek2b7njqqjw2cggl5f7xpuo@etrfki4orlwy>
References: <20231013163420.3097-1-dwagner@suse.de>
 <ZSlzxGx8k9pgkhDk@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSlzxGx8k9pgkhDk@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_085402_514377_78923E6E 
X-CRM114-Status: GOOD (  11.28  )
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

On Fri, Oct 13, 2023 at 10:43:48AM -0600, Keith Busch wrote:
> On Fri, Oct 13, 2023 at 06:34:20PM +0200, Daniel Wagner wrote:
> >  	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_NVM,
> > -			log, sizeof(*log), 0))
> > +			 log, sizeof(*log), 0)) {
> >  		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
> > +		goto out_free_log;
> > +	}
> > +
> > +	afi = le64_to_cpu(log->afi);
> > +	if (afi & 0x30) {
> 
> That should be 'afi & 0x70'.

I've update the patch accordingly and send Kenij and one of our customer
to test it.

