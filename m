Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841B2C83F2C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kxL7juv5/sEpLVZRkPTB76RBwFoczrKMqzvZ2otKvu0=; b=KnSWJdnUVLOASZlfS8/cIUz36/
	94EZKG9s7RjrxXtkjOg5aX9Sc8OKuiMiNOvyvBmJU1SmyhqDF1DdVqlpCNhnJYYLRXHUrRMsa3N4n
	IkF54BDonqXAo3Pf2Et6nWLXq7tAdFPgEA04ooFhprpH/7xLacNUAPUiTYhMScopbXj8tG7XO44d0
	hRpZnCceq7k1SdKGxBbaZ576bvy4K6AGFrkEbgnPAT9FOx7YY2P7BqAoMXRYaijN/xCX8Tl7/5C6Z
	KUodvsjg9dRqRvTBhmjzmjpvPKvNCiy+ESMfqck2KCL/kVYr1jDtCPgAwZkxZLtjJ4Gub1KJnY9q3
	IYieABsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdTTU-005qKH-39;
	Tue, 05 Sep 2023 10:40:01 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdTTT-005qJd-00
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 10:40:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B13821850;
	Tue,  5 Sep 2023 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693910396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kxL7juv5/sEpLVZRkPTB76RBwFoczrKMqzvZ2otKvu0=;
	b=XvyS7ci+Gzc2tebs1hE88GngORss7gTKmhW0slYef07W1bL1VI0u+ufgxigHqt4nDa3pGe
	c3CzAwHWAmFufkIqifBvoaXPZWu27Hm4MMlDP2gJ2JTNskAYBfFI7SW2a6nVNlXrdA7u5v
	WTve5Qz17/XHghKmQhv06RMR9lp6QjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693910396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kxL7juv5/sEpLVZRkPTB76RBwFoczrKMqzvZ2otKvu0=;
	b=QC34U4AyZ9BeP1qTOWcLduVTYsgt9KWWFduofCBvYAg8JSL1XakmHLpQA8TV4ZuOt3ddF1
	2B6BwJ2rrm8hp+Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72B5713499;
	Tue,  5 Sep 2023 10:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cIhAG3wF92RiVwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 05 Sep 2023 10:39:56 +0000
Date: Tue, 5 Sep 2023 12:40:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-5-dwagner@suse.de>
 <20230905065032.GC19701@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905065032.GC19701@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_033959_177321_75DF4045 
X-CRM114-Status: GOOD (  13.25  )
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

On Tue, Sep 05, 2023 at 08:50:32AM +0200, Christoph Hellwig wrote:
> > +	/* No port assigned, portentrybinding is missing */
> 
> Double new line above, and I think a missing white space before
> binding.

Yep, sorry.

> But I'm still confused how we can get here without req->port
> set.  Can you try to do a little more analysis as I suspect we have
> a deeper problem somewhere.

I am only able to reproduce this if there are two connect/discovery
attempts happening at the same time. I'll collect some logs and attempt
to make some sense out of it.

