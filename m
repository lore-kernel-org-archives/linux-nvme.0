Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DBBCD1296
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 06:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HlDhm6YWrzg5UyEIsFpWx/PS0QCxqw3jTEwWr2WCYcY=; b=JjRBnB6/ntA8pOf358vHaMnYaS
	xaWnMDOOoAOOftlkIy8G/n1dKB6RgnXYZ2MEBSXAqqH6rd4LbS+52KWTyDoNoIh1NeS0T8bIKZ/s3
	e5p0pWdfvKegDMq/R61f6Lfk1JcKr0WoahYQnUlJAMErzzT5UizCfH3Dlt4PLPhilmdReQ7x5FysK
	frciiQC17qToRAju7tpYFtrjSquKPm6y9qBrXhkliYAheHhV9zpdXJpwR60DsYrFt0MYKRu68LjLC
	Q8u5R1oWCgx7/lpUFLmKbSyFjvbY7f8eHMgG8tvXuSFbop1LwIlZiggTLQSLoEKkPAy2LA442sVZG
	lVIUinXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruRp9-00000005UH9-3x3c;
	Wed, 10 Apr 2024 06:52:47 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruRp5-00000005UEE-2pyH
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 06:52:46 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EC665C655;
	Wed, 10 Apr 2024 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712731960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlDhm6YWrzg5UyEIsFpWx/PS0QCxqw3jTEwWr2WCYcY=;
	b=IPmugtWcLBSQ2LEvvl9lBEzjLpUI1gl1fsVlDykoueSi/xQLK24YVHaT0gxapJdo56R6yS
	4DUfiBCHY9w0OyPC3y5k9rsYmFdqJMuDFVJi53ev1ND52kXMIXTi/MmboBPMeFeccVt7+G
	3p0PBSKnBAHM/kuFtvFfm9bp1bodwVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712731960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlDhm6YWrzg5UyEIsFpWx/PS0QCxqw3jTEwWr2WCYcY=;
	b=u/ME1YDtcj4q4bhHkXlNu6KcXolmnpzMY8hHUY7uFJYd4XW3ffVSiCUOmQAgkloSdENSr/
	80U7s9/aicnW29DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712731960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlDhm6YWrzg5UyEIsFpWx/PS0QCxqw3jTEwWr2WCYcY=;
	b=IPmugtWcLBSQ2LEvvl9lBEzjLpUI1gl1fsVlDykoueSi/xQLK24YVHaT0gxapJdo56R6yS
	4DUfiBCHY9w0OyPC3y5k9rsYmFdqJMuDFVJi53ev1ND52kXMIXTi/MmboBPMeFeccVt7+G
	3p0PBSKnBAHM/kuFtvFfm9bp1bodwVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712731960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlDhm6YWrzg5UyEIsFpWx/PS0QCxqw3jTEwWr2WCYcY=;
	b=u/ME1YDtcj4q4bhHkXlNu6KcXolmnpzMY8hHUY7uFJYd4XW3ffVSiCUOmQAgkloSdENSr/
	80U7s9/aicnW29DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D8601390D;
	Wed, 10 Apr 2024 06:52:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id bceDETg3FmYRPgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 10 Apr 2024 06:52:40 +0000
Date: Wed, 10 Apr 2024 08:52:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
Message-ID: <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
 <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_235243_909116_6AEF8827 
X-CRM114-Status: GOOD (  13.41  )
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

On Tue, Apr 09, 2024 at 11:26:00PM +0300, Sagi Grimberg wrote:
> 
> 
> On 09/04/2024 12:35, Daniel Wagner wrote:
> > From: Hannes Reinecke <hare@suse.de>
> > 
> > Any authentication errors which are generated internally are always
> > non-retryable, so use negative error codes to ensure they are not
> > retried.
> 
> The patch title says that any authentication error is not retryable, and
> the patch body says "authentication errors which are generated locally
> are non-retryable" so which one is it?

Forgot to update the commit message. What about:

  All authentication errors are non-retryable, so use negative error
  codes to ensure they are not retried.

?

