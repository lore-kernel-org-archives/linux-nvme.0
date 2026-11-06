Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D82606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i2SdEg1r;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DQKPSWQ3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/sKV97SB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qqt+mHYx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ieYv3Tqy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HIbUdhTT2ghjCp4LM+fVx6hNgYWWnPYfW3LLyUiYzuQ=; b=i2SdEg1rooouY8
	5CWB9+eGUC01GeWF6LgRPV3Uj4er9MaS1+qc5cH0Gc/EK8I1qeOAx8NcomTR+Kj7eaOTZ0sUeGTMP
	g83jmT9aAF3gyKM3n9d6irO81Ii0hQ9UllKogbJBGqNwZTxmEA2EQyfUnFBqGCwhcNI5j5uFzSVBS
	Y4mywvkUJteL1Xp5D/uXbslVqZgJpezjomggDU0jw0GcPmynd+qNSFzK7CdIpLbp+1bvrc25l9Nup
	7IGOKDT5prdA+NRy3tf+RRaaN3wk1+jeMc9edUIY1m23xOEkJdJAJZTcjt5WcrnA6QzdjjseXLfdZ
	XuSuyhAkwCGKbqsxrrGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEQ3-0000000BSRO-1shq;
	Fri, 06 Nov 2026 07:31:27 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEPx-0000000BSQf-2x5A
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 07:31:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5CCD1F78E;
	Fri,  6 Nov 2026 07:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIbUdhTT2ghjCp4LM+fVx6hNgYWWnPYfW3LLyUiYzuQ=;
	b=DQKPSWQ3MDZHLeSkIDJu/UiN3MQRCOhZ2ZajGwwOy34MoGBuBSq+WpeJDPwUPX9EutEVER
	QIP2HpoJ55+UgXFZF90sKXfmz+ueQ6ijhYY/oqFnWJK9Q2XHw0eReB1dm/MFNscxh+2e+l
	3eUSdRc8QqhoYc5Myh86gm5klACMvIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIbUdhTT2ghjCp4LM+fVx6hNgYWWnPYfW3LLyUiYzuQ=;
	b=/sKV97SB7/sudRYVxQeOaFZMHU4aMTBw0iJ9ail3caaZ6hCFyVvRaB3pp8lFudQoZNAH0H
	jTQHlnDLfkDo+CBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qqt+mHYx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ieYv3Tqy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIbUdhTT2ghjCp4LM+fVx6hNgYWWnPYfW3LLyUiYzuQ=;
	b=qqt+mHYxqu8KFgszuCikrw7JAVlglQ2l2oM3s6u8Xr2+FwtzDWhiivbEgzATOB0rhnfiXA
	iWzw6xQVTAeYIGf4MO3iOn+xiLiTjeZa7C3lvVXw6TW+oSbP1cX2xeeab2BQKlXjyabUBu
	IpL5CwB9/uMIX+r1Wiu8I0uS80f+1MY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIbUdhTT2ghjCp4LM+fVx6hNgYWWnPYfW3LLyUiYzuQ=;
	b=ieYv3TqyAJq4Odo5GBPq7Ipa6EqzLQ6soW43YmWVShucmstkVDJ84nosXcy87f7EG5H4VP
	/o9suk7ZZvzkD9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61E40134E9;
	Fri,  6 Nov 2026 07:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QVGzDkeC7WoBPQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Nov 2026 07:31:19 +0000
Message-ID: <74470d7c-5763-4963-ae0d-90e87eb208f3@suse.de>
Date: Fri, 6 Nov 2026 08:31:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] nvmet: fix controller reference leak in
 nvmet_install_queue() error paths
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-6-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261106015842.3534898-6-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B5CCD1F78E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_233121_895847_60DA055E 
X-CRM114-Status: GOOD (  20.50  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 2:58 AM, Guixin Liu wrote:
> nvmet_install_queue() takes a controller reference for req->cq->ctrl
> and installs the controller in both req->sq->ctrl and req->cq->ctrl,
> but neither error path undoes its work: the busy return after the
> failed cq->ctrl cmpxchg leaves sq->ctrl set and the reference taken,
> and the err path for a failed transport ->install_queue() clears
> sq->ctrl but leaves cq->ctrl set with the reference still held.
> 
> The queue is then permanently wedged: a connect retry finds the stale
> cq->ctrl, takes another reference and fails again, and the leaked
> references keep the controller alive forever. Clearing cq->ctrl also
> matters because the caller drops its own reference, which can be the
> last one on the admin connect path, leaving cq->ctrl dangling.
> 
> Roll back the sq->ctrl assignment and drop the reference on both
> error paths, and also clear ctrl->cqs[qid] on the err path to mirror
> what nvmet_cq_destroy() would do.
> 
> Fixes: bb78836b3a7ca ("nvmet: fabrics: add CQ init and destroy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/fabrics-cmd.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index fc626c2fd2c9..773dad857a35 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -216,6 +216,8 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   	if (old) {
>   		pr_warn("queue already connected!\n");
>   		req->error_loc = offsetof(struct nvmf_connect_command, opcode);
> +		req->sq->ctrl = NULL;
> +		nvmet_ctrl_put(ctrl);
>   		return NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
>   	}
>   
> @@ -234,6 +236,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   			pr_err("failed to install queue %d cntlid %d ret %x\n",
>   				qid, ctrl->cntlid, ret);
>   			ctrl->sqs[qid] = NULL;
> +			ctrl->cqs[qid] = NULL;
>   			goto err;
>   		}
>   	}
> @@ -242,6 +245,8 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   
>   err:
>   	req->sq->ctrl = NULL;
> +	req->cq->ctrl = NULL;
> +	nvmet_ctrl_put(ctrl);
>   	return ret;
>   }
>   

That looks wrong.
We already do a call to 'nvmet_ctrl_put()' in 
'nvmet_execute_admin_connect()', right after nvmet_install_queue()
failed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

