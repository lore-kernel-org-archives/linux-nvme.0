Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA88C531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P8gF0VRc9Y7rNBPRo/VdLr5wb4xFr5AtxCkwB+zyjs0=; b=QlpwDhPwptxYxz9ZltQkFWkFFM
	CHVCL1nWZXnwWyN1yUDQNa6r6OAak+husdbrptqTI86xAo76UXiEi/apnKzsJwISc4Dg6xhkD68Nn
	zDVtR8buP0lg3Nhzxes/07HVSlRaAvbq34+mO7sYJ9dS24GqVp1DdlS3AQXXhmjevrlJhZqQq/0C+
	eiT4X0yRrbqwu0IafmqSmOCcsYXpg9IK9sfGJkidn2eqJLE4TyMRzrOI6LaCOpwftjcOsCo4T9ZGp
	MBBrlbPNuyGhXnVZPIdRrhRkwCgqhNjxnY0ljI4OuI87Q34o1Xmm/qYQb0HQPtQx/+ALP+V8Y0o0C
	lk9ukubA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shVc7-0000000HAYI-3B1y;
	Fri, 23 Aug 2024 14:50:07 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shVbt-0000000HAVn-169e
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 14:49:54 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F5182032A;
	Fri, 23 Aug 2024 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724424590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8gF0VRc9Y7rNBPRo/VdLr5wb4xFr5AtxCkwB+zyjs0=;
	b=ZJ5SggyfHyMVH4mBqAVtEuFAVR+60VKvNCDblLPKQGIa1nozRRxUQyRcbaPa+wmeXiyDeE
	aMRqwZZCByXG0RWCbY+gQM1X/R/eZ7gOfmDsOgAWYtERysfBySrKzL+2O4U/x/Fh/oZu2D
	xMaeSjmu9Tz6bfR60E577FlJcpptwSo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724424590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8gF0VRc9Y7rNBPRo/VdLr5wb4xFr5AtxCkwB+zyjs0=;
	b=ZJ5SggyfHyMVH4mBqAVtEuFAVR+60VKvNCDblLPKQGIa1nozRRxUQyRcbaPa+wmeXiyDeE
	aMRqwZZCByXG0RWCbY+gQM1X/R/eZ7gOfmDsOgAWYtERysfBySrKzL+2O4U/x/Fh/oZu2D
	xMaeSjmu9Tz6bfR60E577FlJcpptwSo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EC021333E;
	Fri, 23 Aug 2024 14:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qEbKCY6hyGZ7fQAAD6G6ig
	(envelope-from <mwilck@suse.com>); Fri, 23 Aug 2024 14:49:50 +0000
Message-ID: <2cb6f86256803af00557f07e9573331c51111953.camel@suse.com>
Subject: Re: [PATCH 3/3] nvme: add test for controller rescan under I/O load
From: Martin Wilck <mwilck@suse.com>
To: Nilay Shroff <nilay@linux.ibm.com>, Shin'ichiro Kawasaki
	 <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
 <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 linux-block@vger.kernel.org,  linux-nvme@lists.infradead.org
Date: Fri, 23 Aug 2024 16:49:49 +0200
In-Reply-To: <9c260acf-48c1-4b4e-8e02-594bff222af3@linux.ibm.com>
References: <20240822193814.106111-1-mwilck@suse.com>
	 <20240822193814.106111-3-mwilck@suse.com>
	 <9c260acf-48c1-4b4e-8e02-594bff222af3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_074953_478111_F2D1A632 
X-CRM114-Status: GOOD (  16.41  )
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

On Fri, 2024-08-23 at 15:48 +0530, Nilay Shroff wrote:
>=20
> On 8/23/24 01:08, Martin Wilck wrote:
> >=20
> > +	finish=3D$(($(date +%s) + TIMEOUT))
> > +	while [[ $(date +%s) -le $finish ]]; do
> > +		# sleep interval between 0.1 and 5s
> > +		usleep "$(((RANDOM%50 + 1)*100000))"
> > +		echo 1 >"$1/rescan_controller"
> > +	done
> > +}
> I think here usleep may not be available by default on all systems.
> For instance, on fedora/rhel I don't have usleep installed in the=20
> defualt configuration and so I have to first install it. So you may
> want to add "usleep" as per-requisite for this test. Moreover, after=20
> I installed usleep on fedora and ran the above test I see this
> warning:
>=20
> warning: usleep is deprecated, and will be removed in near future!
>=20
> Due to above warning the test fails. So is it possible to replace=20
> usleep with sleep?

The README states that blktests requires GNU coreutils, so yes, that
would be feasible - in principle.

The problem is that bash can't do floating point math, and I want to
be able to sleep for fractions of a second. So I'd need to do something
like this:

usleep() {
    sleep "$(awk "BEGIN { print $1 / 1.e6; }" </dev/null)"
}

But the fork-and-exec to "awk" is slow. millisecond sleep times can't
be realized this way.=C2=A0Anyway, I realize that calling "usleep" also
carries a lot of overhead, and thus "usleep 1000" doesn't do what one
would na=C3=AFvely expect, either.

The only way I can see to make this work as originally intended is to
implement is as an awk script. The README says that GNU awk is
required, so sleep() with floating point argument is available.

Thanks
Martin


