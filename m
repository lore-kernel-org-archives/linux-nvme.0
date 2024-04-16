Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71573C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QPYJiiry+coQMfwqR6VYFAm42kJ8iAkPrnvOrpNcpVQ=; b=rRv+XvY9oqa+N7LHzZlUWAFR54
	CQlzi4snzg0t2HX/rJoJE7IEDQJsbTi0StRCHJqc3eAZaYlV++8+9av1iG14Acd3P9TXFHKX65G4R
	Gk5j/u6XxrPhuTiQgvwrGwU/QURH8ZcxyosJTlSqofGpR/OoMz6sv4U38vuJqsZU8JtMX3nUo7Q35
	eKmeQxMmrtCZMbbK9vCl/oZlps+TnzcN1h6/BcT/3IaCVi6hRvRDAQdujOzGQuxE0yfUgkw2lF0Pw
	WQEsrqArS4k2A0RVGNqtODorjNqQFUvsEqSSxTXqVUaOOINqArilPpEEvmrDBwKm1BKJSeil5x+Vo
	HGWHZe/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwlbD-0000000D0SU-0R3u;
	Tue, 16 Apr 2024 16:23:59 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwlb7-0000000D0Qx-3XtF
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 16:23:57 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 43BAD5D1A2;
	Tue, 16 Apr 2024 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713284628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYJiiry+coQMfwqR6VYFAm42kJ8iAkPrnvOrpNcpVQ=;
	b=Fa+6uOEDIuaUdLhs2kmh33zXHd8dVYDq0tXVjMYWbPf0CehwvlCc/NrQHWfxwsA8pmFdjS
	Jy1aRSe1YqiX5skeQHc3zwksBEW9a/L5h9b/zq1+NnFn98t5hfdVskShcz+UW6kXuJQzCN
	4Up5EJ3ansXEbJrD5t5A6WizielhWIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713284628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYJiiry+coQMfwqR6VYFAm42kJ8iAkPrnvOrpNcpVQ=;
	b=fNCg/DZe3XGUwsGcvjYg57LFfba7C3tMbgJS+dllSHedc7yLZmmasMGgIiKYdytEu1Qzb5
	PApYEKHUqnS9xtCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Fa+6uOED;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="fNCg/DZe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713284628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYJiiry+coQMfwqR6VYFAm42kJ8iAkPrnvOrpNcpVQ=;
	b=Fa+6uOEDIuaUdLhs2kmh33zXHd8dVYDq0tXVjMYWbPf0CehwvlCc/NrQHWfxwsA8pmFdjS
	Jy1aRSe1YqiX5skeQHc3zwksBEW9a/L5h9b/zq1+NnFn98t5hfdVskShcz+UW6kXuJQzCN
	4Up5EJ3ansXEbJrD5t5A6WizielhWIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713284628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYJiiry+coQMfwqR6VYFAm42kJ8iAkPrnvOrpNcpVQ=;
	b=fNCg/DZe3XGUwsGcvjYg57LFfba7C3tMbgJS+dllSHedc7yLZmmasMGgIiKYdytEu1Qzb5
	PApYEKHUqnS9xtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3297313931;
	Tue, 16 Apr 2024 16:23:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1/boChSmHmalGwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 16 Apr 2024 16:23:48 +0000
Date: Tue, 16 Apr 2024 18:23:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel Wagner <dwagern@suse.de>, 
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Message-ID: <fact36d4ueuna534ktaafuel4uqkexmlkrwasky6ytvpmi33bq@x26qccgbqbnw>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
 <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 43BAD5D1A2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_092354_228054_45C9F908 
X-CRM114-Status: GOOD (  18.98  )
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

On Tue, Apr 16, 2024 at 10:28:49AM +0000, Shinichiro Kawasaki wrote:
> >   # nvme_trtypes=rdma ./check nvme/006     ... works
> >   # NVMET_TRTYPES=(rdma) ./check nvme/006  ... does not work
> > 
> > I will modify the descriptions above in the v2 series to note that both
> > nvme_trtype and NVMET_TRTYPES are supported and usable.
> 
> I rethought this. Now I think it is bad that NVMET_TRTYPES can not be specified
> in command lines. To avoid this drawback, I think it's the better to change
> NVME_TRTYPES from an array to a variable with multiple items separated with
> spaces. For example, three types can be specified to NVMET_TRTYPES like this:
> 
>    NVMET_TRTYPES="loop tcp rdma"
> 
> NVMET_BLKDEV_TYPES has the same restriction then I will change it also from an
> array to a variable in same manner. I will send out v2 soon with this change.
> 
> Daniel,
> 
> I assume this change is fine for your use case. If it is not the case, please
> let me know.

Yes, it's nice that all the configure variables are of the same type.

On this topic, I am a bit confused about the naming scheme. We have the
lower case ones, e.g. 'nvme_trtypes' and now the upper case ones
NVMET_TRYPES. I assume you prefer the upper case to mark them they are
injected from the environment and the lower case ones are globals
variables in the framework. Should we retire the lower case ones and
replace them with upper case ones?

