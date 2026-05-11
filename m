Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B3BCD4840
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=le0c1fCb+REYUwgpPDarzYR0H6UKAktV+aCiR8K2SNk=; b=XzRGWXQQZeZi/nXVZNg/CykAxa
	HKOpY882SU7qp1Sn4n1ohDQ700G+eoJIbsy73loqcAlVMsZW1pb4e9Y72BFdk7bBDD3AOvcwQvaqJ
	B6JXANwxlSbg2/6xiT/oWhK0kqagnFvus0eVCnSTgz3VHM2Pb1Kxh6EFb+h1n4S3Yu8ipuqYWs/EF
	5ckRawKiymDOuKAsVWL/rwKuCJguas9plJeCJj/jLpmZyC5wcK/3rIYzU2KZwtzeffdVgZc0fPuy9
	KvaCOW3cy2WaieIRpIUhrMe0sHg+65Bi5ehWfIP1qPvlJbjk86VnxF83sPScbXMAllhGnSVSt8t4m
	++z8Ig9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMW61-0000000EaPS-3XyA;
	Mon, 11 May 2026 19:15:17 +0000
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMW5y-0000000EaP2-3kNd
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 19:15:16 +0000
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-6314cc192a4so897759137.0
        for <linux-nvme@lists.infradead.org>; Mon, 11 May 2026 12:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778526913; cv=none;
        d=google.com; s=arc-20240605;
        b=CPCes7eH7SPZg+fZZ9UOHpSg2FsWTZzbf5NejqnXwsOvSkgwPDZ9UiqYQdMZwmGbE5
         l4rxMxSGpJ06gAr8cYZ4q14IjQxXe6CJf10nMJaW9Fbn3Y9y6AVrYjhkvafsX2N6NLXQ
         wM60H9GgvzRpu/ytksmS/pwOgi4SWgaShGjGtWGbHUWh23ynz67uSswlw+j+IQIV3eIc
         jqnLrrmNLWRl9D0kfsu3mswCVDqa7+heQLfhB0CQeIj4u6CWPtglXPAIpN2HaY68pnKq
         fMy536YY2sa6UMzbjUWq/S+IJ9L5jDVDCVWO7zL6u23DrtaYZ8jBM9F22Rp/FRbuLDnK
         5UNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=le0c1fCb+REYUwgpPDarzYR0H6UKAktV+aCiR8K2SNk=;
        fh=juzThKr/jptU/AxveZA+7rzPuMqwfocM7LH5/gDN0Q4=;
        b=cLXQ2E1wI6F1uK+pYJOPn0yUJr5ORIhjo916Y3MZCVJupGUrmoESwKVOOxdJaCjzWE
         vQp1txKN3L3Q3vrvglICAGHqVarsLawu3r7GjflHo1VquTsKFstBcQ+X+nCZcgRz32mL
         4PcQKn56LcmV+8+J7597Ooun8TT21Pg5oFzexyAr7NFqbU5tq4YiCXwjs6j447BR6V3V
         dWN+TxcQoX5wR3jXGYXG37qJorkaWlgxGsU/RZnixSONe3msvtn2Tj//Fk5N4s70GZ28
         f84Y38wC5ho7TluPG+vcXyo3PPdzy48nQJyIvBI2eMhxJIDRl1TlBFUe1T1UrA+RVtIz
         Cc1A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778526913; x=1779131713; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=le0c1fCb+REYUwgpPDarzYR0H6UKAktV+aCiR8K2SNk=;
        b=GWoeZWFeOQa4qiMtZA+3dr7OXhkGCS3gWJxAtSrhqfs+bZPWPGn+crn7i/OQXdlxz9
         uIy+1fvJr3gYnFj/E+zFt804AsCSa8QdvKwNLwjm+jBjBxLDmdRrJoQpQF+K8y/I/pLe
         wx+JBDiH7r/S/rLc5lFwYBa81zZ4X64ak9wh/RK2+n9TLsKwbqX6aMQeQJ0k+lYyWUD1
         2o2l82ywvY+DsMNa+Vy95qZGWLw8izJl0BBT1E3KrhItlljL86S7v1x0X9KQA0i9qcSI
         pPugJj3NOl6N1iwz1qiUuPuyeoKByyOG+upO2+ZeYhGeE0BRiAPD1ifBOabUtHsTCZTa
         Y5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778526913; x=1779131713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=le0c1fCb+REYUwgpPDarzYR0H6UKAktV+aCiR8K2SNk=;
        b=ILFx5IVjLw4z00kEIhSDMGw2lCK8I6lPMueKMVxUZOrGPFhtx9wzME/tub8aLNcNFK
         fKv2tQR/lUVTimf/3g+CZIEHrF96cehmxMl3oUzhtrPohe5jYAkXVh7YVze0MVnIIj02
         Qcni5tnLsy9vw4bVqJEkPD0UZa7upZJCxTtzh9UmJ2qIetvd+85qwuVJDmMO2s58myrG
         zL57LndWb1NlIpXuWrw4PHY7ZRC+sttc6H3h1ffbD9qekibqscFHHxCNaxmPrfLZL6dj
         Bf2WZ2LDOfXzcn8fumG3ZFCZe/6mTuw29ImK8O56EDBq0u/VPFMEWxYOcqCzhM08TbWX
         8UaA==
