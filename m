Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47127C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 08:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6omq06dOqm9xZH6rsZdUm7Ynp6IAdoqN7Nma2+fPGQA=; b=qjWJmiOwuzEGgdhIIn68kpsbf7
	93YL2ZyGVNj8dJVW3PcuSjlf8fuUZ9y/auY9sWZloX50uixKTxpaTJ15j7mn2Bn69SZn9Ee8gxScl
	JUlGmaQXtV3nxc8EC8xqXaEQ9BHOqEmOS48g9+BqWypVi2IStbfgGcPJ/evM2CYbv4rAVP7C7sgjt
	KL+aPtoZRMF6/8gT58VWygLyNC1R4d6q8KiOJnARdfldYzxRBM4eoWObedTwtdmt8i7ThVe09n41d
	/Zlx+NBzL3tcp2x59QD0QDkhS/k+2uR8RNN+89vu+DpzHYBKtLjIYzeDeGkK7fUq0+jYVpKQXEfAN
	Qbd80hOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEoUf-001H8i-N0; Fri, 22 Jul 2022 08:58:45 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEoUd-001H5l-DK
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 08:58:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEED120120;
	Fri, 22 Jul 2022 08:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658480319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6omq06dOqm9xZH6rsZdUm7Ynp6IAdoqN7Nma2+fPGQA=;
	b=wfnkOe+6ZN8n/LhJIjP44Ogd91U94mcs9Wc+Tcyjk3ebNqcRxwz3qtHFsvtAA0T99MK9sS
	gL/A5N6GcNxOhpz3JEoVvUKiai9k6sGJ9cv4zwZPuvEE6LvQ6oEu28AiDNFmqIpxYugHM0
	Qnh30bhFY9LO3jE9thyu7HUqpzxBHks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658480319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6omq06dOqm9xZH6rsZdUm7Ynp6IAdoqN7Nma2+fPGQA=;
	b=HpeXZq++TTiYtCwyp0B9D1/q5/GR0RaQ+Zvk9v+8JSnz5uK+v7a6powwrC3BXRC7Wh+Lpi
	SBLZLZ7WpinxRJBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A24CB134A9;
	Fri, 22 Jul 2022 08:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bKe0Jr9m2mIxWAAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 22 Jul 2022 08:58:39 +0000
Date: Fri, 22 Jul 2022 10:58:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: consider also host_iface when checking ip options
Message-ID: <20220722085839.cttrthaw5ctp5xgu@carbon>
References: <20220721174414.28294-1-dwagner@suse.de>
 <YtosZB0mt7qTG3eG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtosZB0mt7qTG3eG@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_015843_651614_B16C1D2F 
X-CRM114-Status: UNSURE (   9.93  )
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

On Thu, Jul 21, 2022 at 09:49:40PM -0700, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-5.20.

Argh, forgot to test the non host_iface case. We need to test for a null
host_iface pointer. Do want a follow up on this patch or do you drop it?

