Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDC6CD6E43
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3p5IabBvXdkXZ7+EGubMbHl6mikKS/LG8xMUC3eAH00=; b=jGdNZ6MSXtvDJR+69rWy950TsV
	m2WnWUKHnHJnq6uKlgDfLSQSh8QJSUs4ZyhXnEDk22X7kPiCcGbeWrTCpjv0jIT3ZwpymdEHHg9Lc
	ofral1Nu76H1SJl1hwoHxDYskcfHivq1vm9JaPaUtB7eBRl8MveiUZw28yEZ/wflujw6NPn+9OLeG
	c+MD6h9g5nkZYxbT0WInS4Xlik0cEqgTMuwFLe5CaGsZfxkht+BfSOIvAXx0rCC5QcL90whqnm4Dz
	p4228wL77n+3zPEKS5OqZ1J+Cmle1fM8YQpst4giL01gyiZEbXe6ewsh5/09+ZWIlss+X74zELmDJ
	ff0yQrGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJWLc-0000000ARav-3r3B;
	Thu, 13 Nov 2025 12:22:44 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJWLa-0000000ARZM-1b7n
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 12:22:43 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b72cbc24637so129626866b.0
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 04:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763036560; x=1763641360; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p5IabBvXdkXZ7+EGubMbHl6mikKS/LG8xMUC3eAH00=;
        b=HQlNWWjqTTDIEx5UM3hqaX37mVFckUResIkZtLRihqreuzQi35gPemu/9/iP3OfHP2
         FkZyfrs9COHyDD6wP2bqtFTeYvGs+4zWbkglDawGEpP/e6rc2S7wuD761nr/b7yh82il
         xzvPIejwwC0KQQlq4PX+ame/L4bxwpas5+M5//mx/KXEh+9/0VhFXmr75JgcYamgXLIj
         mSbACaENOoMAbxZWCzXmIgZIMhlL+NNnSnBHPR8iKEBnTBdmT8OcfuBtdNDGxe0gb1Rk
         l+35uUIZuv9/q1RsXBW9nPRuZhrfVVYnQk7ddhGMMSSocfuU+DKeNHTUnkaEuKMG1MTJ
         fMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763036560; x=1763641360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3p5IabBvXdkXZ7+EGubMbHl6mikKS/LG8xMUC3eAH00=;
        b=fjZR5p3MOioTF1j1FX55Bl9sl04FWCx9NMLRe/sLPYS3ZDqxKpFz0a1YEetG7M4Yac
         HmD/1wT0KVCNCR2HWhLI9Y+/Ml4zqwyRh92wGJtV9KMSCShKvwFCxqA7e7MNbNIQ9Qlg
         DYEjxeJue0pXhcwVGfiIoSKdty0uUDNl7Z8gP3kUWkeiVsbwIt25p9w3eXICKrbFymGb
         97bYDyS+hrnR9Fq7UQLRK/GntXqv1UP97XyXWJGaohHB/5dBz0mt1RXfQz9m+WINu9Fh
         dVISG1DQ/kE49nqWhLUR2BcjTulvDzPJKYeM4f4HnGoOBu0Xjqlw/qwgtY6hM9CSfEk7
         Pb0g==
X-Forwarded-Encrypted: i=1; AJvYcCXW/uPnobVEvydg6L7Rv5BcELx1+2bUhiHdiHhtjK2nRtEOhM2h/MtyKCY7MI0iuLydBXjwkwvDOUII@lists.infradead.org
X-Gm-Message-State: AOJu0YzW2ww9ugqzlugmrplbFY5inwMnqzX3eAkzI+ihHaf+LfVZYHTj
	8TOTWFujcmOduPxGPnuF0LDRL/Yxb4MXUpKp5DTRsrmLG68nf9aWUC2zPFl4I+FxlWpOZ4pl3IH
	VgAPHOLPNvYfx8Cs5TnJ4Q34q3hMbCTo=
