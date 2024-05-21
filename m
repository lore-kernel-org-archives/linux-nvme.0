Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5431BC25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 16:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N9Kg/pf8gYSS0qulg1Vt1ueNfM10M5TXHTQ8MBNrIoQ=; b=EtUBgzqlMf3zmtLfXAUU0p07my
	ikAD0wTIRJPVz1BnksBBhe2+qHODYxZGYmvNeizN2ul1yqH9RAGPy41ZsePSayn0BccbQwSsxzE56
	oxN7fOE8rgaxW5QHKxKkVWPMsu0v+w5HHYy3ltYVYmZnM6VDb3R/twW0aorWLmgBmN+AwNR2nzeHt
	ekWL3MgSal/M0t1yHFRNEE6wUqN8KN4xNShrbkILQgMKnFcR4szpiU2x4T3a0iPQq2/pZVW/Oz3Al
	flc16lDVcwsGxUSbIa0FrBr4EszLGQrJEiGgo46pIrYnBWS1SGpcnqLwqxflsj9Q68uy/c8klunG2
	TAYc9nLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9STI-00000000WNe-3fuu;
	Tue, 21 May 2024 16:36:16 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9STF-00000000WL5-0dpC
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 16:36:14 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2b432be5cc9so527987a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1716309371; x=1716914171; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9Kg/pf8gYSS0qulg1Vt1ueNfM10M5TXHTQ8MBNrIoQ=;
        b=M7+Ju6h9oqvL+Awquvz1hdK8ZyC+oHdOCMwkYSWUY3bRm54S85UzxNjlNA0L5dQ3HB
         6HOn+hZBAuPGA+PEKtM/6P0xkhPlRuc0L6HmgQVRygzfUZMU9x9ZUIlrCVreoeeZ48S5
         ztOgOXw98IIF3xQhtIdxvrfhYQJhXSALHo7cFjwoqx60MgybeQa+1R9N7KKHK8IDhMBN
         4kcQdOfNF7I45OvoHfi7R3FpGbgglMqsGp+41aTZ3L7NvMgqtbJTt8Pfv4ANIvUTrY6O
         1oSkk2r8h39kE1i44u/mec2NFjOEYwk4PfjKOcEhXuYnuzbMq9bZ969EgDeTrl0l0IgI
         lZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716309371; x=1716914171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9Kg/pf8gYSS0qulg1Vt1ueNfM10M5TXHTQ8MBNrIoQ=;
        b=m3nELPj2Y/RC96bMh2InJYhYrNfSbP/XJ/RHYn841Ht66e5ANPCTTPHGePmcMKJovx
         rkw1Ed8a3Ktb5uqZRBcZhGqOsyvbpzXwl+LfIJz5f0Pwp8QpLpeIdce425NwvVTqDTMx
         AiplRFWHDg7lXddzDwYjHGcDnN6r2mo/PDnwg7QuupFq875/KAhm+GlEMpABOq/cOZZZ
         gQNkG2uouDsUldsPpd0o70mT6cQ2sElJBpizliL3HedS3ZqZHqmVOmBTWW56JqvMgFM7
         /9jWiksgFU2MriSns+kbhNuv+D3gp8ZEMCyBJN2iwT0ALLu8vdZ1miBHVrtKgS0la0kV
         dLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFVZwLpxHRw9B0r+TnCcnpid0AdRYlktOkYpyW+Aw0iJUyQZJlruyFVtIwvk0dLsEgdq3t+p2li8TWthT0Z9B3dR1MVd4BXmetzDQ6uuE=
X-Gm-Message-State: AOJu0Yzej3AbRPLV8JU9NXD6oMfEu3afWMdwx1jws7p9n1iuf1G8p2BE
	+V9kp4laRUe2mRcUetBQ2khZbBKwKYtxhYCuue2Ya17rg3d03UGpa/oMlJM1psC9j8por/erkI6
	hO3iwEqgtxiLAJdDRpGRKdw3EliYren6SGojSbg==
X-Google-Smtp-Source: AGHT+IEMRQf8n5hn5cwPOiLQmIwQ4FziPw3Hoz6DOA70lGfEPA68bFBNlgXxaaLUwATjW/Cx/n5mTBBy05z2xfdJbrE=
X-Received: by 2002:a17:90a:e7ce:b0:2bd:820b:7863 with SMTP id
 98e67ed59e1d1-2bd820b7aa8mr5509290a91.18.1716309370797; Tue, 21 May 2024
 09:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240520202045.427110-1-jmeneghi@redhat.com> <20240520202045.427110-2-jmeneghi@redhat.com>
 <f808fa46-e7c7-48e6-8c80-3d28efd0afec@suse.de> <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
In-Reply-To: <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
From: Caleb Sander <csander@purestorage.com>
Date: Tue, 21 May 2024 09:35:58 -0700
Message-ID: <CADUfDZrTjDUsu1eEXkmEsSGCXn5=y_KnLnFcz-NbO1DF+BEKBg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy "queue-depth"
To: John Meneghini <jmeneghi@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	emilne@redhat.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, jrani@purestorage.com, randyj@purestorage.com, 
	hare@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_093613_259294_FA0FCA8E 
X-CRM114-Status: UNSURE (   9.56  )
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

On Tue, May 21, 2024 at 8:03=E2=80=AFAM John Meneghini <jmeneghi@redhat.com=
> wrote:
>
> On 5/21/24 02:46, Hannes Reinecke wrote:
> > On 5/20/24 22:20, John Meneghini wrote:
> >> From: "Ewan D. Milne" <emilne@redhat.com>
> >>
> ...
> >> Tested-by: Marco Patalano <mpatalan@redhat.com>
> >> Reviewed-by: Randy Jennings <randyj@redhat.com>
>
> I need to fix this. Randy doesn't have a redhat.com email address... Cut =
an paste error :-(
>
> >> Tested-by: Jyoti Rani <jani@purestorage.com>
> >>

Should be "jrani" instead of "jani" here also.

Thanks,
Caleb

