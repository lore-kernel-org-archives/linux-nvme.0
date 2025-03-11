Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7D3C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNm4pytyaoe7ANX3uVAZTOUpMB40I2SmkL4njmoWVMY=; b=XKapfeCsq2p7hJWZF4DWgZVnmC
	vMqLmTa901YOqs+TKHB6OdDZaodVL7wybyuM3rVhaf47MTX+BXA+YfP2sVDZpiluZLobfp/SA+QqM
	QVJSCjRHghMVWbdh9/3pn6PkXuVqWxKcw0WidG4t1lyBIgGJGbD5JwEBQAUSXvc7H0RQLR42c7HiO
	vjpef+r1KoJCKkhr4r79Vafn4tlZpP9H7R7XzdeWWEZgc56w8zZKZ7K029jWmaGDmtkPg8JfFHKMd
	2rRqxuZm4sB9bjMiCkpDSxUht/ovWyBlbJZZg35Dw3CLzaKAVEBmEHmTUWifRFATSwt8rcVhJWfgB
	VPqPtKwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts1Bz-000000064uS-2nGS;
	Tue, 11 Mar 2025 15:06:51 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ts1Bf-000000064nw-1THB
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 15:06:32 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17F9F1F388;
	Tue, 11 Mar 2025 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741705587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNm4pytyaoe7ANX3uVAZTOUpMB40I2SmkL4njmoWVMY=;
	b=fRZBDhXRcR8zxQB7E4FtNgsDK/tAdjw6IGbvkC8RdHfaWFXARN8h4l4GoPFR7i5qXOEo2V
	SGNRbY5/+x5EM0lDrYff6RexFqOWC/6Xa7/kdFNpmr/mkYUIqrhIRU0N/QKPi+LRnIbvUn
	g0bv1m887pAOKLcNVC1XKMRcncHxyco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741705587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNm4pytyaoe7ANX3uVAZTOUpMB40I2SmkL4njmoWVMY=;
	b=nbQn4Dwpf6FmN3viwh5m0UZsz+M8ZBE4ZVeZyK1hDdIYSIlxytRaG+MrQcxAe2eue1ErQc
	ilnfx+189PwC6XAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fRZBDhXR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nbQn4Dwp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741705587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNm4pytyaoe7ANX3uVAZTOUpMB40I2SmkL4njmoWVMY=;
	b=fRZBDhXRcR8zxQB7E4FtNgsDK/tAdjw6IGbvkC8RdHfaWFXARN8h4l4GoPFR7i5qXOEo2V
	SGNRbY5/+x5EM0lDrYff6RexFqOWC/6Xa7/kdFNpmr/mkYUIqrhIRU0N/QKPi+LRnIbvUn
	g0bv1m887pAOKLcNVC1XKMRcncHxyco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741705587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNm4pytyaoe7ANX3uVAZTOUpMB40I2SmkL4njmoWVMY=;
	b=nbQn4Dwpf6FmN3viwh5m0UZsz+M8ZBE4ZVeZyK1hDdIYSIlxytRaG+MrQcxAe2eue1ErQc
	ilnfx+189PwC6XAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 063E0132CB;
	Tue, 11 Mar 2025 15:06:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MqE2AHNR0GcoZgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 11 Mar 2025 15:06:27 +0000
Date: Tue, 11 Mar 2025 16:06:26 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/15] nvmet-fcloop: update refs on tfcp_req
Message-ID: <48b56e21-2ccf-42ad-83ff-3cd97415e661@flourine.local>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
 <20250311-nvmet-fcloop-v2-7-fc40cb64edea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-nvmet-fcloop-v2-7-fc40cb64edea@kernel.org>
X-Rspamd-Queue-Id: 17F9F1F388
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_080631_532792_4B2E11D9 
X-CRM114-Status: GOOD (  12.16  )
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

On Tue, Mar 11, 2025 at 11:11:33AM +0100, Daniel Wagner wrote:
> @@ -930,6 +932,8 @@ fcloop_fcp_req_release(struct nvmet_fc_target_port *tgtport,
>  {
>  	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
>  
> +	if (!fcloop_tfcp_req_get(tfcp_req))
> +		return;
>  	queue_work(nvmet_wq, &tfcp_req->tio_done_work);
>  }

The ref is already taken in fcloop_fcp_req, so this is wrong and is the
reason for memory leak I observed.

