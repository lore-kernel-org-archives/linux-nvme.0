Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A2606A32C
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2026 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=abIF2ftL;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=gmwmbTHS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SvJ49BQDsT4BUOiui0pHG00KCPFsMBlGlawc8+RP7J4=; b=abIF2ftLcje5ZFaf74b4G9gRl/
	4c9Ntw1DJy27y2lIhU41ZsSBKpsaWYNKg4Mf0OKsQBtMxKxN5P+AkdaQiH2GzJmIyQrawiQteDhYr
	loNxSaqfNqlILrB+pw4mDZbTcP9K79XxL+0g3OQrVGAhWNfHdgOP0L0RGVgtSv8ApoF7tVnxodrtL
	SnCGNRswgoGtCU6FSX4EyjtbRcMuY6dXED4vHbe5b4BC6D1sMfs2uxavv8gJEZ/EBska1Gxg/jaXx
	WMTwp3DcbJxCbJAI8XTA483r4QfgCpy/PhN2+TLwQG+7cQUsK7p6UZQrk3qEk+bY2KhoVfDRi/5Zw
	iS4iDZtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6g0-00000004EJA-09q6;
	Tue, 17 Nov 2026 00:03:56 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6fx-00000004EIU-3y1v
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 00:03:55 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-33fb4680717so10494710eec.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 16:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794873833; x=1795478633; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SvJ49BQDsT4BUOiui0pHG00KCPFsMBlGlawc8+RP7J4=;
        b=gmwmbTHSy0njIl3D+cqpDQDX3nXB0Jr8pJO13At4y2OzU/ZX9McwKo4g7939Y7FJXw
         8YuzwtnHThy4Mj5ZjFUHfw1wSN5Asaltsq4iqVw94nUwjsDqfnUsk/tQRSdyKXpuqkqb
         b775QIYeV6/qJvYTzR9donckyfiDzPROi0SrrXpOMaiu4yarHSuYn6QzOjr2OUB3VlhW
         ROeXaEqLGmGtvYNdDjOwsXOLgpVNdZoDfUg0i9DXGN9hRAxsNMYXeDbN7OVrbdjZ6mBC
         Cdn7ozUbnDqctm7hNgFgWSHRjEc/oGpZGKyurTneo6bjirSq5HJlREDD0ewrpRwzCioJ
         HicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794873833; x=1795478633;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SvJ49BQDsT4BUOiui0pHG00KCPFsMBlGlawc8+RP7J4=;
        b=Z4Cgw6KbHcMAE48Rm2tTOufF0+6GouKQnzhMlsCTjDOd2CwDq3iSbkrjgtrQ8Z66Hp
         UjXOWwHnB8l6awXliX4jNKtfIp7xnhhg7wfQt7xqGaU22pv+V1so3kOCr+keWrUt2JW2
         ws7YNVHhgjutqsPPMB3a2IbORMknkrNLHtb85V5/9o8JHSywxtxlCndcNMJSQADhe1s/
         mucGo9/20xMMdyDQMqcqw4ce41zebw42iD27jZ3nFrwXCpglrPFM0ddq4GV9s/2sxSby
         MYEvLehR9y4bYgUWbXITnfFefMLERy343EDfOZPciukeKVELLApD3jP3y62ksC63G/wH
         0S1w==
X-Forwarded-Encrypted: i=1; AL+hErGLDa5K/QdxT/TUNExDkLSXW7MXnVjjtWbeMiejL9RDpqMbEMxw7iCWcjaFsDdhdlaAqAEKDx5/fRjL@lists.infradead.org
X-Gm-Message-State: APuU4Z+QL71aSK/yYEnubB6tbA9IA1xemBRCem466KnKM+rVwwBquBzo
	ngrBV00+R57VFFq0dZIuVj2hsIZEt0ih42h9H+LZr4nCZd43sfep0f/HGylcmmV8+VY=
