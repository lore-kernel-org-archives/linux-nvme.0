Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9F606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kOENTs3U;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=V/sXUTvl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CKKdw8V+R/UaH3b451GniCGJFNTIiHJBalTQve79lgI=; b=kOENTs3U6RQI1kVtEEHOlzVmW1
	Jghr2L374YW0b4odBbnUCcbIjrokidT+CavXXURgAN84QGpni7jtZBUUsoSx+U99cp2fLeYQavRen
	kSPBjcSA7cYOokujXKonPq8uNQyhGS64m2E5urD8PQpt63kUio3uDouyLIAkz80F+9muoLBZQpPle
	7C7LivtIRvpNh/lq6gYpmy3n440E+IVKo6ed7ltiOSVzfAVD0hGeV+JVltQkg96QtrzktPUGj6BcI
	pRkXlbWrHro3FUZXTrfyT3XSBfN6upbbjE8bih5ltCIeqZmZieHdtWKDOOuSfwMDTrr6/sjokHw2K
	L//lu6Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xItrB-00000008Io4-3hrb;
	Mon, 19 Oct 2026 20:21:17 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xItr8-00000008Inh-4AEb
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 20:21:16 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-48c5358fc28so2122713f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792441273; x=1793046073; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CKKdw8V+R/UaH3b451GniCGJFNTIiHJBalTQve79lgI=;
        b=V/sXUTvlWR33fm9i3YYe4S5SV7X4DKKvfuPdilkUgK5ogv9MK8MUOeclGx1dCXaBFL
         9WLdb9fIHl3ii9MqD9BAPxDz08KMY4k/6UR+MRE3U89iSRWj85LMyDuJW0LWnNTBWgm5
         8ADOYxAl9Qur9gkKKSY7AvwVMOwCo9k34euwf6wdlQ4xQIwOwKOBc10r3I4+RMMdkrgG
         DFpGpec+OsYPeO2ycyQ5DW7xixoNNFcizElG1k8v6TQlUXWgTEC5hm/Jm0QFsOdWN2Cp
         q7selQO1kDvFiCeGv4nQ0A44HhMWIko7qpHyghVn+Cav5XchJ9h9e92ugoTMoZVfjngj
         +Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441273; x=1793046073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKKdw8V+R/UaH3b451GniCGJFNTIiHJBalTQve79lgI=;
        b=fVnkuTLBKsmoSYIK+rDPPrhPkl4wpP7jwwLdHVDrokMrwbqcNkRAK6W75chiWi6fEx
         UXcnb+II7N/To5y0VQeWlSgw2vWDJZhrs8cq3Dqln+yFvNjY+xDZ61v63TIB7ULQDF35
         X2Vt2AxKmC2JJ0ibCSkfu2vL0sSmfelmkLpt/IxadlOj6BqCAmAs1+cDv705va/fb9O3
         eMtAqO8IeZ+89VDAnzpD7odDaBAk0X6Isym7uW6/3c2n36zDvP/rZSUDuMemgDZL9Wim
         Eg+AInHQo2VOrDW+ZaSP2VN873A/HHPIl3J2rrqSMmvcvnKAU/WwlsTUFNQABNuUgSrO
         9RYA==
X-Forwarded-Encrypted: i=1; AKwUvBzaCFLgqIFqYBiyo4+jHN7ykqE+yd8quo7SSuZWMNd/XU5VG5Qr1UUCqeL5+PueVNulpYs5UCkda2xv@lists.infradead.org
X-Gm-Message-State: AFq9FYIDY3bsr+uFnA6bf5tPM2y3SIB/vY2QNVLOqa4cSZDud71p+kWt
	VyvDaM1qXX+Ga9x3PGdE2sbihzeEswfGFEa/KzaBKd0S7mmiGdOOLhzXcd3Jo2hGU84=
X-Gm-Gg: AYBFou3IYSO54niorp3/6Cy9uQIlTl+sHhV9vqYwKP1EzixBNqbndSlINxUsuV0A8ao
	xiHc1VI64qBtjAZiqhA9Po21lpAClfcjgcpVgfy+zIuyMbS+kCmjl4MxVYgBMJAD3wmUeGR9Wqh
	iUlDszo1NF0jePssmKe4RQXN8bK56FMvMEYmEs//NaAQ6erxZM19R1uKDYT3aAPbi9JA5M8gLfz
	M9caJDpLgSWjcrA9CI0yZijsd1JNtngUQkrQ4xmaxiDutaW815Mg26Io8OI8cVouDuXBwYZd73q
	45h5uAypZi9Y9ulyJSsABgNSYgAZuKaVRxZxT1cdv+zOCvHTJREqcWft2fLehvDTpEWwSNqPj3K
	7lf7OmZe0MKqlQ/QUjm+uvy5pvU8CKJSiALcRW17gUfvep3EMGUzLRMYZS1Nqz2KcJD9JmKfdk/
	YQK9tVUkcqbQ6BKNgZ576ffCp30qQ/Bf2AxtgfwNEc8kSkuzqQaOobEVLY/8Ld2PDA0MwZuto+M
	v9fjpQWot2M1sQ0FII=
