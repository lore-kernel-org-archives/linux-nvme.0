Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB4DE77179
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 12:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vlagtk/NHHAwVBHy1ukp5C0o5xRw52iIT19KYNm7LSw=; b=plSsNg9WFNFSGfjTs4ij3v2EBC
	D/FyjYkdCq/hjoVJhWoxKzkvjLkXnHe+QHG4G2plw735aArZVKKbLBkCnEkZ5Ic5qUVt9xrjGmZHR
	g+kAOxuV0foa8LDnrJK/6Ov4McFnrnSsDc4M+rMlve8qu0IM88PdCrhMhzrIG8e5Q1dUK73VCd/9b
	vYEAentp0Cm5wMxa7QYr+iujILWr3/IUDiFe916rI3+ELwFsqAnt5pQ70pW7qVOlqH97IUhTjhziA
	bQzu1UvB4yCh7F59zoasTnG58ePA09RLykk8uEHuowgomF+DNHXFQFWeOBajG7JEAFMawedIm9LOt
	7JUfinKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXVq-00000001ZlR-2wgp;
	Fri, 06 Dec 2024 12:32:50 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXVo-00000001Zjn-1iB3
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 12:32:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDB7B1F74C;
	Fri,  6 Dec 2024 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733488366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vlagtk/NHHAwVBHy1ukp5C0o5xRw52iIT19KYNm7LSw=;
	b=LXM7QPCZFfsLt+xx/5RkKYG8AhuBO6/5nXRuox4ng7rCYUnLyMXhnNwpFxvzsr8nyDy4Ks
	sALqHguLlWqsEmsA00iwh/JDAE417OSznHJWbjtInhub1UOaARj3+U930iXquytIH7edzc
	NJ3buAdmEzrR3TtxGmI6KTEKdoqwW+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733488366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vlagtk/NHHAwVBHy1ukp5C0o5xRw52iIT19KYNm7LSw=;
	b=z4ezCD4mMbabU/zb/2gU35zcLepSJykPfUUopvOXtElK4oIlTBn5EyfiI5vCZYCX7QNljg
	kctQTiPgcOqbDWCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733488365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vlagtk/NHHAwVBHy1ukp5C0o5xRw52iIT19KYNm7LSw=;
	b=wqFDlueOnxgVWjSM4X59i9DjOCJielfAnX+yHtqrqvuplp7boCwMLoOZjJnfX6lZAf09Pu
	stANYhQF4wjXpudBO07sv/lEfJtozYNjbkX4w7FMqSE6LTAgMUj4ko32Y3a9hfubMZcLXc
	jG/9iXihjm4W+5xeKMLU+Vt8JPvHN+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733488365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vlagtk/NHHAwVBHy1ukp5C0o5xRw52iIT19KYNm7LSw=;
	b=2EE8FEBNL9D8QLND2cnfuaULkdYuMNjGbwE+Ak+OvpBLGGOnnoE77i5DNePjxsXkX6By9Q
	86XBZKm9PsGGMGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADF2B138A7;
	Fri,  6 Dec 2024 12:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1UZ+Ke3uUmckRQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 06 Dec 2024 12:32:45 +0000
Date: Fri, 6 Dec 2024 13:32:45 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com, 
	chaitanyak@nvidia.com, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, 
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv3 2/2] nvme: add test for writing to file-ns just after
 disabling it
Message-ID: <8b57ae43-e01a-4b08-9eae-bba43ba2c851@flourine.local>
References: <20241206111812.489140-1-nilay@linux.ibm.com>
 <20241206111812.489140-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206111812.489140-3-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_043248_589955_173C8DB8 
X-CRM114-Status: UNSURE (   7.18  )
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

On Fri, Dec 06, 2024 at 04:48:08PM +0530, Nilay Shroff wrote:
> +		# disable target namespace and write to it
> +		echo 0 > ${ns_path}/enable
> +		nvme write --start-block=1 --block-count=0 \
> +			--data-size=512 --data="/dev/urandom" "$disk" 2>>"$FULL"
>
I haven't checked if this was already discussed. Just wondering what
--block-count=0 is supposed to. Is it the 0 based thing?

Rest looks good. So feel free to add

Reviewed-by: Daniel Wagner <dwagner@suse.de>

