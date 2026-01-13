Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F35D29DE8
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eZ2WEBXX1l9X8JBQG+YJYxmNxxWGJe/kO7nAXn5RTos=; b=NM98pp5+2V/WzwDc8B18aeyiOT
	hM/Nk+8MacUNshOuiSqkxRW4+I3x0h0r7xrGB9eJBPyysuSeSfhV+Vbgtgl12V9/l4nfO8QQHhhpU
	1SpkED5XiOTBpqyGd1KQt843VTlH/mOKV3RdQA5yv8h8FloCwtz6UJeuffUghnO4xozK8g6TGa95D
	CskSxfojqObzZzKK3HKDZon5WzExQM6djvhlq0cdFClhNbK2gJwonH8Mb4KIqlz2B8JQD7SQvxEby
	Sy3FPlXYRIqnw4nved1IAtkqgQNIcJ2ZsCPQqaIJZ98iAXxBm1z6KyunpDUq0dKk3KphYIrUT+ins
	HwSdrJdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfaP4-00000006obH-3acJ;
	Tue, 13 Jan 2026 09:09:30 +0000
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfaP1-00000006oaS-2Xxc
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 09:09:29 +0000
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-59b6df3d6b4so7394023e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jan 2026 01:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768295365; x=1768900165; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ2WEBXX1l9X8JBQG+YJYxmNxxWGJe/kO7nAXn5RTos=;
        b=MM8QZfixuCS65aZTHb4IHxYJW+IXr0I5OJHCsRCwmKdknfUI9xZst4Fy59U/Nwd430
         grAbj+P6YNoc/IMFro3n0AAeCX7q4OQy+zcX5PFjXRp6mpiw0A+oe0ROBj4R7wLFQyxh
         A+9h2izSxtgGy4IoP/EzVCP76UYDg1nTGRF5ffkJDM5cUksw03SP1ayY9fqWZIwaUove
         frwyUSLtWxdmK1qCVQuH5zlDIXRpK7blw1QGXs7BXgnRZDEvf2xQahEDfia0MSC3VTj1
         qWtQYDYmvoGJWG9ScDMaNqZveMScDKslUiq/oR5o7Ek+QqZrhas/2jxs/e8BHwYyI84H
         11Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768295365; x=1768900165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eZ2WEBXX1l9X8JBQG+YJYxmNxxWGJe/kO7nAXn5RTos=;
        b=K71coBCofVf898pjbs1bNpyE8/LGmGnXY7e/qRlktGFqVsGfcPCAdW+3JrjJ9FmAuT
         EfOpPGnAiB0WPZjQcMUK79ESuOIeoTnc52P46Imp/a6OnLsoDiWKjdOfhr6l+t/+EYj0
         4nJw7OQtfdienkmig94uqb2HPXkP7Fi1Ymjd8OlVGSjRrgXqTH2nJ81Sy1xyzbiR5oPI
         w/9dHNf7YSwYxjEHrcLy/kgfiUNLg03mZMvluAzeqeERvtYQyNp2QA4DciB5Ykx0LrtR
         7JwwQwhCwkg7sy5nNKWaqLXEw7gokZQoohirMeXzLX8ClwBDc9xRqcuI/FJcIdwXaFE1
         AcPA==
X-Forwarded-Encrypted: i=1; AJvYcCXYdGWQDn2WW8hqUXD239uyOukRsHxhg99NtI8jbztqlcea32TkrDOY/QCjTw7JPVw47rDx6SGFIORX@lists.infradead.org
X-Gm-Message-State: AOJu0YyYe3Y9GPzkcKtb/F1+2QpXaEkBcAJSYDt6j9DtGZE9lbM+Ol3W
	mCBLdcMy9QXVtjt3p124Fiwsgex/kIpgHbsUOKNW8eyCvjLjezdNfCVCCDw2F2z51jLp3+qMIK1
	jwi9bf4MvhPCfy621UQGOoskLK9K8tAOWDUNCyD4beg==
X-Gm-Gg: AY/fxX6AqzH1LlbkSnSH9rel8y45ciSyUxxI4q5PgiAj/BJGXh5OeyfemknXFHljYLo
	hmeL2cCKgSlwiwBXK8TUA2TvbfynklNmkd/p8AWjKf5gNq/tBiJYvfi3a+VmXpPw8mztcaBplcA
	8HDNYAizLcRFhDewwVosRZ7QfgEP0QqdmLIhWQxHFESQ153SjjUIvORlIY/AmxS1D+0FOHCgR4Y
	AuEWtR3OprFfNTmtt3ueAP+o5YE3DycViBxArLblQjbmvbUWd09fGCTp9nAGsR1hnO0Op7sGWXS
	spYeTcQ1WqnP1pZB7yo8YAAtXdH9
X-Google-Smtp-Source: AGHT+IHr11OMrBaPdT1PnT3XnhvTNAcWmdOypWcziomsI3n8WA7rdO+m+Lk5ybRQl5fjJZK8nlm51yx/ovfcCoVIG0c=
X-Received: by 2002:a05:6512:3d29:b0:59a:183c:4863 with SMTP id
 2adb3069b0e04-59b6ef028fbmr5936211e87.8.1768295365360; Tue, 13 Jan 2026
 01:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20251104112535.139450-1-marco.crivellari@suse.com> <20251104112535.139450-4-marco.crivellari@suse.com>
In-Reply-To: <20251104112535.139450-4-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 13 Jan 2026 10:09:13 +0100
X-Gm-Features: AZwV_Qjn0mD5DN6xmpvJWaXwgmzhnB6PONRCrummysbqFjVMRIxJRgEh6K_F68M
Message-ID: <CAAofZF4beBFQ41Au3H1n=rRpE9hyPvfm4DR4OoLQ1wv5vHPBkg@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvmet-fc: add WQ_PERCPU to alloc_workqueue users
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_010928_682228_32F356D6 
X-CRM114-Status: GOOD (  11.27  )
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

On Tue, Nov 4, 2025 at 12:25=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
>  drivers/nvme/target/fc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 7d84527d5a43..ac730f2e6ea1 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c

Hi,

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer

