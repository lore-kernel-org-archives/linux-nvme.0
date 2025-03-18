Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4EDC282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z1+GRzDBEJ3yO+UybatdwhvZcQGrlwdOntRypEmfOAI=; b=pxMUDQjeSxYvRsEtoK27dK3neM
	Z7DdYYxP3dw3oK11guMUUKdZZAJhDne3mD+K2C3vA1bPKR++zG4Ak32/3aNuMUhFa4MQiFs7IAboN
	+FtzzfY601TBxvzrZwHF6iFAZhcgS+qDMEyjGAdshQjYdVuksFMEs/gBGb+aw8OuOss2zEoTNY26p
	4GBQcuyqSk+CGhfmisK/2efvqpMH+8SA3e08wKVABsa6TiYkJr6taIc051U80nCzdzsOvfLSmJFNw
	sBew2w9NCDMWj6OBg4YGRtHug6bIVErCuFik6CsEz8WEt8dsl+W8JFTLX5TZpwez/K17R0Kfsm7/t
	vHhF9vFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXMO-00000006577-10iU;
	Tue, 18 Mar 2025 13:52:00 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXJk-000000064bo-41dy
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 13:49:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A5891F45B;
	Tue, 18 Mar 2025 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742305755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1+GRzDBEJ3yO+UybatdwhvZcQGrlwdOntRypEmfOAI=;
	b=SrEjnnU9f3J0CAKIJddEbIRsOGfKDQFT0limJKycLkISwHVD2rwnCQMHqccqfnMtpjzEpn
	UOqtS710xtzQABlTPdT+E3uYe5c+uZXJqpDnmxgKKdwQOZB9krcuagR1isSFq8UOgYy3Qn
	siq5uXwbEynt8S8PiTYnzjYaKksJ1M8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742305755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1+GRzDBEJ3yO+UybatdwhvZcQGrlwdOntRypEmfOAI=;
	b=S/BBctCUM4+gEpEV/oyIOaN8OCG1yojuxv4v6vVSyCSK6K6UeezottewjADr/oI7hFRTyW
	umZLcHClz0t/hfCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SrEjnnU9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="S/BBctCU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742305755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1+GRzDBEJ3yO+UybatdwhvZcQGrlwdOntRypEmfOAI=;
	b=SrEjnnU9f3J0CAKIJddEbIRsOGfKDQFT0limJKycLkISwHVD2rwnCQMHqccqfnMtpjzEpn
	UOqtS710xtzQABlTPdT+E3uYe5c+uZXJqpDnmxgKKdwQOZB9krcuagR1isSFq8UOgYy3Qn
	siq5uXwbEynt8S8PiTYnzjYaKksJ1M8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742305755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1+GRzDBEJ3yO+UybatdwhvZcQGrlwdOntRypEmfOAI=;
	b=S/BBctCUM4+gEpEV/oyIOaN8OCG1yojuxv4v6vVSyCSK6K6UeezottewjADr/oI7hFRTyW
	umZLcHClz0t/hfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF7011379A;
	Tue, 18 Mar 2025 13:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SZZ5Odp52WcCeQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Mar 2025 13:49:14 +0000
Date: Tue, 18 Mar 2025 14:49:14 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/18] nvmet-fcloop: add missing
 fcloop_callback_host_done
Message-ID: <db31e99f-364a-49ce-b54f-b697e76eca11@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-8-05fec0fc02f6@kernel.org>
 <931e5618-f85c-43ed-96a2-696c23a57857@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931e5618-f85c-43ed-96a2-696c23a57857@suse.de>
X-Rspamd-Queue-Id: 0A5891F45B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,flourine.local:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_064917_146931_009BBEE2 
X-CRM114-Status: GOOD (  19.96  )
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

On Tue, Mar 18, 2025 at 12:12:52PM +0100, Hannes Reinecke wrote:
> On 3/18/25 11:40, Daniel Wagner wrote:
> > Add the missing fcloop_call_host_done calls so that the caller
> > frees resources when something goes wrong.
> > 
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> > ---
> >   drivers/nvme/target/fcloop.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> > index cadf081e3653c641b0afcb0968fc74299ab941d1..de23f0bc5599b6f8dd5c3713dd38c952e6fdda28 100644
> > --- a/drivers/nvme/target/fcloop.c
> > +++ b/drivers/nvme/target/fcloop.c
> > @@ -966,9 +966,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
> >   	}
> >   	spin_unlock(&inireq->inilock);
> > -	if (!tfcp_req)
> > +	if (!tfcp_req) {
> >   		/* abort has already been called */
> > +		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
> 
> Am I misreading things or will fcloop_call_host_done() crash on a NULL
> tfcp_req ?
>
> In patch 3 fcloop_tfcp_req_put() doesn't check for a NULL argument...

There is NULL pointer check in fcloop_call_host_done eventually. It is
in 'nvmet-fcloop: update refs on tfcp_req'. That hunk should be in this
patch though.

