Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E717FF885D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3oMwxTPIycHtc6QHYlxrvJTJdmUhQvrAn14KV3y3FTk=; b=zdgmxu69xqLKO3BoUkCcdrxXvH
	zdbLNeNkPu/qKWWVxGxOIJkyJFhlhDKhGGlo7W4feYm7H6X+WyBn/Ib5ULcD0Qee8YME9qO7RsWJu
	7jSweJGaB66KLdrZU5ebJIcongLVNAVcYKACeBV2TbcprcJ+AGjCNCKvUWH8vD1hILGJ/6Izpn9XF
	EHYT3x5JwpMxxVRMC8ildvcoaaEhAZyNUyOSgAtRSePGpk3Jz5sIWCOpsshg8ULWI9bVvjBXhP4KM
	eRbxExfmnZUQg/To6T59/FajoWJTLri1UNPiGlf2nJS8FDe8Tcf2675e5WNFI52Efv47rW0++pLjC
	zRZl+Y5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhlq-00000001S5f-44iD;
	Tue, 28 Apr 2026 12:42:34 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhlo-00000001S4t-0zHF
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 12:42:33 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C5705BD4C;
	Tue, 28 Apr 2026 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777380149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oMwxTPIycHtc6QHYlxrvJTJdmUhQvrAn14KV3y3FTk=;
	b=LrJiEgzCHMQlHEynELA54lTWCczrINwWICqMzGFTArcFe6uLWsABVGzVUyvGUVsVGqJVD7
	8p2ziuBY2+ZmoB0ZRgVjB3Hy2bT6jRb2sRNhRmSvcCYJxHczIe2EV8joo22r51tP90yU7O
	cDViJJHNjmPWoemIzFxPSu5Ipna7f+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777380149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oMwxTPIycHtc6QHYlxrvJTJdmUhQvrAn14KV3y3FTk=;
	b=GHCvsexUbM1Bm+j+FjdUPu5y+/sAaROl1OXHSagBKGAIBY69z8s5IGw9KgXwqXeJZ3NjLG
	x3VEw9Nrk8E/kxAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777380149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oMwxTPIycHtc6QHYlxrvJTJdmUhQvrAn14KV3y3FTk=;
	b=LrJiEgzCHMQlHEynELA54lTWCczrINwWICqMzGFTArcFe6uLWsABVGzVUyvGUVsVGqJVD7
	8p2ziuBY2+ZmoB0ZRgVjB3Hy2bT6jRb2sRNhRmSvcCYJxHczIe2EV8joo22r51tP90yU7O
	cDViJJHNjmPWoemIzFxPSu5Ipna7f+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777380149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oMwxTPIycHtc6QHYlxrvJTJdmUhQvrAn14KV3y3FTk=;
	b=GHCvsexUbM1Bm+j+FjdUPu5y+/sAaROl1OXHSagBKGAIBY69z8s5IGw9KgXwqXeJZ3NjLG
	x3VEw9Nrk8E/kxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B878593B0;
	Tue, 28 Apr 2026 12:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7UaZATWr8Gm6PAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 28 Apr 2026 12:42:29 +0000
Date: Tue, 28 Apr 2026 14:42:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, nilay@linux.ibm.com
Subject: Re: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
Message-ID: <328010ad-0d56-4f5e-a37a-e25914da08b5@flourine.local>
References: <20260415104111.1439459-1-john.g.garry@oracle.com>
 <655129a4-de84-4c10-9e55-f75143684b7c@flourine.local>
 <2512cec3-31a8-4703-a50e-85289c860d25@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2512cec3-31a8-4703-a50e-85289c860d25@oracle.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_054232_423565_8FF1ABD4 
X-CRM114-Status: GOOD (  12.84  )
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

On Mon, Apr 27, 2026 at 01:51:17PM +0100, John Garry wrote:
> However some of what we want to test is still based on timing - for example,
> if we set delayed removal timeout to X seconds, we want to ensure that the
> gendisk is gone after X seconds. So we need the X second delay. Currently X
> is 10, but can shorten that.
> 
> sound ok?

Sure, that's sounds reasonable.

For the gendisk removal case, I'd suggest to monitor if the disk goes
away within in a time limit instead of a simple sleep and then test. A
busy system might take slightly longer than usual. The time limit can
then be really high.

