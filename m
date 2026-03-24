Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F993F532FC
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q0phjcraIpr6kclnIYW3HstHTcnEjybGITzwqz53oaY=; b=yOeXcafzS5x69eLk8JeuJU3N5j
	6ebUcyN7aYgY78folWV60TyG3jqV/RmopdPwNmHFsWSVfrrbUHVUWXYWVZWwfMO2wHqIVXTtpewbt
	0nE/7RPd8z1lCDL6q3w6qCgZjiI+yKkzji+qu1bN3YSQh1M/MqvaaSFnSqn/uDJOJ63KC2175Tiw7
	gi8DVhGIJf/A+a4fK/orbKL6NN/A1SLMKOj+4uW9klDWWGJXbgmU4KIGmOm3ZREb13Euc19Ls+YbO
	/UkNvnX6KVTfIoj0yOI7uKzDi61MHQgKdOfTBgxVvuEZhekv3EmEdjm6kZ8ReSyXs4jpCHpEAFqWA
	qVO/7b4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4xib-000000012ps-2ckR;
	Tue, 24 Mar 2026 09:06:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4xiY-000000012pC-3CRE
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 09:06:32 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 953364D1CA;
	Tue, 24 Mar 2026 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774343188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0phjcraIpr6kclnIYW3HstHTcnEjybGITzwqz53oaY=;
	b=GssiSsBk8vcMzQ2RsXY5CF1v308YnrD6GUFgjtAtSFMSKyxp66vqoo/0ONOFqsSMecqdK1
	S2jLLWguVPYJH6nMaUEWqWf4ozTjUP17480JL/+DPRUQr+WJHG4TwgSiFKoA5UR4kzRJxU
	Wv7nHgVBglG8pBizrbScCwthqD8iKuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774343188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0phjcraIpr6kclnIYW3HstHTcnEjybGITzwqz53oaY=;
	b=Xj0AsKHm6DW8ZrpoKJHVuGhXu0inDBHRSMjUllFYH+cUwEr2at4CMYjfjnNb1aLpX1TrXQ
	t3n3NtmV9uw+RdBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GssiSsBk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xj0AsKHm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774343188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0phjcraIpr6kclnIYW3HstHTcnEjybGITzwqz53oaY=;
	b=GssiSsBk8vcMzQ2RsXY5CF1v308YnrD6GUFgjtAtSFMSKyxp66vqoo/0ONOFqsSMecqdK1
	S2jLLWguVPYJH6nMaUEWqWf4ozTjUP17480JL/+DPRUQr+WJHG4TwgSiFKoA5UR4kzRJxU
	Wv7nHgVBglG8pBizrbScCwthqD8iKuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774343188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0phjcraIpr6kclnIYW3HstHTcnEjybGITzwqz53oaY=;
	b=Xj0AsKHm6DW8ZrpoKJHVuGhXu0inDBHRSMjUllFYH+cUwEr2at4CMYjfjnNb1aLpX1TrXQ
	t3n3NtmV9uw+RdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8501A43D67;
	Tue, 24 Mar 2026 09:06:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NTNBHxRUwml8CgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 24 Mar 2026 09:06:28 +0000
Date: Tue, 24 Mar 2026 10:06:23 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org, 
	hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
Subject: Re: [PATCH 5/9] libnvme: add support for retrieving namespace
 gendisk I/O statistics
Message-ID: <3c8a6da5-31ef-44f0-a9c8-d675d810ea03@flourine.local>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-6-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321152823.3197870-6-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,flourine.local:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 953364D1CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_020630_957427_420883BE 
X-CRM114-Status: GOOD (  12.33  )
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

On Sat, Mar 21, 2026 at 08:58:04PM +0530, Nilay Shroff wrote:
> Gendisk I/O statistics provide useful insight into disk activity,
> including read/write/discard/flush operations, as well as information
> about in-flight I/Os and I/O timing.
> 
> Parsing these statistics allows users to determine the number of I/Os
> processed, time spent servicing I/O, number of sectors accessed, and
> the count of in-flight requests.
> 
> Add support for retrieving namespace gendisk I/O statistics. Also add
> support for computing deltas of these statistics between samples, such
> as I/O ticks, number of sectors, and number of serviced I/Os.
> 
> These metrics can be used by tools such as nvme-top to display real-time
> disk activity.

Same comments as in the previous patch.
  - error codes
  - is it necessary to expose 'cur', 'this' via the API?

