Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3E2606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2026 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sIPJvoqC;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sE9HnRkd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SHKFWJwa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sE9HnRkd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SHKFWJwa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UfdGpWtgTLDzFQ8nU2mzJ6EvNoOQYOiNgDYthHagyV8=; b=sIPJvoqCKyTZGR
	ywoHnenEtGgKDx0k5njDnsOAVHNUG4zPgwuAR2Vduo+0b0nbrdHc46RkKUGWvXWlqAPtkE0X/wUt2
	Q5x0hUt0Mx+64ziOGDGLumP9SXVedgTZOgWCpBNkDnXba5cQBq/9O5oYjK4I9TgnCgyyXuZ0CFnT3
	XxmIExvS6/EBD91cpxcQjzjEVZV75rRfBoLYJD1CKwzcw/jnohEyX+uRP5rQ8bVt4hOWXRQFEyiLw
	Gzi99Nnf5nYYgL3KFCxQTQ36729DyKb+KXehSZLQiwFWJqDTEyWXBH3621kDR9V09oFch+zxFZf8l
	6naKYBbs8Pkn3Ztt2QLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTDJt-00000004jzF-1Z7o;
	Tue, 17 Nov 2026 07:09:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTDJq-00000004jxU-47SM;
	Tue, 17 Nov 2026 07:09:32 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85FA422298;
	Tue, 17 Nov 2026 07:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794899368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfdGpWtgTLDzFQ8nU2mzJ6EvNoOQYOiNgDYthHagyV8=;
	b=sE9HnRkdS/woZlNm9Wj+G1JECjUCb4rn0MCeryzwIxYvvriUOLX20g6qTuLwEOfayzn3FF
	8gS9tEF/rSfUtpP91v0tnVBITpbVSzYNCSgAOtqVOd9wglnpbkcP6RdZAIcr0SEvf7jOq+
	JD5iafcou2p8jT/S1d1cgvrBAwKpbus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794899368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfdGpWtgTLDzFQ8nU2mzJ6EvNoOQYOiNgDYthHagyV8=;
	b=SHKFWJwaSEPnXO5VkGfNu+KZPbGTrLH2h5eRX31uDGs8bcJh37gKlkI7rnjvfSQrgus75S
	H+5dFeF6B06IL7DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794899368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfdGpWtgTLDzFQ8nU2mzJ6EvNoOQYOiNgDYthHagyV8=;
	b=sE9HnRkdS/woZlNm9Wj+G1JECjUCb4rn0MCeryzwIxYvvriUOLX20g6qTuLwEOfayzn3FF
	8gS9tEF/rSfUtpP91v0tnVBITpbVSzYNCSgAOtqVOd9wglnpbkcP6RdZAIcr0SEvf7jOq+
	JD5iafcou2p8jT/S1d1cgvrBAwKpbus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794899368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfdGpWtgTLDzFQ8nU2mzJ6EvNoOQYOiNgDYthHagyV8=;
	b=SHKFWJwaSEPnXO5VkGfNu+KZPbGTrLH2h5eRX31uDGs8bcJh37gKlkI7rnjvfSQrgus75S
	H+5dFeF6B06IL7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A465D1334C;
	Tue, 17 Nov 2026 07:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JiZ5Gaf9+2pcbgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Nov 2026 07:09:27 +0000
Message-ID: <44dcc2bc-e7eb-48c6-9aa0-96f2ad5dcb0b@suse.de>
Date: Tue, 17 Nov 2026 08:09:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/17] nvmet: Implement CCR nvme command
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Mohamed Khalfella <linux-nvme-bounces@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>,
 Randy Jennings <randyj@purestorage.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-4-mkhalfella@purestorage.com>
 <20261116084540.GA3655@yadro.com>
 <20261117000348.GD1670230-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261117000348.GD1670230-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,grimberg.me:email];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,suse.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_230931_381040_D5D786F9 
X-CRM114-Status: GOOD (  22.09  )
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

On 11/17/26 1:03 AM, Mohamed Khalfella wrote:
> On Mon 2026-11-16 11:45:40 +0300, Dmitry Bogdanov wrote:
>> On Fri, Nov 13, 2026 at 07:04:17PM -0800, Mohamed Khalfella wrote:
>>>
>>> Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
>>> Reset) command is an nvme command issued to source controller by
>>> initiator to reset impacted controller. Implement CCR command for linux
>>> nvme target.
>>>
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>>   drivers/nvme/target/admin-cmd.c | 76 ++++++++++++++++++++++++++++++
>>>   drivers/nvme/target/core.c      | 83 +++++++++++++++++++++++++++++++++
>>>   drivers/nvme/target/nvmet.h     | 13 ++++++
>>>   include/linux/nvme.h            | 23 +++++++++
>>>   4 files changed, 195 insertions(+)
>>>
>>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>>> index 5710ae53eb83..3df9db454db9 100644
>>> --- a/drivers/nvme/target/admin-cmd.c
>>> +++ b/drivers/nvme/target/admin-cmd.c
>>> @@ -378,6 +378,7 @@ static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
>>>          log->acs[nvme_admin_get_features] =
>>>          log->acs[nvme_admin_async_event] =
>>>          log->acs[nvme_admin_keep_alive] =
>>> +       log->acs[nvme_admin_cross_ctrl_reset] =
>>>                  cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
>>>   }
>>>
>>> @@ -1629,6 +1630,78 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
>>>          nvmet_req_complete(req, status);
>>>   }
>>>
>>> +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
>>> +{
>>> +       struct nvmet_ctrl *ictrl, *sctrl = req->sq->ctrl;
>>> +       struct nvme_command *cmd = req->cmd;
>>> +       struct nvmet_ccr *ccr, *new_ccr;
>>> +       int ccr_active, ccr_total;
>>> +       u16 cntlid, status = NVME_SC_SUCCESS;
>>> +
>>> +       if (!nvmet_check_transfer_len(req, 0))
>>> +               return;
>>> +
>>> +       cntlid = le16_to_cpu(cmd->ccr.icid);
>>> +       if (sctrl->cntlid == cntlid) {
>>> +               req->error_loc =
>>> +                       offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
>>> +               status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>>> +               goto out;
>>> +       }
>>
>> cntlid has to be validated against the configured range of the controller
>> ids (subsys->cntlid_min <= cntlid <= subsys->cntlid_max).
>> That will allow CCR to work correctly on a distributed target.
>>
> 
> Thanks for the review. nvmet_ctrl_find_get_ccr() below will verify
> ictrl->dntlid == cntlid before proceeding with the reset. Is this not
> enough?
> 
> Adding this check here means if either cntlid_min or cntlid_max change
> after ictrl has been created, CCR will fail saying the controller was not
> found. Why do we want to CCR to fail in this case when ictrl might
> actually be there?
> 
The point is that in a distributed system the cntlid range is 
distributed across all nodes in the cluster (as indicated by
min/max_cntlid).
While logically all cntlids belong to the same subsystem,
technically each node can only reach (and reset!) the cntlids
of controllers local on that node.
With CCR each node can receive a CCR for any cntlid, but it
can handle only those cntlids which are local on the node.

But as we're looking up the actual controller structures
(which are only present if the cntlid is local to the node)
I think we should be good here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

