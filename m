Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C81606A32C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jdRlpzCs;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=dbYEl6ry
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8iePJ2j9hYRhBFpXy6COEqiXeGRhguwoRsD0/kPxjro=; b=jdRlpzCs5LBqGkL25tPmqq6ot3
	lDsG0XdPh8UArS5+X3zvIXvTJjfdsPgaOve6OMV9mV81Dz9vpVGwahCn2lBhk99Rv1QrqHr2l+wOc
	3XxO4H3MpH6IZIvOP2VvYnFr1YsETFRejFRthT49QuoL6uzs+VkiXWFdKP6ancWJb1KLwM4UnTgKX
	tWkVfGYBniaqr8syEv/SNnnjSMJuDIL7nRd/3N3QyZeYatwT7tZNgaUp0JJRYqxX71neD2XhHMvYh
	/a2YqIbeQ/0ggnspZVmiUnMMOp5upySroFm688BjFfninJnsknlRnonL9aIDdsN7Q44PGAUKQw2Sc
	cNPdn92A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5yz-000000049b7-2X79;
	Mon, 16 Nov 2026 23:19:29 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5yx-000000049Zt-1TCb
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 23:19:28 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-14394530ec6so5071902c88.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 15:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794871166; x=1795475966; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8iePJ2j9hYRhBFpXy6COEqiXeGRhguwoRsD0/kPxjro=;
        b=dbYEl6rybDsVL+L/6Z6jcdCI00jLc5TK+6pDHaBgPqODhwx171SVHcz01Ht+vQftuP
         kHqv/4Ma9eNcbM4Q1X2TGn38A4EzGF4vDu8fKFQOASsdvK1aPXYE7/q399RociSdroPz
         LiL3QiHwtsPEP+wpsZRHsFRoYM8cfSUe20fh7AflkekX3YeS4MMVT9hDX/dNQh4TXBYR
         zr3XHXKabTzoHlXe/LTf0qVsy+DFJE+yG/56+1F2h6HV64vJcaGGrld0tF8Pt7rlMFSd
         N0qJFn+I29aVFQQmoJGeMbfQcJy9RBHMO4gDVyqVWCMpwkzTKdgVJTj+I1Myi07BXVRC
         iyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794871166; x=1795475966;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8iePJ2j9hYRhBFpXy6COEqiXeGRhguwoRsD0/kPxjro=;
        b=e05j9AwIQzQCOoA80Qt/Y30aVaI6t93NEXxYY4STmfwcnHlbtB0VeshInNQ4wRvaMH
         gvl020Ovj19C1MMeb0lU27GnrKnjhUF2bI551gJ3eTFy2hkw6kvCE+/8cVbREZdnR6VE
         JeMPiZqkF9oejoks+nYFbPvF/Afm8d2Rl+H96ALqvpkbEgNgjIAE544DZhnnbzmh2mH0
         Xljfq8t9pgiL8Hz/owB9wIKqmTatPf6jk0t4NXoKCfgzFm+jdxzMwhaXmkH5h1FQWr83
         yVYljlyZCOFl/WkhEjmyaZSfURrfHpy/gw/soXqJgzGp8c6DitTLRXgZ1lKpGoA85Mmz
         KswQ==
X-Gm-Message-State: APuU4Z+HK6RqElwG2fpJUQFCgsLeu4nZw9ZpAO6fa3zYn879wJnxC7kC
	wYXE2GHY/WgDCP1E67lV3k7OpG1ABPkPc+GWaD6hLrFIXt3Xevb6Qq5JRRSa8+4ZljUDUU6H7rn
	ztAyU
