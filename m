Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F8160A260D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ikx6Lrig;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JNWQmoxr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zO4Ds2zy;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JNWQmoxr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zO4Ds2zy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNVwXEKTBC/72qphnT2ap3ikWCo3v6If04rWDXywPlM=; b=Ikx6Lrig2R0FQpKScTN00rNQtb
	F4tgx8UAJBg9J6O924S005LJHyuruIuAc69isphC5oPNaHMqky/Jm8t4u49UNq3I9ofCPl6AGWMED
	/hcS08+56nI8SyRSPLxERwcfjTFIPS/IL/5fV/Oac5CbaG6zmzy+6htqotQttd9Lcsn1eMKilw9AS
	viw9p1GJ2WVu9Tx0XXtA4/ZTH7pnNJbRJBFiu3o3nTgXe6sx+F5fA5W7Q8+dQ806GgqQ+4bG1zM9B
	6YKhh7+uACpK/AcpW99qekIRhPn/eErnw0LlzGsEP7av7A6AGTx28mgatDcNw4FWpXr3nryu9NOsf
	e/RjO/DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ6HM-00000009IQi-1OHM;
	Tue, 20 Oct 2026 09:37:08 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ6HG-00000009IOC-44cf
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 09:37:04 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B32321C13;
	Tue, 20 Oct 2026 09:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792489021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNVwXEKTBC/72qphnT2ap3ikWCo3v6If04rWDXywPlM=;
	b=JNWQmoxroueCA0tPjH8HCx93RvPXWROb9vW5w506dgIkyoXP8/wBfHqKRt3ZlsOx84c4zP
	JwWSVOweAQ9H+cqryXbf/tZa9n9Od0Ti95tVu6V4bKvnCg5pcOdtiZG+jvFoKRp8RBTE9/
	+YIBZvWGqpCDnc2TBWumAyIvnu+NwYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792489021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNVwXEKTBC/72qphnT2ap3ikWCo3v6If04rWDXywPlM=;
	b=zO4Ds2zyTTbURvetQrlnPSpFHitNwrjBJbXmTNY+XlzAfGz5TTi/gtyGRkIyKz2elzmNbi
	3P2Y8fXgh0m8+eBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JNWQmoxr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zO4Ds2zy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792489021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNVwXEKTBC/72qphnT2ap3ikWCo3v6If04rWDXywPlM=;
	b=JNWQmoxroueCA0tPjH8HCx93RvPXWROb9vW5w506dgIkyoXP8/wBfHqKRt3ZlsOx84c4zP
	JwWSVOweAQ9H+cqryXbf/tZa9n9Od0Ti95tVu6V4bKvnCg5pcOdtiZG+jvFoKRp8RBTE9/
	+YIBZvWGqpCDnc2TBWumAyIvnu+NwYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792489021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNVwXEKTBC/72qphnT2ap3ikWCo3v6If04rWDXywPlM=;
	b=zO4Ds2zyTTbURvetQrlnPSpFHitNwrjBJbXmTNY+XlzAfGz5TTi/gtyGRkIyKz2elzmNbi
	3P2Y8fXgh0m8+eBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECBAF136C6;
	Tue, 20 Oct 2026 09:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4lH1MTw212qJBgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 Oct 2026 09:37:00 +0000
Date: Tue, 20 Oct 2026 11:36:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/18] nvme-rdma: Use CCR to recover controller that
 hits an error
Message-ID: <8cfb3b90-7629-4a8c-a393-7f724f01c19c@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-12-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920182936.2317916-12-mkhalfella@purestorage.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2B32321C13
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_023703_170127_97C8ED04 
X-CRM114-Status: GOOD (  11.30  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Sep 20, 2026 at 11:28:09AM -0700, Mohamed Khalfella wrote:
> @@ -1990,13 +2014,15 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
>  	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
>  	struct nvme_command *cmd = req->req.cmd;
>  	int qid = nvme_rdma_queue_idx(queue);
> +	enum nvme_ctrl_state state;
>  
>  	dev_warn(ctrl->ctrl.device,
>  		 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout\n",
>  		 rq->tag, nvme_cid(rq), cmd->common.opcode,
>  		 nvme_fabrics_opcode_str(qid, cmd), qid);
>  
> -	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
> +	state = nvme_ctrl_state(&ctrl->ctrl);
> +	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {

documentation needs to be udpated like in the tcp patch.

