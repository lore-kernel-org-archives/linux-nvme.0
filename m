Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE987C04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5t6ewyKu0QA6XNnRZiUhesdzfQHct03fpBfgids7PCw=; b=s3uQDJQVaFNVzvt5SKTqUgvVtz
	uq+RXjCdLMVfOfXJ5RCJsrwCtEhSe8mqBX0tHQDK5ujxy+u9GrXR/31abZ0eQuet9KNzHZ2iQ5Uad
	JG1WpmYVKSUZ+Q7M/3NNsysWBZs8ew9l93YyBw3D+xJ2Ne46tN3vGZowjVpF15HlE+CW12Wse9RlN
	akTY1UiwtanspBBSVZqQ3ltpo6NbtpgohjnM7kryQTcJAx1+sWR6PqE01q6RtUsma0pP9rNdlafur
	wDlwKPP+C6Ed770W8QiCsAmvSF5BnNvDQzVBcNGluytH7NJM5jCID3yIgd1u+XKXY/k/FPhELpckG
	KVgq7elA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4iWI-0000000Ft2l-2HU9;
	Wed, 08 May 2024 14:43:46 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4iW8-0000000Ft0C-3wxU
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 14:43:40 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a4702457ccbso1186200866b.3
        for <linux-nvme@lists.infradead.org>; Wed, 08 May 2024 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715179415; x=1715784215; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5t6ewyKu0QA6XNnRZiUhesdzfQHct03fpBfgids7PCw=;
        b=yWxbyN4w+AZBB4e/Kbbj6W0sCU/1Z0+aL+z61o43GjXhdSr1/3ekgYaJ5qk1oxVGvs
         xDyvh7Wgivkf078w/vxw43dB7uAE/IVhc0IW9vhFL/4Jq4b/VzFqrcXRHyYFRfpjhhxD
         CWN11nZKFZYBNbHPP8/eDSVbjx8ghWN01KYNSpsNXikiFswWL9hgZJEYy/hIbEw//yqK
         fSBDq8XVqmhbxRlzT5mWxYr4wvZN1LX+FsxH680yeOpj/3AnJ0M/wopFCkz6oLyYAYFW
         tuWHM0Bs7/sRVM9XvgigPmyTGSrJPr/r1Yque0+6HVocot941DErUyCw/JW41FjP3CwI
         F/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715179415; x=1715784215;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5t6ewyKu0QA6XNnRZiUhesdzfQHct03fpBfgids7PCw=;
        b=LlatU1Ol/1lVCobE1wmydTKoEJ5Y3UnSWNtZRhKjaxqnHaIVTa7IY7jrpuwCgx9ZJW
         AWreJ7qe2zJaKIG0kflwt0a3Tr54Pa9k8kMLuu3291smxot4y9mIe/g5lRRBxW+KSzDC
         P5MQWh9G9KBW4g108Vbw0SJUGmPBeVYXdWeArVEyLWbc05rqdtwv6kZMNsYK+bFoeYtN
         Pwuq7YK/0179oqqDNvOLH3BUKy+fLlT4pBh1wx+0XJPJnC2MbKmCyTq0A5uCFv5cqP3j
         GCYY1h75EwNvdffxEK6B7O1KZUJACd3aMtLq6nytmGiyjxaTbxH9ahdiaVNIyD/hGf9u
         hOhA==
X-Gm-Message-State: AOJu0YzT3FfAvr6tOOGhyJkXrCWH7CUT3QzSEkYVH6C3jtdMci3d0CI2
	E4y9D/69SnhQTrf756lX0axFm90+Q0ktD25IUYJrzK74Xxs9ha8Z28smiGfJfquTFY89ufRQ2PG
	U
X-Google-Smtp-Source: AGHT+IHqEtw9oB9h4yFU0kKeVZ33DT6VeTJ56bNUb5GEdegkUsw1DvveIZbEdC/Nim+M3Y3DRHhIPA==
X-Received: by 2002:a17:906:22c7:b0:a59:a977:a15b with SMTP id a640c23a62f3a-a59fb9e73b4mr178421466b.68.1715179414609;
        Wed, 08 May 2024 07:43:34 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id br9-20020a170906d14900b00a59a2189f0dsm5868149ejb.94.2024.05.08.07.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 07:43:34 -0700 (PDT)
