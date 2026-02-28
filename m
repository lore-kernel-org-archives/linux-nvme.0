Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFBA1048926
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Feb 2026 01:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vsir7RzWJTF5T+JtYgTpKZswmD6bp2siqT17GC9wqT0=; b=GwG760y75ziZC9jWPSlGdiczOd
	igcSTpE68wwSWFwt/reCqO8xlubNwk3kR/8U2CDo5OFGgjyKzAIkjCV/Vl5CJO8BX6rGg55mG2ex7
	Qh1x45c0FFo2rUOC9uuJ7ZODHlrmpA640Ie0JXw/r299oW4/2fTAY9baa9Yy5F2OmzcVYF5fxwE87
	gtHKUIeFXvXKb3y2jj/3eXpuQrTIHO3jq0XUeg5lWI8affuzWamQ56ibsltZk3hOrGTcq//W4H+Ai
	GarNu1pNeYkGXHZP3v3YjJr+0hHyfB/HPApy/c59VMTqSVpaywBptALj1W3uU7/ZKoeilbCu97/I8
	HLayZFYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw8sl-00000009NIx-3aS2;
	Sat, 28 Feb 2026 01:12:35 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw8si-00000009NHr-1sho
	for linux-nvme@lists.infradead.org;
	Sat, 28 Feb 2026 01:12:34 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-1277d379936so3481712c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 17:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772241151; x=1772845951; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vsir7RzWJTF5T+JtYgTpKZswmD6bp2siqT17GC9wqT0=;
        b=eTIiHDfyTJbeLzrhQMu8mVdvyh/k55fUqmU7R3pmwNinyNZpeXn8GU+x3EE1VIHnEb
         +D+MAmRkKai2sQVLEyeUT/vTdyRfHyqHQS4H/vn6/ARJIKxEJt0vzCguohORyDUUG86u
         XIV51OcsHsOPouMqRSXY0p8DzNm+MvaLOchXP62LFtLj1yzYk/dEjgg74PL/ziICvf4X
         MKIGMmHPTnwERBKdKPJtiPZoLY/flOi8vRXVqxks3B3j/ezOPqZDD71Z2PWX72uq8Vg3
         aDt+M5jJGRs6xt3VWz8ZOOSPfTLcAsTlGKFcTdfTsZ6Ek53eaIifbgWKzSBK0BSz3gBw
         DmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772241151; x=1772845951;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vsir7RzWJTF5T+JtYgTpKZswmD6bp2siqT17GC9wqT0=;
        b=qHnZpZMsWNZxstN1Ns/tcULPmOj3DfNZ3OFASG/gpSZKICrCiHpt3KvOnItzxDFxcv
         5cN+O+tNo3keKrVHyGy9XxTh9EOg09AYKHo6Qo2dZCe/pY1wbNzKGhrqBGHGz9O4e/LQ
         8ZLnlsx6/kASY1rP2ivmxPLIcZLVzAQ3ltF4QHu3klpeJKbVhxg+2F3JuQasbMf6ZLf+
         vTyd0rxIl8UIbkiEraxG1x0+djJ11hBm+IBhn18w3KZ7QNZqXBneRgN1IcokK6CfzPn/
         td10pI+sqL61zStmDvmOtN/DeRWynAjWeRlDh8JpRDJ7MvWK+3NCcIxoOewoBIIHQsMR
         cYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJGrrVc+aEePRaPJRoYmViSiFEFwbVqDmBuEiDJKItcbynBrWbylAmusqF9Dmr1buC5MioMVfqESO6@lists.infradead.org
X-Gm-Message-State: AOJu0YxStMFZFxIDbgDRmX7l6SzW75t1Ciqv09Bdjtc0mGvFAGGmjC/a
	CEIHqBssaHoDoleKWdJ0Mhpaf5s5gmcJXXt/NoFN+lBD2cpU3sWf3x4A
