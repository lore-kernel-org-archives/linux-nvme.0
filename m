Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE79606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=s6SIu8Xe;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=aHv/r8lE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VUtXluh5oLaQga2mDElt3F7B3MTKErkoGZJ+ACHq9d4=; b=s6SIu8XeLcnSrn4isFX/qI0RTP
	+61+cRD0MWsmrxjq5Q2N6gJqj49/7iunhQhMbCTjGJsk7FPIqhaLmGWCD4Xb8xhx5kF4UPfRv+OjZ
	xLQ6ZD/6g2v8UD+I0GEQAQt6ItsI1I1vV5MEx2OWIFbOkyQwo80px6VtFRfnukQ4Fbgln1C63ZfR1
	sZgi7NqgoofESXOVxZC7vRSmQZf7naGatg5bXdBhH7osBqLqapqgl/6pQGxO4WO27PiKPNecaYXYx
	/h2Pg9xMvq0YuhHQg1DcCHOC5odMoXfzLmwd4De+sx/QtuHofvAUuabo2S4YYmkDRDhbQlSgNkjcj
	o5knPZEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5wl-000000048wI-2VB7;
	Mon, 16 Nov 2026 23:17:11 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5wi-000000048vB-1CGG
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 23:17:10 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1736176eec.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 15:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794871026; x=1795475826; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VUtXluh5oLaQga2mDElt3F7B3MTKErkoGZJ+ACHq9d4=;
        b=aHv/r8lEKcrijEZK2TvjTnEQSTp/FDbdHfdGoQPsMHYMcd0+K7yK1HcJl4PswrjpSg
         WzNIN1pVBjP90Cdc7eXH3q4f3sAYb7mu+NJQ+0vIuxk9bvs74HyMahNwuWboyDfZIZzf
         ZXdB5ABPxmzBD8NE0gACMqF+jKrupec45/YVexCuRyqrAOKXdPvZMJgcxbQiGeozfIV/
         AiVC0YY5hysevnamNw6xS0wKiTJdrXdsoMuPddG6i8eIlKCNaryJ1M398pN/Av4ZvA+G
         QmTE3l9/lQDbCe3e441JdJah6iUNB8NxapVHvAmbpip+DZnBkqGDb5dwhd01+f1Dq/AH
         OxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794871026; x=1795475826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VUtXluh5oLaQga2mDElt3F7B3MTKErkoGZJ+ACHq9d4=;
        b=tFsuUxNHpnaY6p1x0sPaBeHbkkoZbXNWN/4KxzruDQxEOxxPaQFkTXevIxrjSpg5la
         m+25zaIW/hh/1pE1FS8AZi95h+qC/Isrk0PRw7aEY+Lms4TWOlYJMSQzO/UEILU/mwH0
         o5lMIaXXsIVCI7pHpUfiLu/+1EhJ21iv1rg1fhXvnlMhxy1R9gptqRDp91obakFpOV9j
         opW3p4mvG1tXFlGy3zpNod8IAHEoxZqfsv8V3BZzRf8f4rTe7F6C2Q7zZF7uyZHQ+XjX
         SNvupZ7GRN4NpxrxIzxVA4AUwjqw6HrLabdmWH46P60LigLNngPXKtemK1azOJYs9Hh9
         Ks+Q==
X-Gm-Message-State: APuU4Z8aDGsU+9aqP+6152JWtI8gy68km4a8j/OP+exqcjtclJejdWSD
	VwP7BHeYrbv73anga1N98feYDYwXyGz4GlygjButpwtJzaXrVYc16hkm1UP1yG3Xd78=
