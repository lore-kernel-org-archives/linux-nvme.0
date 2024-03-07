Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D09C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xFSrhPAhdeU+042oYvavyOjg/sVd7TdbAFR+fQA1Bpc=; b=wifUlzbKEmRAk3RHokGb1NC932
	kJ5qUXKruue5RL8Zox73Lq09neSI/+PKtcEobJ5kYp/ygHAPxRzLE4cgc/9AZu9Cv/5K/0+Fgss+y
	pfc1YlWW1hmiydmGetoPEQGqfJxx3R4o8kPagQQacVMs7uTjKYcqHJ4kGAH51eU9buEPeMpPOgU06
	H5NgCeTo+9kVoL4BLGsTEk+z4o2ahQcj7de9hz2M8LcRCFBXccnW1ym4Jyhb8wutX2sL140Rgi6yW
	K0bjr6IWiiA2T4bcdGVR6corjBJFryS21E8qd5Up+V2+6XgVfEFIK16oxlEIrnbWr+yQaTwFBY7Me
	G+oc7pxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riF7o-0000000597l-1ta7;
	Thu, 07 Mar 2024 14:53:36 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riF7i-00000005950-2P7h
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 14:53:34 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 906A925B68;
	Thu,  7 Mar 2024 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709815415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFSrhPAhdeU+042oYvavyOjg/sVd7TdbAFR+fQA1Bpc=;
	b=ttccUmx1QeU+BppR9JgrXCg9E9b7S7d/IVMycDyD0IYMF/srVgCssFrEyZKN+rEwkpmD2O
	CYugHIodpUJYPr4jQGjf+0kGfvaQxs+FQEQGLumK0g5A9Xt9cKAp+IQH4UonxuVZfYDmuN
	ms8BGU6kmjBl8D17nVD8TP5D9YZYPNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709815415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFSrhPAhdeU+042oYvavyOjg/sVd7TdbAFR+fQA1Bpc=;
	b=pqxNk3pzkXGBijZ0OTzkrXQGf/dILR6pSr8Q0sAfGmWzSN/YtK399b/p1hksivbcSMtFHo
	8pzU8CtDYHZ9eVDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709815415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFSrhPAhdeU+042oYvavyOjg/sVd7TdbAFR+fQA1Bpc=;
	b=ttccUmx1QeU+BppR9JgrXCg9E9b7S7d/IVMycDyD0IYMF/srVgCssFrEyZKN+rEwkpmD2O
	CYugHIodpUJYPr4jQGjf+0kGfvaQxs+FQEQGLumK0g5A9Xt9cKAp+IQH4UonxuVZfYDmuN
	ms8BGU6kmjBl8D17nVD8TP5D9YZYPNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709815415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFSrhPAhdeU+042oYvavyOjg/sVd7TdbAFR+fQA1Bpc=;
	b=pqxNk3pzkXGBijZ0OTzkrXQGf/dILR6pSr8Q0sAfGmWzSN/YtK399b/p1hksivbcSMtFHo
	8pzU8CtDYHZ9eVDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E86B13997;
	Thu,  7 Mar 2024 12:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id i7HVHXa26WXGRwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 07 Mar 2024 12:43:34 +0000
Date: Thu, 7 Mar 2024 13:43:33 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Message-ID: <qbzzr6waj23q6rxrueevwoteg5i4ogr7hr45ckseu7ekdcc7sb@xgyvtkp27w5i>
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
 <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
 <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
 <3xhhdconprn3vvkky4yj4iazku4eiqxl6l6rw6z5tivvdjwaby@ts7satqbih7w>
 <hxr2hztb64dank3jvbnrlciaebo4k2qkkrg3brhrppizeyelpo@ewupxurl7iqm>
 <5d67a55e-e979-4c3c-8dcc-597cb13c7c9d@suse.de>
 <83bca01f-fc34-405b-9f2e-8079130400ce@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83bca01f-fc34-405b-9f2e-8079130400ce@grimberg.me>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ttccUmx1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pqxNk3pz
X-Spamd-Result: default: False [-4.42 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.de:dkim];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.11)[88.35%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: 906A925B68
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_065330_799460_407A53AD 
X-CRM114-Status: GOOD (  15.46  )
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

On Thu, Mar 07, 2024 at 12:25:16PM +0200, Sagi Grimberg wrote:
 > > Is this what you had in mind?
> > 
> > Which, incidentally, is basically the patch I just posted.
> 
> Reading this, the patchset from Hannes now is clearer.
> Isn't the main issue is that nvme-fc tries to periodicly reconnect
> when failing the first connect? This is exactly what the test expects
> it to do right?

Yes, the test expects that the initial connect attempt fails. nvme-fc is
using one connect path and doesn't distinguish between the initial
connect attempt and a reconnect.

All fabric transport share the same problem when the connection has been
established and later one a connection drop happens and a reconnnect is
executed. The blktest nvme/048 case extension I've posted tests the
reconnect attempt after the controller key has changed. In this
scenario, nvme-tcp, nvme-rdma will also do a reconnect attempt although
DNR is set.