X-Gm-Gg: ASbGncteXXwHJ/rMiKdwkq4uj4IhWGaRrJSJJtou3ORsNIKkEm12UErRkZ9Fzf0pFk4
	kQSja2hBNwiDmA526omTJNHDcfFcutetysoETURFVsAiKh5b1Hhxvdhj/CSMsxiqcZWE0lemTxE
	541OlIuBFv7meWJYLmd8FYUHu+vEvPdsk6/mvJQB9BAxytSEKs1Y8EosMZg4cDs1d06ba0+wm/c
	IXeShxI0MAjpOER3o+egYlMgiDVHrdMLSFsNt2FYXUgrZQoMhd6SnMqwxLeZ/u4FlNhfUl8W+tL
	ebl4Ht0oBI5zA9NbhVMh7QWHwQ==
X-Google-Smtp-Source: AGHT+IHajWmOUi5tVirqZttadrxPuDW8EgmHs+9YBUIXUMLLZEAk7AvCdaI53LFV6WjAMP90FcJnMv5O+DsAooIz/88=
X-Received: by 2002:a17:907:3f23:b0:b42:f820:b7c with SMTP id
 a640c23a62f3a-b7331a6c6d3mr650622166b.41.1763036560109; Thu, 13 Nov 2025
 04:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-4-alistair.francis@wdc.com> <caadfcbb-8964-4447-a93d-8e49b4c14c7e@suse.de>
 <CAKmqyKNzi7OAq49b-aa1H8++ReTvWnHKBDwA88ionJshhOVp9g@mail.gmail.com> <2019e372-c079-4230-97ba-a3299ced0474@suse.de>
In-Reply-To: <2019e372-c079-4230-97ba-a3299ced0474@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 22:22:13 +1000
X-Gm-Features: AWmQ_bmAssFXEqhTauCGTaWw-0uu2B0mXfE1GiVBD99ZnIinb6qgcFh4JAAHSvY
Message-ID: <CAKmqyKOBr2eV6AeWH6SHz_UX4ciKgdf3zGJ9LMHEOuFz55kO+A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] nvme: Expose the tls_configured sysfs for secure
 concat connections
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_042242_454313_D401ABB5 
X-CRM114-Status: GOOD (  29.07  )
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

On Thu, Nov 13, 2025 at 5:21=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 11/13/25 03:08, Alistair Francis wrote:
> > On Wed, Nov 12, 2025 at 5:08=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 11/12/25 00:45, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> >>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >>> ---
> >>> v2:
> >>>    - New patch
> >>>
> >>>    drivers/nvme/host/sysfs.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> >>> index 29430949ce2f..6d10e12136d0 100644
> >>> --- a/drivers/nvme/host/sysfs.c
> >>> +++ b/drivers/nvme/host/sysfs.c
> >>> @@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct =
kobject *kobj,
> >>>            !ctrl->opts->tls && !ctrl->opts->concat)
> >>>                return 0;
> >>>        if (a =3D=3D &dev_attr_tls_configured_key.attr &&
> >>> -         (!ctrl->opts->tls_key || ctrl->opts->concat))
> >>> +         !ctrl->opts->concat)
> >>>                return 0;
> >>>        if (a =3D=3D &dev_attr_tls_keyring.attr &&
> >>>            !ctrl->opts->keyring)
> >>
> >> ??
> >>
> >> How can you have a configured TLS Key for secure concatenation?
> >
> > I'm not sure I follow
> >
> > `ctrl->opts->tls_key` is directly set at the end of the
> > `nvme_auth_secure_concat()` function, so it will be set for secure
> > concatenation.
> >
> Right, sorry. Of course you are right.
>
> But I'm still a bit unsure about the interface here; just writing
> anything into it doesn't feel like the correct way of doing it.

I'm happy to change that.

I was thinking a bool, so basically write 1 to trigger

>
> I would rather modify the interface to allow a key serial number (or 0).
> That would allow us to modify the configured key, which currently is
> fixed for the lifetime of the connection.

Wouldn't a configured key (`tls_key`) be changed via the tlshd
interface, not writing a key serial to sysfs?

> And writing '0' would reset the configured key, reverting to automatic
> key selection.
> Having such an interface would actually be beneficial, as it would
> remove some limitations from the current interface.

Anyway, I'm not sure your vision conflicts with allowing "write 1 to
`tls_configured_key` to trigger a REPLACETLSPSK"

Alistair

>
> Hmm?
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

