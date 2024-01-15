Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBD0C3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/QSYR8EwMeIwb0nQG9BENliM51dHDcXG/pZ8KlC0eEc=; b=DpI4xvJwA/MHSd8b4D4/lxMy+R
	BzGvi+uNGgUn7EzSoXzrVMqLKUy4UZTpIQ6rXcIHzffYwYsZHR2Lgm4rBfV+82yMdIU4UqT2J/GiA
	bmzsU676yWQfyd3O68kEre78iTbXEINaLctuyOFu/A7ql945qdYY4/gB6nGSDSLz6f+GydB2kIKot
	uEuXnJuHEYitfMUDE4jXvTaALgupalpQtbmK6U1vRzIlUwxTMzGxQxxWDXniTKYt5eZzjKI1inSou
	kP1zjx7zcOy1XfDd/eAXPeZG3ZW7/2qx3L1GKwS4DAjH1kWE4rPNvHvOALpw9rfPeQTcSVNQe6+Nr
	iFNTCcIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPMCn-008v3k-2r;
	Mon, 15 Jan 2024 12:36:41 +0000
Received: from mail-lf1-f47.google.com ([209.85.167.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPMCk-008v3N-27
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 12:36:40 +0000
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e79299da9so1587443e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 04:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705322195; x=1705926995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QSYR8EwMeIwb0nQG9BENliM51dHDcXG/pZ8KlC0eEc=;
        b=paFGrI/k8o2R7JK4+bRlR6ScZXyJjgY8adAkL9wAekUesdLMaum7KKx1v38Hzpe+Hw
         q0heboZZ8jyg9ZcVVisF7zkRbWRefDDxhMz5y8dctdPvZm3YL1HUuUowNdMgkqSRU8mQ
         Pcv6qKEjVLXSA7egcXnC6k9b/hDF28feA1dyJ1HBKa3fGJk15xu2ZsNm4MEmfK3a8IsZ
         nwVf6TpxY2hvMISBOFW3J7OjPx2G1zs09WJPugQIhieGVEDe6x6xktk9YbuXObOlHa7h
         VhPZ3jEtzch2hzCruk7tOB+IhsqoS0V/TUZhL5idjs/qRfrezowt1uXB/aKWJbiYXf2G
         fYKQ==
X-Gm-Message-State: AOJu0YxEckOMv5bPnaGppScpHwa6a2KUDKKmzlhlvFmSNK/sPhtOJ/Z8
	ZA+QuEn3HolA0lnpYe4gv30=
X-Google-Smtp-Source: AGHT+IHCVA+u0bweKc1CVKoOz1TE88fVV1MdVypv1kg4HFXKjSuebWlaJ3YTJVbVWeyAJB5kSmx9qg==
X-Received: by 2002:a19:e006:0:b0:50e:337b:f316 with SMTP id x6-20020a19e006000000b0050e337bf316mr5172303lfg.1.1705322194744;
        Mon, 15 Jan 2024 04:36:34 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090639c400b00a27a766c6c8sm5241061eje.218.2024.01.15.04.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 04:36:34 -0800 (PST)
Message-ID: <61300700-8107-4bdc-a43b-6b9b0a7ac816@grimberg.me>
Date: Mon, 15 Jan 2024 14:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Do not terminate i/o commands during
 RESETTING
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240112100907.80765-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240112100907.80765-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_043638_719711_482B966E 
X-CRM114-Status: GOOD (  25.43  )
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



On 1/12/24 12:09, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Terminating commands from the timeout handler might lead
> to a data corruption as the timeout might trigger before
> KATO expired.
> When several commands have been sent in a batch and
> the command timeouts trigger just after the keep-alive
> command has been sent then the first command will trigger
> the error recovery. But all other commands will timeout
> directly afterwards and will hit the timeout handler
> before the err_work workqueue handler has started.
> This results in these commands being aborted and
> immediately retried without waiting for KATO.
> So return BLK_EH_RESET_TIMER for I/O commands when
> the controller is in 'RESETTING' or 'DELETING'
> state to ensure that the commands will
> be retried only after the KATO interval.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 08805f027810..9dcb2d3b123c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2431,17 +2431,27 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
>   	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
>   	u8 opc = pdu->cmd.common.opcode, fctype = pdu->cmd.fabrics.fctype;
>   	int qid = nvme_tcp_queue_id(req->queue);
> +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
>   
>   	dev_warn(ctrl->device,
> -		"queue %d: timeout cid %#x type %d opcode %#x (%s)\n",
> +		"queue %d: timeout cid %#x type %d opcode %#x (%s) state %d\n",
>   		nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
> -		opc, nvme_opcode_str(qid, opc, fctype));
> +		opc, nvme_opcode_str(qid, opc, fctype), state);
> +
> +	/*
> +	 * If the controller is in state RESETTING or DELETING all
> +	 * inflight commands will be terminated soon which in turn
> +	 * may failover to a different path.
> +	 */
> +	if ((state == NVME_CTRL_RESETTING ||
> +	     state == NVME_CTRL_DELETING) && qid > 0)
> +		return BLK_EH_RESET_TIMER;
>   
> -	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
> +	if (state != NVME_CTRL_LIVE) {

The remaining states are:
NVME_CTRL_NEW
NVME_CTRL_CONNECTING
NVME_CTRL_DELETING_NOIO
NVME_CTRL_DEAD

The comment perhaps is becoming outdated?

I'm wandering if it would make sense to turn this
into a switch-case statement:
--
	switch (state) {
	case NVME_CTRL_LIVE:
		/*
		 * LIVE state should trigger the normal error recovery
		 * which will handle completing this request.
          	 */
		break;
	case NVME_CTRL_RESETTING:
		/* fallthru */
	case NVME_CTRL_DELETING:
		if (!qid)
			break;
		/*
		 * If the controller is in state RESETTING or DELETING
		 * all inflight I/O commands will be terminated soon
		 * which in turn may failover to a different path.
		 */
		return BLK_EH_RESET_TIMER;
	case NVME_CTRL_DELETING_NOIO;
	case NVME_CTRL_DEAD;
		/* fallthru */
	case NVME_CTRL_CONNECTING;
		/*
		 * Fail immediately to avoid a deadlock if the request
		 * is blocking as part of the ctrl setup or teardown
		 * sequence (e.g. connect, property_set).
		 */
		nvme_tcp_complete_timed_out(rq);
		return BLK_EH_DONE;
	case NVME_CTRL_NEW:
		/* fallthru */
	default:
		WARN_ONCE();
		return BLK_EH_RESET_TIMER;
	}

	nvme_tcp_error_recovery(ctrl);
	return BLK_EH_RESET_TIMER;
--

Thoughts?

