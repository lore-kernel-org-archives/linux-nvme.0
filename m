Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995AAE9D80D
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2026 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KjBTWmM1cPjY49EOYiuerHROAqOXcRoYVzyzwcieuRs=; b=2nkVj4DUD/SjiCgQn0ApMXaiMU
	g3stLr4Is0ggA1CRstkyqXsDR/X676hdxqc6KINs9c/em45oiyJq+OLlDEY0Q+L2OiC39sYON0clC
	UAfUvGkzTTTZJFmz4Q09COpl3GDFT04k3gv+WJ40JLqLv4orI9gD5KW3mWsPr0UUKTQG3wIg1jLUw
	e/GXzRyWnpV65J0gsoMnH3FWtUCXSWApPEN2g7MeIJxipRvwRAeiw9+c8KB3nWZPmcEK0telrg8n9
	WvOlS5Vi9wyU8Q1ihDH7YcbHy+H+1E/DDBmngrwRg0j9cZU6I9kAg9KdWlSFmRoSv7rnnnFOUuO5p
	8EEbRV4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9TYP-00000004Rus-0EcR;
	Sun, 05 Apr 2026 19:54:41 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9TYM-00000004RuT-1PHH
	for linux-nvme@lists.infradead.org;
	Sun, 05 Apr 2026 19:54:39 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-43b983bb07eso1911438f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 05 Apr 2026 12:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775418876; cv=none;
        d=google.com; s=arc-20240605;
        b=K68pB3qFqAIbKjClqjGvCv+sbCqItu/BJ8nt59HhEU8WzSgXnxyJvxGHAd2kti478j
         Bu4xIzSVSFYRJBzfnpjo5rEAoxTm+OOvNrCDLv8jBnobPeYnC0u5DHQMPE0VSeU8Elc/
         +GcEEqzT3t/6at64dxPFRKb7ULmWxL5MHUe1ktarWdvqDT/f8cLu/JRsHs9lH8dLTtEX
         y0orISlyDED5T4QZTItCRET5Y+jPgb6EiM6gbfokFWz4XeZQ82RwxwDnA0aFvXIf+9d+
         vqo/2Y4Bwvc94kbfqh6/vdnDKJDe/fDfiuHJ+YQIEmi7vPcNszIDrxcwn7qzq1cdH+aJ
         y6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KjBTWmM1cPjY49EOYiuerHROAqOXcRoYVzyzwcieuRs=;
        fh=z6rBNCpeUpF7w0bRlIu80+6kDNOHAuIqGuQCJff2SKs=;
        b=lGqPsMUOhMHCXyyxDVIlL/Vp7Ia3L+q5TjnQFu+rDAPTEaQj9y48ldjehfWkqyttR5
         sGijjuSdB8UVqXfTDAWQsetCp1Qo9dYWeB61bM7wX/NLHhfJBgys+7828rnviUck1B8Y
         mEqSwj6Eai0nPFIbicMEtzwwFufoXJwiHOvss/XCYukLlMRed9ww3mA0Q6hRzkC3ZfFl
         UfVgTSOBt/3a6frM7ARdn1ZWVB1mBbqL6hGoc/3Soa8LiPQBHnozcFTElAs6Rs2c9lx9
         zg0RkYOZp+iPAoyOl3KZUjRc/+Zd1NJaCI6+S6DNvkzg0ejMvdaIEeNZJpvEkedfV12t
         cKAA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775418876; x=1776023676; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjBTWmM1cPjY49EOYiuerHROAqOXcRoYVzyzwcieuRs=;
        b=gcyoNvfuC5wAw8h35ZO/o0xqk4CO8X+V9r9vcr4BwVbk+HJ4WEzqVaSeg3KCuiS3Hj
         asGrLEL8gOySsCjIfFYQmBynd/UVmIWcTF1AG9+APRS665ENT9Iv7N/QcMKR6JPb812X
         ZdszFE6RUfitvoh7VDXHmVI3mJy/vJdB9PweJbTBBf8/lHgSXFxXL9xZf6/0Y3+1qZvI
         8/Ce7YWj2cgwpuQA7letTimyFaRx21tiMCqvmnUT6b/+1knwG0JXqDpGNN6DP82NXlxR
         QhTmPP83d0VTSvqjE8jkm0VAASomPXbQU5FmwAQXfEjOX9uILfkDUOY2DGOC3uVuFVwn
         FgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775418876; x=1776023676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KjBTWmM1cPjY49EOYiuerHROAqOXcRoYVzyzwcieuRs=;
        b=rMuKIh7sBvImxr4mBl9TkQfOrWc4DruOXjd/djkem/vnPYHbtwzLAN22DvhnwAjPfR
         kxvL/n/iTulMTum1aPZt/hEaCr+2idDgkv1PELfuCp74ZMBTTKTFMTO4fKd7ljcqGkWs
         L9eWZXRpFWR4kuyCeKHK7up2qKNTG9oujb7OM28DFO/hbN1ADQ8zU34TFMx6SJstWlnZ
         h4mAwoT72YwCmz5mL5EpiJ+2nzq5u5B7CnzSojbT+jvpcKNytjcRjohSdQWkf1qKE1KG
         nuDI8UOAZrB5IF9oe9aNrgFiXiOBdmYuio3O+od+j2Fkp8G2B1bYHDEjXtkUEip4NzcR
         eGZA==