X-Received: by 2002:a5d:584f:0:b0:48b:123e:2f60 with SMTP id ffacd0b85a97d-48e07fa71c4mr16000755f8f.39.1792441272605;
        Mon, 19 Oct 2026 13:21:12 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e1d817d75sm1239430f8f.25.2026.10.19.13.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:21:12 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:21:08 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 03/18] nvmet: Implement CCR nvme command
Message-ID: <20261019202108.GL2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-4-mkhalfella@purestorage.com>
 <179242560183.3619480.12432335570480465347.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179242560183.3619480.12432335570480465347.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_132115_083454_927BDFDA 
X-CRM114-Status: GOOD (  24.41  )
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-10-19 18:00:01 +0200, Daniel Wagner wrote:
> > +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
> > +{
> > +	struct nvmet_ctrl *ictrl, *sctrl = req->sq->ctrl;
> > +	struct nvme_command *cmd = req->cmd;
> > +	struct nvmet_ccr *ccr, *new_ccr;
> > +	int ccr_active, ccr_total;
> > +	u16 cntlid, status = NVME_SC_SUCCESS;
> > +
> > +	if (!nvmet_check_transfer_len(req, 0))
> > +		return;
> > +
> > +	cntlid = le16_to_cpu(cmd->ccr.icid);
> > +	if (sctrl->cntlid == cntlid) {
> > +		req->error_loc =
> > +			offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
> > +		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> > +		goto out;
> > +	}
> > +
> > +	/* Find and get impacted controller */
> > +	ictrl = nvmet_ctrl_find_get_ccr(sctrl->subsys, sctrl->hostnqn,
> > +					cmd->ccr.ciu, cntlid,
> > +					le64_to_cpu(cmd->ccr.cirn));
> > +	if (!ictrl) {
> > +		/* Immediate Reset Successful */
> > +		nvmet_set_result(req, 1);
> > +		status = NVME_SC_SUCCESS;
> > +		goto out;
> > +	}
> > +
> > +	ccr_total = ccr_active = 0;
> > +	mutex_lock(&sctrl->lock);
> > +	list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
> > +		if (ccr->ctrl == ictrl) {
> > +			status = NVME_SC_CCR_IN_PROGRESS | NVME_STATUS_DNR;
> > +			goto out_unlock;
> > +		}
> > +
> > +		ccr_total++;
> > +		if (ccr->ctrl)
> > +			ccr_active++;
> > +	}
> > +
> > +	if (ccr_active >= NVMF_CCR_LIMIT) {
> > +		status = NVME_SC_CCR_LIMIT_EXCEEDED;
> > +		goto out_unlock;
> > +	}
> > +	if (ccr_total >= NVMF_CCR_PER_PAGE) {
> > +		status = NVME_SC_CCR_LOGPAGE_FULL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	new_ccr = kmalloc_obj(*new_ccr, GFP_KERNEL);
> > +	if (!new_ccr) {
> > +		status = NVME_SC_INTERNAL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	new_ccr->ciu = cmd->ccr.ciu;
> > +	new_ccr->icid = cntlid;
> > +	new_ccr->ctrl = ictrl;
> > +	list_add_tail(&new_ccr->entry, &sctrl->ccr_list);
> > +
> > +out_unlock:
> > +	mutex_unlock(&sctrl->lock);
> > +	if (status == NVME_SC_SUCCESS)
> > +		nvmet_ctrl_fatal_error(ictrl);
> 
> nvmet_ctrl_fatal_error will log an error, is this desired?

I think it is good to have the error logged. The fatal error might not
have been observed by the impacted controller we are failing yet, but it
is still okay to consider it as fatal error IMO.

> 
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
> > +		/* Avoid racing with a controller that is becoming ready */
> 
> I think this comment could a bit more eleborate, it took me a while
> to figure out the impact of it. What about something like:
> 
>                 /*
>                  * Enabling the controller (nvmet_start_ctrl()) regenerates
>                  * ciu and cirn under ctrl->lock. Hold the lock so that a
>                  * controller becoming ready concurrently is matched against
>                  * either the old or the new instance, never a mix of both.
>                  *
>                  * CSTS.RDY is not checked on purpose: a disabled controller
>                  * can still have commands in flight, so a matching instance
>                  * must go through the CCR path rather than being reported as
>                  * already reset.
>                  */

Okay, I will take the first paragraph and remove the mention to
nvmet_start_ctrl() because comments with function names do not
usually age well. The second paragraph is not directly related
to the lock IMO.

> 
> -- 
> Daniel Wagner <wagi@kernel.org>

