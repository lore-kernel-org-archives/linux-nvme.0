Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB57E8B383
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 00:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aWLC7k0F8kY0CegokUrTiTZDQON6PfMasA1hSC23Xkg=; b=vQy7r13NWAhHogzQC5D+EyUUlv
	8tsLe6g18k8ONYpl6D0dBl1Eeg9kGTaOdI/EA9KXdQZsWUkr/QH7JQNnFtTO2yfXYrRF1bVByC/dM
	8YzBN0k5Kv+7PtW9B+r00PFSaIvoqHqFOj0QDniVbDRMR19HdpwIgOEUL1wqgNQ6KCPCbi9AIcRGQ
	u5tdax7xpg5faU5neBWi6cnoJz+sBVImDhoWLqLhpoDbTBlYpWee6sSdErvC7NF+LBWPbsUC9B+Z5
	4UfdYZOrXRqYz38V2PF7HOi+ARbopFxNot24hB7+gZ5zyGwMU61W/ALwY28Pec7iTQI136FWf6XKW
	kazDSYNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQYs-00000007cV7-0BMy;
	Wed, 04 Feb 2026 00:16:02 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQYl-00000007cUh-1QzB
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 00:15:56 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-124899ee9d3so328675c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 16:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770164154; x=1770768954; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aWLC7k0F8kY0CegokUrTiTZDQON6PfMasA1hSC23Xkg=;
        b=LKF8F8Fo4DLMdGvsVWmbzIDeEa0o2MgWIO8fEI7Ix+z76fktZUSKorib2JhpptTxWF
         wzYTyu5gWPc9zimE6aSZUk0T7Avqmynsk+EdEDOrnXEjAn6nUdeewB9GLntHQh6z/j6x
         Uy5MJe4AIBUZFKke6Fe3YDHOV4vLAhsIGZNHSFR0Jt2TzHtLx2XYJTaGP4RUWgqIJjWI
         k7rn3aNPlplhK5Uq1WPkF8IXKbs+ZfZwTyWMMHQ7UvwaoORBghO7ybgQ2peCJphjbsPq
         fafasqrHBwPO0h4io38wI2EcFp3xS2p2Vz6SpioY14GlDzHHud20UjoeAEdXWMg/TqYC
         muTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770164154; x=1770768954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWLC7k0F8kY0CegokUrTiTZDQON6PfMasA1hSC23Xkg=;
        b=cCae/Rj+HLb+PHWWvG6ibBh2tTXuPCWTsSrQhU9OuCoU01pPdxA5c7M1nv1r9+8lkO
         a22XybOE8UN2InhFndf3XP8E+QmK4KJtL4rRaEw8yCU6rdGgh1s6JamfwhaemMJbyU/1
         AiKVWntJj0W52CybIEWzLNwAoG8Kb2SD4XNGckZAJD2218AE9EhMZqZ5wyXDi0LtxjEp
         dVRyUOH30JemlrmmoSlAdjfgghQL0IDSwNTJtY+e0fFB+L4dNYE5tSTIFY5nTxorlZUq
         rU/OVl211HFwzgG4Z0kg8CVMtUwpNgZXCyLph5438/NsV08o2XQmeYyyD7x5CdTygowd
         TtOA==
X-Forwarded-Encrypted: i=1; AJvYcCWNz3wq6tFRJrlUaRf3+7ugQNlLpNRuTHTZxaZwKj7F8Z5NXtjPYgppNsrEsJbQALEmo09vBZ0m2m2z@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2vgCZuRxOzSmzfb+hIp0GGiWYZJMBwStQl3Reu0NVXjlSs3zK
	sCFXel/lw9Y0nloyySPjyHeOsDBuvUXZUTerHlgPqi+fwZo5rPIlTWIjHVqDkZDFb00=
