Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F55CC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+67X3s0+LtDgnVqweOYLzcbxICYyQTbn4dfq/CvPpQ=; b=DLbMB7cwjqrLhJZj4kD7gwz32q
	xv3QprsHQbMorwIlmf/LvJWvM3VE9aXnZSuK5mOHECNftg7S77i0XG+JGR9splvDqhoiraQyQCe2T
	3nataKwj+y7iMMqDJeh+GrFWKMLvhgGZvWjmXNjN36tNM23ys7nF0b2FomcrrLeUimhWtI2bM3Zso
	Z6rKRfbR3lJlreemh7PkwYhqUoLfVKjSKqct0dFf1oAnByRyoi+Onl3YTHrOQwk9NIaiimXLbfzHR
	oc806JRVqmyMfiXNWKphLoE14mOscrxTMyo3aS6PxwnsSVmp+PgSx0TP52ngd2LzX/OLDS7QE/L2q
	wC7dcJEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4fZg-00000005mkz-2JCa;
	Tue, 15 Apr 2025 12:39:36 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4fUU-00000005lA6-0vfz
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 12:34:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90BAB1F454;
	Tue, 15 Apr 2025 12:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744720452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+67X3s0+LtDgnVqweOYLzcbxICYyQTbn4dfq/CvPpQ=;
	b=JPBs7s9mwTexAkKO2LUNyZLvLV1QdJrBs67wF4khREKN7XM6UvA/BDvpfY2QIHz1+rk36F
	EJ+sZZoVXV6hYQ2nBWNlKoGOywFDkPle69CUofEnruD2mn60gaBCre9n/4ZB8Tm2G6PuQB
	hmHTCcTNGETr/JxeyJBBVvutm2Fe4KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744720452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+67X3s0+LtDgnVqweOYLzcbxICYyQTbn4dfq/CvPpQ=;
	b=BzjtjqQsZcu+jHqQ41mwllcXcIISpeVsJPaDPLxTiCELx7lPzj3t9GnGyySExXGN8ymaFn
	8J9thXLcFcfHmCBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JPBs7s9m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BzjtjqQs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744720452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+67X3s0+LtDgnVqweOYLzcbxICYyQTbn4dfq/CvPpQ=;
	b=JPBs7s9mwTexAkKO2LUNyZLvLV1QdJrBs67wF4khREKN7XM6UvA/BDvpfY2QIHz1+rk36F
	EJ+sZZoVXV6hYQ2nBWNlKoGOywFDkPle69CUofEnruD2mn60gaBCre9n/4ZB8Tm2G6PuQB
	hmHTCcTNGETr/JxeyJBBVvutm2Fe4KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744720452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+67X3s0+LtDgnVqweOYLzcbxICYyQTbn4dfq/CvPpQ=;
	b=BzjtjqQsZcu+jHqQ41mwllcXcIISpeVsJPaDPLxTiCELx7lPzj3t9GnGyySExXGN8ymaFn
	8J9thXLcFcfHmCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BA97137A5;
	Tue, 15 Apr 2025 12:34:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N948HURS/mfEFAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Apr 2025 12:34:12 +0000
Date: Tue, 15 Apr 2025 14:34:08 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Jiewei Ke <jiewei_ke@163.com>
Cc: wagi@kernel.org, hare@suse.de, hch@lst.de, jmeneghi@redhat.com, 
	kbusch@kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	mkhalfella@purestorage.com, randyj@purestorage.com, sagi@grimberg.me
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <424fe473-8472-42b8-99c7-8b0534771343@flourine.local>
References: <8F2489FD-1663-4A52-A50B-F15046AC2878@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8F2489FD-1663-4A52-A50B-F15046AC2878@163.com>
X-Rspamd-Queue-Id: 90BAB1F454
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[163.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_053414_407418_C4D3DFA5 
X-CRM114-Status: GOOD (  23.53  )
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

Hi Jiewei,

On Thu, Apr 10, 2025 at 11:44:13PM +0800, Jiewei Ke wrote:
> I just noticed that your patchset addresses a similar issue to the one I ’m
> trying to solve with my recently submitted patchset [1]. Compared to your
> approach, mine differs in a few key aspects:
> 
> 1. Only aborted requests are delayed for retry. In the current implementation,
> nvmf_complete_timed_out_request and nvme_cancel_request set the request status
> to NVME_SC_HOST_ABORTED_CMD. These requests are usually already sent to the
> target, but may have timed out or been canceled before a response is received.
> Since the target may still be processing them, the host needs to delay retrying
> to ensure the target has completed or cleaned up the stale requests. On the
> other hand, requests that are not aborted — such as those that never got
> submitted due to no usable path (e.g., from nvme_ns_head_submit_bio), or those
> that already received an ANA error from the target — do not need
> delayed retry.

If I understand you correctly, you are concerned about delaying all
commands even these which are not transmitted yet. If there are no
garantees on ordering it would be possible to failover these commands
immediately. Sure something which could be improved in my series.

> 2. The host explicitly disconnects and stops KeepAlive before delay scheduling
> retrying requests. This aligns with Section 9.6 "Communication Loss Handling"
> of the NVMe Base Specification 2.1. Once the host disconnects, the target may
> take up to the KATO interval to detect the lost connection and begin cleaning
> up any remaining requests. Retrying too early may still lead to data
> corruption issues.

The host error handler is executed thus all communication is stopped.
This part hasn't changed. Not sure what you are referring too. The only
thing which changes in this series is when we enqueue the failed
commands again.

> @@ -2178,6 +2180,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
>  	nvme_quiesce_admin_queue(&ctrl->ctrl);
>  	nvme_disable_ctrl(&ctrl->ctrl, shutdown);
>  	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
> +	nvme_delay_kick_retry_lists(&ctrl->ctrl); <<< delay kick retry
>  	after teardown all queues

Without the kick it hangs. The admin has explicitly removed the ctrl.

As I already said, this is a RFC for the sake to figure out if this
approach is a good idea. We all agreed, we should first try to sort this
out before introducing a new queue. There are many problems which it
will introduce, like the one from above 'why delaying not send
requests?', 'What happens when we have several short
disconnects/connects?', ...

BTW, there is already a hack in disconnect/connect state transition.
Ideally we solve this in a more generic manner.

Thanks,
Daniel