X-Forwarded-Encrypted: i=1; AFNElJ98TZO1HqesoJvg/jlYW95kZim+pGXfQoaOyOPl4UzotIT45vf2cgdQbqj/eIA0QJ+TLRWW+09UtZ/l@lists.infradead.org
X-Gm-Message-State: AOJu0YxVI+P7VnYBpagOTymdNm+c3mTvzYmObO+BbFxiMqtSUnns/Ci8
	D8+0C1pz23usD/LKkWUUvF4xQwxyuwlGZWqd+WDMLd7ccKoGHiCCA5P7rS46D6bzcTRIy/b9rXC
	hbin5+V9MdDISHybcfnyWN5IDLufiiLwT6Fdb3aXoAg==
X-Gm-Gg: Acq92OGuIWsp72fcUWGMm2hQQNN72FYEUBW9dP+RrMs+/q9USN7gsv+pi4QpqAnUTpO
	Pxn4yBXfGFcQqABF4tb2Ut6A3GQ2TmRDn3QAuK6PvvCfYz700xxT4D7qexX9BEyNK0rk1EWK3sc
	LUK6wuZWgAQIxENEw3f725uNwkc5/B+gLqdGYyMwZv1J4h0H7Q3HJd7rzbJlUb3HlwfAykN9m7D
	fxfUMM0IhuGanutVfYF82DkncEyhbSi0ZQ4DCtNL8G5WFMfLHgjnjJywFWgE07MMjylMALKBm2B
	uH9G1nZL0TP9XTsJYJW7EgKm+7wHJBAT0pS2yWGb6DNoUKQLMqupLK3PtzOXCUPJT6ioeRAropl
	P5cII
X-Received: by 2002:a05:6102:6447:b0:631:81d6:e15b with SMTP id
 ada2fe7eead31-63181d6ee2emr5490829137.29.1778526912965; Mon, 11 May 2026
 12:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260430232913.129271-1-randyj@purestorage.com> <63cf777c-2b40-439c-842d-33477f7602ec@grimberg.me>
In-Reply-To: <63cf777c-2b40-439c-842d-33477f7602ec@grimberg.me>
From: Randy Jennings <randyj@purestorage.com>
Date: Mon, 11 May 2026 12:14:39 -0700
X-Gm-Features: AVHnY4KKpi_5BMDm55y09JnPWZUcaFDKgdEDhGoFpBosRLWO-fXcPBqoYodGRLE
Message-ID: <CAPpK+O2T3vYoMWN2U0j8BG4Sn_se_k2ywWRotbaA=y7wHc0gmg@mail.gmail.com>
Subject: Re: [PATCH 0/7] NOT FOR MERGE nvmet code to exercise CCR/CQT
To: Sagi Grimberg <sagi@grimberg.me>
Cc: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org, 
	cleech@redhat.com, mkhalfella@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_121514_976142_0E0EA33A 
X-CRM114-Status: UNSURE (   6.81  )
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

No.  this was only to show what testing was reported for this presentation:
https://lore.kernel.org/linux-nvme/CAPpK+O03nHvHGESXsDDARz_kgbNkmeHmu-G3XWt=
o7CqHtyVedQ@mail.gmail.com/

On Sun, May 10, 2026 at 3:39=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
> Was another round of this patch set submitted randy?