X-Gm-Gg: ATEYQzxlLbLmwZRvaWSlzwVSiMCAMpi5IDuGJO+rJsiELlL6SRfnO8heqJ2MmjMXfim
	xlIZmLV44LOafTtq2YU6lfZ4Y8vCVw/Ro3h6omvL/a2hWAwSpakYbI770uW4+fC1OTjeRHcXVs8
	yNQw7qlgdmwQYlYtZBXa4Ygo71H+CB/V3Xt3+u2bZi8elR2oTIKyyvR+D/LY+s9JCHCmhw6vTsG
	fqjnkUsduPBC0Z3b6eT1PU2n8gtA2tdHQQEDB/ZBLUOZJfyBAyj08K6xYromhUZn2yOIZuCoeBm
	5I+c0u8XPuXlLESL/tMXBmaQz4QuQDVr+233LFuCYeom60FKz657EjtbYBjgX6AmYt+OF7zQlt+
	eYqrbHItrH4iplytQzdbJF5+xSGRGDKYGLb9m0Xd+hWsvfZ6Rck/zVb3uoNEhxsU3z4e1/MNUwa
	DFlhDQYkD+fD6o5YS1vqjVeI936xdR//CyuRd0R/gc6Az0
X-Received: by 2002:a05:7022:6723:b0:127:5cda:ab0f with SMTP id a92af1059eb24-1278fb604damr2414632c88.5.1772241151375;
        Fri, 27 Feb 2026 17:12:31 -0800 (PST)
Received: from [10.69.56.189] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789962f89sm5830261c88.0.2026.02.27.17.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 17:12:30 -0800 (PST)
Message-ID: <4029a0f6-4135-4609-9cb4-9fbd014b85fb@gmail.com>
Date: Fri, 27 Feb 2026 17:12:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Smart <jsmart833426@gmail.com>
Subject: Re: [PATCH v3 15/21] nvme-fc: Do not cancel requests in io taget
 before it is initialized
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, jsmart833426@gmail.com
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-16-mkhalfella@purestorage.com>
Content-Language: en-US
In-Reply-To: <20260214042753.4073668-16-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_171232_496565_A9F4C4CE 
X-CRM114-Status: GOOD (  19.85  )
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

On 2/13/2026 8:25 PM, Mohamed Khalfella wrote:
> A new nvme-fc controller in CONNECTING state sees admin request timeout
> schedules ctrl->ioerr_work to abort inflight requests. This ends up
> calling __nvme_fc_abort_outstanding_ios() which aborts requests in both
> admin and io tagsets. In case fc_ctrl->tag_set was not initialized we
> see the warning below. This is because ctrl.queue_count is initialized
> early in nvme_fc_alloc_ctrl().
> 
> nvme nvme0: NVME-FC{0}: starting error recovery Connectivity Loss
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> lpfc 0000:ab:00.0: queue 0 connect admin queue failed (-6).
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> Workqueue: nvme-reset-wq nvme_fc_ctrl_ioerr_work [nvme_fc]
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x57/0x80
>   register_lock_class+0x567/0x580
>   __lock_acquire+0x330/0xb90
>   lock_acquire.part.0+0xad/0x210
>   blk_mq_tagset_busy_iter+0xf9/0xc00
>   __nvme_fc_abort_outstanding_ios+0x23f/0x320 [nvme_fc]
>   nvme_fc_ctrl_ioerr_work+0x172/0x210 [nvme_fc]
>   process_one_work+0x82c/0x1450
>   worker_thread+0x5ee/0xfd0
>   kthread+0x3a0/0x750
>   ret_from_fork+0x439/0x670
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
> Update the check in __nvme_fc_abort_outstanding_ios() confirm that io
> tagset was created before iterating over busy requests. Also make sure
> to cancel ctrl->ioerr_work before removing io tagset.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index e605dd3f4a40..eac3a7ccaa5c 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2557,7 +2557,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>   	 * io requests back to the block layer as part of normal completions
>   	 * (but with error status).
>   	 */
> -	if (ctrl->ctrl.queue_count > 1) {
> +	if (ctrl->ctrl.queue_count > 1 && ctrl->ctrl.tagset) {
>   		nvme_quiesce_io_queues(&ctrl->ctrl);
>   		nvme_sync_io_queues(&ctrl->ctrl);
>   		blk_mq_tagset_busy_iter(&ctrl->tag_set,
> @@ -2954,6 +2954,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>   out_delete_hw_queues:
>   	nvme_fc_delete_hw_io_queues(ctrl);
>   out_cleanup_tagset:
> +	/*
> +	 * In CONNECTING state ctrl->ioerr_work will abort both admin
> +	 * and io tagsets. Cancel it first before removing io tagset.
> +	 */
> +	cancel_work_sync(&ctrl->ioerr_work);
>   	nvme_remove_io_tag_set(&ctrl->ctrl);
>   	nvme_fc_free_io_queues(ctrl);
>   

looks good

Signed-off-by: James Smart <jsmart833426@gmail.com>

-- james


