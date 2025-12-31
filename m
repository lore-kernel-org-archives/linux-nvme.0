Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD00EE6441
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 21:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=muTPllHB/pE0CEfICYtNHH+FjA3I5MdilveUBt/VzE4=; b=TN1QYK9C1KcrBKj57uCQUN63cF
	RgnIPwx14BIXFxiOLzJR0R+82sWMeyRiyAZXwH6QvVpETXrnuUgvHaEMFJTOz8OPtFSNo+8IKfW4N
	IJeEBUXTdYKqrXeygO/FUnvTtScYxkcAmTN+aSyXurtUwmEzKKm5WrBZGMDSV5ISMS0C+KZFDG0it
	e6LUIAYvXYmbI21B6+5sPAA3xYRbYaRhVurYr4WaaIKzyd1O9LQBaOaqEjcDhibf5FzcK3RbYcKSt
	2NoGrSq0zBLqrRLvgXMY5sFj/L1cD4403ktzdEsO4OyPvOUDAcBbOliMe60rR/8K0ta2SMDiL/47Y
	s8xMUBVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb3qw-00000006MJm-3BLV;
	Wed, 31 Dec 2025 21:35:34 +0000
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb3qu-00000006MJM-1Obm
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 21:35:33 +0000
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-2ae24015dc0so10593612eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 13:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767216931; x=1767821731; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=muTPllHB/pE0CEfICYtNHH+FjA3I5MdilveUBt/VzE4=;
        b=NcOYDh3+UY4mbabCKHMsAqUitFQGj8girNGo0vgk75fYeabVsQotMERd6WYNY6Q/Yd
         VQXoaWkcdFvxf1mcM1hFmFAJ3SEaVwWj2HhqIrrtMdyM7McI3lcNo986WSDEvRI+hAq0
         n+tuHmCR3MrGoEVn6IL79ZRizBO3+/esOlBG4+uo9ouo8ghmTWwLquzaBGXZDDh0gfMi
         /tTT1/FTBTJVrkOY1JO7oYa9sNF5EJV1kQj0GDN3v4TSK579rRetKyVx82rwuXFv5DtX
         15jFYELx1FG9Dlg/waESJNpE7V5KSCaO7OxISl4I/YlcAB7P681JRw6UsBUZrziPUPzK
         5ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767216931; x=1767821731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muTPllHB/pE0CEfICYtNHH+FjA3I5MdilveUBt/VzE4=;
        b=hdRS9wJ/PPScNjaPXLMvVy+cWMH9aP82JHy81wlHQOPE+Cfgx281P4EZQdG3gf9cOZ
         /hExqIc5mA/2WB69204tUtf0lJ0UzYzzzPUxDKGblv+FTtKzNQiWJFSonh8QDi77a0eI
         n+hc9E90APePHnZ1KmYLs4lYyxMSyJPPnMzCPR7cn3bCXOvB9YzQwguzAEAMm2LrTTXu
         8pnka8YKG/CQtmHTYUY8nFXkoFPphvZko6gRMaFsOtAxNpAcFSiTo/NQOIBLWKBkzlFh
         uu/x9Pgz6AIXm8D5LF8zxXUgt3gR+4zlS4mgxr6rwkNhpxBYawymG8wCvR4acIKPVzwS
         UlGA==
X-Forwarded-Encrypted: i=1; AJvYcCUJfD78wr2tUvv0n8QnHNink+DbwcF2COC0GVDdZJBS5WasNGF5KXNUyrwdPG5PrguChLb4umHdXY92@lists.infradead.org
X-Gm-Message-State: AOJu0Yxhn5iq/EegmJSCoJuHInVDKXoeA/PsrbFyuQNHw/mrQLEiC/ja
	sd4Gr5cRZxH+PeX5FIcB2JqV1hOfFB0hQaHGVc/kvSYSp0DZykydWqq4PhVc+KfswWA=
