Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0DCC48260
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Feb 2024 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eXJu1lti/YL9b9eLBL5o0g1fuOA+z3Z1pve6u3c4mhQ=; b=QF0a+g8PSla4XtlSOdML8G9bM0
	QOok8L8hq75zunzoBoay3Jc1vvzklC2//SdDcQuEDu4K0vPi+rR1fnrTH4c+PAJbwxPCzARAvyHrW
	1WAHL4wwrKYrfaMe1TWbCSxaNR3yAz7x4XXkfVM0wXP4MAvIlrtcHOpYr2jrYuad65iybjVaUywbt
	G68s4X3xPDFX90B+zqf3u84gJjpzOZa46cQcO9rqzFg80LleUMOovBYRVkjVzvDLxI5qrrw6+CFqj
	qUW9bGUa90o5Jhp3BnPHkkNRaC32YbuCG7fT8v6WY03SPchJLUdRuXx9146bOHFPVxyYX32mzmI1B
	m1jy+Yew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb1Ju-000000032Iw-34XR;
	Fri, 16 Feb 2024 16:44:14 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb1Jl-000000032HV-1Aqe
	for linux-nvme@lists.infradead.org;
	Fri, 16 Feb 2024 16:44:07 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E9731FB73;
	Fri, 16 Feb 2024 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708101843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXJu1lti/YL9b9eLBL5o0g1fuOA+z3Z1pve6u3c4mhQ=;
	b=oXxYf1GPFWXOcgqcHA2ePzg3k8lbTe5hjXx7KDjENBXhJ9IOAOBTKxP0EQ3/bP9kiX08RB
	9FQk652sf8JXla23ZARcq32SRIXxMkEKc2OQrTBrfeWNoHeEbJAePYu7OlHMCpE4u/Xc2/
	7SoYKKFkwFfTTEovCasaVjo1CXzA3Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708101843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXJu1lti/YL9b9eLBL5o0g1fuOA+z3Z1pve6u3c4mhQ=;
	b=RPF5q9EEsaz/WG47s0EwJdUF0GQIGvUBDsYv42hxwOdVr/W2jEkFKDERCD5cUHa3ywLC7y
	lvRNIfmWHVdNxTBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708101843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXJu1lti/YL9b9eLBL5o0g1fuOA+z3Z1pve6u3c4mhQ=;
	b=oXxYf1GPFWXOcgqcHA2ePzg3k8lbTe5hjXx7KDjENBXhJ9IOAOBTKxP0EQ3/bP9kiX08RB
	9FQk652sf8JXla23ZARcq32SRIXxMkEKc2OQrTBrfeWNoHeEbJAePYu7OlHMCpE4u/Xc2/
	7SoYKKFkwFfTTEovCasaVjo1CXzA3Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708101843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXJu1lti/YL9b9eLBL5o0g1fuOA+z3Z1pve6u3c4mhQ=;
	b=RPF5q9EEsaz/WG47s0EwJdUF0GQIGvUBDsYv42hxwOdVr/W2jEkFKDERCD5cUHa3ywLC7y
	lvRNIfmWHVdNxTBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B3C813343;
	Fri, 16 Feb 2024 16:44:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4lLoENOQz2XgVgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 16:44:03 +0000
Date: Fri, 16 Feb 2024 17:44:02 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 1/6] nvme-fabrics: introduce connect_sync option
Message-ID: <jfjchxptpfcpolpy2etiigflqvfcp2nzk53iwb6rx2zsdfd6by@h6ezfayjfqai>
References: <20240216084526.14133-1-dwagner@suse.de>
 <20240216084526.14133-2-dwagner@suse.de>
 <20240216094909.GA19961@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216094909.GA19961@lst.de>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oXxYf1GP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RPF5q9EE
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5E9731FB73
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_084405_493512_DE395D63 
X-CRM114-Status: GOOD (  18.18  )
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

On Fri, Feb 16, 2024 at 10:49:09AM +0100, Christoph Hellwig wrote:
> On Fri, Feb 16, 2024 at 09:45:21AM +0100, Daniel Wagner wrote:
> > The TCP and RDMA transport are doing a synchronous connect, meaning the
> > syscal returns with the final result, that is. it either failed or
> > succeeded.
> > 
> > This isn't the case for FC. This transport just setups and triggers
> > the connect and returns without waiting on the result.
> 
> That's really weird and unexpected.  James, can you explain the reason
> behind this?

James answered this point on my attempt to make this synchronous:

https://lore.kernel.org/linux-nvme/0605ac36-16d5-2026-d3c6-62d346db6dfb@gmail.com/

> > Introduce a flag
> > to allow user space to control the behavior, wait or don't wait.
> 
> I'd expect this to be the default, but I'll wait to hear more about
> the rationale.  If we keep the async default the option looks sensible.

Ideally, we could agree on behavior which is the same for all
transports.

