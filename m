Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BADFC44501
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h3qCa6h/Jvlmbl1Ys+5fQfN3jSZxZGaoGH61HxHQNew=; b=Ov1E7PfbK4XCg3W/ZiQMtTuzk0
	94nO79rcIm3YdByIdDCVjiykENIYd79fSlW74R3Wr+xldN1MOYcJ1SBJOfuYoPgW+GPq057tTimK/
	1grsHDxN/b+i++crQNx4vp2Qy3gMBGmHndgpB7nO2b2Ceme0F4gJb1MGep15MAwcSi0UTxi2VDWig
	tHt95muH0JhyXAWOVQ1auGA7zBadLVx81woGAlYhNKArLnE54b4p+bHQH0qUi+onJ/DcgkXSzBMHt
	M7fpvqS7UGh0WahU8q6pGOudzpYPARsm6xeg781hxptsKhMW6S0DBWuK5IM70WaESFyy2qr+qEkJJ
	p8l3Uc4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjyTg-0000000Ejjd-27fy;
	Wed, 15 Jul 2026 12:12:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjyTe-0000000Ejio-331o
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 12:12:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C58C8783B9;
	Wed, 15 Jul 2026 12:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784117556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3qCa6h/Jvlmbl1Ys+5fQfN3jSZxZGaoGH61HxHQNew=;
	b=1YRLsYo8r79BCIWJoZfm9IieU5v6JggzVTxHo+mCiP8xjmtS/gy7V1QfdUGL1F4b5mINsK
	r6k84SYqV5UXfB6Hj2xQ15GrXf+M/0y2Rw7vBQento+AfHXl6/Osq1onWpfR1VjvfJgQkS
	MGBc0T6enwj0sgqyE6Evgt1rY1lXbiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784117556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3qCa6h/Jvlmbl1Ys+5fQfN3jSZxZGaoGH61HxHQNew=;
	b=GBNJfTvpEf8RwkWdcKSaMFHyzF6IpiBxvNZBVE3t89FxrKune0xp0VDJQSGutGwO58ZtHG
	us2FWwFJ3PGEaxAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784117556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3qCa6h/Jvlmbl1Ys+5fQfN3jSZxZGaoGH61HxHQNew=;
	b=1YRLsYo8r79BCIWJoZfm9IieU5v6JggzVTxHo+mCiP8xjmtS/gy7V1QfdUGL1F4b5mINsK
	r6k84SYqV5UXfB6Hj2xQ15GrXf+M/0y2Rw7vBQento+AfHXl6/Osq1onWpfR1VjvfJgQkS
	MGBc0T6enwj0sgqyE6Evgt1rY1lXbiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784117556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3qCa6h/Jvlmbl1Ys+5fQfN3jSZxZGaoGH61HxHQNew=;
	b=GBNJfTvpEf8RwkWdcKSaMFHyzF6IpiBxvNZBVE3t89FxrKune0xp0VDJQSGutGwO58ZtHG
	us2FWwFJ3PGEaxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD9BF779AD;
	Wed, 15 Jul 2026 12:12:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HM8YKjR5V2rvQwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 15 Jul 2026 12:12:36 +0000
Date: Wed, 15 Jul 2026 14:12:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 0/4] misc fixes
Message-ID: <8fb8b561-77d2-4192-8180-8ffbe283665f@flourine.local>
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_051238_919004_44384F5C 
X-CRM114-Status: UNSURE (   8.19  )
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

On Mon, Jul 13, 2026 at 09:39:02AM +0900, Shin'ichiro Kawasaki wrote:
> These are miscellaneous fixes. They do not affect test results, but worth
> fixing.
> 
> Shin'ichiro Kawasaki (4):
>   check: fix exit status code handling
>   nvme/rc: use _set_attr() in _create_nvmet_passthru()
>   CONTRIBUTING: clarify that GPL-2.0 is not applicable
>   new: guide long command options

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

