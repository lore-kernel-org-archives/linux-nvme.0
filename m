Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD30EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jun 2023 07:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzodxslVWR34FWKTezh8R+HCLqkf9hKJ6nwhZ2cYyW0=; b=f+q2rm+ZpM4FaVatCi6JpHvlsc
	l220qhVxRyCu/GPIR9R6/Yqp0bq47nogbOkmbuA+d0Zhi9+e8YPHC7LOq3bFjtnY3Ntno0cMqg/9S
	cNBMtUmJurCz0Zuwa2Bu2tyJRvvxf3sRUgGR4gmhUdS2hgqZTqBye2JUXvmd3Ap8SXX6xeEGTJtD9
	4WSZxnFvnL/fKQtFG6mya10GVdvqr5N9D9ySBVrqAS9GfP8Zh94ZyCii4jZ+tJpKq5z6BIVnxtPOq
	lORfx9Jryx7i4sSXG0cx3+1hOijoN4Drd6yzhWxjHaq09FdQtKNr+yvmqGtpZDfBdtOqdON/HPqmc
	vOCJig4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qB9jO-007krV-1M;
	Mon, 19 Jun 2023 07:55:22 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qB9jK-007kqW-2p
	for linux-nvme@lists.infradead.org;
	Mon, 19 Jun 2023 07:55:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B877B2188E;
	Mon, 19 Jun 2023 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687161314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzodxslVWR34FWKTezh8R+HCLqkf9hKJ6nwhZ2cYyW0=;
	b=eNlw2lEdFwRO24qHwcZk6RTiyPfPkFK/qnznneFVO8rBVp3e+AZ/aqo7cxuiWUi7UZx3/u
	vkV2Xoh4sMJjXcH5IJeusAnX5mWTuVn8oi5gpUC4jlQYE+YlD/QdEUarmKV36IYMkRGmVb
	scGcJ9MfBs7nhXYSgMCL6L2HxVXQ96Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687161314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzodxslVWR34FWKTezh8R+HCLqkf9hKJ6nwhZ2cYyW0=;
	b=5dGQ0ErR9rr16jt9qdW7WZcepprWjTCTT6S4BuS9s9Siz9XZJXBmmJ4JbJ68RjM0Wj1Dsm
	qnkil/Q7ipU84tCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A99C3139C2;
	Mon, 19 Jun 2023 07:55:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3PtfKeIJkGRQBgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 19 Jun 2023 07:55:14 +0000
Date: Mon, 19 Jun 2023 09:55:14 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v1 0/2] nvme-fc: Fix blktests hangers
Message-ID: <iek6a3eegnjirapsuw2jtptxttgor2e4bvoljlr2swqwzagso5@b7k5kq6j2ab2>
References: <20230615094356.14878-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615094356.14878-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_005519_077116_75493085 
X-CRM114-Status: UNSURE (   9.60  )
X-CRM114-Notice: Please train this message.
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

On Thu, Jun 15, 2023 at 11:43:54AM +0200, Daniel Wagner wrote:
> A couple more fixes to enable blktests for the fc transport.

I let run blktests in a loop and eventually the unloading of the fs module
blocked again with

      nvme_fcloop: fcloop_exit: Failed deleting remote port
      nvme_fcloop: fcloop_exit: Failed deleting target port

So the reordering of the module unloades in blktets just made it a bit harder to
hit but it's still possible to hit this. So we should also consider

https://lore.kernel.org/linux-nvme/20230418130159.11075-2-dwagner@suse.de/

