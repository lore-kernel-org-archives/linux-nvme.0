Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D29F532F8
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m2+SXCjbCrFKGqZSk/xQwRbAVc92PsYAjGOfnz6HI1Y=; b=fSuoTjrUvxdE870YeVsTGaIzg2
	j9gusWp6eo7RyfOe0UqZwtwguwfYbOSS7bXeCnc8WwLNdGgWQuFvllPTlR8wRUcsru3zLzQo/wEuy
	lYxz8UQ1tPOmn+2dHP7u0Z5gO/3Fb81oEA2ckYLgCC9ky2ElLPUZ1lbYwDW4c2XGrbbjfmtHOWxLK
	9G+kh+SRjN1a4vTFFa1J3hDQAsclL+EvdM/EZblV03oCfgXaRdVtQhjN3K4qbLtpq0SoM8rb9JILN
	MfinRRsZ31P3ry8mhf/2TKTZov2jR/wLQxkH77v30zGSEe2I4xQzjde3OB7z/7lTlLVer/+pVcq5C
	j76ZkSfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4xXj-000000011pm-36Rv;
	Tue, 24 Mar 2026 08:55:19 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4xXh-000000011pJ-08aG
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 08:55:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AAE524D2D4;
	Tue, 24 Mar 2026 08:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774342513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2+SXCjbCrFKGqZSk/xQwRbAVc92PsYAjGOfnz6HI1Y=;
	b=V8pNFfKHJmGmESZx9pVwqsIDdJ29+/g9DRI/On0wFa3MZ0cQZmOqIT6gX8ofodoDmsanoY
	5G4ZwoI9rdnIBW51mT4C9fqlfPXqQgGHTkKNpaf5HcThmTArAydSv8c5ialcmu7IYfaNUa
	0mxiEgvf5+S2LkmThTju4EO2iPgPNkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774342513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2+SXCjbCrFKGqZSk/xQwRbAVc92PsYAjGOfnz6HI1Y=;
	b=97XnTLLhPIl6SuBxCXyM1ALbcFzjSsu5EPunapn2zTfDKFIJWMNPPk9kPLyYO2lL+9pgWi
	ZdtNyKlRypJsTeCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FeyMhmwT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QcqVvIW5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774342511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2+SXCjbCrFKGqZSk/xQwRbAVc92PsYAjGOfnz6HI1Y=;
	b=FeyMhmwTA5DFsmZgt1smrlm0QtD4yfXR3eBbejGH80x/PYBJYHI9aTK+bQYR+eVt6m7u5k
	g+67fumMe+aal119+LyjYFp5Kb9+HZSQ/gnbjWIHl/1rHaXbFkwAwyt7d+cZZbDxurc90u
	33hPon+0voILCGsTnKCK6Qs0sKYqaFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774342511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2+SXCjbCrFKGqZSk/xQwRbAVc92PsYAjGOfnz6HI1Y=;
	b=QcqVvIW5GxA5pPnvvRB39l4Z7YH/bl+JBFwzZ6Vrk67YXytfqXx7OJ9c/PpQLA4H5hCf5K
	ECSfXk2/2TAIGyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A6CE43D5C;
	Tue, 24 Mar 2026 08:55:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VxeGJG9Rwml9fQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 24 Mar 2026 08:55:11 +0000
Date: Tue, 24 Mar 2026 09:55:07 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org, 
	hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
Subject: Re: [PATCH 1/9] libnvme: annotate nvme_path::ana_state with
 !accessors:none
Message-ID: <6ed0f13e-2aad-4b2f-a8b7-39e6b3f85606@flourine.local>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321152823.3197870-2-nilay@linux.ibm.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AAE524D2D4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_015517_225425_F1F48678 
X-CRM114-Status: UNSURE (   9.30  )
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

On Sat, Mar 21, 2026 at 08:58:00PM +0530, Nilay Shroff wrote:
> +__public char *nvme_path_get_ana_state(nvme_path_t p)
> +{
> +	_cleanup_free_ char *ana_state = NULL;
> +
> +	ana_state = nvme_get_path_attr(p, "ana_state");
> +	if (ana_state) {
> +		if (!p->ana_state || strcmp(ana_state, p->ana_state)) {
> +			free(p->ana_state);
> +			p->ana_state = strdup(ana_state);
> +
> +	}

a couple of tabs indention here

> +	}
> +
> +	return p->ana_state;
> +}

