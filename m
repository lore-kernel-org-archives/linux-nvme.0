Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C12CD4F39
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xb4jnKHYGpg5jJZWTYyOdTuoHgd8mg4ORmYOUpHaqsA=; b=q3JB7O74fylVYC9/xhU6ctNTLp
	uVjtFvK05QF3vDneD9nJ0v3a+R1eJsDgdb+Rl4RxuW4nLAA82ZvL2o7PTiC0pOTdMUNY0KtmILScL
	QPhrLCJRMPTbJOLr2HjB11eqHPhk1JhvqNcHRSnqMkneBK/WtUTHgl64wCfT9nwAMq+5wsorFZp7T
	xcsr2YNz7Xmq75UdxKoPYLUC0D3LwVbwCh3lSfj5Q3pujU9B8sJCpRmrsyGjurNm6eg4Rb3KoK3QT
	zsf6MDcSXcxh8eD53MTqn+rAgZUIWSCuRpR8Q+6wiEx+q38KSAtaVMnbxOvKvHijRcg0aadE7pS3F
	uM570Cuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgGT-00000006ttB-1eKN;
	Fri, 15 May 2026 00:18:53 +0000
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgGR-00000006tsc-2aV0
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 00:18:52 +0000
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-6312a0d556cso3323721137.3
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 17:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778804330; cv=none;
        d=google.com; s=arc-20240605;
        b=Sl++jIUXqa8GKv6pPBdD/mBQta1SH2j07HAvtnEO1VOktrfMbu7bdp5dsKPAFibnZR
         gkbKkEKbxqGTD4jAO7pxEzH2JzHAtz/VC7oMjYtkCXnHsg6Pj2jLnETeUFNSz29vBxAI
         AFlLZDbS2ZHvNVYZclLznQ08EIFt0rODMMVXfwbhfZC69xvcMF+U4+rF33yZpZoyVOUn
         jyhNkSqgnDyBSaAyuT0im9X86MWPfL/pS9qtNgXsKP+NxxJMT5cqJFPDM63Ac/gew345
         G9tONXuHBkwaONPpSXDDtLTcg7XtLRE+vFTmadJ3adrsSVZqU84mBNoPwMZ/AEofDjpw
         XjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xb4jnKHYGpg5jJZWTYyOdTuoHgd8mg4ORmYOUpHaqsA=;
        fh=Jc0jPMpD5M1RjBCeXapFxak3vu//FF9+NzgBvQVdQP4=;
        b=EDeim/wNDjzjMpMflNRBCPAFKCDi2rIKAe0yDcX+2rZxk/7Rp/syto80SzHxWi2gDJ
         KQLn+bJ4tWhz/wkUi5lUojDCyahLZ7zCKzbUEVf7XG55ZE2FEPAzNx2OpUS3kXyIhtl/
         UzgPpj2rflBRIZ7of1t6UpXVaQv9ombUxtv7SJ0UUQ+7krAskqRQRq4agwb7kBOzRP64
         rAjPs5us6TQ7f7iopmdirSr8PAehQCCIEvtvfo6TLJYoDZ5RhZKHAQpIZd9NGg4MNKZf
         oFfrj60D8VNQBDCQXX11enEHY15NiUITE120uvY61L39F0SnGwVdXjLnYTWv9hbPP4Xq
         THOQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778804330; x=1779409130; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xb4jnKHYGpg5jJZWTYyOdTuoHgd8mg4ORmYOUpHaqsA=;
        b=NtBWeJ8Ebpsal8sMrGD2WRH6KUUBa4R1+xD+zquxYb1AvQ7bNBjavs0MC/QKC5iaIY
         79VQztIL2nJr7HVYMBbHFGE2LtZuyM6b5v8pQlpYuqfk4bk4WqE5sseiB/0TFztMBOCG
         Af+TM9Mc/cexj9saGxNVHJKwzCMJv7nbPccv9U7YoguFM5I0JU5+BTHLSKNfrtMzBqff
         5T3v4FXaKmW95xIa3fURCQCDH9SKMD7/zyQwuT1RDuh2zElgSmFLU4hl3T3o2F+yD1wZ
         RYjYf0lEOUctxmfDV4YNuLXjIJqaf7L/tTFTeRH01pQOgtrJ/Xl/GVXiuCe3sJQpYFtg
         ee0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778804330; x=1779409130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xb4jnKHYGpg5jJZWTYyOdTuoHgd8mg4ORmYOUpHaqsA=;
        b=RPEiX/gLfLZoaqQn8p2oUopDaJKRdqQcbOOFhd1CAMuz1XHCYJfTioIoL/ouSUX1XQ
         AG7JbcZVSEmFb5D7sYzJQ7mCFhJRX4d+WYIdwt6KvpvyJfU3iRoNAGmThmJ3XGjVAzOs
         gRRcq0jo8Gn04+5vPsiioUqkpZXeDHG+mqgOS48B7u3zayqG4VybUj5h+yOGLx1JGHIq
         6EP7XMB1rJ2Xu7x1TC2Uf1pZbYX+Kt475BvAQXY/Tz4g6Y30S5sgLuhInoifqb8YpbKX
         ltgL5v7JusX5BXMe4AUpyqOTbeMT+bmTApVR+HNzivKBdoU489FrtOtjlU0nc+a+zHQx
         yLJA==
