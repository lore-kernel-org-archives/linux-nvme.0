Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2D1FD9E0A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 21:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TXXixwQEw5022DrSGPNE/sS67V/HSDoFrZQpE8y+vJw=; b=kZgKuExxMHt3+Exo7Fa6VxpJfb
	Lio2Lwd7RUu8iqTj7SLA5fuAC4zXyJrISJRzZt+fZI1fHYFEBaMml2szkL1SA0bSaBuP1SUQUXIpW
	IyMAs5btf0F28uwcEkLUGTD10J35NspZBeqh+4iZ1bqLafCDIYMz/mg8wWhw17HWiyi35LUG95RXk
	rWPi4bAUOrtV3txh1RDELl/wHPbhdmFchrEkSoP3oM+pFoZqDq0l4ij+xlqZdYxm7hGctGQaVBobX
	fpmIxUdjgLKVHyTbePJdV/PKKg5V1eGjTBjCwPS2NUcwa6RLSAFD2MgadjlAxYitYIJwh7JwDY0xD
	EwWVkqdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vviYu-00000007CJT-0iYF;
	Thu, 26 Feb 2026 21:06:20 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vviYq-00000007CIh-3sKt
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 21:06:18 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-b936ba512fcso9705166b.3
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 13:06:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772139975; cv=none;
        d=google.com; s=arc-20240605;
        b=dENdGFDQZKi6owu/dXRITE61Ni1Xo/ZgUxN1uBDXH8PUCZvuAawQ0cfMwwqZ9csqOb
         l8z21i8vWk9sxHV+Jb1mnsNqJ10W5JSOCTOR5glrPGuEoqFrf4ucze5aczSXhLG4SJ4e
         r0gbuMTXqPEYCGxVQweHFBP0QvOTVGLcYx0lpw5yaVeBTk7RsqCUEiOECMnanruPAhHO
         fjBDJ9+Nj4xxQyCTpyae3hJkObcsjKkq68u5dZXbdkFgxclfnSrIsqVkQcVegcP4B1mk
         Vh5125jnwald91BYdWU6gaeJkgm8hYdLf3xl8/JX6VBi7rhg5CMiOuIAHtDf9SlDTiYc
         6YmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TXXixwQEw5022DrSGPNE/sS67V/HSDoFrZQpE8y+vJw=;
        fh=ClUn0TpVaJamvFA9py1GKx+nS1hzOzmjik1Xna2A2GI=;
        b=fhZ5WFohEx+extFD34wZ4q+V50JUwZnzygma4Wo2inPb9Qyykf3nTq8xz+gw5/AcuP
         A1SDKFa025oltOdxtVgqk9w5cJzS7JNKKrEBfdGzDiQkwKbiMXKfCbJ1f4NEH26NH28u
         Glf/juZKTTAstUnR9IVbB7n5iSUtjY6hZktiJX586bb9ycVbh7Tpj8KOFGVVSDhxY9Jb
         +z0rxm0Eo5iOR89bpkc4YGGGggCtS1Dkx5UhHjIIB7YWaYE2oGTVmb4fWSBnDfyii9Ar
         Z8kEwjTr+plQBU73OjUTduQ6U1LUHyLnu+wmO8OVeWifGaUbIyz5BH7+WOSWUaaV2VMn
         TROA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772139975; x=1772744775; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXXixwQEw5022DrSGPNE/sS67V/HSDoFrZQpE8y+vJw=;
        b=Q/lXjzds+WpqHVIUp0ZzgvagOaEctu0NFURNrF+CRtIw6ZWR+wOzQzWjoxUg0dm0w1
         3IMKwI4xVnNYW4I2h3UQuQK+SmCi0R03DNZqxzFUxfle49LqyFSto6xXJMJ7esd8K7KV
         0hTTJ4QTV+gFi2XCOq6NzuG9NTDvvrSBOYJCX26HbONqHo47EzAOFAZcMx2Low+VTizj
         3T7A66msSu9p/YPZnW49fgi/yN59W2b3RdqBplWxBaHmtCy55dfe4zsTkSA8r1irmsWv
         E9ghqVTYr+wvD/kgOrmeC5+nN556l5CMNijhuxNTOTgh2YGYZSph9SLCemBykRU4XVFG
         GIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772139975; x=1772744775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TXXixwQEw5022DrSGPNE/sS67V/HSDoFrZQpE8y+vJw=;
        b=n21pt1z097Ojj3VP8kQAlOoU5sRhkX8FWmBSTlV7leRkQwhYIFURtu/eU8Z+c/cquI
         +L0FnEVXfKU7703K0ED1UsF6IeRkl/0+M/18jNS3kmOz3udyRR/pdk7aQ5JS0SKAQuI7
         +CiyJSBIVDozL/SrNvjCuPtDgnprf1Wr72iv+fTsdB8IQb/Stdv9i9aHPsUXwUhKDxfy
         ZBKhOotISB2VaUKsM6ncNuGqJ1AmgdI3wLH0gHsLUgW0ua6wtInIm+tYW5lfxf9+ANEH
         DxDOPJptjS24i+7TC5QQwZS8NGwlJviibU5NHL6wi1k4742Xz5q9R4SSBUtd9alNJV59
         5vPw==
