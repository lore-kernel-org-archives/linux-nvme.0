Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D92C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:53:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A78920708
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HmQv1KOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A78920708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dMByxLOYUDTjX7ynU85SO9xwhb8FnltmX7yeJGvuX48=; b=HmQv1KOquBf7CIwmzE3itbTQb
	25gFzfj5vWPVgGm5eR5d0IPvEwylU7purDiX7s3qc6xoRy0vH3z0kSjkhSkTvq2tYu3s9gDM2yUhL
	QIXP/CDHXYm8YFmHMUS5wziIIGkdp2Gjc43HP7vYftLwyUVU7xBZl1eRFjKjCrbespLkbJbELANH6
	DkynQ2MjsjKPrDIRI+egJD5qNQ4OODsbnNMSDQdVdc2762S6N2sRmqO/QnBHwEEF/1m8TPbfyZxmE
	VFcNMgpebf/YgwVTLRYqd1KXW/HqOf+HNmjGLBLCy4RbwmPiCuAo4WZS8c+JdxexAzy1aicnhuXYl
	wQ6u+DFuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6Tad-0006Y3-IZ; Fri, 14 Aug 2020 06:53:23 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Tab-0006XF-1g
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:53:21 +0000
Received: by mail-wm1-f67.google.com with SMTP id k8so7034955wma.2
 for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2020 23:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R98QDB24e1f/EyNvzbPCtJM2RLHYWMk5nZRYsMJ6+Vw=;
 b=phuZrNsRVEPwxrVOdIeemGO3dTI4mWViBWrLRnyBVQRvnFujxC4cd+17c97IfmKmyi
 9dOFP5AoE0NhOLo+k46ALBzybz2wz0+5FSM7q+UmI25jyUS8r4nNcqeE6nCFiS1Gp0cE
 6N3ca5UpoXLAJrdNxcBrnDjESFrkufDNkCDLiNsXCRc8ux28blmyNeQL+R6zwc+ReN2Z
 N7udiDiFr4GGbQLet+A5Z2umeWkVsYpx1FSqm5IfbilLo7odrtt8eek22ESTkLB4ukG1
 6Su1bDYVg31Yek6cSJp9ge/U8bcg79MiazwWbZ5h2JJDhNLa2NZDJbGC8gFLYy0PdtzW
 lZNg==
X-Gm-Message-State: AOAM532RvOklQ/9AD/4hdyZrMAe/w/rzS69UNM4U17SwQTCTn7URbllt
 0KEvsgjpUxhG0wE673MSLU8=
X-Google-Smtp-Source: ABdhPJyblIiEL1uyaEoCxwaA/L+BxzNnfLA00lQmpNzqeruB2N+ne1qge8Ibhvf74hOyrQiw+FIhJg==
X-Received: by 2002:a1c:540c:: with SMTP id i12mr1123763wmb.96.1597387999953; 
 Thu, 13 Aug 2020 23:53:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id a10sm13359599wro.35.2020.08.13.23.53.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 23:53:19 -0700 (PDT)
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@redhat.com>
References: <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com> <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com> <20200813153623.GA30905@infradead.org>
 <20200813174704.GA6137@redhat.com> <20200813184349.GA8191@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <96aff2d0-5907-f5c9-9164-8fea0d030d95@grimberg.me>