X-Gm-Gg: AY/fxX4S/OgLwiayhOPkq/Es7Ss0Mz+f6M+3j5173b9/1bAMVqK0rrCbpvUBGckuFKU
	mkYz5GbKKYQrh78+3o5Shnuk+1sZwhanF0V+rK2BYvlPgHM58fB2UegYajg/BqOIhUaaOthb+yA
	eZniuSICMAPXC5Jlkg/HQ+tLVGfrDEbaxaeYnSvAxy+4qg1czDgl4Tgoxr+Q2r4LWAhlatgl00x
	BHN0jd1etpmPMtboS0uNkL66vfWlWkFUDs7w7SakM7SPbxiUYOQZRWWOz6Z3Hx0VGsVFZdREpBA
	M2kdPHLE9WgmmIkTv8ldAjb1tRH5YlshQBrS9sAuTRAgUoUK3u3+PRWElDbxEFbwYBbdQKkLfOO
	825QKXsh7AWEIhfwuwdHo4x6zhBb3G2MZMQ6a9r9dwzIAJnemv4i0oayoXeTGXXGT8dGcBNZ3rZ
	EqOdfBHfiH911dOc7I3laivMHlp0lhz7r4R5KZcppf1Q==
X-Google-Smtp-Source: AGHT+IGj7vZ+K+Rs8yNMRoW77jO06fTGqONtOHZF/JCfCYHUE5UPNAt/EP69WsAU1R1/uh5ghk6oVg==
X-Received: by 2002:a05:693c:838b:20b0:2b0:487c:7aba with SMTP id 5a478bee46e88-2b04cc11b2dmr31173737eec.21.1767216931046;
        Wed, 31 Dec 2025 13:35:31 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2b05fcfc1b7sm83805653eec.0.2025.12.31.13.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 13:35:30 -0800 (PST)
Date: Wed, 31 Dec 2025 13:35:29 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/14] nvmet: Implement CCR nvme command
Message-ID: <20251231213529.GJ3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-4-mkhalfella@purestorage.com>
 <3f2c8a9e-2e1c-4cb8-b296-8f61ab16b03a@grimberg.me>
 <20251225173342.GB8129-mkhalfella@purestorage.com>
 <eeab9242-6968-4d44-b765-d4876b353b62@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeab9242-6968-4d44-b765-d4876b353b62@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_133532_401106_2909F102 
X-CRM114-Status: GOOD (  21.11  )
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

On Sat 2025-12-27 11:39:55 +0200, Sagi Grimberg wrote:
> 
> >>> +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
> >>> +{
> >>> +	struct nvmet_ctrl *ictrl, *ctrl = req->sq->ctrl;
> >>> +	struct nvme_command *cmd = req->cmd;
> >>> +	struct nvmet_ccr *ccr, *new_ccr;
> >>> +	int ccr_active, ccr_total;
> >>> +	u16 cntlid, status = 0;
> >>> +
> >>> +	cntlid = le16_to_cpu(cmd->ccr.icid);
> >>> +	if (ctrl->cntlid == cntlid) {
> >>> +		req->error_loc =
> >>> +			offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
> >>> +		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> >>> +		goto out;
> >>> +	}
> >>> +
> >>> +	ictrl = nvmet_ctrl_find_get_ccr(ctrl->subsys, ctrl->hostnqn,
> >> What does the 'i' stand for?
> > 'i' stands for impacted controller. Also, if you see sctrl the 's'
> > stands for source controller. These terms are from TP8028.
> 
> Can you perhaps add a comment on this?

Okay, will do that.

> 
> >>> +	new_ccr->ciu = cmd->ccr.ciu;
> >>> +	new_ccr->icid = cntlid;
> >>> +	new_ccr->ctrl = ictrl;
> >>> +	list_add_tail(&new_ccr->entry, &ctrl->ccrs);
> >>> +	mutex_unlock(&ctrl->lock);
> >>> +
> >>> +	nvmet_ctrl_fatal_error(ictrl);
> >> Don't you need to wait for it to complete?
> >> e.g. flush_work(&ictrl->fatal_err_work);
> >>
> >> Or is that done async? will need to look downstream...
> > No, we do not need to wait for ictrl->fatal_err_work to complete. An AEN
> > will be sent when ictrl exits. It is okay if AEN is sent before CCR
> > request is completed. The initiator should expect this behavior and deal
> > with it.
> 
> Yes, saw that in a later patch (didn't get to do a full review yet)

