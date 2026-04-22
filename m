Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40813F9B608
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q1xMRZWqDfIhySbVfrKu97fD/4kfP1NTWCjWEK9b9/E=; b=Nh1iftF7ua37Zkbl6uapCXWlxN
	zXB2hV+qMgureGWglGs7MIEo/IXxfg4XXq+v/sX2QPcoh4qCx52bDFBMUb8Fs5eG9sN4Uo07VzZY1
	XobV6Q7mrpyhUiKgylLNzD+ZwPwVgQDHyhBvPG+pDq0tsRoUuVoCkO05UmtLPoc0ZXcqzeGlK7Emy
	u+iwcQJkgORE6Pqgz3y/mQqvzORDpe/l0EAa0XDng6OUf3CdvFvVHMnzTiLSZDewohOmSGnlWWKe2
	js2qebq6vWZHf2JEXHhTifiAomQA5wGqFyRD18omVoPPQAEa1rSY9LBgC/q91LDQfpqsxNQmZ9JHM
	yn7VXaPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFUXq-00000009vmr-1CW1;
	Wed, 22 Apr 2026 10:10:58 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFUXn-00000009vm5-3PF2
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 10:10:57 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 082696A81D;
	Wed, 22 Apr 2026 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776852654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1xMRZWqDfIhySbVfrKu97fD/4kfP1NTWCjWEK9b9/E=;
	b=V/0XDtQVw6m42jrQd7Lov7F0BDvQvzGo1IsGfl1Hd+jfxHQTqL5NswnPxRI66r7H6D3LkJ
	LzC+krZjgFiYlzNj3nuDTmYPbhssfnH61qeGA9mc9WDw42FmCGKHG3rXeqsyKISrqSCuQj
	XfrPsgZWm+ny+3V3h0ZjuxOiJRSe3Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776852654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1xMRZWqDfIhySbVfrKu97fD/4kfP1NTWCjWEK9b9/E=;
	b=M9Xqbxq/SAAOqM7Eq9EQWSqz2WDhKT/pwY50U9fPw8Vq8cOIGFe1qWkaO8TqpAsPYz3tZf
	HYkQktbh7zDxRIDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776852654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1xMRZWqDfIhySbVfrKu97fD/4kfP1NTWCjWEK9b9/E=;
	b=V/0XDtQVw6m42jrQd7Lov7F0BDvQvzGo1IsGfl1Hd+jfxHQTqL5NswnPxRI66r7H6D3LkJ
	LzC+krZjgFiYlzNj3nuDTmYPbhssfnH61qeGA9mc9WDw42FmCGKHG3rXeqsyKISrqSCuQj
	XfrPsgZWm+ny+3V3h0ZjuxOiJRSe3Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776852654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1xMRZWqDfIhySbVfrKu97fD/4kfP1NTWCjWEK9b9/E=;
	b=M9Xqbxq/SAAOqM7Eq9EQWSqz2WDhKT/pwY50U9fPw8Vq8cOIGFe1qWkaO8TqpAsPYz3tZf
	HYkQktbh7zDxRIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAFA4593AF;
	Wed, 22 Apr 2026 10:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bSIuOK2e6GnFYQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 22 Apr 2026 10:10:53 +0000
Date: Wed, 22 Apr 2026 12:10:52 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 2/8] nvme: add sysfs attribute to change admin timeout
 per nvme controller
Message-ID: <a3171007-7cfb-45b0-b0bf-01dcc7ba51ab@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-3-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-3-mlombard@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_031056_026305_2C79B89F 
X-CRM114-Status: GOOD (  10.72  )
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

On Fri, Apr 10, 2026 at 09:39:18AM +0200, Maurizio Lombardi wrote:
> +	/*
> +	 * Wait until the controller reaches the LIVE state
> +	 * to be sure that admin_q and fabrics_q are
> +	 * properly initialized.
> +	 */
> +	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
> +		return -EBUSY;

I assume the idea is to use an udev rule to set the value. Though I
think this is racy:

	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);

