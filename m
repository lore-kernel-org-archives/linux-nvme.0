Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2ACF589B0
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1sqHqvlZYXHIm94uWIEWLqHumMInJGVjKy3txPSiUqQ=; b=Nuro2fvu5VZSfsiCzhsp4NSRdR
	V/dLtHAzNbBhxTTjmrl3JKS8YqKWNli7b4Vevup7St0n8diLIG2WuNA/JSA1LMJ5ebkOpzKBqGs3D
	MT3lZOp1YtatAapmJKjcJOJZ47gordHVcp2cSIxiOb3O1WYFQDraGFoQBGCpsqOzMn/vv2w/VKg6Y
	2l5bPt3ce+EwJUX9KTkptOrUyN5tHdNnNgXvfPGz0ffnYq5OE5PdZhdUXumKtJSi4XAfSfb1uoqnD
	9vLR9yH+1YQC2/HHwbFGw028+Od6QyMhbj+xB0KVQlAc7qtxw41nFe1TU88E0KmS0voLDy5gre3ay
	HYgM9ekA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFtSY-0000000BgK8-1YhJ;
	Thu, 23 Apr 2026 12:47:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFtSV-0000000BgJa-33RZ
	for linux-nvme@bombadil.infradead.org;
	Thu, 23 Apr 2026 12:47:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1sqHqvlZYXHIm94uWIEWLqHumMInJGVjKy3txPSiUqQ=; b=X1FJnMWdzq6A43hLYBx2SJN+SK
	18vkyA0redgnUziwdm2VFQF9/8hRn/AnCEfKK7SGFhPo1VKccHB7bADLBPzaY3mz7jhLHbRrJ6Sh0
	VIwMzMN5pA59BmB8hg+i6NL0VtWPEvehh5R4CUrPZSf4w9kHp7bcu78+7nL7IKBY58gFWf4CUlqfH
	/9W7OFctjV5xBILR1jdeODflDpaTGeE4oWQofaQv3J3NF5NmV4N0Oi7BEvKqeAV38mtY+Dpceju/N
	xZ7BTLNLlvYvfczhG3Ly/R93BwGu4nnI5BuSZ51VfkNSPCRNw4XzlJAIhJ9PtumFvf19mBlSy5OYJ
	Wza0kGLA==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFtSP-0000000D3vx-0CfH
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 12:47:06 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37A425BD11;
	Thu, 23 Apr 2026 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776948419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sqHqvlZYXHIm94uWIEWLqHumMInJGVjKy3txPSiUqQ=;
	b=Dg5W/s1U4j2edcrSRX11LTcZI+1nv4L0gG+h1szAK2O3T2/ANdQdQhjwT52bT1uje0hVje
	1XcEpQg/vjzG5FzkQik9MTJ/dKOCFjuMCw5TRTFD1OcdLLFRdm43xk1UzQSiT9d/fGOp97
	/052dEGAT+lJGrIX0T6zir5A7pwd6OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776948419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sqHqvlZYXHIm94uWIEWLqHumMInJGVjKy3txPSiUqQ=;
	b=oHBNYiMmyO2/o6b/FXkCGbqO4XPiSrRXOTWk6EoLjs2ATjSI4Rp0K46OD1SLGDIg4UqVKC
	44eHIqrYzVOeQCBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776948419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sqHqvlZYXHIm94uWIEWLqHumMInJGVjKy3txPSiUqQ=;
	b=Dg5W/s1U4j2edcrSRX11LTcZI+1nv4L0gG+h1szAK2O3T2/ANdQdQhjwT52bT1uje0hVje
	1XcEpQg/vjzG5FzkQik9MTJ/dKOCFjuMCw5TRTFD1OcdLLFRdm43xk1UzQSiT9d/fGOp97
	/052dEGAT+lJGrIX0T6zir5A7pwd6OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776948419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sqHqvlZYXHIm94uWIEWLqHumMInJGVjKy3txPSiUqQ=;
	b=oHBNYiMmyO2/o6b/FXkCGbqO4XPiSrRXOTWk6EoLjs2ATjSI4Rp0K46OD1SLGDIg4UqVKC
	44eHIqrYzVOeQCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 272FE593A3;
	Thu, 23 Apr 2026 12:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vONaCMMU6mnCBAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 23 Apr 2026 12:46:59 +0000
Date: Thu, 23 Apr 2026 14:46:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org, 
	mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com, 
	linux-nvme@lists.infradead.org, mkhalfella@purestorage.com, chaitanyak@nvidia.com, 
	hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 2/8] nvme: add sysfs attribute to change admin timeout
 per nvme controller
Message-ID: <e99f2ce9-e47a-432a-b6ea-795081de1f4d@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-3-mlombard@redhat.com>
 <a3171007-7cfb-45b0-b0bf-01dcc7ba51ab@flourine.local>
 <DHZMXEY4JPEF.1HHTTEZPN53ZU@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHZMXEY4JPEF.1HHTTEZPN53ZU@arkamax.eu>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_134701_225811_8849826F 
X-CRM114-Status: GOOD (  19.36  )
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

On Wed, Apr 22, 2026 at 01:08:44PM +0200, Maurizio Lombardi wrote:
> On Wed Apr 22, 2026 at 12:10 PM CEST, Daniel Wagner wrote:
> > On Fri, Apr 10, 2026 at 09:39:18AM +0200, Maurizio Lombardi wrote:
> >> +	/*
> >> +	 * Wait until the controller reaches the LIVE state
> >> +	 * to be sure that admin_q and fabrics_q are
> >> +	 * properly initialized.
> >> +	 */
> >> +	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
> >> +		return -EBUSY;
> >
> > I assume the idea is to use an udev rule to set the value. Though I
> > think this is racy:
> >
> > 	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
> > 	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
> 
> 
> Not really, the idea was about to prevent the user from setting the
> timeouts too early during the controller's initialization.

Yes, but then how do you know when is too early? Do you read/poll the
state of the controller? 

> Otherwise the user could try to change the timeout while
> admin_q and fabrics_q are still being created.
> 
> if the NVME_CTRL_STARTED_ONCE bit is set, we know that the
> initialization has been completed and that admin_q and fabrics_q will
> exist until the controller will be torn down.

Yes, that is all fine but I think it would be good to be able to use
udev here as we have it other timeouts.

