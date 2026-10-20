Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB0606A31B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tDSL1tWc;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=W2tO11AD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GlVPXgLU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=W2tO11AD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GlVPXgLU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ysfbbrFI8yivLPYPpI0njpIa6LJjUf9RR89EPWV3woQ=; b=tDSL1tWcEL665ZYqU8FFWVKL8I
	v+TTlb14iWxURHBdU14KuvKuTU4YaTV+6L3D8MSf5gLBs2JY0MlA4NiCIMIhytM+aSyoBmU17NJ6R
	4DeFNaJd2KW8troyhuj2lb6FoKejE4zSKNaks/PsMO0AhzsIns7y9VH12hrEKZGr9yXACA+hsG21D
	CfylmG/tzI9BIkUQpc8JbBPGTZ3euXLWdWvrTm5nDH1bSPbHPGFz5XblCRzoi87LWu377h/Cox0Po
	N3H/+qskoiJV447QkmfYw8jhwCvQ7ru/CxUazJ0Pe8wf7+QZ4JBZsMw8Dz/uaw1ovwOnVx3nBLt/l
	cjqbw77g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ5z2-00000009HLp-2TLb;
	Tue, 20 Oct 2026 09:18:12 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ5yy-00000009HLS-2AkL
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 09:18:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B53D11F44E;
	Tue, 20 Oct 2026 09:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792487885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ysfbbrFI8yivLPYPpI0njpIa6LJjUf9RR89EPWV3woQ=;
	b=W2tO11ADs9lp13lL6/fdplhBq0f1R9OtWB/EyD27XTYl7cyUV4GkvUC+3Px7lPVMlJ6Ix+
	15B4omv2hYncyr3nLfkYAigVEtMCJgRrkVI5Nu0kXs8DDphXsxy2+2UEDOJKpj0HrCZz6Y
	BdhzKfE/7AvyYi7rk0iiOf3B2zhrLN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792487885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ysfbbrFI8yivLPYPpI0njpIa6LJjUf9RR89EPWV3woQ=;
	b=GlVPXgLUletv7Aw/8+gtLbc1JwS7igsW7TkChkoRqVg5ludBuM3zt8Ifhfu0zIARUua7zu
	xKYus6Tj9QEsqfBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W2tO11AD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GlVPXgLU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792487885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ysfbbrFI8yivLPYPpI0njpIa6LJjUf9RR89EPWV3woQ=;
	b=W2tO11ADs9lp13lL6/fdplhBq0f1R9OtWB/EyD27XTYl7cyUV4GkvUC+3Px7lPVMlJ6Ix+
	15B4omv2hYncyr3nLfkYAigVEtMCJgRrkVI5Nu0kXs8DDphXsxy2+2UEDOJKpj0HrCZz6Y
	BdhzKfE/7AvyYi7rk0iiOf3B2zhrLN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792487885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ysfbbrFI8yivLPYPpI0njpIa6LJjUf9RR89EPWV3woQ=;
	b=GlVPXgLUletv7Aw/8+gtLbc1JwS7igsW7TkChkoRqVg5ludBuM3zt8Ifhfu0zIARUua7zu
	xKYus6Tj9QEsqfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A498136C6;
	Tue, 20 Oct 2026 09:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PTFaFM0x12ofcQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 Oct 2026 09:18:05 +0000
Date: Tue, 20 Oct 2026 11:18:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/18] nvme: Implement cross-controller reset
 completion
Message-ID: <207f5a00-7fee-4ea5-b541-38424d4766bd@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-10-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920182936.2317916-10-mkhalfella@purestorage.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B53D11F44E
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Score: -4.51
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_021809_750270_1AA285B8 
X-CRM114-Status: GOOD (  14.09  )
X-Spam-Score: -2.1 (--)
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

On Sun, Sep 20, 2026 at 11:28:07AM -0700, Mohamed Khalfella wrote:
>  static void nvme_fw_act_work(struct work_struct *work)
>  {
>  	struct nvme_ctrl *ctrl = container_of(work,
> @@ -5099,6 +5142,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>  	case NVME_AER_NOTICE_DISC_CHANGED:
>  		ctrl->aen_result = result;
>  		break;
> +	case NVME_AER_NOTICE_CCR_COMPLETED:
> +		queue_work(nvme_wq, &ctrl->ccr_work);

What happens to the waiters on sctrl->ccr_list when the source
controller enters error recovery while a CCR is pending?

As far as I can tell, ccr_work itself is fine. The reset path cancels
it via nvme_stop_ctrl(), and in the error recovery path the Get Log
Page just fails once the admin queue is torn down. But the target drops
all CCRs issued by the old association when it frees the controller,
so the CCR completed AEN for them will never arrive. Nothing on the
host side walks ccr_list when the controller leaves LIVE, so
nvme_issue_wait_ccr() sleeps until min(kato, deadline - now) runs out
before nvme_fence_ctrl() tries the next source controller. In the
worst case that eats the whole fencing window.

Would it make sense to fail all pending entries (set ccrs to a failure
status and complete them under ctrl->lock) when the source controller
goes into error recovery, so the fencing code can move on to another
path right away?

