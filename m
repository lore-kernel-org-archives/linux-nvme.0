Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083F606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=N9Aa/KqF;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=KMZ2hPNb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Q6USGcPBbGiibCPbj0AvZUr4XyMx+DULAeB+QLoxL6Y=; b=N9Aa/KqFfZki0b
	+bCvuE/bg9wMV3OXoB4IQOC2A8k9GlJ+kIJd17+L5YizWmPumLFdJmpLEqzIMj2NoUIaRvy1VEc/g
	TP99cDtt5GwOVybnnvnDczRiY5TRRnH3JlwUcfpkr7L/63pMKSpaz5Bi8HUk6Poh2DPauAyJ6+ptH
	PyLQWRylBQ584BH9de3iBXZNnsQk2klt8gOzqCQdMbjs5R7fPD8UfMG7oB/07z+1RWwfu9xb3rvgh
	5sfdxXQ4+cWNdrYHZ9W6TPWn+KGHRDr4liEzcllO1VhliB6LsfBAMBLOJENlqq67J2AvC7d7mKl5p
	qOVYYkF55614pFpflOdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMtgm-0000000Caaz-0UQi;
	Fri, 30 Oct 2026 20:59:04 +0000
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMtgj-0000000Caac-1SPM
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 20:59:02 +0000
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-7bec5112765so778726137.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Oct 2026 13:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793393938; cv=none;
        d=google.com; s=arc-20260327;
        b=ElKh0utBjN484DoZKmotgEyDEzHKYgkF20x9l/GixKqGkv/AQSJLDI/tP/83RVjqSe
         xNrMRWzWVYanR1/71OJZ2RP0w5P/0W6f15/aibm4P7XUTu96hj3cM36wc9yXg17OjoDp
         9YttU315p8UEOwOuFjOP7ZoZxp1njNFBg13L6n6SNO6OPEY7s/NK6NngszlY64btq/CY
         vbENm2Bvm44zg6/Ki25szR4DjE8NagnZTwnVbz2ZRyjtDuMCraPe++T8rH/nJkdVRKNu
         hzY3DhJ+qv24fLpxn1a/+y0oLVGWohtCRBHw2pkaPr60NLXUNYGOrS6ePMje2V2PgxTh
         0Uow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q6USGcPBbGiibCPbj0AvZUr4XyMx+DULAeB+QLoxL6Y=;
        fh=3E6AYo4BGdCDrepOA/s3U8Axc4WBa4JOulxzDYxc2Qw=;
        b=dsL6gLsFIG+ZQsanPcsSKNSN1FhvNVR5lDkTcWkOtk1ovKlPMJtnQBh2TmwEvIW0ov
         ZxgdZM3IjuID/9vlPUIlvQveXHwgZw7EsY9zXTCSiZVw1q9Gx/smhi3k3ZrQ37VHELBQ
         QEc2SD7I426Bo7gcTnFeeNUr4IAGLZ5XV/NEhk+5tPOsLERTCLtvEgmvAH1JSsxVd6Ih
         d7zt2/O7wmiXfG8Dpk4koVeyssNljoywumHICYn4I2N1xPpi+5ZZW9MEnk6Cv1z9m4RM
         o49His7lUy1m7gbhaHmdqA3+0cVV/ZsyS68Zdq2Qzqbo549IX0wbXeesOEQOU7HJQ+eg
         rebQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793393938; x=1793998738; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q6USGcPBbGiibCPbj0AvZUr4XyMx+DULAeB+QLoxL6Y=;
        b=KMZ2hPNb84w83MlaAjbeIwVrCuqbCCjAwEOa/jGUd/W8iVpnqa9e1DKZrZfjCbJ3i9
         /FbsSC+QhjeNcrscOTjR6OPn+nDWJF1hlbiIym4NCdTk8UxgDRiCxov88WL+Sbr1Ma4R
         aZClT63cvom9yWkv9kU8+P/64BrYIXDwyuznfPd9eeH8UTBdzzE/+3LuBbj3CrsH6Q1/
         teClBQmfo2sPVrLrTd67K5f9WT/J6FTeuJLbWTyDfpKwJ9u49EclwdR/750cHoZMT7bh
         WeiGXsj5mCOfn7j9eS4Sn3/2ZHvruF2L8GIHqfaFWpT9oZdoZu+haCucSQAofLfGM7rv
         u9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793393938; x=1793998738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6USGcPBbGiibCPbj0AvZUr4XyMx+DULAeB+QLoxL6Y=;
        b=qIiiDbneVDllMzTODbdSjuT5HQepISVODA92s2ySVrQw1QmF1vTBdXBqNayvL8UmVW
         lh30SW/bYGg/hqA9fwRyfFm95r/IUAYsPjA9oCcFUkfSGNKfiNoSP0bkeLzd2svHa8Lq
         3igWNRGAsvQse2BYvbTRLqvwK0TuHwZDG5E6OhI8qj3Yj2oJZeC9iToDzoFcgv3nXfSr
         QgVhWGhBmQjLm7mnooe5Cr7jBr/yuUpvcTMsr3ZyWozNIBNWIdbJBy0y/NOxI8KDOXEv
         tu3uNuUYWZn4MDvhYX/clXWWdiOJO63fVZpFxCiaXUrSB7NSBgPEA6/ul5Pv8bqv8ceL
         GpJg==