X-Forwarded-Encrypted: i=1; AFNElJ/RbPC6p0OsYMGVIjKyKRIAldhqUGxhhDrOtnLYPil5jYwwHhNwp1FiZrrmf0QDukuaS1OJfUWa0WB1@lists.infradead.org
X-Gm-Message-State: AOJu0YzlPXFBRCq2A+GqnCrKXNzFyMCcgiQrwkPCQUO5hk6zs7I6WNW2
	BXXNfL85TMN69+mEO2RfSTI06YlaoA7zlWLyZUddsQk0FSt0EtnC4Ip9j7D9zmhLEXJztgOxcT6
	3BckdlzWAtO4wnpZCqVK18Q0HGFpRFVOZFpCxuc3/KQ==
X-Gm-Gg: Acq92OGeTVf6wUXla88wGLWyG6kMFRC46SrXIQUmDSOpw/s/MqW1swy/M913E79+Bu9
	9krGB53wfGTPhh4ESEPwP7Kb2hZrRrOVxROu3tIarDLxzXDCz1/x4fy06hBk5zgbNGKxRJir6D5
	2jzTGOkRVHUZap1fDTMDKktjk/FA7aAOC6zzxx5MQ4Yefa9ZEfzt1tFYAV79pkhNExOcZ4EG8n1
	/CIlA8QXXim3eVKCDFsBUSpvtXjskUu4Yps1+uohePGyIjzKy2wPv6z6KGQbD5OZR8tJ3OO2H5D
	WLq3ix2wSWTCXTzupgcMG82DnT3Lcr2r0wjdgUYcH46srIK58BloHn6QEXWt8DtHaCwJbw==
X-Received: by 2002:a05:6102:5e98:b0:62e:c54:fccb with SMTP id
 ada2fe7eead31-63a402a37b8mr868646137.28.1778804329989; Thu, 14 May 2026
 17:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-4-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-4-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 14 May 2026 17:18:37 -0700
X-Gm-Features: AVHnY4K5XJAmacZhIfNsTkj3Rq8eKrzQ4kXmEILjge171kcoBHPiD7N6pmKWSJM
Message-ID: <CAPpK+O231eYoQGx4zYQZdKhpRq2wkj60PZj_r=1QBW7OF7jQ8Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/15] nvmet: Implement CCR nvme command
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Hannes Reinecke <hare@suse.de>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_171851_665716_03625F1A 
X-CRM114-Status: GOOD (  10.62  )
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

On Fri, Mar 27, 2026 at 5:45=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> Reset) command is an nvme command issued to source controller by
> initiator to reset impacted controller. Implement CCR command for linux
> nvme target.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---

> +       mutex_lock(&sctrl->lock);
> +       list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
> +               if (ccr->ctrl =3D=3D ictrl) {
> +                       status =3D NVME_SC_CCR_IN_PROGRESS | NVME_STATUS_=
DNR;
> +                       goto out_unlock;
> +               }
> +
> +               ccr_total++;
> +               if (ccr->ctrl)
> +                       ccr_active++;
> +       }
> +
> +       if (ccr_active >=3D NVMF_CCR_LIMIT) {
> +               status =3D NVME_SC_CCR_LIMIT_EXCEEDED;
> +               goto out_unlock;
> +       }
> +       if (ccr_total >=3D NVMF_CCR_PER_PAGE) {
> +               status =3D NVME_SC_CCR_LOGPAGE_FULL;
> +               goto out_unlock;
> +       }
> +
> +       new_ccr =3D kmalloc_obj(*new_ccr, GFP_KERNEL);
This allocation could be done optimistically outside of the mutex.
But that would lead to more complicated code; probably not worth it
here.

Reviewed-by: Randy Jennings <randyj@purestorage.com>

