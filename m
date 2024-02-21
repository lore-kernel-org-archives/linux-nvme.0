Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76D0C48BF6
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yvVVrhvjHY4YuhOA+lFM2mTu+paFlyivAKigptrpqHU=; b=vCzvelPj8FF7bvZF6gSqmmhobM
	HTHZuKhm7A8tnzBwJPrMI/AoQkD8h1kNEo/t/dK2jUQmWEOAX+nXiluK+l/imhmyCweexJuv3l1ce
	BKGob67M45s/DLRkTz5LVhUe68ssOGnAVG2uAQwe7qxlJFTUQEUCK7A2WYAykbQV+KnRRgUhKLHBe
	8vkVTe4Ig9xFInI+zXgyyZtnYc1GOQv9W1qxO1IEWCL24rAiYXVD9eRwxMZIV+Br5TgnQyh2q9sfJ
	TNcnsIpEp6YtWzCZQauwnFb8TdCouqhQlz+CJem3AKxpXWAeR4Qps1ccIyAaNtvxpewQoe0qlwQ26
	/ojkAPpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmOH-00000000yvb-1sNz;
	Wed, 21 Feb 2024 13:12:01 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmOD-00000000yuN-1phZ
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 13:12:00 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA40D1FB61;
	Wed, 21 Feb 2024 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvVVrhvjHY4YuhOA+lFM2mTu+paFlyivAKigptrpqHU=;
	b=g/GtBXNkKWP5JrW7cv9laXx5edqXaQQVc48kGrVmc+oKgKb/FOD1ME75+FZf0T3qJFB0m9
	aeRxpO22ax9vIJS+cmqL3/JjP4dWCWmTHg1iMXVP0P0rNqr+zgKTXLLFzvJFB5vN3lohzk
	J1SJwRI0gt4KyXrqnOq5kRzWvMCYkS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvVVrhvjHY4YuhOA+lFM2mTu+paFlyivAKigptrpqHU=;
	b=+XYzAtzEB6TecJShy6AA4PgOG0qGC++CpIICYBBAOadcAMcHcVguaJN+bm7rWLAQKeloiw
	L4EPw3JeJAOk8eBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvVVrhvjHY4YuhOA+lFM2mTu+paFlyivAKigptrpqHU=;
	b=prrG8c77QgQvuZlRsBK9Lap62Z5RYC0HEenOAOTscDU2ZkMirsBXK5i5f2v398BSY4ucDT
	hD9+jQL5OOBy04bgCrN8qS0Dv6o6ZpGJBOOnTSpDp608N8TgErNHEcUSM3XhkuRh2kqwoN
	rVgCqGFdiQfQRgzHaQKyyQ6iL6wEp+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvVVrhvjHY4YuhOA+lFM2mTu+paFlyivAKigptrpqHU=;
	b=iFuUtGVp8jTIMrqcERYrWQR1yhziFCqCAi9pcDC+GGaLYElAlXvtytMx5A8uicsMEpg/iM
	CH4ssaTE3XMc7FCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D729B13A25;
	Wed, 21 Feb 2024 13:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oRwXM5j21WVSOgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 13:11:52 +0000
Date: Wed, 21 Feb 2024 14:11:51 +0100
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: move RCU read lock to nvmet_fc_assoc_exists
Message-ID: <xe7nvn5qnwolv5fnhmjxkmbh7uk7pckqsa66ndmqakqk7kbt4v@zxuwbppfq6io>
References: <20240212102940.11137-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212102940.11137-1-dwagner@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.23 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.63)[92.67%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_051157_646803_0F110981 
X-CRM114-Status: GOOD (  11.85  )
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

On Mon, Feb 12, 2024 at 11:29:40AM +0100, Daniel Wagner wrote:
> The RCU lock is only needed for the lookup loop and not for
> list_ad_tail_rcu call. Thus move it down the call chain into
> nvmet_fc_assoc_exists.
> 
> While at it also fix the name typo of the function.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

ping