X-Forwarded-Encrypted: i=1; AKwUvBw1phuTRfMFUkwSI5PrVT3xXcpsu67xpuM+UhhNBlcpD+4d+3Yfm3AbwRz8dj9bOFsKK+cZO7hesoGG@lists.infradead.org
X-Gm-Message-State: AFq9FYIZem9CNo6x8c82YxwoxHx95c0b/2amQQES8IczXuLxiKx4o/Y7
	f8z3aMJvhKylwjHjM5KVYntZl7ifili7yXxitgOcyeavNMxMDFtQL3mUanxAfzZNL9DSL1CBjtQ
	YBpBVAe1KfWxvhA8mW30t3vdL1LXH65Y3j6kPCfVZkg==
X-Gm-Gg: AYBFou1tN3RC9m+xrAqUqHwDxtpklBjAbNAFWXCkkt41zqIZb51kW7VFd+SIgmMTv8j
	+HBvuVRti166yQkLPxmL1LR5smahZezqlAKz96eoB4ASQVMsE944yL+62aAHenvTqeztylVRmh2
	I7RDtJ4PDh2lXfMxk13Frnn8FuyLyk9v9dl6bKU7+z+i3mQp1iMsvvkGQ8tUFmojeFrU6fOymzw
	GB5RGMn6R1uTDByRBMYlxx6NMUPB2DJ8EBveKQZmnhA0OpUpKc491TYFuOgCOx61z0bqWVJot09
	ZfmGR6q0vhIt85mlRQ1wypH1tAtrzccs93Zd5craKiZDONAFJ0Rv2UUKB+UdZGCvuJHI2k01oYh
	mRLom5Ha1K4TnpX0Vyv5bNiN5xI4Y9OEVOgkJShHItc/9GMLbooNbjdpdEo5i5SC9cGSp7Qx2Pe
	wNVKILqp0t8vqrdXWcF1/Jfg==
X-Received: by 2002:a05:6102:4422:b0:7c3:7286:c291 with SMTP id
 ada2fe7eead31-7d072c3e082mr2023245137.19.1793393938021; Fri, 30 Oct 2026
 13:58:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260920182936.2317916-1-mkhalfella@purestorage.com> <20260920182936.2317916-6-mkhalfella@purestorage.com>
In-Reply-To: <20260920182936.2317916-6-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 30 Oct 2026 13:58:46 -0700
X-Gm-Features: AclHuK8X6zhh06a0byCpdwLnjr3WBz6Rb-me0_VFRdAQiql9ckylY2x3JwQ4rBM
Message-ID: <CAPpK+O3+eF=9WOVqDJptwfGdA+=XwFeTx-sMatq=bQLUPhMvVA@mail.gmail.com>
Subject: Re: [PATCH v6 05/18] nvmet: Send an AEN on CCR completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Hannes Reinecke <hare@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_135901_707736_B45C17F4 
X-CRM114-Status: GOOD (  15.65  )
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

On Sun, Sep 20, 2026 at 11:30=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> When an impacted controller that is the target of pending CCRs is torn
> down, send an AEN to each source controller that issued a CCR against
> it. The notification points to the CCR log page that the source
> controller can read to check which CCR operation completed.
>
> Split nvmet_add_async_event() into a locked helper so the AEN can be
> queued while ctrl->lock is already held.
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index f5d7cb9c943a..69491e8e52ba 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -218,13 +218,19 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl,=
 u8 event_type,
>         aen->event_info =3D event_info;
>         aen->log_page =3D log_page;
>
> -       mutex_lock(&ctrl->lock);
>         list_add_tail(&aen->entry, &ctrl->async_events);
> -       mutex_unlock(&ctrl->lock);
>
>         queue_work(nvmet_aen_wq, &ctrl->async_event_work);
>  }
...
> +       lockdep_assert_held(&ctrl->lock);
Is there a reason not to replace the mutex_lock() call with a
lockdep_assert_held() call?

Reviewed-by: Randy Jennings <randyj@purestorage.com>