X-Gm-Gg: AZuq6aLGaU9OI64A1rnwwfQUlSRHgVMkFWj/Iisd5W89csGVpTf0b2fW2xXyHTFnAAi
	WZRMv1UwilttU+AK2GkRHoDbGpcC/A3jvLGu+e0g3tQiQNBjuypikVGZuh0RxFPIFcyCDLagbZT
	VQN+W0iPYsHZNh2paPsdTxCpN+am6DSMCEBOEMIdpbaKCmjqV7OH3YskTG3GcD9uuGL9eCQGZ73
	7he8ndi7L3cOCrHAtrijUGdkyHbsu/S+35/bEFMGdvHbjGN3RSrkkHYODVg6yqaV/VnAR5VMfg+
	JUxtBq+Gi5X0PibKunpxKm6Si4I+LrE70n4+dp6LO9XubICZWZCVkfYtGI2sN3cHV2ifUxcLk2m
	coHUxVlxvXSAKgF74v5q9aUY+Ec740tREZb59l4L2ISvR1FNYtTwfaImARNlp8/m9yQNgPqqJka
	sUbVuEuK6Wz8ziDxaN2zmfBwquX0w1IF0=
X-Received: by 2002:a05:7022:620:b0:11b:9386:a383 with SMTP id a92af1059eb24-126f48e64d5mr538384c88.22.1770164154059;
        Tue, 03 Feb 2026 16:15:54 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-126f4e042bfsm780514c88.4.2026.02.03.16.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 16:15:53 -0800 (PST)
Date: Tue, 3 Feb 2026 16:15:52 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: James Smart <jsmart833426@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] nvme-fc: Decouple error recovery from
 controller reset
Message-ID: <20260204001552.GJ3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-13-mkhalfella@purestorage.com>
 <383bbbe9-6cf5-465c-8811-0dddce34f883@gmail.com>
 <df3246bc-a5e7-4835-8d75-ca468b6bcd27@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df3246bc-a5e7-4835-8d75-ca468b6bcd27@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_161555_428380_E53EECA0 
X-CRM114-Status: GOOD (  24.47  )
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

On Tue 2026-02-03 14:49:01 -0800, James Smart wrote:
> On 2/3/2026 11:19 AM, James Smart wrote:
> > On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
> ...
> >>   static void
> >>   nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
> >>   {
> >> @@ -2049,9 +2061,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
> >>           nvme_fc_complete_rq(rq);
> >>   check_error:
> >> -    if (terminate_assoc &&
> >> -        nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
> >> -        queue_work(nvme_reset_wq, &ctrl->ioerr_work);
> >> +    if (terminate_assoc)
> >> +        nvme_fc_start_ioerr_recovery(ctrl, "io error");
> > 
> > this is ok. the ioerr_recovery will bounce the RESETTING state if it's 
> > already in the state. So this is a little cleaner.a
> 
> What is problematic here is - if the start_ioerr path includes the 
> CONNECTING logic that terminates i/o's, it's running in the LLDD's 
> context that called this iodone routine. Not good. In existing code, the 
> LLDD context was swapped to the work queue where error_recovery was called.

nvme_fc_start_ioerr_recovery() does not do the work in LLDD context. It
queues ctrl->ioerr_work. This is similar to existing code. I responed to
the issue with CONNECING state in another email.

> 
> > 
> >>   }
> >>   static int
> >> @@ -2495,39 +2506,6 @@ __nvme_fc_abort_outstanding_ios(struct 
> >> nvme_fc_ctrl *ctrl, bool start_queues)
> >>           nvme_unquiesce_admin_queue(&ctrl->ctrl);
> >>   }
> >> -static void
> >> -nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> >> -{
> >> -    enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
> >> -
> >> -    /*
> >> -     * if an error (io timeout, etc) while (re)connecting, the remote
> >> -     * port requested terminating of the association (disconnect_ls)
> >> -     * or an error (timeout or abort) occurred on an io while creating
> >> -     * the controller.  Abort any ios on the association and let the
> >> -     * create_association error path resolve things.
> >> -     */
> >> -    if (state == NVME_CTRL_CONNECTING) {
> >> -        __nvme_fc_abort_outstanding_ios(ctrl, true);
> >> -        dev_warn(ctrl->ctrl.device,
> >> -            "NVME-FC{%d}: transport error during (re)connect\n",
> >> -            ctrl->cnum);
> >> -        return;
> >> -    }
> > 
> > This logic needs to be preserved. Its no longer part of 
> > nvme_fc_start_ioerr_recovery(). Failures during CONNECTING should not be 
> > "fenced". They should fail immediately.
> 
> this logic, if left in start_ioerr_recovery

I think it should be okay to rely on error recovery to handle this
situation.

> 
> 
> -- james

