Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEE7C432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 11:25:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF09F610E8
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 11:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF09F610E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=98Vhl+3x/BuY6hlX/wSJr8fg7qCduma5mzwwJgijNCk=; b=FcF2zd5Mw8VSLGo6tousndzcOm
	q9lvpY69qnDrH5zLEsoh36r7sdm/WzrfLJP1wUL3DC/xvecRm7vtJYPbs6n0Iu42cX9Fe127UlGvs
	H4y1iTl7GXDWF+VN5Ovt9g3ZUWK9NwhQO6eJUixnS2JmGvZ5qQsS/vwal1vYl9A8sZTmpSOPfRgW4
	EDl7FmXExfwFTaFR+oJp3d37gnoCgdzbXuoBn6DCAuFUOU+0Nv/Xe2mrQf2quayVeAAGfLkDfvhUt
	fhZ92iVGXCiy55k+11pqA9TpznSbVoHsZKYRn/RtgTlMSn4ECkhSGplTab5Xk8sU0vc9gieDB5JVn
	Nu9stOkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKfPh-00H4kh-Nf; Mon, 30 Aug 2021 11:25:17 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKfPd-00H4ju-Qn
 for linux-nvme@lists.infradead.org; Mon, 30 Aug 2021 11:25:15 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 v20-20020a1cf714000000b002e71f4d2026so11238392wmh.1
 for <linux-nvme@lists.infradead.org>; Mon, 30 Aug 2021 04:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wqRTnIr5Cge1DbJwXPCdaa0iV8m7g/QRqZT/v0OelUI=;
 b=XgEr4h1p0/aY5FfJvrZerYKT8fNLEH0Z9ftSBYq/il3Txo5nixK00jyT6mCqyN76b7
 ncMNutwTU1TS2MwoOB9HwA4/nSyti4LsMD6RuQvbjUvw199Dy1B2EC2i9O1V9PHUbmnz
 GKSEB40k+BChTFu5JyuvSdroQFVyqyNp+TUexZXrpbf5BBmlE7R9Nrli3+8jk9R8lgak
 LFKvEjmdtMMGFnhmoDKv8H9qaVFcUYcckGMfS3Bw9br0cI9SwDv1cA13ITq796rdekf1
 QSp9vNp7BHfWAgvqrrOXr0Ul+r12uE/CmX/58p967wxCeLvR52IHs+8LGXTvXGzYbXYg
 Mz1w==
X-Gm-Message-State: AOAM532tUHx69HnP8ivIQ05VyzWi+W871KZQU93I8hoZiMlI0aW+0ZhL
 BF+nf48A1ueY3STWz6cpnrc=
X-Google-Smtp-Source: ABdhPJwnBG2m0WK7taiBFZmrq9ajOSpvBC/acB8HnYFa6P0Ge8zvDBaho28tmmFvGEkMI0iTKeCoxg==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr23807193wmh.145.1630322707053; 
 Mon, 30 Aug 2021 04:25:07 -0700 (PDT)
Received: from [192.168.64.87] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id e2sm17030045wrq.56.2021.08.30.04.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Aug 2021 04:25:06 -0700 (PDT)
Subject: Re: [PATCH v3] nvme-tcp: Do not reset transport on data digest errors
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>, yi.he@emc.com
References: <20210826082137.23826-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <53701a52-a49c-fcdf-49cc-98da55447e9a@grimberg.me>
Date: Mon, 30 Aug 2021 14:25:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826082137.23826-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_042513_932363_823E5F76 
X-CRM114-Status: GOOD (  29.97  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/26/21 1:21 AM, Daniel Wagner wrote:
> The spec says
> 
>    7.4.6.1 Digest Error handling
> 
>    When a host detects a data digest error in a C2HData PDU, that host
>    shall continue processing C2HData PDUs associated with the command and
>    when the command processing has completed, if a successful status was
>    returned by the controller, the host shall fail the command with a
>    non-fatal transport error.
> 
> Currently the transport is reseted when a data digest error is
> detected. Instead, when a digest error is detected, mark the final
> status as NVME_SC_DATA_XFER_ERROR and let the upper layer handle
> the error.
> 
> In order to keep track of the final result maintain a status field in
> nvme_tcp_request object and use it to overwrite the completion queue
> status (which might be successful even though a digest error has been
> detected) when completing the request.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> The status member placed so that it fills up a hole in struct
> nvme_tcp_request:
> 
> struct nvme_tcp_request {
>          struct nvme_request        req;                  /*     0    32 */
>          void *                     pdu;                  /*    32     8 */
>          struct nvme_tcp_queue *    queue;                /*    40     8 */
>          u32                        data_len;             /*    48     4 */
>          u32                        pdu_len;              /*    52     4 */
>          u32                        pdu_sent;             /*    56     4 */
>          u16                        ttag;                 /*    60     2 */
>          u16                        status;               /*    62     2 */
>          /* --- cacheline 1 boundary (64 bytes) --- */
>          struct list_head           entry;                /*    64    16 */
>          struct llist_node          lentry;               /*    80     8 */
>          __le32                     ddgst;                /*    88     4 */
> 
>          /* XXX 4 bytes hole, try to pack */
> 
>          struct bio *               curr_bio;             /*    96     8 */
>          struct iov_iter            iter;                 /*   104    40 */
>          /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
>          size_t                     offset;               /*   144     8 */
>          size_t                     data_sent;            /*   152     8 */
>          enum nvme_tcp_send_state   state;                /*   160     4 */
> 
>          /* size: 168, cachelines: 3, members: 16 */
>          /* sum members: 160, holes: 1, sum holes: 4 */
>          /* padding: 4 */
>          /* last cacheline: 40 bytes */
> };
> 
> v3:
>   - initialize req->status in nvme_tcp_setup_cmd_pdu()
>   - add rb tag from Hannes
> 
> v2:
>   - https://lore.kernel.org/linux-nvme/20210825124259.28707-1-dwagner@suse.de/
>   - moved 'status' from nvme_tcp_queue to nvme_tcp_request.
> 
> v1:
>   - https://lore.kernel.org/linux-nvme/20210805121541.77613-1-dwagner@suse.de/
> 
> drivers/nvme/host/tcp.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 645025620154..29ef0f74f620 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -45,6 +45,7 @@ struct nvme_tcp_request {
>   	u32			pdu_len;
>   	u32			pdu_sent;
>   	u16			ttag;
> +	u16			status;
>   	struct list_head	entry;
>   	struct llist_node	lentry;
>   	__le32			ddgst;
> @@ -485,7 +486,9 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> +	struct nvme_tcp_request *req;
>   	struct request *rq;
> +	u16 status;
>   
>   	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
>   	if (!rq) {
> @@ -496,7 +499,12 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> +	req = blk_mq_rq_to_pdu(rq);
> +	status = req->status;
> +	if (status == NVME_SC_SUCCESS)
> +		status = cqe->status;

Maybe more intuitive to skip the local status variable?
	/*  */
	if (req->status == NVME_SC_SUCCESS)
		req->status = cqe->status;

This way it is always consistent completing with req->status.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
