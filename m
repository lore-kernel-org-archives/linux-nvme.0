Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7723CC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 07:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K7FviU23eehy++1lcakRR9B+/tG/SqL59X2v/sJOw6k=; b=V7Ca15+rGbXPSgJxYQiI02UzKC
	Q9wjnwkKulwcTEBQ7NZ1fnd6mMLhsXsgTPaoFgYxOd7zTQeiL2NsZsHHHLsxssA1gX9r9fpPOPrVD
	iAkw/vfFrcqYOwVvf8ixVXvzmPY9EUb5E6LC5Rj/zUiX9sP0XfKno+IZuiX0X5O37tirmnk3qIdz0
	S2pxsYwv6Wf9sVarNEHf8CEyElKCsxF7W3ZdHAfe2dGR3P3SvC7Xhz8wxzjNC0malGWURp7yUjUr/
	Kj6ibJg8tvj4gngAyAa5XQUGipoAKIqbjw6qV6+vBvJOJq5pyojP6ssuez3v9u0vFkTa3KpK6ROSA
	mT6EfxiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onabk-008NEl-9B; Wed, 26 Oct 2022 07:13:48 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onabg-008NDg-7H
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 07:13:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 131271FD59;
	Wed, 26 Oct 2022 07:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666768421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7FviU23eehy++1lcakRR9B+/tG/SqL59X2v/sJOw6k=;
	b=rjRM6VOY1/Mbp1BCho9v5EL3Mr1xV3e6lunms+aDbvPXM8cvUg0ZCHPwk4DksNkfAAx/1b
	AeGAdyDOb7h1CtDjZxQooIapgsbFWcxF+HbnbLjc0b2WDpllTSHExASeebVyGGIDsyg3qS
	5ejqNnVfyADHWHNL7HA/CPqJQrCa8XQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666768421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7FviU23eehy++1lcakRR9B+/tG/SqL59X2v/sJOw6k=;
	b=0X6a43Fz3RthF7+ZxDC/fD9giwlFQZdMp8UGQcBk7arcbnfPn9EkKrG0XHBuObsmrjOVXw
	bjXvaK9xDcCZGjBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 043A813A6E;
	Wed, 26 Oct 2022 07:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mGv3ACXeWGNRFwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 26 Oct 2022 07:13:41 +0000
Date: Wed, 26 Oct 2022 09:13:40 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme-tcp: send quota for nvme_tcp_send_all()
Message-ID: <20221026071340.ocqe74c6fvv52sdg@carbon.lan>
References: <20221024150334.29215-1-dwagner@suse.de>
 <529264d7-c3a6-04dc-f705-c0ce3a49759e@nvidia.com>
 <fb22c7e1-3731-f997-1896-024745082ad7@suse.de>
 <9f40e42d-7525-5644-6773-19e3b842f7f1@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f40e42d-7525-5644-6773-19e3b842f7f1@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_001344_422989_29400FF4 
X-CRM114-Status: GOOD (  10.41  )
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

On Tue, Oct 25, 2022 at 04:46:07PM +0300, Sagi Grimberg wrote:
> Daniel, does adding cond_resched() make the system responsive again?

As it turns out I can't reproduce it anymore. Our test lab got
restructured and the cabling between machine changed (maybe even
different network switches, idk). Also the target got a firmware
update.

It looks more like the real problem was caused by the network
infrastructure than the host itself. And adding the additional delay in
the send path was just reducing the load which made the ssh session
working.

Given this, I don't think we currently need to touch this code. Though
the unbounded loop makes me a bit uneasy.

