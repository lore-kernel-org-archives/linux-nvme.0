Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8F2E83051
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 05:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oBYXMfJ62YtIuGtc795jxZuVaPAaVKLQPurbNpFRrMw=; b=vN5ThsxuQzmAA0NNKNTF2tZfN6
	ALk9WvwAOxTBxeaYQ6VLyFbntd52ti9xoXpFyoM6/dUYPehiPa/vGKXGDcAGlhRsbg/cIjMMczSl1
	J6hcaCK4Y/OyOzsAsFCBh83OfnqINGDSkLlLQajhVb3VlkllK5Tv2G/9DZhFOcPnDyFo9ywqt9O/b
	L7HbEB0aqlIIQzA50ZV1mBh1YDrgL9TzUIB3+9Eqtb2X4mo4ltV5h2f4+VH6CQIA/QhWDpr4/JZoa
	GTc0Kfom+V9k91sC8ItwujiMjIMUQinZhZ4V9qHHgeU6Bwwml0D7HqquUJeQXXKgfi6PZClQRAQzK
	SD4B2dBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn8dl-000000064mL-0kod;
	Tue, 03 Feb 2026 05:07:53 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn8dh-000000064lP-3dYN
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 05:07:52 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B33DC5BCC6;
	Tue,  3 Feb 2026 05:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770095267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBYXMfJ62YtIuGtc795jxZuVaPAaVKLQPurbNpFRrMw=;
	b=fUrrkKgtAVYKXNmoEx5ZqGa4IuMmfi4JsPxIVZg/esgTtaQgWmbqK5wyjygr/23h/7U/Ho
	fZqwyQ/f10lHS+NWFInkimRiuyNNNqFBCr+ivriSVfGLXcZiG53aVaI08KJTaBg6w1p8N6
	aUnrHdsYtARDvtcALZOU5ffOGI2Jaqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770095267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBYXMfJ62YtIuGtc795jxZuVaPAaVKLQPurbNpFRrMw=;
	b=EfT7+pajQdCT3QlGqSPXgpKM6BEA3jRWhBFFa3QJ17tqbyJ6TeK/xoCxAA1hlq1n1DpW8f
	5sOnMHOGZtYJCKBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770095267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBYXMfJ62YtIuGtc795jxZuVaPAaVKLQPurbNpFRrMw=;
	b=fUrrkKgtAVYKXNmoEx5ZqGa4IuMmfi4JsPxIVZg/esgTtaQgWmbqK5wyjygr/23h/7U/Ho
	fZqwyQ/f10lHS+NWFInkimRiuyNNNqFBCr+ivriSVfGLXcZiG53aVaI08KJTaBg6w1p8N6
	aUnrHdsYtARDvtcALZOU5ffOGI2Jaqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770095267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBYXMfJ62YtIuGtc795jxZuVaPAaVKLQPurbNpFRrMw=;
	b=EfT7+pajQdCT3QlGqSPXgpKM6BEA3jRWhBFFa3QJ17tqbyJ6TeK/xoCxAA1hlq1n1DpW8f
	5sOnMHOGZtYJCKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6FED3EA62;
	Tue,  3 Feb 2026 05:07:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3eo/Jp6CgWkjQwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Feb 2026 05:07:42 +0000
Message-ID: <fe62af4b-718c-423d-918a-d05acdadb980@suse.de>
Date: Tue, 3 Feb 2026 06:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] nvme: Introduce FENCING and FENCED controller
 states
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
 <20260130223531.2478849-8-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260130223531.2478849-8-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_210751_078953_0A513919 
X-CRM114-Status: GOOD (  23.12  )
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
> FENCING is a new controller state that a LIVE controller enter when an
> error is encountered. While in FENCING state inflight IOs that timeout
> are not canceled because they should be held until either CCR succeeds
> or time-based recovery completes. While the queues remain alive requests
> are not allowed to be sent in this state and the controller can not be
> reset of deleted. This is intentional because resetting or deleting the
> controller results in canceling inflight IOs.
> 
> FENCED is a short-term state the controller enters before it is reset.
> It exists only to prevent manual resets to happen while controller is
> in FENCING state.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/core.c  | 25 +++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h  |  4 ++++
>   drivers/nvme/host/sysfs.c |  2 ++
>   3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8961d612ccb0..3e1e02822dd4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -574,10 +574,29 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   			break;
>   		}
>   		break;
> +	case NVME_CTRL_FENCING:
> +		switch (old_state) {
> +		case NVME_CTRL_LIVE:
> +			changed = true;
> +			fallthrough;
> +		default:
> +			break;
> +		}
> +		break;
 > +	case NVME_CTRL_FENCED:> +		switch (old_state) {
> +		case NVME_CTRL_FENCING:
> +			changed = true;
> +			fallthrough;
> +		default:
> +			break;
> +		}
> +		break;
>   	case NVME_CTRL_RESETTING:
>   		switch (old_state) {
>   		case NVME_CTRL_NEW:
>   		case NVME_CTRL_LIVE:
> +		case NVME_CTRL_FENCED:
>   			changed = true;
>   			fallthrough;
>   		default:
> @@ -760,6 +779,7 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
>   
>   	if (state != NVME_CTRL_DELETING_NOIO &&
>   	    state != NVME_CTRL_DELETING &&
> +	    state != NVME_CTRL_FENCING &&

Shouldn't 'FENCED' be in here, too?

>   	    state != NVME_CTRL_DEAD &&
>   	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
> @@ -802,10 +822,11 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_receive))
>   				return true;
>   			break;
> -		default:
> -			break;
> +		case NVME_CTRL_FENCING:

Similar here.

>   		case NVME_CTRL_DEAD:
>   			return false;
> +		default:
> +			break;
>   		}
>   	}
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9dd9f179ad88..00866bbc66f3 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -251,6 +251,8 @@ static inline u16 nvme_req_qid(struct request *req)
>   enum nvme_ctrl_state {
>   	NVME_CTRL_NEW,
>   	NVME_CTRL_LIVE,
> +	NVME_CTRL_FENCING,
> +	NVME_CTRL_FENCED,
>   	NVME_CTRL_RESETTING,
>   	NVME_CTRL_CONNECTING,
>   	NVME_CTRL_DELETING,
> @@ -777,6 +779,8 @@ static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
>   	switch (nvme_ctrl_state(ctrl)) {
>   	case NVME_CTRL_NEW:
>   	case NVME_CTRL_LIVE:
> +	case NVME_CTRL_FENCING:
> +	case NVME_CTRL_FENCED:
>   	case NVME_CTRL_RESETTING:
>   	case NVME_CTRL_CONNECTING:
>   		return false;
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index f81bbb6ec768..4ec9dfeb736e 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -443,6 +443,8 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
>   	static const char *const state_name[] = {
>   		[NVME_CTRL_NEW]		= "new",
>   		[NVME_CTRL_LIVE]	= "live",
> +		[NVME_CTRL_FENCING]	= "fencing",
> +		[NVME_CTRL_FENCED]	= "fenced",
>   		[NVME_CTRL_RESETTING]	= "resetting",
>   		[NVME_CTRL_CONNECTING]	= "connecting",
>   		[NVME_CTRL_DELETING]	= "deleting",

You need to modify nvme-tcp.c:nvme_tcp_timeout() too, as this checks
'just' for 'LIVE' state and will abort/terminate commands when in
FENCING. Similar argument for nvme-rdma.c. And nvme-fc.c also needs an
audit to ensure it works correctly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

