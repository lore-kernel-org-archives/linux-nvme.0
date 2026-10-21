Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60C606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vbmwLSKU;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=cPFUdHDM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uIy+JtJ16TtxbVm/PfwhUZa+19M2uMfSlcIIrSZi7Tg=; b=vbmwLSKUd4sNZHyo6l/S++qJvm
	fsSXUPOFnIpu6snEkozUJK5ISR6sCFFc6YziqXX2Q4Wr2H5N6xPA4e6kCzb7uF/brrYRaBi8CBO5I
	zgZgMbk9jwDN8NLWiuotJBVYmIJX6C3VMQd1jFRNR+ohVJQzsa6rFrtgGhu+DLVx6RuHDKld8S41k
	I+GTFqDwyy11jX+JBcm+QwVRwPSavbSROxMqWt5q5Fu+Bc143zNElmGG9hXoOuXWYZ3Xjh3/rdbG8
	JVwwtVIjIK5y9gVwXaWJfC+uUf7B8MX/AtoA9cOfOaYmaByn2rX+O1Arh9J3Uwcg2FpUpnRaKUHqY
	eiMGkgGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJL0p-0000000AtJe-2Fd8;
	Wed, 21 Oct 2026 01:21:03 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJL0o-0000000AtJI-0Mu7
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 01:21:03 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-35f036b17easo465038eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2026 18:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792545661; x=1793150461; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uIy+JtJ16TtxbVm/PfwhUZa+19M2uMfSlcIIrSZi7Tg=;
        b=cPFUdHDMWCJbc2whFXbuDtrySNzemGzQhO2TkJ6tW/OkiLXxZzgSmLCABTE6qJyNim
         s/seyFqKNkMc+HrABWtO4P7ahXPOc9rbXMbpzcSssYyDKlLU4wqL01+/b6h1t6YpVgEM
         8+JLye1EmM5cRG8oZ6EdU2Ei/VA0+uG8RZtxoTd9bTytsQaw5tF0xufn0ca6Hhljh6al
         sEV3wgfGL9spubQkfsQSSRbtPvV4ZcDdlH2RQtu1prtoQtfr3Q816OGqoFrYsvfzTJvc
         KQvUbNing+Iog2WOjl7X2sqQ4fa9VcUqMhbC+92SLaSL+na/nG5QPPMNwd9na/U28pEU
         j3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792545661; x=1793150461;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uIy+JtJ16TtxbVm/PfwhUZa+19M2uMfSlcIIrSZi7Tg=;
        b=gN8khz8W3SYwHs4fQq9PcVtzLDxBMNBmnJO6Sysn/vj6AbuQTVZEEJatlIUoBhF4uk
         LIWYoPfAI3aky7v8jWXSylp8KccRuVmox0IKQpgZUUxT0HDuQodEnZLLgX4fkncZPyrq
         UAGZeLAzKcXbH65daM6l0bjK9/AozJx9lyBEJ16pyGYienAib87qUSDkWvnlLtmN3mWv
         g3KAweA9UHnPg91ZeJRgA7vo1jtKrbXLUB0O2u7K8ld8jNZh94t4j/qUxMtRDfVXwabd
         ZQO4ziSCzenZod+5K9wsp+pN3zUkhcWiIa5dPMpc+n30/trg4gRLH5xM9EEho2yvuHy3
         mSRQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9+NtB3GWJ+MxU0aeKyiI3bkroJnzqRftVJyc6th8YV+8WirJE73g2vjO0ntL+6IDzEAByMW+6q5JA@lists.infradead.org
X-Gm-Message-State: AFq9FYL3wR1BNJtDTxxQCUqEWXMX1Nzj9/QgXt0hT7SO2dFEUdCRCejX
	WdA1rf7tqxHroZPlKYYVnhZEpeRhGQe5rDJ3qe8345A2oZ1A2orqQusAFj6766V7gQg=
