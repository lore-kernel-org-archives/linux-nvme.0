Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BCBC53219
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 07:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=usrfVYHsOydTgFDHdwjdurPUbbzlE2oAC72hFVI74H4=; b=ikFwJrH1esMUQlpdnqOcuozMLs
	bnPMFA7NclWzvL4VBpepa/JIvGZ5TJjHLi6vZHF9QT8JT5PdoT3wcMFsuAkcVb5JXfu8q8NcEyDxN
	qnfuWKbrzCpxnO5ZJ8IFmEeBDT2JjRV70pH87oFxgVHhKRpvZf0hYuRjQs7/dLhoXaAZnOJIUKT5B
	nUKO5wkq73bgCc50KOzhZnoO/c5u52yc2vdgwzsGAGrw/jRIyXlk6AwwFitd8o0pUMDgy8Tvs56cB
	pnByYEJT8dMWNI/xwyvyO+k6ybRnNSa5KMf+1IV2OaBegexSvL8SPKa7ZFigKlDgU1I0iuipqOY/j
	HUqpHQGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woz8k-00000007Aqx-0jvZ;
	Wed, 29 Jul 2026 07:55:46 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woz8g-00000007Aqd-3PGQ
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 07:55:44 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so908466a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 00:55:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785311740; cv=none;
        d=google.com; s=arc-20260327;
        b=P6+KWOXIcVXOnVA0CkQmhBT+KQc0EzBC11z7PXroxvOMQIlIJSKuEIGUZDHOqSvJEb
         7aWsTSiuy5xsTnH8L9kVZiKKayhVJCErEqVY9+0HEjGtVJgecAPeylKakSiaKVmQ7Cm9
         EC7D1eNjwGfIoRo77SU1/VCzxH/14kcCF0nvjJ+dtNrMTTs/zFP7v/rFDrDeLKGJDY3w
         sgcYRIUaVnRrav1jffetk0vFGahwlvCR7A+4q8p1w0Mx17WWm8YL4pOfKkWZLAAKdtiV
         3VuRI3JHsZbEG+60LRuD8tgPr53zcNJkq6tCD/6wsXlCOz2GnT6R5gWRIz2K3TWpEgzh
         vv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=usrfVYHsOydTgFDHdwjdurPUbbzlE2oAC72hFVI74H4=;
        fh=8l7efM5a+N8DKRODn0ACrlF4oo+TCxdbd+CZVkF9X5I=;
        b=e9hzvcefod2jEQssKhftV/f51Z7fzhG51lMoqj9q8wXRTwRoI/M65IqTLOlDlbn8b7
         ILKq0gbvMkEVwqXyFDgShy3Zwoiou4px932YAsDg0IlSL9rNTM9oqPp3upx/k0Db/klH
         docrbKi+LRjXNolDZ9p4wU7uibpkY3U3u25HmASBxcOAkK1SPBed8mpdLGhhiul0pI0q
         0nHyUrqckvdzo46Oj2wzk4VdNUlNwzEgHvjeZOZGnObdfgGl2x/gRkgN5WKVwbUqYVUA
         8229Rd+1bhqpN0sp02hjFweIBlxhnsrgfjrzrDq56N6t772xMAuJvdfgOmGEOqABQugE
         lyTQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311740; x=1785916540; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=usrfVYHsOydTgFDHdwjdurPUbbzlE2oAC72hFVI74H4=;
        b=Ab7r6hq403abBJioprw1WrBOtiAThhbwyOKFinWB7TzjogPy4J5E8P1BbkgLATco2V
         IGgXNlZXlD4tCV/GDW2rWRc+DZIGKAV2BlUTSlHjSEIVxsvyQD5t2SGdlo1lnv4Qo+so
         IzJpH+oN/KX7eKe23RfeqJ6rKF1v+BL/jAHAu4cynFj+wDg4IJA8fe0gu0oN99CFS4Eh
         OcsQVs2KFPqmeAW1tWtnkYxAAGdIAJgLMYldNQsLfTSjOnWIyeVdlsb3jx7jJygj/9Cr
         Dq7INL/Lx70DMnN9D40M6QbXbViqYgI/oOq1uLnArb4TAhJGpw9xfPnxsde35hBHRG60
         r1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311740; x=1785916540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=usrfVYHsOydTgFDHdwjdurPUbbzlE2oAC72hFVI74H4=;
        b=jtgA0cuGeto2dIHn7Zplvqo5m71tbOIApdrluOfFkRXo3D+kK+xC7WfvSToKgf5JOU
         hVm9wTErRKyDEuHE0iIPfh67U7Kj5vlp7+HNxvNvvxNhWzAR1tRr9aUd+nnnA9CJwcYP
         I2whnLiQ3KYml/3rcLbnxre/EfiA9SUg3GyBexTnbVUk7135feKQBH4Woorig3gBDrsN
         KrffdlptDcf50m/oXhv7x7sVAB4N3GEyEBuKE7gYg/1tgM6sQS+Rji9o4EzQpQxt9dCq
         z9mOFRBHSaOeCgW5pUNBWA0B3WIRulYvXXgiL0PbNkg+8jJSWuTrp9ozMzuhv/wvAfxS
         hZkA==
