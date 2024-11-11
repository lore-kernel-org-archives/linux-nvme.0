Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3D8D2E9D3
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 10:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7rSKkxkmwPU/38cREfPvyGqTHWOhgUZ2IHz39EGeyhI=; b=HH2loAxeEsUapiiBBwkwO40J02
	7eubdRucmF6YNywpl2GuBtfVtprdamE0syknQrNH3hYHr040slj46sXCMVqU0902b41FC9fbz7afo
	YtvhbhQVi4aVrCcROxeuOtkFvAYtMVjrLV3wkSZxkQLAjj9FXzllpjh+hTISjh/cc89o1MWcb2V+w
	wA8LwTPSwLAkujwRR245vbBYmXgBRpR9LIKo9goNq8g4XlLuje4SBmWyJP9v8ntAOq0pJ/F13M5fW
	Bn9YZJIQh9nwBYu+WXQqKWWXxwVASICoSJPOYZFWZZqeHGQpzfDN6e6+3J8ypK2feYO6lT6cN6BZz
	rj2tggCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tARip-0000000HIGV-3uxi;
	Mon, 11 Nov 2024 10:32:39 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARik-0000000HIEC-2u0d
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 10:32:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 318E1218A1;
	Mon, 11 Nov 2024 10:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7rSKkxkmwPU/38cREfPvyGqTHWOhgUZ2IHz39EGeyhI=;
	b=Pf8hKXlzSOhhxakoWrQqZaP0SykjLaRlrL84gGoonZf2SIST2g9QPTQxmY9ZMOUCke7gtQ
	4WVxjm80N4C0FovT1xe+DjSfdpKP5WJVl9A7qd3Fy0ymyL5oPaUwbOCOrb2ph++I7NQcwk
	pkOgDVUyTDrkt0VMq9R2O/+jQg3rylQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7rSKkxkmwPU/38cREfPvyGqTHWOhgUZ2IHz39EGeyhI=;
	b=53AKNFvV59UWsrxLFVzD2NVVloeUyUp8Jj/usM1b5nV/LXg5oEhvAPhQe16gHmG8wR1AJQ
	ErwClonOHHNwmiCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7rSKkxkmwPU/38cREfPvyGqTHWOhgUZ2IHz39EGeyhI=;
	b=Pf8hKXlzSOhhxakoWrQqZaP0SykjLaRlrL84gGoonZf2SIST2g9QPTQxmY9ZMOUCke7gtQ
	4WVxjm80N4C0FovT1xe+DjSfdpKP5WJVl9A7qd3Fy0ymyL5oPaUwbOCOrb2ph++I7NQcwk
	pkOgDVUyTDrkt0VMq9R2O/+jQg3rylQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7rSKkxkmwPU/38cREfPvyGqTHWOhgUZ2IHz39EGeyhI=;
	b=53AKNFvV59UWsrxLFVzD2NVVloeUyUp8Jj/usM1b5nV/LXg5oEhvAPhQe16gHmG8wR1AJQ
	ErwClonOHHNwmiCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 170DB13301;
	Mon, 11 Nov 2024 10:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i3c3A0HdMWdeGgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 11 Nov 2024 10:32:33 +0000
Date: Mon, 11 Nov 2024 11:32:32 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 4/8] nvme/017: do not create namespace when
 setting up the target
Message-ID: <ee88d4d8-9fb6-4f9e-9ebd-80e9dceb554a@flourine.local>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
 <20241107111354.80606-5-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107111354.80606-5-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_023234_903802_A20D1DEF 
X-CRM114-Status: UNSURE (   8.27  )
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

On Thu, Nov 07, 2024 at 08:13:50PM +0900, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Simplify the testcase by not creating a namespace when setting up
> the target and have to loop iterating over all namespaces.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [Shin'ichiro: use for loop instead of seq per style guideline]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

