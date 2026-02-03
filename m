Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC91E83043
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 03:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Krm98tN9lFPURW356QRSQtol7r+oaOm3effAglpFnyc=; b=U6o9R54OmV1qVm2Jt4scEqL63K
	sJ3IiBK0JbUc0sZI3nBGr64I8JCWzl3hwVOWL6v8jIbNrjbfw/0MDw9EJcvPI+ha2PNc3YSBUHAAp
	20q1VQOadUQQ494hAkTkhVqze5Ee5W7FV3oAlSzDsfkLlIiFsZDLuj1LkMOkX6hJ27ofso//ZzWWp
	kHj+0Qkj4o1cCzlRldwz7Idx0u7e1rC9BY0ijR87Ix3i2e5hsZ2mvU+PNbvF0gQb7/4uTteH/BRTn
	G9av97XBsFAjlHLyv+c7ShGS54SOpS7k7SQ9WuDv2Nvkti8UNFU2P2YFrVZLyUVilbvuYAu6RSCVk
	nDKh+Ygg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn74z-000000060Fl-1zrE;
	Tue, 03 Feb 2026 03:27:53 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn74w-000000060FM-0sqb
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 03:27:51 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25AF25BCC3;
	Tue,  3 Feb 2026 03:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770089268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Krm98tN9lFPURW356QRSQtol7r+oaOm3effAglpFnyc=;
	b=IZn9FtOzg0hDyeKaDHERc28XCI4iYytnpvwd/FhNcoFNtmhlX6uvalVaZJF2TUggRYC/xI
	sZmQfZ1MPZ23pejRQaT8vNWedGFRTU9N6qoaMab96C2LEGNZ3UeFKmmPtgRdjIZZRgNVqW
	Ev6nY2OkdIlX4KOkNiA8qtkRyHihDC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770089268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Krm98tN9lFPURW356QRSQtol7r+oaOm3effAglpFnyc=;
	b=oKRnmNbBT0Mk66wNf2TSse+kbCy3mMqfNz7D+Imq8OEKrqyMe8hCmfD5zxvuLc66BbUkpa
	mlXG9C1vqoArSfBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770089267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Krm98tN9lFPURW356QRSQtol7r+oaOm3effAglpFnyc=;
	b=eVeqAUZpg44HqWFI6hOvTIVB/2Jv09FR6bNUCWaRN6KB3JK4R0HhkBhAbA0KGEkD/mt6RE
	obtDiiiYh1Mx4XNdOJJJU7tO8Sq5ep2xg896GVB1HlTyS9v0DJ2Q1ye/yFJAspfxlvFo2G
	HGlAxgf1aHN/MeAWD4n0aXjbSrEWqDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770089267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Krm98tN9lFPURW356QRSQtol7r+oaOm3effAglpFnyc=;
	b=HPO/g1qMC6NUxLuB5Vy/npwfEMhal5AXMAhdnHeBw3JFd+Ja0vcJYP3gfv3exdBZRYPVNJ
	yU1gXp1wvExqH4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E2803EA62;
	Tue,  3 Feb 2026 03:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jNRtAi5rgWk9dAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Feb 2026 03:27:42 +0000
Message-ID: <3e5a7153-662d-479f-8205-c17cd3f35455@suse.de>
Date: Tue, 3 Feb 2026 04:27:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] nvmet: Send an AEN on CCR completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-6-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260130223531.2478849-6-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,purestorage.com:email,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_192750_544295_F2786F94 
X-CRM114-Status: GOOD (  21.62  )
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

On 1/30/26 23:34, Mohamed Khalfella wrote:
> Send an AEN to initiator when impacted controller exists. The
> notification points to CCR log page that initiator can read to check
> which CCR operation completed.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/target/core.c  | 25 ++++++++++++++++++++++---
>   drivers/nvme/target/nvmet.h |  3 ++-
>   include/linux/nvme.h        |  3 +++
>   3 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 54dd0dcfa12b..ae2fe9f90bcd 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -202,7 +202,7 @@ static void nvmet_async_event_work(struct work_struct *work)
>   	nvmet_async_events_process(ctrl);
>   }
>   
> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> +static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
>   		u8 event_info, u8 log_page)
>   {
>   	struct nvmet_async_event *aen;
> @@ -215,13 +215,19 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>   	aen->event_info = event_info;
>   	aen->log_page = log_page;
>   
> -	mutex_lock(&ctrl->lock);
>   	list_add_tail(&aen->entry, &ctrl->async_events);
> -	mutex_unlock(&ctrl->lock);
>   
>   	queue_work(nvmet_wq, &ctrl->async_event_work);
>   }
>   
> +void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> +		u8 event_info, u8 log_page)
> +{
> +	mutex_lock(&ctrl->lock);
> +	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
> +	mutex_unlock(&ctrl->lock);
> +}
> +
>   static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
>   {
>   	u32 i;
> @@ -1788,6 +1794,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   }
>   EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
>   
> +static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
> +{
> +	lockdep_assert_held(&ctrl->lock);
> +
> +	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
> +		return;
> +
> +	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
> +				     NVME_AER_NOTICE_CCR_COMPLETED,
> +				     NVME_LOG_CCR);
> +}
> +
>   static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
>   {
>   	struct nvmet_subsys *subsys = ctrl->subsys;

But what does the CCR command actually _do_?
At the very lease I would have expected it to trigger a controller reset
(eg calling into nvmet_ctrl_fatal_error()), yet I don't see it doing
that anywhere ...

> @@ -1803,6 +1821,7 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
>   		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
>   			if (ccr->ctrl == ctrl) {
>   				ccr->ctrl = NULL;
> +				nvmet_ctrl_notify_ccr(sctrl);
>   				break;
>   			}
>   		}
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 93d6ac41cf85..00528feeb3cd 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -44,7 +44,8 @@
>    * Supported optional AENs:
>    */
>   #define NVMET_AEN_CFG_OPTIONAL \
> -	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE)
> +	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE | \
> +	 NVME_AEN_CFG_CCR_COMPLETE)
>   #define NVMET_DISC_AEN_CFG_OPTIONAL \
>   	(NVME_AEN_CFG_DISC_CHANGE)
>   
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 3e189674b69e..f6d66dadc5b1 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -863,12 +863,14 @@ enum {
>   	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
>   	NVME_AER_NOTICE_ANA		= 0x03,
>   	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
> +	NVME_AER_NOTICE_CCR_COMPLETED	= 0xf4,
>   };
>   
>   enum {
>   	NVME_AEN_BIT_NS_ATTR		= 8,
>   	NVME_AEN_BIT_FW_ACT		= 9,
>   	NVME_AEN_BIT_ANA_CHANGE		= 11,
> +	NVME_AEN_BIT_CCR_COMPLETE	= 20,
>   	NVME_AEN_BIT_DISC_CHANGE	= 31,
>   };
>   
> @@ -876,6 +878,7 @@ enum {
>   	NVME_AEN_CFG_NS_ATTR		= 1 << NVME_AEN_BIT_NS_ATTR,
>   	NVME_AEN_CFG_FW_ACT		= 1 << NVME_AEN_BIT_FW_ACT,
>   	NVME_AEN_CFG_ANA_CHANGE		= 1 << NVME_AEN_BIT_ANA_CHANGE,
> +	NVME_AEN_CFG_CCR_COMPLETE	= 1 << NVME_AEN_BIT_CCR_COMPLETE,
>   	NVME_AEN_CFG_DISC_CHANGE	= 1 << NVME_AEN_BIT_DISC_CHANGE,
>   };
>   
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

