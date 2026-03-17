Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1A7FD7065
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w3/jFMGouVK3V6xfQi2vrpJENRw4ZSv6/V2GWJt4Wu0=; b=D3uS74IWxmfLqAEDqxhAvZVIkA
	TmJugpUgcFAR8+gDYP45iHnQX9KiCLYqoVIGCtME3qg0vUvdHMtaMHAwy9P4JNiSc9LkvTII3Mmt2
	g+xv4x280xWRtSyc3m91llhjmke6qjAWJN/LI0IRpdG2i4TlxfGpUA+f6EwBEdJsUAsN5w0qehV54
	y49O8PeB+2F0Q+aXY0HrgRoRqulLxpFDueBKc6oRw9ZAk4aXbMI/g9w0TSVTRu4lUJbfWCEIOnjj6
	W3vOmTSQPBZg64s4YYEzh6EZXDY8RdogQR5GyYdfsNPQK+S0JOOk8xEBCpIZ6NU/fhA3C2tP1JoDB
	YnwXeE3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2ROC-00000005xRS-0MKy;
	Tue, 17 Mar 2026 10:11:04 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2RO9-00000005xPu-2J6P
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 10:11:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9AAEA5BDCA;
	Tue, 17 Mar 2026 10:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773742259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3/jFMGouVK3V6xfQi2vrpJENRw4ZSv6/V2GWJt4Wu0=;
	b=cf/Q7nAwkJvy2q3Cyv5gKDimXTFLaREUl50+dXpFbPAO9QvK8XTPQtLZchoaW43Od57+nY
	/2jtDa1OXIqpeyVojHC5FR3jVKKJrN7pRMiHFxHDZuXREThf5EZ3UvC5fVr2b7fYmthljY
	I16k0oBy7hQ3iuBK6jaZNc47qmMcZNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773742259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3/jFMGouVK3V6xfQi2vrpJENRw4ZSv6/V2GWJt4Wu0=;
	b=v90tr/tW+M0Db9UQX1r7PTzSjMtmh//Pl9/m7cKd9oF/5D08BVOCKmVmphQEjCztMpHFIz
	gwvEmGdcMCVRj6BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="cf/Q7nAw";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="v90tr/tW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773742259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3/jFMGouVK3V6xfQi2vrpJENRw4ZSv6/V2GWJt4Wu0=;
	b=cf/Q7nAwkJvy2q3Cyv5gKDimXTFLaREUl50+dXpFbPAO9QvK8XTPQtLZchoaW43Od57+nY
	/2jtDa1OXIqpeyVojHC5FR3jVKKJrN7pRMiHFxHDZuXREThf5EZ3UvC5fVr2b7fYmthljY
	I16k0oBy7hQ3iuBK6jaZNc47qmMcZNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773742259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3/jFMGouVK3V6xfQi2vrpJENRw4ZSv6/V2GWJt4Wu0=;
	b=v90tr/tW+M0Db9UQX1r7PTzSjMtmh//Pl9/m7cKd9oF/5D08BVOCKmVmphQEjCztMpHFIz
	gwvEmGdcMCVRj6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B49D4273B;
	Tue, 17 Mar 2026 10:10:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pargILMouWkeVwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 17 Mar 2026 10:10:59 +0000
Date: Tue, 17 Mar 2026 11:10:54 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: libnvme API review
Message-ID: <f469ac91-a55a-4b19-b251-31081537d403@flourine.local>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <2e26ab34-5568-4b5e-bfbb-7466eb515f13@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e26ab34-5568-4b5e-bfbb-7466eb515f13@nvidia.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9AAEA5BDCA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_031101_739400_953AA144 
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

Hi Chaitanya,

On Mon, Mar 16, 2026 at 05:32:00PM +0000, Chaitanya Kulkarni wrote:
> Based on the Curtis's comment if we follow this format we may not be
> compliant with spec, if that is okay with everyone then we should strictly
> follow the spec.

As I pointed out, we have to separate the NVMe spec related APIs from
the library APIs. These are two separate things.

> Otherwise
> nvme_[ACTION]_[COMPONENT] format is much easier to follow and keep it
> consistent across the whole code-base.

Going strictly this rule is an option but it would make the tree.h API
slightly less well organized, IMO. E.g. we have function which operate
on the namespace object:

    nvme_ns_get_csi
    nvme_ns_get_eui64
    nvme_ns_get_firmware
    ...
    nvme_path_get_ctrl
    ...
    nvme_ctrl_get_address

would then be

    nvme_get_ns_csi
    nvme_get_ns_eui64
    nvme_get_ns_firmware
    ...
    nvme_get_path_ctrl
    ...
    nvme_get_ctrl_address

Sure this works. I am not really attached to either way. If someone
really makes a strong argument to touch the complete tree.h API, I would
suggest to stick with the current solution.

> nvme_identify_controller()
> nvme_identify_ns()
> nvme_create_ctrl()
> nvme_create_ns()
> nvme_match_ctrl_config()
> nvme_get_subsystem() and
> nvme_reset_subsystem().

Yes, this is what I'd like to do (except for the tree.h part).

> It will be very inconsistent if we try to follow the spec since spec may
> not follow same convention (???).

I left out is the mi.h header. It strictly follows the NVMe spec with
gives some 'interesting' names. Though it's very simple to find the relevant
part in the spec.

> Keeping the naming convention separate from the spec and following
> above example format is much easier for long term nvme-cli future and
> maintenance.

In the other mail you argued it's good to stick to the same names. Did
you mean this for the nvme commands and the 'payload'?

Cheers,
Daniel