Date: Wed, 8 May 2024 17:43:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: james.smart@broadcom.com
Cc: linux-nvme@lists.infradead.org
Subject: [bug report] nvme-fc: fix io timeout to abort I/O
Message-ID: <4561816b-bcae-4292-af42-e563f78cd805@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_074337_003054_39236208 
X-CRM114-Status: UNSURE (   9.36  )
X-CRM114-Notice: Please train this message.
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

Hello James Smart,

Commit 52793d62a696 ("nvme-fc: fix io timeout to abort I/O") from Oct
16, 2020 (linux-next), leads to the following Smatch static checker
warning:

	drivers/nvme/host/fc.c:3239 nvme_fc_delete_association()
	warn: mixing irqsave and irq

drivers/nvme/host/fc.c
    3219 static void
    3220 nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
    3221 {
    3222         struct nvmefc_ls_rcv_op *disls = NULL;
    3223         unsigned long flags;
    3224 
    3225         if (!test_and_clear_bit(ASSOC_ACTIVE, &ctrl->flags))
    3226                 return;
    3227 
    3228         spin_lock_irqsave(&ctrl->lock, flags);
    3229         set_bit(FCCTRL_TERMIO, &ctrl->flags);
    3230         ctrl->iocnt = 0;
    3231         spin_unlock_irqrestore(&ctrl->lock, flags);
                                                     ^^^^^
    3232 
    3233         __nvme_fc_abort_outstanding_ios(ctrl, false);
    3234 
    3235         /* kill the aens as they are a separate path */
    3236         nvme_fc_abort_aen_ops(ctrl);
    3237 
    3238         /* wait for all io that had to be aborted */
--> 3239         spin_lock_irq(&ctrl->lock);
    3240         wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
    3241         clear_bit(FCCTRL_TERMIO, &ctrl->flags);
    3242         spin_unlock_irq(&ctrl->lock);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This will enable IRQs

    3243 
    3244         nvme_fc_term_aen_ops(ctrl);
    3245 
    3246         /*
    3247          * send a Disconnect(association) LS to fc-nvme target
    3248          * Note: could have been sent at top of process, but
    3249          * cleaner on link traffic if after the aborts complete.
    3250          * Note: if association doesn't exist, association_id will be 0
    3251          */
    3252         if (ctrl->association_id)
    3253                 nvme_fc_xmt_disconnect_assoc(ctrl);
    3254 
    3255         spin_lock_irqsave(&ctrl->lock, flags);

So the flags here doesn't work as intended.  It will just enable IRQs
at the end.

    3256         ctrl->association_id = 0;
    3257         disls = ctrl->rcv_disconn;
    3258         ctrl->rcv_disconn = NULL;
    3259         spin_unlock_irqrestore(&ctrl->lock, flags);
    3260         if (disls)
    3261                 /*
    3262                  * if a Disconnect Request was waiting for a response, send
    3263                  * now that all ABTS's have been issued (and are complete).
    3264                  */
    3265                 nvme_fc_xmt_ls_rsp(disls);
    3266 
    3267         if (ctrl->ctrl.tagset) {
    3268                 nvme_fc_delete_hw_io_queues(ctrl);
    3269                 nvme_fc_free_io_queues(ctrl);
    3270         }
    3271 
    3272         __nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
    3273         nvme_fc_free_queue(&ctrl->queues[0]);
    3274 
    3275         /* re-enable the admin_q so anything new can fast fail */
    3276         nvme_unquiesce_admin_queue(&ctrl->ctrl);
    3277 
    3278         /* resume the io queues so that things will fast fail */
    3279         nvme_unquiesce_io_queues(&ctrl->ctrl);
    3280 
    3281         nvme_fc_ctlr_inactive_on_rport(ctrl);
    3282 }

regards,
dan carpenter