Date: Thu, 13 Aug 2020 23:53:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813184349.GA8191@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_025321_113606_66FBCE62 
X-CRM114-Status: GOOD (  28.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, Ewan Milne <emilne@redhat.com>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> +static inline enum nvme_disposition nvme_req_disposition(struct request *req)
> +{
> +	if (likely(nvme_req(req)->status == 0))
> +		return COMPLETE;
> +
> +	if (blk_noretry_request(req) ||
> +	    (nvme_req(req)->status & NVME_SC_DNR) ||
> +	    nvme_req(req)->retries >= nvme_max_retries)
> +		return COMPLETE;
> +
> +	if (req->cmd_flags & REQ_NVME_MPATH) {
> +		switch (nvme_req(req)->status & 0x7ff) {
> +		case NVME_SC_ANA_TRANSITION:
> +		case NVME_SC_ANA_INACCESSIBLE:
> +		case NVME_SC_ANA_PERSISTENT_LOSS:
> +			return REDIRECT_ANA;
> +		case NVME_SC_HOST_PATH_ERROR:
> +		case NVME_SC_HOST_ABORTED_CMD:
> +			return REDIRECT_TMP;
> +		}
> +	}
> +
> +	if (blk_queue_dying(req->q))
> +		return COMPLETE;
> +	return RETRY;
> +}
> +
> +static inline void nvme_complete_req(struct request *req)
>   {
>   	blk_status_t status = nvme_error_status(nvme_req(req)->status);
>   
> -	trace_nvme_complete_rq(req);
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    req_op(req) == REQ_OP_ZONE_APPEND)
> +		req->__sector = nvme_lba_to_sect(req->q->queuedata,
> +			le64_to_cpu(nvme_req(req)->result.u64));
> +
> +	nvme_trace_bio_complete(req, status);
> +	blk_mq_end_request(req, status);
> +}
>   
> +void nvme_complete_rq(struct request *req)
> +{
> +	trace_nvme_complete_rq(req);
>   	nvme_cleanup_cmd(req);
>   
>   	if (nvme_req(req)->ctrl->kas)
>   		nvme_req(req)->ctrl->comp_seen = true;
>   
> -	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
> -		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
> -			return;
> -
> -		if (!blk_queue_dying(req->q)) {
> -			nvme_retry_req(req);
> -			return;
> -		}
> -	} else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -		   req_op(req) == REQ_OP_ZONE_APPEND) {
> -		req->__sector = nvme_lba_to_sect(req->q->queuedata,
> -			le64_to_cpu(nvme_req(req)->result.u64));
> +	switch (nvme_req_disposition(req)) {
> +	case COMPLETE:
> +		nvme_complete_req(req);

nvme_complete_rq calling nvme_complete_req... Maybe call it
__nvme_complete_rq instead?

> +		return;
> +	case RETRY:
> +		nvme_retry_req(req);
> +		return;
> +	case REDIRECT_ANA:
> +		nvme_failover_req(req, true);
> +		return;
> +	case REDIRECT_TMP:
> +		nvme_failover_req(req, false);
> +		return;
>   	}
> -
> -	nvme_trace_bio_complete(req, status);
> -	blk_mq_end_request(req, status);
>   }
>   EXPORT_SYMBOL_GPL(nvme_complete_rq);
>   
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 3ded54d2c9c6ad..0c22b2c88687a2 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -65,51 +65,32 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>   	}
>   }
>   
> -bool nvme_failover_req(struct request *req)
> +void nvme_failover_req(struct request *req, bool is_ana_status)
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
> -	u16 status = nvme_req(req)->status;
>   	unsigned long flags;
>   
> -	switch (status & 0x7ff) {
> -	case NVME_SC_ANA_TRANSITION:
> -	case NVME_SC_ANA_INACCESSIBLE:
> -	case NVME_SC_ANA_PERSISTENT_LOSS:
> -		/*
> -		 * If we got back an ANA error we know the controller is alive,
> -		 * but not ready to serve this namespaces.  The spec suggests
> -		 * we should update our general state here, but due to the fact
> -		 * that the admin and I/O queues are not serialized that is
> -		 * fundamentally racy.  So instead just clear the current path,
> -		 * mark the the path as pending and kick of a re-read of the ANA
> -		 * log page ASAP.
> -		 */
> -		nvme_mpath_clear_current_path(ns);
> -		if (ns->ctrl->ana_log_buf) {
> -			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
> -			queue_work(nvme_wq, &ns->ctrl->ana_work);
> -		}
> -		break;
> -	case NVME_SC_HOST_PATH_ERROR:
> -	case NVME_SC_HOST_ABORTED_CMD:
> -		/*
> -		 * Temporary transport disruption in talking to the controller.
> -		 * Try to send on a new path.
> -		 */
> -		nvme_mpath_clear_current_path(ns);
> -		break;
> -	default:
> -		/* This was a non-ANA error so follow the normal error path. */
> -		return false;
> +	nvme_mpath_clear_current_path(ns);
> +
> +	/*
> +	 * If we got back an ANA error we know the controller is alive, but not
> +	 * ready to serve this namespaces.  The spec suggests we should update
> +	 * our general state here, but due to the fact that the admin and I/O
> +	 * queues are not serialized that is fundamentally racy.  So instead
> +	 * just clear the current path, mark the the path as pending and kick
> +	 * of a re-read of the ANA log page ASAP.
> +	 */
> +	if (is_ana_status && ns->ctrl->ana_log_buf) {

Maybe call nvme_req_disposition again locally here to not carry
the is_ana_status. But not a biggy..

Overall this looks good I think.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