X-Forwarded-Encrypted: i=1; AJvYcCV0ajFQ3zSlJ9wSVftBdddZCFI9Is/VHRRD9wMY4ZCKgXDe+eIJO8SEA1LuJLas1UwSi/H/qQ+gWNbs@lists.infradead.org
X-Gm-Message-State: AOJu0YxJy6Z5Va9FMQzG7oz2ssJdAMpxmYtH7N3vv7lT/1LTCteX29Gk
	WlJz+4TIUfjMZ7v/hTZpyl83XRCWJ0eTvToH6m5vTikQKEXaO5bO+JqbJilNi3U/8osoLgk6o35
	xIibkZWSi+/JFfnVHtKDUvHX3qa62280=
X-Gm-Gg: AeBDieua6jYXCBQFlvuSJJuebSNi2ICYIRDUg80/27rXwsOJUFG4lopTfWN3k2H3mpN
	N7r6F4Ql2UCLv0hVseu6HY1DxwM6fsDXRGFeAq7EH+zJUz6XFWWe8fLn7Pd+wbpKiSzigcqiUlo
	sJ2Hg3vdtKLN9TvOmZpT+FOpQoEqMzkBgt1pMejCVIc1ZW2dn7i0SGeIRKKoayx+Kck64J6dsbq
	tFg45ai7TunsjJQgjO83irt5gGLXfVFDoWIe25xBdfqz8O6Cjjh/AReddMX99IP+Uwcs47zwouh
	oRllBELB3Myoj53a
X-Received: by 2002:a05:6000:4010:b0:43d:1e97:d62e with SMTP id
 ffacd0b85a97d-43d292e4100mr16082357f8f.24.1775418876127; Sun, 05 Apr 2026
 12:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <2026031827-carving-overdrawn-5b1f@gregkh> <20260318225658.1760759-1-kumar.shivam43666@gmail.com>
 <20260320074652.GA14485@lst.de>
In-Reply-To: <20260320074652.GA14485@lst.de>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Sun, 5 Apr 2026 15:54:24 -0400
X-Gm-Features: AQROBzCwAsDtahFiwQ387gePW6uyvl7zAG8Jjv5p8qcdKy4RhGl7ks6GS6I1XLc
Message-ID: <CA+ysrS+Uht6pXJ3odiyGccZ7HrR+WvtrHexNkTB1Gvy=Uxw79w@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in
 digest error path
To: Christoph Hellwig <hch@lst.de>
Cc: gregkh@linuxfoundation.org, security@kernel.org, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_125438_402464_520DC486 
X-CRM114-Status: GOOD (  10.76  )
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

Hi all,

Just following up on this patch.
Please let me know if there are any concerns or if any changes are needed.

Thanks,
Shivam Kumar

On Fri, Mar 20, 2026 at 3:46=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Looks good to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Although I'd prefer if someone more familiar with the TCP code could
> also look over it.
>