X-Gm-Gg: AYBFou1X6EzCaYPuwVNp37k2KX7qVI9KEiJ/uvoXHCCtnZJM/5Ag5/paT/wmpSf9yCE
	RNcIx4eVHKfVMn7UNzU8aWpdE4ZKwUi9GUu0y+eLRrcOc+kv8MHPq3WY9pTdU7FZ0tk94jIl6TH
	ueqn9rG/bFGOLDTfLgQBu2rp9vdzlQb+z21ZtxS3evGOTTt5UhH3Ooj1Sq+25QRa/6yp+Z7Hlep
	AJ2CjXPUWrSmhOWOayUrwCcZRYd3ziAPF19TX/SeBHuuXXSu5r6WG75JbaSWuy4+nENUCSRDAHM
	/WkdZcj9YbJXhsaRGTAbXISdM3bkkFsN1on30btr1+GhR3nCyeCTD2PjXX0cpCMxMIESPK5AUrR
	K8IRo+1RKvVbGUg4JgfGHxCcVcefGphEyK51ZcJlHrCBl+P2Rwfq7l9dMa3nmQcxwDYdN+vnrPF
	apw5x/vbxDUXSzitMcAc4CSaa2xBnjT7+bRwUopCWyCSicphlSbmKGhtPogwOHo5e1hK5asuX/C
	DHL2wAaq9uC9Z0FPcPIILRiQgeEl7YDqQhegitz8eFl8vrg21kiPebvjD4k5Ku2Pazu03FjTF6c
	la7hh4Q2qi8DKESaSfqyPMQcAeir4h4Iwu0EeZmx+bQ0YIRk4Q==
X-Received: by 2002:a05:7023:a89:b0:1b2:4da6:bccd with SMTP id a92af1059eb24-1b50312b2f7mr13094928c88.34.1794871165920;
        Mon, 16 Nov 2026 15:19:25 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50319d40asm36020092c88.11.2026.11.16.15.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:19:25 -0800 (PST)
Date: Mon, 16 Nov 2026 15:19:24 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 02/17] nvmet/debugfs: Export controller CIU and CIRN
 via debugfs
Message-ID: <20261116231924.GB1670230-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-3-mkhalfella@purestorage.com>
 <sashiko-outbox-214069@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-214069@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_151927_418779_E9F6D7FF 
X-CRM114-Status: GOOD (  18.45  )
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

On Sat 2026-11-14 03:12:01 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] nvmet: torn 64-bit read of ctrl->cirn in
>   nvmet_ctrl_instance_cirn_show()
> --
> 
> commit 70231338c7dc52cc534009767cd7997ab988025e
> Author: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> nvmet/debugfs: Export controller CIU and CIRN via debugfs
> 
> This commit exports a target controller's CIU and CIRN fields as debugfs
> attributes under the controller's debugfs directory.
> 
> > diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
> > index e85fe1d4c9f8d..221fa81e124fe 100644
> > --- a/drivers/nvme/target/debugfs.c
> > +++ b/drivers/nvme/target/debugfs.c
> > @@ -153,6 +153,24 @@ static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
> >  NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
> >  #endif
> >  
> > +static int nvmet_ctrl_instance_ciu_show(struct seq_file *m, void *p)
> > +{
> > +	struct nvmet_ctrl *ctrl = m->private;
> > +
> > +	seq_printf(m, "%02x\n", ctrl->ciu);
> > +	return 0;
> > +}
> > +NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_ciu);
> > +
> > +static int nvmet_ctrl_instance_cirn_show(struct seq_file *m, void *p)
> > +{
> > +	struct nvmet_ctrl *ctrl = m->private;
> > +
> > +	seq_printf(m, "%016llx\n", ctrl->cirn);
> > +	return 0;
> > +}
> > +NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_cirn);
> 
> [Severity: Low]
> Can nvmet_ctrl_instance_cirn_show() observe a torn 64-bit read of
> ctrl->cirn on 32-bit architectures?
> 
> nvmet_alloc_ctrl() calls nvmet_debugfs_ctrl_setup() before the host
> enables the controller, and nvmet_update_cc() -> nvmet_start_ctrl() later
> writes a new 64-bit value to ctrl->cirn under ctrl->lock whenever the
> controller is enabled or re-enabled.  Reading ctrl->cirn without holding
> ctrl->lock races with that update and can report a corrupted mix of the
> old and new values to userspace.

Not worth it IMO. I will keep the code at it is. If we are considering a
race with a controller that is becoming ready, then the value will
change and old values are stale because CIRN and CIU are random
variables.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261114030454.2836543-1-mkhalfella@purestorage.com?part=2

