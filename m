Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F38606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eFxfVDhw;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=HE6Qrs4W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xV4hGNRv/ke1OuTNrqmu+aBd7MFTgTP4hspbNlDMV+A=; b=eFxfVDhw5nZmav8ycVx5bmbdmz
	JgSJ4o5243TfUGjPm/I+xmuZqnc7VgcgskHx44yOuOxQ9hgQacEbyWl/YzsDFHOsQSEqDDL4ed0Lr
	KarKuQRBWSp7r5u+nO+vN0r6Yk7BMXpTMlBneN+irZJeO7NWbBXcvWNSNR7wKiUNfmGIpSMTJu1rB
	aQ0qp9gRLae9/4hOTR9aW/oZqILKRTKFVKUJGajEE4RlA9uMfqC9Hip2kgIVuk2pmHfnq2DYRmALh
	l000O/W153hbTCiQsJ1sVIvYTiGx8BD1W4ceiTumXxQuHJoWOl7OMI6g4K77uLQXv0qrtoggmiLpf
	V0+sae9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6WW-00000004DbX-0BW1;
	Mon, 16 Nov 2026 23:54:08 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6WT-00000004DbA-3T7k
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 23:54:07 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-36f8cdd30beso6655057eec.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 15:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794873245; x=1795478045; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xV4hGNRv/ke1OuTNrqmu+aBd7MFTgTP4hspbNlDMV+A=;
        b=HE6Qrs4Wj1Auugg8QX4DMH/76Sc7G/12KEID1iT9aCXtKBLTKsEGADV24YaDwjlq73
         2nPWhnXdR0GgTWqf2jsv4ufrGpdTbLRB3rqyifGvHrX95tT/bU15qj6oC5UeTWXiGUZK
         QFjEMZXvYsdbXwAdTI5T1zf8CK/9RzU48UR7FqB8GA4PvqOvbLtiSGQK6en3/FLkdSHM
         pE95jMtcxau3ierxYRzxQ2R+EHtFgISvbb7nULio9j8T1mR0EhZnEB3ytr0SQKBwFEPV
         cNHnbemfK1qKztyheO9HUml3CYIooh9AFGNZ7qb5mtXc+awwRR+5HQbc0ZQhhWxFTIUc
         7pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794873245; x=1795478045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xV4hGNRv/ke1OuTNrqmu+aBd7MFTgTP4hspbNlDMV+A=;
        b=VJ108yUrUFSp8YbePlDRJaQrMuNCieVktkiEdwEJyUHBGRzq6ATVzjNjW/7fDbZnef
         DuOiG/5Mn+fFAQ+ENPQnuh5nZyIn4jUso/eLmNLvqVXRF41aJjedn3n1CrrwqPYvTnly
         27es4GiP2Y/kytbYNrlTrYMsSAdA/Bx347tAlr1VqSIXmDrgsaqqRRFEEGm5NRQ4igTu
         jj9aRAiWvlQTfWOeJzJuMsooHMc9Vdbl6WIkrLqZy1ijnGOcuxLT/V3I7xv20Js/4WFu
         YhCV2oe3Lns58kd099zaKdf8aYFQM9fo2b5D5p3+0hf8BUmAwqSbpb6osOzONPR9tAnL
         j5Dg==
X-Gm-Message-State: APuU4Z8voMHHPWyhb18eJCWjtT3nIXZWMMEqHXxVMhCbF09H/N88tUtM
	2Vq7qEpZOAzTjNWBh+4B71lRl/B8H6UCUBvbgXk3LHw+siZIqfCUPbdxVuW17qlJ++hqXsbzXFk
	clpAa
X-Gm-Gg: AZFdTZcTfyKTWGrrYih3gTyR4Pg23uBYEpo1ueYy5sex/X1kBIy/sOBW/8aYhDWbqnf
	tDQjujN0cu994jQX9P+YW8yT7Igc09wkYfzc6X312ZpddW4c49l2Sqc/+J8rThfwnRY2Yz07GvD
	37XkUPdA5GzKCWm/rGFxJ6/fEbrJAAUpEbEN6MA/z4iixdvqzQCsgIBiH603EUBo7TqnrLaJ4rJ
	yG9X8yPQFhk1IsfAyG9fgCEoMc1irYDhp6/XU0aB5Xu8Gn3X6Aviq/SzpdSa5L4qZ2qI1luvqjI
	Fsyo7D6tcerTjicM69D+9xGFDBjHnQUZ8cH8Z6dcU9NAJNSrBBSjVpT2QwRmi/RXgPKh8zLUGiz
	HsUXO4UZKNl91X3xKVwtq9UBf7rQRVMv/Ie4KJe96SbfQJCwy6Ika9E9P+nFIw+FBMbuGIsEouc
	A3dJz5y8aRC9Gs/QgkyD50eAbr/InWuaEDRd0lpDUc36mFVIuDDzzdMq6EqSNeUbNbsn4mC+8JR
	KiCfxsovzcT5gJSiq04JMUj1swwfAqK0JezBLoVXdDibnoY2kQlhPVPdsco0UiViAN20sMpO57C
	P6SbgAee3zIyUvyGLDvdUDfpKOkII9S1+nkB/WMB17Dvkp0zV+U=
X-Received: by 2002:a05:7300:540f:b0:380:c3d7:c263 with SMTP id 5a478bee46e88-380c3d7c590mr2343761eec.5.1794873244352;
        Mon, 16 Nov 2026 15:54:04 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-37956bad134sm46028299eec.27.2026.11.16.15.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:54:03 -0800 (PST)
