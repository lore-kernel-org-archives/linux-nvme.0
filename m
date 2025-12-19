Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD1DD711D5
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Dec 2025 02:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z3TECe0SBwj1XaJbGYaOS05lmYl8mf6axe8WfauAgqk=; b=BFTuSz1UbA3Tm5K2uqGmDK1mEz
	03AVV5Z/v/7exAwPOBvJiEQAWKYbpYKgdx2LQYssBcbnKOOjbYhtNcKojvNb75nK8gs3qrn+QP3p4
	SoaP3lMJG1jpmWdQTqEqcJ2OQKeJjirm+iiDIFJS1kht/R1Vva2vsSNjCfOD9yhftn/RmeLiyveeF
	E6wGyzr3HeG+mYkCg4PtogQCLOGcJTDwIVR03ac+/ejNlv3Aw/UlH1644m9d/LBzokpMgqoxixP0t
	4JFpYDTwLHWKgpLXtxjKgsjQtPIfNPStvLUTNLfTBUGg4v9TbCA5Upp7ABmK2ttrQLb+aJZyeugH6
	swlnLUBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQiF-00000009WIv-3zPl;
	Fri, 19 Dec 2025 02:59:27 +0000
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQiC-00000009WIX-2773
	for linux-nvme@lists.infradead.org;
	Fri, 19 Dec 2025 02:59:26 +0000
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-5dfaceec8deso795432137.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 Dec 2025 18:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766113163; x=1766717963; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3TECe0SBwj1XaJbGYaOS05lmYl8mf6axe8WfauAgqk=;
        b=cjcWa43MSpw2AqbGh5bI4YFBgQbIkVkNUtSVTaGSxBsrkU+dEiG96XixArzHxNGv1u
         6/NSqIcX7aJNPV/QmROk4Bel6xctqbo5tQlC11gRdD6XN6DxcG7rhsUBSRIWlLHD+qCg
         qUFcH28N1WqnLz9cf1VVnk/cxwSDFwvx0YurSgndjFLqyvCDIkSSucC2GQrEkh1zaD0c
         +I5LGC3R6h5uABBtHrFoJgc1fC+vM7xz6UQdcCJPXY5afk8i1fxGpssLQ/KUWyodeNF0
         Rudg5uxUOWriqa8JsRYeSAke69umV3d22uyrCtpxVFCCOAB+NEcZslZA1DZfBU6+SEk9
         rC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766113163; x=1766717963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z3TECe0SBwj1XaJbGYaOS05lmYl8mf6axe8WfauAgqk=;
        b=j7Bop9+0RPm2V1NG7C2G4SQVDGr2X6XtaXtwlem6Iq++Yd1y93DJeKj10nLMtWEJX6
         PSmIS0+FlhDei7fUEAol+Be4pWDABX5GSqVPUBvAC6Fu1bW3OJ8xHm+7mHsWBqrU7KAg
         kgKJVtENFOs2+x5X/ZcxAvicH1pn05t2LTzqpgXLItfbFMD6dO/GHYHHzyR25jUTLu10
         HxnTPbVyIqtCY9kRZCjdwOeQHFoUQNUh1WH8GahgBxo5T1z/5EGFqTITCmU1cmLPcKW/
         GicoDOqF+SuDhRxgge15X63pityS/sutpqA6GD/zsg0w/4lk+ODuhMDjW24Z+XjZGfC+
         OkkA==
X-Forwarded-Encrypted: i=1; AJvYcCVCY3rsvgGz3bk+8r+FTQCUOo7BO9o+4fqe2NutxQ/KJ8wzX1hG+aOrMqPESTskLU1KkwEBKIoykkrp@lists.infradead.org
X-Gm-Message-State: AOJu0YysYm9MRJNfPlf1bX/KqamJxpCeAW9OflzEYLheUmaI9nKe5AH2
	XqAZ67ZjGvGALUUwjJ2pBCDzps05oewDxHxUzvYGgJT4VgNKhHeDxswvNr8RaaOUfexBnIxP9pR
	UMIGf8+SXXwdoAIkpqYFs0T8NdCsm+ZXejqVizjfQ+Q==
X-Gm-Gg: AY/fxX5x5bGLATB3bRa+v6MgFifMuf36wl70j82JKA5lBFfje7oS9N4y1m8dYu+O6aB
	XTEoKhxy79H1pqres3/qnyaZcjM0OcBuKuZmW4emdVz+QuPjDg7NxpwGhXDcYExwThstbuSqwRH
	NKt8cE+jzt9WrZPpjYm11e8BM6VT1gvxqjo5cTiRxV8DwlRjWHdKxMGwaEQ9FgK/BUOIh0SaYVY
	YwtIJuMG7Fghl3nfMBuBeMRzkplWJdDNfqFCfop+Sfu8ias4Y01vbnXNLA6SufDNZrRp8Al
X-Google-Smtp-Source: AGHT+IHHxE/nNt3qZfZsE49JXCZAnqrVwp2jqtpdcCis+TWwHz5rVILjC9qbGx+2UB8rUhZ9afstQ8OO5ePRs2khaTQ=
X-Received: by 2002:a05:6102:3710:b0:5db:3c3b:7767 with SMTP id
 ada2fe7eead31-5eb187045a8mr605141137.16.1766113163051; Thu, 18 Dec 2025
 18:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-13-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-13-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 18 Dec 2025 18:59:09 -0800
X-Gm-Features: AQt7F2qmCjCywovby4jc2khbEC8OM1yNeiN5GE72MDs1O96UiLrRy_LoPInHlzI
Message-ID: <CAPpK+O1G6_xxp1b01Px0=YBc5qWb539MtiMfGsH6BdyMTQuxSg@mail.gmail.com>
Subject: Re: [RFC PATCH 12/14] nvme-fc: Decouple error recovery from
 controller reset
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_185924_643544_3B90E81B 
X-CRM114-Status: GOOD (  12.01  )
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c

> +static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
> +                                        char *errmsg);
>
>  /* *********************** FC-NVME Port Management *********************=
*** */


> @@ -983,7 +985,7 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlis=
t *sg, int nents,
>  static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
>  static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
>
> -static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errm=
sg);
> +static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
does it make sense for nvme_fc_error_recovery() to move to be with
nvme_fc_start_ioerr_recovery()?

> @@ -2497,39 +2508,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctr=
l *ctrl, bool start_queues)
>                 nvme_unquiesce_admin_queue(&ctrl->ctrl);
>  }
>
> -static void
> -nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)

> @@ -3347,6 +3315,26 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>         }
>  }
>
> +static void
> +nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
I'm curious about the motivation for moving the function.


> +{
> +       nvme_stop_keep_alive(&ctrl->ctrl);
This is a new addition.  I think it is a good one; FC can use
keep alives, and nvme_stop_keep_alive() is called in one
other place, but I do not think the Linux nvme-fc driver
uses keep alives.

Reviewed-by: Randy Jennings <randyj@purestorage.com>