X-Forwarded-Encrypted: i=1; AJvYcCXm2qeHyC0WXuArSqQH4kKA/tWWQlBuGA/274QnqZCwYiCHcPZveZTQ2G+S5ij0XGEX0Z3zcievnUyO@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6d5q/UPpi3xr2yOV67Od8dlIAoDeDvCvWCO/c4bb1Tv6oOAQd
	AIkZw3U4VOWcc4l3dsyTcGGjMMelSaUvZSD3fKrFKsncU3zuH8SvRi8d+grpHdC81ZMulbr25TS
	w0UHWOxuLbeifdEF8A920nL7zom2jhi0WjI8wWh8chg==
X-Gm-Gg: ATEYQzzgnffX51J7Yr0km6SlB7pgP/fAqHtOiaVfY6d/88h/I5rPtH25seQrP8wRRu3
	+er8MI+7oJ33Wiy2vKY45MiuxRRMM0pGygOaTbfJsDI+TtIp/EEJq1OT07nfsOo0aJTnkSO3PH6
	P6Tu+0UfWxkdkg41K1ldBmupv4o5QW9vno7yGDbVMUVyMmrNDucnmQ5mAh0XMddEphKoTEI7eHf
	1a5hUMDen0xhoOncE9RAsb/z+Qbu3Jy9o0gHsTA1xrpXjgPBjvUO4VDeZaSANW/oNv850wEqbpO
	yjuW9SM=
X-Received: by 2002:a17:906:c150:b0:b88:5fe8:b75 with SMTP id
 a640c23a62f3a-b9376550688mr12154066b.6.1772139974850; Thu, 26 Feb 2026
 13:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20260226190416.297725-1-csander@purestorage.com>
 <20260226190416.297725-5-csander@purestorage.com> <aaC0-mfU4Q4im-yW@kbusch-mbp>
In-Reply-To: <aaC0-mfU4Q4im-yW@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 26 Feb 2026 13:06:03 -0800
X-Gm-Features: AaiRm52VQO7vpWVqz9H8eRKaxZZ9j_x-rv8nZL54WmQcTe_HfVBWJYAmwIhH9pU
Message-ID: <CADUfDZoJR_pz0aqyqZzaNozdVjmks3Ojiw=tFUukJAfYROtt5g@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] nvme: always issue I/O Command Set specific
 Identify Namespace
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_130617_012520_BF00B17A 
X-CRM114-Status: GOOD (  12.22  )
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

On Thu, Feb 26, 2026 at 1:02=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Thu, Feb 26, 2026 at 12:04:11PM -0700, Caleb Sander Mateos wrote:
> > -     if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
> > -             ret =3D nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
> > -             if (ret < 0)
> > -                     goto out;
> > -     }
> > +     ret =3D nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
> > +     if (ret < 0)
> > +             goto out;
>
> I don't think we can do this identify unconditionally. The controller
> has to at least pass nvme_id_cns_ok().

Good point.

Thanks,
Caleb