X-Forwarded-Encrypted: i=1; AHgh+RocElY1AqPOb9Qv6IbTbAifYGQd0szWy0RJBVP3nKsWfuaEfKJfTcex62CjoWNGT9b9CfIdvRMqJ+98@lists.infradead.org
X-Gm-Message-State: AOJu0YydOgYwRA1h18nHw/trjyJADC6B3bXnHytIqvMj4mIIPsJa0Fku
	Yw4aHwPrTE65EnsfNemESb3PZR2cbEpqMODcw4POv9Ot4ztomzN2XxrzU7CrvPyNlqr+Y4CYCxW
	rgEoiCgr/LtuZ71De5HaXe3evpaBtXV4=
X-Gm-Gg: AR+sD11nMo3nQ9d0nl5yCve/DpMucUpyeJ/iEJQGM3qZ5xLTPN0en6HsizL+0ZB73Km
	DrqnEF3WiyL5Qnns0KlTEz2HdYEIO4hKvbH5A4fwwydeY9EVISzkKb7a6/Chdyc/cfcRG64uyy/
	ghgvps6vXzJaJHMD5ve56jtimmVI3bp3jfrd6cA23A/kHl3JI0GznIH3YtPfssgsnh0KrMmiTjs
	zXxQEP8lfhWWhdB591Y3g9Y+HMBG+gRTeUQRI5qCLKzBLZ3VFIe/heajx+Yu8VZFsUYU1/O4Q0r
	DVbdoKnqFuAuLrZ2TkosSpJBL36zasvM8+IRFOCXHaARWI8O3YHCre4UiM/jeH3jGA+JPRNXQGS
	A
X-Received: by 2002:a05:6402:52c9:b0:69a:bba:a526 with SMTP id
 4fb4d7f45d1cf-6a034a737e8mr2702089a12.29.1785311740595; Wed, 29 Jul 2026
 00:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260727201257.211635-1-coshi036@gmail.com> <20260728042356.GA19874@lst.de>
In-Reply-To: <20260728042356.GA19874@lst.de>
From: Chris S <coshi036@gmail.com>
Date: Wed, 29 Jul 2026 03:55:28 -0400
X-Gm-Features: AUfX_myr7JpqXMkOy9tcHEjoMtEEuRi-rrvzumCtNMx_grG_fNvGn32KWtLiE5c
Message-ID: <CACd_6n12dp2E7URMaEFtD-GUkL9K6viDWjU6JRd7ozu81BPJ=w@mail.gmail.com>
Subject: Re: [PATCH] block: stop the timeout timer when releasing a never
 added disk
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Weidong Zhu <weizhu@fiu.edu>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_005542_875854_68AF3F33 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
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

Thank you!

Best,
Chao

On Tue, Jul 28, 2026 at 12:23=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