X-Gm-Gg: AYBFou3qtKjue8FNIxNxKb1vG25XL2L51K8CIwUoQpT+PLcBGGchZs2Hwe0vS7Zi8K/
	c1hiU+iFFCM3sqmiZ2txpNPrKYsgyJ6yPK2BKhwlt+j3DiYb9PxgIg8wSqA3VR/Khi8LKvy7sIo
	O6o0duE6qSqoeBGdO6mm7enxaZaR/0BI9vYaRalf6onpAYqJLFDXmLwPSg99nH/GjpfH+/iHsF6
	76puBWlL9os/j2+69Q42VNH5Y+Y/F19LgnGUCuxvrZYrWK7NWaoMOCUC7VqW1EvciWyqiFkgixm
	1kj/mGO8D8Pg0ecxgR7u5MzTl9zP/rqayFxKYKV9CPPyMEtslbLVtxRoruvxvc8XjCBPBRfn0l1
	Lw7hecEncih7IImZzU/KGzi6NRunhx5nirgizmL/Q86JAaueY9jvkPKbPiFsA82YpqxlFuDFbMk
	iLDpHIpfOFtBwdx2dETEyfkIwaRWnn3zrk/SoIZDV6v2IcjpOYrDR4L/ZJ+tQedP/UmwNYk86DD
	ipwKNrITjishu0HyaRpHjp+fugmv+uY/S486Oryj5J2xc+wYdgETxET7ny9gag3TzB4cqR/iRQ5
X-Received: by 2002:a05:7301:a07:b0:366:913f:4d27 with SMTP id 5a478bee46e88-3674fa0d640mr1022322eec.30.1792545660473;
        Tue, 20 Oct 2026 18:21:00 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-367411bd2a6sm3211171eec.18.2026.10.20.18.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:20:59 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:20:58 -0700
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
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/18] nvme-tcp: Use CCR to recover controller that
 hits an error
Message-ID: <20261021012058.GS2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-11-mkhalfella@purestorage.com>
 <d1e6b53b-3d14-4cc0-8153-dffd5da7673b@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e6b53b-3d14-4cc0-8153-dffd5da7673b@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_182102_133612_5873951F 
X-CRM114-Status: GOOD (  20.12  )
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 11:36:19 +0200, Daniel Wagner wrote:
> On Sun, Sep 20, 2026 at 11:28:08AM -0700, Mohamed Khalfella wrote:
> > @@ -2731,13 +2755,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
> >  	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
> >  	struct nvme_command *cmd = &pdu->cmd;
> >  	int qid = nvme_tcp_queue_id(req->queue);
> > +	enum nvme_ctrl_state state;
> >  
> >  	dev_warn(ctrl->device,
> >  		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
> >  		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
> >  		 nvme_fabrics_opcode_str(qid, cmd), qid);
> >  
> > -	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
> > +	state = nvme_ctrl_state(ctrl);
> > +	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
> >  		/*
> >  		 * If we are resetting, connecting or deleting we should
> >  		 * complete immediately because we may block controller
> 
> The documentation should be updated, maybe something like:
> 
>           state = nvme_ctrl_state(ctrl);
>           if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
>                   /*
>                    * If fencing has finished or we are resetting, connecting or
>                    * deleting we should complete immediately because we may
>                    * block controller teardown or setup sequence
>                    * - ctrl disable/shutdown fabrics requests
>                    * - connect requests
>                    * - initialization admin requests
>                    * - I/O requests that entered after unquiescing and
>                    *   the controller stopped responding
>                    *
>                    * All other requests should be cancelled by the error
>                    * recovery work, so it's fine that we fail it here.
>                    */
>                   nvme_tcp_complete_timed_out(rq);
>                   return BLK_EH_DONE;
>           }
> 
>           /*
>            * LIVE state should trigger the normal error recovery which will
>            * handle completing this request. In FENCING state the request
>            * must not be completed before fencing has finished, so just
>            * rearm the timer and let the error recovery pick it up.
>            */
>           nvme_tcp_error_recovery(ctrl);
>           return BLK_EH_RESET_TIMER;

Good point. I updated the comments.