X-Gm-Gg: AYBFou2NtF5s3+oEB67qNXTWJFHbfR0rgRZRCmLDX4s9KtocwLaZja+USS1p+EI/hZg
	ZSCeifWetgbzTBufs4EoBQ4j6o9UmKaY72obJAcp2EJ1V73IpzhK0g740BGSFjBaXLuutjn8RmC
	lf4BKNBwsPs3YdMMG8KwXNcyGpTFiTeEOXiLGjE6qyLac7AjUokONSB1/mvdhjSVVC+noa1+1kS
	rCzNRVd1Urp4PvrL/XulkmTuQkDbEcttiZDOKRZOSQoRUkEmS3Qiank4VDt88gMrx9DnkZio2qu
	VNpYFAtVmmkMOJPC/sYyvYXifCnwlbKBlRx+e/oVisEMoK0z1nSwc6Kr2A59KKnR3GDSceCokAV
	X4h/x2rjqWwtZbT5/tUmPfP63A+Dv4t88NkW3hA3SL4GLy99faGTIQOcr3NiBO3f0Ol4OXukhxZ
	9z/Ljd0MT0J4mowqedqwrucseHaeZQNfc2LV0SVewxusKRtazJyVRzIXJn0OLTbpURPUDC673e+
	6WKzbuUx6Ywf+YhpZul18kSUYRn93sFLN0goEFsVAN9q9BmXQYuoXpBUXf8PV3GXiok45O4xhRo
	zbz5/584fw+OxrYlGPXf2T1Uag9wa7ytdUDMpZo0g2W2pqvGoA==
X-Received: by 2002:a05:7300:6b28:b0:376:bcc4:774b with SMTP id 5a478bee46e88-3796638ab4emr12333373eec.23.1794871025916;
        Mon, 16 Nov 2026 15:17:05 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-380e0fdcc36sm2832887eec.25.2026.11.16.15.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:17:05 -0800 (PST)
Date: Mon, 16 Nov 2026 15:17:03 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 01/17] nvmet: Rapid Path Failure Recovery set
 controller identify fields
Message-ID: <20261116231703.GA1670230-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-2-mkhalfella@purestorage.com>
 <sashiko-outbox-214092@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-214092@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_151708_482703_B6E911A1 
X-CRM114-Status: GOOD (  18.46  )
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

On Sat 2026-11-14 03:17:21 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] nvmet: missing TP8028 field overrides in
>   nvmet_passthru_override_id_ctrl()
> --
> 
> commit b07e2fdf2211131fb02142faf21d5cf7328792da
> Author: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> nvmet: Rapid Path Failure Recovery set controller identify fields
> 
> This commit adds the TP8028 Rapid Path Failure Recovery fields (ciu, cirn,
> and ccrl) to struct nvme_id_ctrl, initializes ciu and cirn on controller
> allocation and start, and populates them in the Identify Controller
> response for non-discovery subsystems.
> 
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index f12d830986446..5710ae53eb83a 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -702,6 +702,11 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> >  	id->mdts = nvmet_ctrl_mdts(req);
> >  	id->cntlid = cpu_to_le16(ctrl->cntlid);
> >  	id->ver = cpu_to_le32(ctrl->subsys->ver);
> > +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
> > +		id->ciu = ctrl->ciu;
> > +		id->cirn = cpu_to_le64(ctrl->cirn);
> > +		id->ccrl = NVMF_CCR_LIMIT;
> > +	}
> 
> [Severity: Medium]
> Should nvmet_passthru_override_id_ctrl() also override id->ciu, id->cirn,
> and id->ccrl?
> 
> On a passthrough subsystem, Identify Controller runs through
> nvmet_passthru_execute_cmd_work() -> nvmet_passthru_override_id_ctrl(),
> which overrides id->cntlid and id->ver but leaves id->ciu, id->cirn, and
> id->ccrl with whatever the backend controller returned.  Every fabric
> controller connected to the passthrough subsystem will report the backend
> device's ciu and cirn instead of ctrl->ciu and ctrl->cirn, and if the
> backend controller advertises a non-zero ccrl, hosts will issue
> Cross-Controller Reset commands that nvmet_parse_passthru_admin_cmd()
> rejects.

Makes sense. Will update nvmet_passthru_override_id_ctrl() to set
id->ciu, id->cirn, id->ccrl, and id->cqt to zero. This way a passthu
controller exprted say over nvmet-tcp does not claim to support CCR/CQT.

I will break the change into fixups to two commits
- nvmet: Rapid Path Failure Recovery set controller identify fields
- nvmet: Add support for CQT to nvme target

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261114030454.2836543-1-mkhalfella@purestorage.com?part=1