X-Gm-Gg: AZFdTZfU5E+R7UhYBYo5QSfaEaeeEdupoKGtP5tenA4w3l/jcK9kv3RrFTltsCLZX1C
	g2ylLcE9BNndSWOOLocYjNFxXrcternARc6qzvZeyJtWK5ZtW+D1I3YJ7fEYFRRRaRv9NIMKE/Z
	wS+iPiVkjrGRfdhwVQy7XfAOzyLxHCzy9O+mhLZNODVWYnEvrLiurl3/gd3OsC8OZrs/T2HC2Zz
	xmlikSawNnXnjCw6mAnRZZ3T9U5ERjrgJv/s+ZDz3kTF6jwTNLehtQRMZAuc+qVIQ0mXO7mopM5
	q2PojdMB2UoOltj5CVOlUnojT7eptSTS26H1Oqwv2E7gq4zdKqNY1S3czNyW/Rhzr6aHeluwZsm
	rjQEH8nDkLgw3bMxVtwwK49m0sf3lNzqdD4/eVWoLnpEpP3PvM6GKUwqaSttFHUt5C5/s3xom9z
	+0wRZ4HcgY+R/sGoeAx3jQvtJsFia/E9LqMmc2YaU2RcBWqDXiQxV8fTvsRFgFbzf4Q+VWjipub
	dgEnQ/aJEJHdM5So6aoFqDhuV3kzqwF0Q6RoQb8F0NIReydhSEIu1+11wPq0P6RAOUXYbCXQmcI
	uStZ92USiaBfii8ZSglgh+1kc/wDtjLTvcRFNre7IjP+nWuJCA==
X-Received: by 2002:a05:693c:414c:10b0:369:9062:c392 with SMTP id 5a478bee46e88-379680cf511mr13649785eec.37.1794873832487;
        Mon, 16 Nov 2026 16:03:52 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm68688756eec.21.2026.11.16.16.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 16:03:51 -0800 (PST)
Date: Mon, 16 Nov 2026 16:03:48 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Mohamed Khalfella <linux-nvme-bounces@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v7 03/17] nvmet: Implement CCR nvme command
Message-ID: <20261117000348.GD1670230-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-4-mkhalfella@purestorage.com>
 <20261116084540.GA3655@yadro.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116084540.GA3655@yadro.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_160353_982321_CBBCE020 
X-CRM114-Status: GOOD (  25.10  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-11-16 11:45:40 +0300, Dmitry Bogdanov wrote:
> On Fri, Nov 13, 2026 at 07:04:17PM -0800, Mohamed Khalfella wrote:
> > 
> > Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> > Reset) command is an nvme command issued to source controller by
> > initiator to reset impacted controller. Implement CCR command for linux
> > nvme target.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > ---
> >  drivers/nvme/target/admin-cmd.c | 76 ++++++++++++++++++++++++++++++
> >  drivers/nvme/target/core.c      | 83 +++++++++++++++++++++++++++++++++
> >  drivers/nvme/target/nvmet.h     | 13 ++++++
> >  include/linux/nvme.h            | 23 +++++++++
> >  4 files changed, 195 insertions(+)
> > 
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index 5710ae53eb83..3df9db454db9 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -378,6 +378,7 @@ static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
> >         log->acs[nvme_admin_get_features] =
> >         log->acs[nvme_admin_async_event] =
> >         log->acs[nvme_admin_keep_alive] =
> > +       log->acs[nvme_admin_cross_ctrl_reset] =
> >                 cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
> >  }
> > 
> > @@ -1629,6 +1630,78 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
> >         nvmet_req_complete(req, status);
> >  }
> > 
> > +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
> > +{
> > +       struct nvmet_ctrl *ictrl, *sctrl = req->sq->ctrl;
> > +       struct nvme_command *cmd = req->cmd;
> > +       struct nvmet_ccr *ccr, *new_ccr;
> > +       int ccr_active, ccr_total;
> > +       u16 cntlid, status = NVME_SC_SUCCESS;
> > +
> > +       if (!nvmet_check_transfer_len(req, 0))
> > +               return;
> > +
> > +       cntlid = le16_to_cpu(cmd->ccr.icid);
> > +       if (sctrl->cntlid == cntlid) {
> > +               req->error_loc =
> > +                       offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
> > +               status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> > +               goto out;
> > +       }
> 
> cntlid has to be validated against the configured range of the controller
> ids (subsys->cntlid_min <= cntlid <= subsys->cntlid_max).
> That will allow CCR to work correctly on a distributed target.
> 

Thanks for the review. nvmet_ctrl_find_get_ccr() below will verify
ictrl->dntlid == cntlid before proceeding with the reset. Is this not
enough?

Adding this check here means if either cntlid_min or cntlid_max change
after ictrl has been created, CCR will fail saying the controller was not
found. Why do we want to CCR to fail in this case when ictrl might
actually be there?

> > +
> > +       /* Find and get impacted controller */
> > +       ictrl = nvmet_ctrl_find_get_ccr(sctrl->subsys, sctrl->hostnqn,
> > +                                       cmd->ccr.ciu, cntlid,
> > +                                       le64_to_cpu(cmd->ccr.cirn));
> > +       if (!ictrl) {
> > +               /* Immediate Reset Successful */
> > +               nvmet_set_result(req, 1);
> > +               status = NVME_SC_SUCCESS;
> > +               goto out;
> > +       }
> > +

