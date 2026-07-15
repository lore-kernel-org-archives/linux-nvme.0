Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0EAC44501
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 11:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M81O0DXOi1FCvsN+GzxuFb2gMIuocxEv4Z7NyTVCI4g=; b=SA+eJx6PdMTGHnuSSbMxuX4CWR
	mDwWWI3uiVQgHVZaIxYi7Yy/uDwqoLM8oj9bdZxMqZB30tArZ2OqtqA2Rgh+bPY1Lmx94aCLBcMxR
	uEr3bCyzQsXvCEtaV+27RYG7axMu3TL8CJF/ZaEnxLV1SCh3+SdRrl2hJsOARY7F7lZnw4+Qf68Z/
	SE/ScrNdGxBNepAwBbjCe7Ik9oRpyKHrHXfkcwZ0gqedF3zsZqdzQyi4qCSXJBvToc7wrM7vQhfdF
	6kky6uC0tx375VNhBSR9AkwRO+LYfBz1M7Dr5EzTr6c2aylU6nYyNjeo5rM9R6gbTw5Qqc5YK3ZRU
	P9Ra0vIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjxg8-0000000EYnP-2kj6;
	Wed, 15 Jul 2026 11:21:28 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjxg6-0000000EYmZ-33kf
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 11:21:27 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B406E3DF5;
	Wed, 15 Jul 2026 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784114484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M81O0DXOi1FCvsN+GzxuFb2gMIuocxEv4Z7NyTVCI4g=;
	b=WDJHbPM6uKMH7ixqKN9HfJFkJLEexumRGEuYwhx03ECeBtsZUwuWgj+RdVNhZBP5lkrvIF
	ltvQNRLRWhabao8W5CviQc7vQUOwrwWJlsUlX/EhtNpseJSZtjPvA2l0wAYqDKG3/ZbhbV
	BoFxwKOSDoUNxUjQo7aOTuk3kNwyjXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784114484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M81O0DXOi1FCvsN+GzxuFb2gMIuocxEv4Z7NyTVCI4g=;
	b=Vf2HV7SI/3hk72YeyeITvKyDewmCm3NJl+PbmyscwnnbMIw8G0iM+4+O8EJS5F+Chdkz/s
	mVAEaWqr+T4OA1Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784114484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M81O0DXOi1FCvsN+GzxuFb2gMIuocxEv4Z7NyTVCI4g=;
	b=WDJHbPM6uKMH7ixqKN9HfJFkJLEexumRGEuYwhx03ECeBtsZUwuWgj+RdVNhZBP5lkrvIF
	ltvQNRLRWhabao8W5CviQc7vQUOwrwWJlsUlX/EhtNpseJSZtjPvA2l0wAYqDKG3/ZbhbV
	BoFxwKOSDoUNxUjQo7aOTuk3kNwyjXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784114484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M81O0DXOi1FCvsN+GzxuFb2gMIuocxEv4Z7NyTVCI4g=;
	b=Vf2HV7SI/3hk72YeyeITvKyDewmCm3NJl+PbmyscwnnbMIw8G0iM+4+O8EJS5F+Chdkz/s
	mVAEaWqr+T4OA1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 962EE779AD;
	Wed, 15 Jul 2026 11:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LQUjIzRtV2oCEAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 15 Jul 2026 11:21:24 +0000
Date: Wed, 15 Jul 2026 13:21:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHv3] nvmetcli: store DHCHAP attributes
Message-ID: <902e34d5-7fe8-46d6-b358-d3013b32d4ad@flourine.local>
References: <20260715090733.94695-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715090733.94695-1-hare@kernel.org>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_042126_917222_454E4607 
X-CRM114-Status: UNSURE (   7.95  )
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

On Wed, Jul 15, 2026 at 11:07:33AM +0200, Hannes Reinecke wrote:
> The DHCHAP authentication attributes is stored under hosts/, and starting
> with 'dhchap_'. So add a 'dhchap' attribute group for the host object
> to correctly save and restore DHCHAP values.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>

Patch applied. Thanks!

Daniel

