Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A54C25B67
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 07:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZPoKy/32kD9TK86P4LFHbN697d0ba1K8lTZLC735wI=; b=av9Wh7sf+cBybVejvStCOmttUd
	F3JjgVQqSYczQLrjN+tK9qbBQ6QhCGz/ZiCBhKqfrIInGzk/x+ubdudRHqVnPSmaxJgdmA8Bsm03F
	raYb8f+RGLCEQPa9OjWv7NIGOrL6jBkYeYfJ9WUgZLPM8bG6v1VK3bxIdfFRwbOA5lNgXnwP4ua1W
	9oZzYpmWARzdPpyMZxqolrDrLhEsGZSxSenwjACeFtEMNnIHjhe5UTiy9IrqqetrRx3PeuN4qQq7W
	/Jk0QVfcXJ7FmbYx7dTgCgQxR3JqKfhFbO3C7fkZRNyIKG6BbKRzFTvmnwnPvv/WqSzYwSOGUkpDW
	1Bq6cYXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwGyg-00Fk6l-1h;
	Fri, 27 Oct 2023 07:09:54 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwGyd-00Fk67-2M
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 07:09:53 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32ddfb38c02so1198173f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 00:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698390589; x=1698995389; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZPoKy/32kD9TK86P4LFHbN697d0ba1K8lTZLC735wI=;
        b=Vb2UOXuJ7XDs3aCnlQeci+v5SylQENhW8phvV+ydh+HNz6b0EhaFX5avMPsmyHB+uB
         7sF5U0D2ouh83pNvndUqEx98LLacRZjdE09QJelL2aPc6hoAJzPsn0FZLP32DR5cIfXp
         D3FOC0kckGNGGV74mXdMS8uvzKeoS8YcXUd6M0W+PJh8KNsCD11D/tUiFWRpqcVt0dU5
         HJghcOBCjizduGGWbB0eF1HaeODW24BUz4ypNJ44B2g8tOjIy8qnH4jtSkhH0TprO0NS
         211sd8z/VLHzFU+TxZKfBil66HGz7aUa3t2Sg0ihpdb6cUHKDC44I70lSVQ9VRKMCpeV
         dSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698390589; x=1698995389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZPoKy/32kD9TK86P4LFHbN697d0ba1K8lTZLC735wI=;
        b=eYgNxybt+X2hSsNhvEVCkL50DPIKAws0XyFRRd4TMgqcNmM+7U2Bw/m9gT1Y+I1JW8
         xb6nkWiz3JrOl+eG4cE9fKWetD8+Fq9Tm+CARKi11KRftyhpqvrpmJ+/0gYym6mmbYs/
         fS/9lG1ib2PyQPQVHPcM+fRdYfI8ZUnz+LkwM/QJTxye1oCQugo9+wUNce2peE7O20d4
         dcuV1yWpSBR/62SjaCpFfmoL/9M51GY/iXmST6lOcgIn5o0uveJBvC5PjP4MWQall9L3
         H+yKxLCPKJBTt2GOg/vFN5+GqGhD9u7di3uEn8SXBATLgwJBHz2VdDKR3r5pDJOQz31T
         w8pQ==
X-Gm-Message-State: AOJu0Yxy9O75ugRYxlKuGjiryiIZcZnxBcjFShVvxqTEZe3AnuoZWdNl
	ZfvU548s91MvN9Hh2CNa8mygaUUNjcAgTmvXvc4=
X-Google-Smtp-Source: AGHT+IF01OB0Jby2mK/tN88u5K9Rlr0RZoeviolDpclBjhYuB5Lnu0XGEJoSIP1m0B5VdJ4ky9LA7tjpeDc3tnbjI20=
X-Received: by 2002:adf:e4c4:0:b0:32d:804c:15d1 with SMTP id
 v4-20020adfe4c4000000b0032d804c15d1mr1515310wrm.47.1698390589010; Fri, 27 Oct
 2023 00:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp>
 <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com> <20231013154708.GA17455@lst.de>
 <CA+1E3rKaUW0YN+bphe9n26ZRTX1rq6M0z7Hpc=zLOJE1AER9hw@mail.gmail.com>
 <20231016054647.GA26170@lst.de> <CA+1E3rKcN=bOw3613XWKm_NqPS=dGOz43g4zwwQG_pRQSWkH_w@mail.gmail.com>
 <ZTqA--6dDYJ76Gyk@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZTqA--6dDYJ76Gyk@kbusch-mbp.dhcp.thefacebook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 27 Oct 2023 12:39:22 +0530
Message-ID: <CA+1E3rJsb-8M_fE-PGrvAkzwHN6PLZPSYXJpZhRtn6hOipK8cA@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, vincentfu@gmail.com, ankit.kumar@samsung.com, 
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_000951_768257_C0F64233 
X-CRM114-Status: GOOD (  19.41  )
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

On Thu, Oct 26, 2023 at 8:38=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Thu, Oct 26, 2023 at 08:03:30PM +0530, Kanchan Joshi wrote:
> > On Mon, Oct 16, 2023 at 11:16=E2=80=AFAM Christoph Hellwig <hch@lst.de>=
 wrote:
> > >
> > > On Mon, Oct 16, 2023 at 12:49:45AM +0530, Kanchan Joshi wrote:
> > > > OTOH, this patch implemented a software-only way out. There are som=
e
> > > > checks, but someone (either SW or HW) has to do those to keep thing=
s
> > > > right.
> > >
> > > It only verifies it to the read/write family of commands by
> > > interpreting these commands.  It still leaves a wide hole for any
> > > other command.
> >
> > Can you please explain for what command do you see the hole? I am
> > trying to see if it is really impossible to fix this hole for good.
> >
> > We only need to check for specific io commands of the NVM/ZNS command
> > set that can do extra DMA.
>
> The spec defines a few commands that may use MPTR, but most of the
> possible opcodes that could use it are not defined in spec. You'd have
> to break forward compatibility through this interface for non-root users
> by limiting its use to only the known opcodes and reject everything
> else.

I see. Future commands. Looks like every solution involves non-root
users to face some form of inconvenience.

