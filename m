Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC05606A31D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AOjToBvW;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=p1grDgPR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5Dw2sKmE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=p1grDgPR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5Dw2sKmE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s0rKbjF/Y9G+VhQ22dzUsW8sQ6QduMv5ejx2RtBN2mU=; b=AOjToBvWStnbi8m99AoDqE1cfF
	YLtNE1Q8kPBR+jDJzlgK1cyKnsGL1uc/QVdRAw0WHawi+ZXN/EAC7dJG8qtHmPDss+RYmboeiQT/y
	qA6PRwrw7jqSGEYJNW6MFuDeziNB8GAQuoV+LFw+xM0zZLBTgUekDzJOmkPO6VBXunRlGH3f4dgnh
	gA5MheXGmyos0LKCg5ICHfv9zfXIKG1RgAoysjDTB9UnRQ4m9O+RneY1qy4w2+3r3p6LlVmE3wk4c
	jD9sJthTo4LxOVLRBD8veH8tjt4BKR1xiVyLZz1spbzDgL+PdZYuY7h+bANRjrqREtcu1G/zC61z3
	Sj1Wn7iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ5cy-00000009Ews-22eK;
	Tue, 20 Oct 2026 08:55:24 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ5cv-00000009EwH-1yFl
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 08:55:22 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A996721DC3;
	Tue, 20 Oct 2026 08:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792486519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0rKbjF/Y9G+VhQ22dzUsW8sQ6QduMv5ejx2RtBN2mU=;
	b=p1grDgPRHf6OGuugOk7QiucIuC4RfCbaERlfhTQFC6a7M0AIAheBKfW5+UvJhCg3uGULuS
	QvfbrmZDYgopPwdgr4ldzTo5htvB+tBte7Nv43DEoIDxuQ6vtjT8Jrh+PkFN9JoG5GjNvN
	Ucu+shMVk6azF6ywbs7WAGZqirTAbRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792486519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0rKbjF/Y9G+VhQ22dzUsW8sQ6QduMv5ejx2RtBN2mU=;
	b=5Dw2sKmE4wG4Eqs9tVzOAf4Uo704s9sOdLZuP34fIl8NI8/fovnx+8hJ30OktwvSgKsahX
	Ju1t60C5tFWeprCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792486519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0rKbjF/Y9G+VhQ22dzUsW8sQ6QduMv5ejx2RtBN2mU=;
	b=p1grDgPRHf6OGuugOk7QiucIuC4RfCbaERlfhTQFC6a7M0AIAheBKfW5+UvJhCg3uGULuS
	QvfbrmZDYgopPwdgr4ldzTo5htvB+tBte7Nv43DEoIDxuQ6vtjT8Jrh+PkFN9JoG5GjNvN
	Ucu+shMVk6azF6ywbs7WAGZqirTAbRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792486519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0rKbjF/Y9G+VhQ22dzUsW8sQ6QduMv5ejx2RtBN2mU=;
	b=5Dw2sKmE4wG4Eqs9tVzOAf4Uo704s9sOdLZuP34fIl8NI8/fovnx+8hJ30OktwvSgKsahX
	Ju1t60C5tFWeprCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79B7E136CC;
	Tue, 20 Oct 2026 08:55:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 48OwF3cs12oUWQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 Oct 2026 08:55:19 +0000
Date: Tue, 20 Oct 2026 10:55:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/18] nvme: Implement cross-controller reset recovery
Message-ID: <6e0b4de0-b030-47cc-84ce-3f021a5c75b0@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-9-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920182936.2317916-9-mkhalfella@purestorage.com>
X-Spam-Score: -4.30
X-Spam-Level: 
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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_015521_654172_F9FBB30D 
X-CRM114-Status: GOOD (  15.36  )
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl,
> +			       unsigned long deadline)
> +{
> +	struct nvme_ccr_entry ccr = { };
> +	union nvme_result res = { 0 };
> +	struct nvme_command c = { };
> +	unsigned long flags, now, tmo = 0;
> +	bool completed = false;
> +	int ret = 0;
> +	u32 result;
> +
> +	init_completion(&ccr.complete);
> +	ccr.ictrl = ictrl;
> +
> +	spin_lock_irqsave(&sctrl->lock, flags);
> +	list_add_tail(&ccr.list, &sctrl->ccr_list);
> +	spin_unlock_irqrestore(&sctrl->lock, flags);
> +
> +	c.ccr.opcode = nvme_admin_cross_ctrl_reset;
> +	c.ccr.ciu = ictrl->ciu;
> +	c.ccr.icid = cpu_to_le16(ictrl->cntlid);
> +	c.ccr.cirn = cpu_to_le64(ictrl->cirn);
> +	ret = __nvme_submit_sync_cmd(sctrl->admin_q, &c, &res,
> +				     NULL, 0, NVME_QID_ANY, 0);
> +	if (ret) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	result = le32_to_cpu(res.u32);
> +	if (result & 0x01) /* Immediate Reset Successful */
> +		goto out;
> +
> +	now = jiffies;
> +	if (time_before(now, deadline))
> +		tmo = min_t(unsigned long,
> +			    secs_to_jiffies(ictrl->kato), deadline - now);
> +
> +	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	completed = true;
> +
> +out:
> +	spin_lock_irqsave(&sctrl->lock, flags);
> +	list_del(&ccr.list);
> +	spin_unlock_irqrestore(&sctrl->lock, flags);
> +	if (completed) {
> +		if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
> +			return 0;
> +		return -EREMOTEIO;
> +	}
> +	return ret;


This part could be made a bit simpler and there is no need for the local
completed variable:

[...]
        if (!wait_for_completion_timeout(&ccr.complete, tmo))
                ret = -ETIMEDOUT;

out:
        spin_lock_irqsave(&sctrl->lock, flags);
        list_del(&ccr.list);
        spin_unlock_irqrestore(&sctrl->lock, flags);

        if (ret || !completion_done(&ccr.complete))
                return ret;
        if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
                return 0;
        return -EREMOTEIO;
}

