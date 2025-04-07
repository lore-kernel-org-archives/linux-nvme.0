Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6925CC36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6BiIpIpDIqqYvk4vlqM3fV8trpN1udJJCEYdAMg0pM=; b=Ir5hIWwt9IkMVv2sWSVVhk1JW1
	UqreW1UARtxBDjWQ7ICVdug7Jo3w3RN6Lfk635koiEEIXPDUJ8RhwCvekc0EzUHQwWXJ+uOfF3BnJ
	1qFYSq8Z6lIU4W8pTsZ2s5kNGlgNZYXqSXSV45SotooWYf+uNnDqRyvUs6DVHlWDn9MpaSqYjwR5W
	jzJoPVaV4VD7RqQIc9B4wFC5ysh79DBc34Utmvi4uzX8ErRaaA0VxtiFWBWH+YYOWvsPxr2c/JwEN
	hNfa9KSxoKPyTqxcYKfK+JEfmwbq4VsPkRV8IWyGTuOdng/L5Eb+NHmZDVxjvr0AUlrPhMArtvci1
	OH0hoGdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1kRj-0000000HXP4-1coO;
	Mon, 07 Apr 2025 11:15:19 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1kNa-0000000HWNx-0kSO
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 11:11:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C26F1F388;
	Mon,  7 Apr 2025 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744024260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R6BiIpIpDIqqYvk4vlqM3fV8trpN1udJJCEYdAMg0pM=;
	b=tfRBePe/4XQI9hCR11kFOt0CbydaibRutEtc3DTDjXWu7qEfFXWsRZsbk8J9ZSIqlKi9U5
	euMBubEkKSyJQJevyZMG+9lTgNnUqHaaia6PmGkcbE3FA8e3ua2PgMgUN94HZ8GrkYPf1x
	NIIuXPr6Hjp6QlHkqex26ayaWppRneM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744024260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R6BiIpIpDIqqYvk4vlqM3fV8trpN1udJJCEYdAMg0pM=;
	b=0P+yszsOaqKwCXONiYXKS8P5J527sCtWeKvUrrZj0WX31swzo9NAXXw5ezPfZ0o/DzSjqo
	oCS27SgJLcjcwCBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744024260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R6BiIpIpDIqqYvk4vlqM3fV8trpN1udJJCEYdAMg0pM=;
	b=tfRBePe/4XQI9hCR11kFOt0CbydaibRutEtc3DTDjXWu7qEfFXWsRZsbk8J9ZSIqlKi9U5
	euMBubEkKSyJQJevyZMG+9lTgNnUqHaaia6PmGkcbE3FA8e3ua2PgMgUN94HZ8GrkYPf1x
	NIIuXPr6Hjp6QlHkqex26ayaWppRneM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744024260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R6BiIpIpDIqqYvk4vlqM3fV8trpN1udJJCEYdAMg0pM=;
	b=0P+yszsOaqKwCXONiYXKS8P5J527sCtWeKvUrrZj0WX31swzo9NAXXw5ezPfZ0o/DzSjqo
	oCS27SgJLcjcwCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A49D13A4B;
	Mon,  7 Apr 2025 11:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fs5fG8Sy82doZQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 07 Apr 2025 11:11:00 +0000
Date: Mon, 7 Apr 2025 13:10:59 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, kbusch@kernel.org, 
	gjoyce@ibm.com
Subject: Re: [PATCH 3/3] tree: add attribute numa_nodes for NVMe path object
Message-ID: <89bce70c-8eac-4dee-a5ca-4aa52fa5687f@flourine.local>
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-4-nilay@linux.ibm.com>
 <1f88256a-f36f-4a34-96e2-53d2b6da7764@flourine.local>
 <4db3b302-3a07-4e82-aa5c-c63c55de2c6f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db3b302-3a07-4e82-aa5c-c63c55de2c6f@linux.ibm.com>
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_041102_367196_0628076E 
X-CRM114-Status: GOOD (  23.29  )
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

On Mon, Apr 07, 2025 at 03:29:53PM +0530, Nilay Shroff wrote:
> On 4/7/25 1:14 PM, Daniel Wagner wrote:
> > On Sat, Apr 05, 2025 at 06:32:49PM +0530, Nilay Shroff wrote:
> >> Add a new attribute named "numa_nodes" under the NVMe path object. This
> >> attribute is used by the iopolicy "numa". The numa_nodes value is stored
> >> for each NVMe path and represents the NUMA node(s) associated with it.
> >> When the iopolicy is set to "numa", I/O traffic originating from a given
> >> NUMA node will be forwarded through the corresponding NVMe path.
> >>
> >> The numa_nodes attribute is useful for observing which NVMe path the
> >> kernel would choose for I/O forwarding based on NUMA affinity. To support
> >> this, export the attribute in libnvme.map so it can be accessed via
> >> nvme-cli.
> > 
> > This one has the same limitation as the previous one. Given that libnvme
> > currently caches everything, we could just accept this limitation for
> > the time being. Any thoughts on this?
> 
> Yes agreed. So how about adding a new API, for instance, 
> nvme_path_get_numa_nodes__no_cached which would not return 
> the cached value but instead re-read the latest value from
> sysfs attribute and return the latest value? We may similarly
> extend other APIs where we don't want to retrieve cached 
> value. 

Adding _no_cached function is certainty an option for libnvme 1.x.

One of the API changes for the next major version of libnvme (aka 2.x)
is to add an handle to all functions. Currently, we only have it for the
fabrics API. If such handle is available, we could add no-cache flag
instead duplicating all functions.

Maybe adding an explicit flags argument for 1.x is an option or should
we just keep going with the cached only approach?

