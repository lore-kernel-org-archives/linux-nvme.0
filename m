Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3F3C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LKfof6hym3RoRIHBYAszTdRtgchJ1su6/mBldx/DwFw=; b=cIx6V0XBjOVKrRgjd9m5/90haO
	2fHhImz6MEZPPJ5Bv54sXnBchwr15oDwrGmhnlB8OAsff6lt44MyZ7lDYO/neZgCUkSxisYtkwR6F
	BEsPd8vmW/NnSMTF/dV5I2X0Wo1yQZgxpKyvUyPNX1Fl/uYNJL1J4Gnouxx/muxVfcT0GvbGqO6uH
	WdOAfl2nrRlmQ3YcQ9c4V5YTRjIdgepHCJ/bLayS7oQTVCEfeI4sEBOORBKTVKw1Gq7qwxZyyTfOE
	ZUgd9gl8ihpzUifekS6+SXUapGhsjnaIZJDouIeUqPBeGyddX87UkofEwDL4Buz46qDEtgbAYLpkF
	1gTBeqbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGJMY-0032YR-1m;
	Thu, 21 Dec 2023 13:45:22 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGJMU-0032Tz-29
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 13:45:20 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28bd423fa08so366497a91.3
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 05:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1703166317; x=1703771117; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKfof6hym3RoRIHBYAszTdRtgchJ1su6/mBldx/DwFw=;
        b=I7eZmgBATVvL1D2syQfqNKwxoAvesb8GJJg2X1trlX/kY3UImENhX4ZyKENidfKdNS
         O0wgvTp4KUEI8q/SKjk6RCBSN7YR2x8a5/JJxHZU/8d48RwLhk/EZbez2S4I7jI8nGG4
         a5BS47tlch/kboQjzWItaFMxDmqcAi09fEBggKsQJEG1MDb/+YNt6ndRciu8zYoHeJ45
         xze111z6eHvgfb9lPzAnr8Ff5EazwmoaVQCTR15E1ofqGM60ltdqBa6djjZk6+ghAm6k
         iCLyrfYIwLQ4TGpaT19oFQvI5L0KFFEsqtqM4No5xLhsYe87wubXHeIgHK7riKR3Sqw1
         cqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703166317; x=1703771117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKfof6hym3RoRIHBYAszTdRtgchJ1su6/mBldx/DwFw=;
        b=wzGTHYOi8cICh249q/RehJRw/o9AfWgh+EM41izgt5KjqzXFirtIe89QZXRNiUI8wN
         y49Gd0i93QVERVBQy340lF+PsxcqDH1hKTLPxHg/pOAWNPf/l/9pT6kGWfMU/Sa1toNp
         fMTuEZiPTl7XM++wbSRBRDiKq8z9ZIG37FH0re4b7G7ox9wNtfPxTLK12O7fFdRGtfjM
         febQ32GpXq6gt9dZHH/SKe+uMYshyKm8O6jdZoyVker9E8McVsWTjAx9YyATX5YsIRRZ
         LuL1WNvf2eiD8xzzehpfqM3nLDncYroHg6poN9ZUILJiriPRVX4F3/ejPHmTDolyfDaS
         fLnw==
X-Gm-Message-State: AOJu0YwdI1lHRQ4HMQ07oRImwDbsipaLkuapDB9PihlQzOyDhZFEOlLl
	oLvnzBTRZ5XgpQuSNu943MRcbXMWAZEw1Q9I+Y5U8g==
X-Google-Smtp-Source: AGHT+IHRhQyEaMvIrVm+IRt2vv8YX+zNAHLClxrPKQRJRGNoa6fB9WYzc9OV8z8uqtr8NNrs+bYa21J0C2vVCCkV/Hg=
X-Received: by 2002:a17:90b:3846:b0:28b:e0e9:4816 with SMTP id
 nl6-20020a17090b384600b0028be0e94816mr1376288pjb.65.1703166316862; Thu, 21
 Dec 2023 05:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20231220092745.35325-1-mgurtovoy@nvidia.com> <573c2ad1-8407-4c8d-b31d-b89b16f0fea0@grimberg.me>
 <CADUfDZrhPONOEK6xhbn3Uig4UZ+nwg0hDCRUziW8NA_g01raHQ@mail.gmail.com> <5694a097-eec9-45af-8bf5-2e5d3963a03f@grimberg.me>
In-Reply-To: <5694a097-eec9-45af-8bf5-2e5d3963a03f@grimberg.me>
From: Caleb Sander <csander@purestorage.com>
Date: Thu, 21 Dec 2023 08:45:05 -0500
Message-ID: <CADUfDZo5zxgidqjt-OmQVzGXdoONvX=LV0dpm0rCsjjXPhnBpg@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme-fabrics: don't check ioccsz/iorcsz for discovery
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, dwagner@suse.de, kbusch@kernel.org, hch@lst.de, 
	linux-nvme@lists.infradead.org, oren@nvdia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_054519_196035_8C6351F2 
X-CRM114-Status: GOOD (  10.25  )
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

On Thu, Dec 21, 2023 at 4:02=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
> > Why? As Max points out, the base NVMe spec says those fields are
> > reserved for discovery controllers.
>
> Oh, didn't understand that it was already the case, I thought
> that the intention was to made it as such. Can you point us
> to this part in the spec?

https://nvmexpress.org/wp-content/uploads/NVM-Express-Base-Specification-2.=
0c-2022.10.04-Ratified.pdf
Figure 275: Identify =E2=80=93 Identify Controller Data Structure, I/O Comm=
and
Set Independent
Both fields IOCCSZ and IORCSZ have "R" in the "Disc" column,
indicating that they are reserved for discovery controllers.

