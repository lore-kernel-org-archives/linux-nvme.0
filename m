Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E860DC48BF6
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 10:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wfXXfslEZ30esp1tv2rVfmGy6A6st0sm1Cci55ZlEGA=; b=dGEnWQnoWl+GCnCQnLa5c5ZaiN
	RxDJzv/uBPiTykP9YnGU4DSw/s1iigfvDy6Sd/Eb/9nEbjSwX5nOKIxmjUqTrFpDu6UXq5TbbA/s3
	VkdJKGHs7xDo/+FoJwJRCICeOjYTdz013zefpEXlA+gcAXoahpSvatfQT+SSXyWQ8MT+YIeGgDXgk
	EU+ZSS3tF9sLKN8BbSIdQZb+ZhVHU/cuWscPT3RwmOxEUs3FQ+uFDTLAqYWspIjZgFU+n+uT+MaZP
	mufcpk9vxwKRgRRhBTKP4pVxX/KCPAoVG9pclzd09jJNo/feTUrDmIRc3hyMLhsHfIPxxj5HwXfok
	MLzu8LKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYA8-000000002Bu-0tQC;
	Mon, 26 Feb 2024 10:24:44 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYA2-00000000296-0yyI
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 10:24:42 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0EDE1FB44;
	Mon, 26 Feb 2024 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708943076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wfXXfslEZ30esp1tv2rVfmGy6A6st0sm1Cci55ZlEGA=;
	b=Wo8+sft3eHhcluFMa8MvuZa0unjp5tp35cBmH0d9LM8Y1W6MHLPsGKjX7ptmBBQu4f/J2s
	gfqMaHT+HWfMJzUwxWj4B6a9ITsqN3OH8J5oJ75MY0R+fKM8n9zqxJtjhLOGzh59CilcNZ
	AKtR0Pt5RtZFc1XhEFY08VqeDBghbsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708943076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wfXXfslEZ30esp1tv2rVfmGy6A6st0sm1Cci55ZlEGA=;
	b=iQvOmTNKvHH6hWn/Eg7w7ugcns6lvnEs9in7/a9HsGyxtrZL7AkxAO0NsdqMxs3jwnYQ5/
	C9mNW+IZ0AGzNCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708943076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wfXXfslEZ30esp1tv2rVfmGy6A6st0sm1Cci55ZlEGA=;
	b=Wo8+sft3eHhcluFMa8MvuZa0unjp5tp35cBmH0d9LM8Y1W6MHLPsGKjX7ptmBBQu4f/J2s
	gfqMaHT+HWfMJzUwxWj4B6a9ITsqN3OH8J5oJ75MY0R+fKM8n9zqxJtjhLOGzh59CilcNZ
	AKtR0Pt5RtZFc1XhEFY08VqeDBghbsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708943076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wfXXfslEZ30esp1tv2rVfmGy6A6st0sm1Cci55ZlEGA=;
	b=iQvOmTNKvHH6hWn/Eg7w7ugcns6lvnEs9in7/a9HsGyxtrZL7AkxAO0NsdqMxs3jwnYQ5/
	C9mNW+IZ0AGzNCCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E52A1329E;
	Mon, 26 Feb 2024 10:24:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wLEvJeRm3GV4IQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 26 Feb 2024 10:24:36 +0000
Date: Mon, 26 Feb 2024 11:24:35 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2] nvme: authentication error are always non-retryable
Message-ID: <g3rnirwykldnoved2rojfkf3xrhkv4hai46m3b45kt4tzxpvyx@gqhr3v2l33ea>
References: <20240226080628.21220-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226080628.21220-1-hare@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.37)[90.65%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_022438_467357_D8F825B3 
X-CRM114-Status: GOOD (  11.15  )
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

On Mon, Feb 26, 2024 at 09:06:28AM +0100, Hannes Reinecke wrote:
> Any authentication errors which are generated internally are always
> non-retryable, so set the DNR bit to ensure they are not retried.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>

> @@ -541,7 +542,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
>  		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>  			dev_warn(ctrl->device,
>  				 "qid 0: secure concatenation is not supported\n");

Maybe also updating the warn message to "qid %u: ..." wouldn't hurt.

> -			ret = NVME_SC_AUTH_REQUIRED;
> +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>  			goto out_free_data;

