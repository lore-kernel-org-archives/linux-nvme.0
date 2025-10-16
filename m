Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81D7CCD194
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Oct 2025 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cVV/KwHjxiS7+96/bFDec8FyYsMnOtZihuFI+9lxnyE=; b=xe4AhdOJpWka6//JirxNNMPNCD
	w0ODEApHEd7q+eCzYv8K9NrOnDAMzPTJ4kepcP65IW2qqw/FFNMOW11yvB8uWTIIc5uQYalQLcMyE
	NQxH+TZbBDmwsSHqdUlAh+DdT2KHx5vrAHXTYpXdqhHQ5eQPV/IHAJ6IY6PUKw56FGRbfXV6dOzyh
	JGeYCuY2XQOk4DHlp/ozpFUSgyCDqNXI4STEKBjlHwzL5oolQMhcKh6QQT9/7uKIQ9Us/zX8CzuaZ
	Jyu0D6R6YN0uTxvVhPZbZyxFVB8iW/2U4di1YP0/gLEysp4fX/bUt6gwDV9AiMTHOpMHy7M/H7NnG
	mgIZC1Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9JKO-00000003vrB-2zhD;
	Thu, 16 Oct 2025 08:27:16 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9JKL-00000003vpZ-3LOA
	for linux-nvme@lists.infradead.org;
	Thu, 16 Oct 2025 08:27:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8317821D33;
	Thu, 16 Oct 2025 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760603230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVV/KwHjxiS7+96/bFDec8FyYsMnOtZihuFI+9lxnyE=;
	b=Tgp6aOIeRqiIAqLXG7r4+BlqC6Px29qc462eVTtkGGZvUS0C9LvbYiBLulWzjnHO2QqjNQ
	vZd3oHIxUAAEC5UkCmxiAuDWCp7lgOtpVGm5tCNWv+ZDMdiE/qq7z3UmGHX2vOo29xMq9U
	xXqfpHnQXqTYyZxJMIOBtRVsRIF6SY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760603230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVV/KwHjxiS7+96/bFDec8FyYsMnOtZihuFI+9lxnyE=;
	b=7ownKTXDpjl+jdjUkA3N/YGLWogx+P6HRcIGLsZ8vLYZsiPgL9DyG5YPsULfDviKxP6vrA
	L91OfxP6HNQUPiAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Tgp6aOIe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7ownKTXD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760603230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVV/KwHjxiS7+96/bFDec8FyYsMnOtZihuFI+9lxnyE=;
	b=Tgp6aOIeRqiIAqLXG7r4+BlqC6Px29qc462eVTtkGGZvUS0C9LvbYiBLulWzjnHO2QqjNQ
	vZd3oHIxUAAEC5UkCmxiAuDWCp7lgOtpVGm5tCNWv+ZDMdiE/qq7z3UmGHX2vOo29xMq9U
	xXqfpHnQXqTYyZxJMIOBtRVsRIF6SY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760603230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVV/KwHjxiS7+96/bFDec8FyYsMnOtZihuFI+9lxnyE=;
	b=7ownKTXDpjl+jdjUkA3N/YGLWogx+P6HRcIGLsZ8vLYZsiPgL9DyG5YPsULfDviKxP6vrA
	L91OfxP6HNQUPiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A5501376E;
	Thu, 16 Oct 2025 08:27:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NJqVGV6s8GhfFQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 16 Oct 2025 08:27:10 +0000
Date: Thu, 16 Oct 2025 10:27:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [RFC PATCHv2 4/4] nvme-multipath: add debugfs attribute for
 adaptive I/O policy stat
Message-ID: <803f429d-60f3-4af7-9535-37a2038e53c1@flourine.local>
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
 <20251009100608.1699550-5-nilay@linux.ibm.com>
 <359e3d8f-4db7-4430-8520-4fed9de4f48e@suse.de>
 <4faf672b-ad74-41dc-9518-bbb9af557544@linux.ibm.com>
 <d179666e-aed5-476e-a6b6-73b3a80ce925@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d179666e-aed5-476e-a6b6-73b3a80ce925@suse.de>
X-Rspamd-Queue-Id: 8317821D33
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_012713_986043_7A8A9B02 
X-CRM114-Status: GOOD (  13.55  )
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

On Thu, Oct 16, 2025 at 08:14:19AM +0200, Hannes Reinecke wrote:
> > Currently queue_depth and numa_nodes attributes are created under
> > sysfs, so do you meant to move those attributes from sysfs to
> > debugfs?
> > 
> Yes. sysfs information can be perused by udev rules, and that assumes
> the information in there will not change without a 'CHANGE' uevent.
> So it's questionable whether volatile information like the queue depth
> or the round-robin path selection should be presented there.
> I'd rather have it moved into debugfs.
> 
> But that might be personal preference.

If this moves to debugfs, I think nvme-cli should not show it per
default. Don't want to get lots of questions why the value is not
showed or updated.

