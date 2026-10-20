Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8ED606A323
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vPuFHBv6;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DHS6/S5i;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=m7Eq00Dz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DHS6/S5i;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=m7Eq00Dz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4n+etd17kWY75uo06/KgtPiuqzHBy7OLAf8ZWW1+Os0=; b=vPuFHBv6ij3X/76Y0yHMVmq2bI
	WYbljWBJ+OXzQyOgypikoQ4nAleV/qHy83qpIWeh+S/g0sfEZfnQCA9cnKu2Vd2ADlR0CayqXBz/5
	IguRa57UFQJsCRticUS14bQ8JzUaO7PfruyQT+lYvnD/F2GFoip/9Pzp6EVbaPVO3nl4hp8Ccf9x0
	bjfhb2fKM18wmNYr5Xr5aDsfPH4OMg5ZbczqKW28YwyzpzHm0/l8WKymgVQpX8DMSs94C4zchMR8Z
	SS3rBSNB73hFkUHXJYzDlfzED2JFZks1DuW6M++QLzrJo4JIu5QuWZ18IUoF9AUssQU8043yx5lvn
	jRVWxwvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ6Ge-00000009IFU-21TA;
	Tue, 20 Oct 2026 09:36:24 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ6Gc-00000009IEm-1ZkC
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 09:36:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 727A41F799;
	Tue, 20 Oct 2026 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792488980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4n+etd17kWY75uo06/KgtPiuqzHBy7OLAf8ZWW1+Os0=;
	b=DHS6/S5icgKNpGYywSSHizjoxayQszIGA6xizV7fOiJb1mXHltw+ATaqaCTR3xRbhZ8QEW
	dPjq3E2VPOvUZasObWXDebdAMZoopaYpHeZn7bTO92yU8SRVNG+fBLzrtcdLKi+wxeiTvD
	ABNBng+pp0rvAmtwXp3bpPP2+mSgmNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792488980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4n+etd17kWY75uo06/KgtPiuqzHBy7OLAf8ZWW1+Os0=;
	b=m7Eq00DzwWYMSfrkIbfzUgDyvYrshqE9eREGIE7Zwwodf9MEN3WOS4f4D/g3Q26VO5tiw7
	7VIWhfH5IpuXwFCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792488980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4n+etd17kWY75uo06/KgtPiuqzHBy7OLAf8ZWW1+Os0=;
	b=DHS6/S5icgKNpGYywSSHizjoxayQszIGA6xizV7fOiJb1mXHltw+ATaqaCTR3xRbhZ8QEW
	dPjq3E2VPOvUZasObWXDebdAMZoopaYpHeZn7bTO92yU8SRVNG+fBLzrtcdLKi+wxeiTvD
	ABNBng+pp0rvAmtwXp3bpPP2+mSgmNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792488980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4n+etd17kWY75uo06/KgtPiuqzHBy7OLAf8ZWW1+Os0=;
	b=m7Eq00DzwWYMSfrkIbfzUgDyvYrshqE9eREGIE7Zwwodf9MEN3WOS4f4D/g3Q26VO5tiw7
	7VIWhfH5IpuXwFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39648136C6;
	Tue, 20 Oct 2026 09:36:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p8XBBRQ212o7BQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 Oct 2026 09:36:20 +0000
Date: Tue, 20 Oct 2026 11:36:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/18] nvme-tcp: Use CCR to recover controller that
 hits an error
Message-ID: <d1e6b53b-3d14-4cc0-8153-dffd5da7673b@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-11-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920182936.2317916-11-mkhalfella@purestorage.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_023622_568123_2CFC1D1C 
X-CRM114-Status: GOOD (  15.21  )
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

On Sun, Sep 20, 2026 at 11:28:08AM -0700, Mohamed Khalfella wrote:
> @@ -2731,13 +2755,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
>  	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
>  	struct nvme_command *cmd = &pdu->cmd;
>  	int qid = nvme_tcp_queue_id(req->queue);
> +	enum nvme_ctrl_state state;
>  
>  	dev_warn(ctrl->device,
>  		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
>  		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
>  		 nvme_fabrics_opcode_str(qid, cmd), qid);
>  
> -	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
> +	state = nvme_ctrl_state(ctrl);
> +	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
>  		/*
>  		 * If we are resetting, connecting or deleting we should
>  		 * complete immediately because we may block controller

The documentation should be updated, maybe something like:

          state = nvme_ctrl_state(ctrl);
          if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
                  /*
                   * If fencing has finished or we are resetting, connecting or
                   * deleting we should complete immediately because we may
                   * block controller teardown or setup sequence
                   * - ctrl disable/shutdown fabrics requests
                   * - connect requests
                   * - initialization admin requests
                   * - I/O requests that entered after unquiescing and
                   *   the controller stopped responding
                   *
                   * All other requests should be cancelled by the error
                   * recovery work, so it's fine that we fail it here.
                   */
                  nvme_tcp_complete_timed_out(rq);
                  return BLK_EH_DONE;
          }

          /*
           * LIVE state should trigger the normal error recovery which will
           * handle completing this request. In FENCING state the request
           * must not be completed before fencing has finished, so just
           * rearm the timer and let the error recovery pick it up.
           */
          nvme_tcp_error_recovery(ctrl);
          return BLK_EH_RESET_TIMER;