Date: Mon, 16 Nov 2026 15:54:02 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 03/17] nvmet: Implement CCR nvme command
Message-ID: <20261116235402.GC1670230-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-4-mkhalfella@purestorage.com>
 <sashiko-outbox-214113@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-214113@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_155405_894218_298A6151 
X-CRM114-Status: GOOD (  25.31  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat 2026-11-14 03:30:43 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] nvmet: TOCTOU race between nvmet_ctrl_find_get_ccr() and
>   nvmet_start_ctrl()
> --
> 
> commit 8afa887480a9e0f0751311107895be0ad6ed159f
> Author: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> nvmet: Implement CCR nvme command
> 
> This commit implements the Cross-Controller Reset admin command for the
> NVMe target, allowing a source controller to look up and trigger a fatal
> error on an impacted controller matching the specified controller ID, ciu,
> and cirn.
> 
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index 5710ae53eb83a..3df9db454db9c 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> [ ... ]
> > @@ -1629,6 +1630,78 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
> >  	nvmet_req_complete(req, status);
> >  }
> >  
> > +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
> > +{
> [ ... ]
> > +	/* Find and get impacted controller */
> > +	ictrl = nvmet_ctrl_find_get_ccr(sctrl->subsys, sctrl->hostnqn,
> > +					cmd->ccr.ciu, cntlid,
> > +					le64_to_cpu(cmd->ccr.cirn));
> [ ... ]
> > +out_unlock:
> > +	mutex_unlock(&sctrl->lock);
> > +	if (status == NVME_SC_SUCCESS)
> > +		nvmet_ctrl_fatal_error(ictrl);
> > +	nvmet_ctrl_put(ictrl);
> > +out:
> > +	nvmet_req_complete(req, status);
> > +}
> [ ... ]
> > diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> > index 9c9ad4d9b292d..86018e0fb1586 100644
> > --- a/drivers/nvme/target/core.c
> > +++ b/drivers/nvme/target/core.c
> [ ... ]
> > @@ -1432,6 +1446,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
> >  	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
> >  		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
> >  		ctrl->cirn = get_random_u64() ? : 1;
> > +		nvmet_ctrl_cleanup_ccrs(ctrl, false);
> >  	}
> >  	ctrl->csts = NVME_CSTS_RDY;
> >  
> > @@ -1537,6 +1552,42 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
> >  	return ctrl;
> >  }
> >  
> > +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> > +					   const char *hostnqn, u8 ciu,
> > +					   u16 cntlid, u64 cirn)
> > +{
> > +	struct nvmet_ctrl *ctrl, *ictrl = NULL;
> > +	bool found = false;
> > +
> > +	mutex_lock(&subsys->lock);
> > +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > +		if (ctrl->cntlid != cntlid)
> > +			continue;
> > +		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
> > +			continue;
> > +
> > +		/*
> > +		 * Enabling the controller regenerates ciu and cirn under
> > +		 * ctrl->lock. Hold the lock so that a controller becoming
> > +		 * ready concurrently is matched against either the old or
> > +		 * the new instance, never a mix of both.
> > +		 */
> > +		mutex_lock(&ctrl->lock);
> > +		if (ctrl->ciu == ciu && ctrl->cirn == cirn)
> > +			found = true;
> > +		mutex_unlock(&ctrl->lock);
> 
> [Severity: Medium]
> Can nvmet_execute_cross_ctrl_reset() race with nvmet_start_ctrl() and
> trigger a fatal error on a newly enabled controller instance?
> 
> nvmet_ctrl_find_get_ccr() drops ctrl->lock right after matching ctrl->ciu
> and ctrl->cirn.  Before nvmet_execute_cross_ctrl_reset() calls
> nvmet_ctrl_fatal_error(ictrl), a concurrent nvmet_update_cc() can enable
> ictrl and advance ictrl->ciu and ictrl->cirn:
> 
> CPU0                              CPU1
> nvmet_execute_cross_ctrl_reset()
>   nvmet_ctrl_find_get_ccr()
>     mutex_lock(&ictrl->lock)
>     /* matches ciu and cirn */
>     mutex_unlock(&ictrl->lock)
>                                   nvmet_update_cc()
>                                     mutex_lock(&ictrl->lock)
>                                     nvmet_start_ctrl()
>                                       ictrl->ciu = ...;
>                                       ictrl->cirn = ...;
>                                     mutex_unlock(&ictrl->lock)
>   nvmet_ctrl_fatal_error(ictrl)   <-- kills the new instance
> 

If ictrl matches cntlid, ciu, and cirn then it is our controller we want
to reset. There is nothing wrong here. Even if ictrl changes its ciu,
cirn it is still the controller we want to reset.

> If the interleaving goes the other way and nvmet_ctrl_fatal_error(ictrl)
> runs just before nvmet_start_ctrl(), nvmet_start_ctrl() overwrites
> ictrl->csts with the ready state, clearing the fatal status bit while
> ictrl->fatal_err_work is already queued.

That should not be a big issue. The controller is being deleted anyway.

> 
> In addition, when a controller is re-enabled in-place via
> nvmet_start_ctrl() rather than freed in nvmet_ctrl_free(),
> nvmet_start_ctrl() only cleans up entries on ctrl->ccr_list where ctrl was
> the source controller, leaving pending entries on other controllers where
> ctrl was the impacted controller active with a non-null ccr->ctrl pointer.

This is intentional. NVM-Express Base Specification Revision v2.4
section 5.2.13.3.1 Cross-Controller Reset (Log Page Identifier 1Eh)
states that completed CCR operations (ccr->ctrl == NULL) should be
cleared from CCR logpage when a controller is reset. Pending entries do
survive controller reset.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261114030454.2836543-1-mkhalfella@purestorage.com?part=3

