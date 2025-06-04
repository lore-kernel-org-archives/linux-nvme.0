Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BB3C5B552
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 07:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZvVRZGR4kcYhZPhtOACMXE0Zb57gL/uh1lF70ODprqw=; b=VA7x/iXwStrOmTQfTtRue5+iST
	48fjsf2lep+OB2CCFpdyCLwbj3vL78OnLtksVfuVhdoycPxXpiZINyQAsCbrvSwjPriBAFe6uYpes
	XMDLLsJ5lPXCJhUQue/ADMjbqjxUgSflbzJdmnZFMryUD72M/n5rW2Q/VgZaGe9A9A60/bQMRxrsd
	bkLM/2KaV2HsaCO7lQW1MkUm/nYxbNLNbE2qqop8hTFS3luZLXZFwxoRH7TGPCrqdXpTvDcEg04LM
	OZ51hN4mUR21/8aJiJPCOWlWLd2fDpVuAT/WPW9Tm73U54YmujreZs2YLdzqbXR6DeBO1NtBM4shR
	mpy5ozOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMiMM-0000000CkQp-2oOJ;
	Wed, 04 Jun 2025 07:16:26 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMiMK-0000000CkPm-0xIa
	for linux-nvme@lists.infradead.org;
	Wed, 04 Jun 2025 07:16:25 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-adb2bb25105so1042566066b.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Jun 2025 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749021382; x=1749626182; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvVRZGR4kcYhZPhtOACMXE0Zb57gL/uh1lF70ODprqw=;
        b=mjtkh/2+OwcIBgFisjDo8VoZlyLRGk5gZxVEiVG/XwpkIZtI8YU9RgfrvI1OzK0Q3V
         C8kOie0HHlSvxUXaPuH6RRR0yMQgnZpLrinagWyN8qtCkE1/+1DJbA1JjDZsSYZ/uPKT
         9kPUV3UZKpQhm6aiP6vA9zjsEfrmQwSJHaZdc9idoF+C3jkZet+uJLF+4BG9UIJarmJs
         LEYqoV3a04CCDrBLPaMXzcOdyPFk8aRDWlnnDQElw2QjLUFn0LrS4mcRfHKjvP9MXeUy
         GY/3uP8jmQOVl3F3Mlkur/taYy+lOFNXtuYdIdENw5IVcJxidWG3cpLrkrN0jnBqN/8X
         7yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749021382; x=1749626182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvVRZGR4kcYhZPhtOACMXE0Zb57gL/uh1lF70ODprqw=;
        b=ty6mQ/w33bd+U69x5u/wIE6qu2v33nnb4ttkQuBbI6t/8zRvrZbeLMveusY1//4rU4
         zOy1k9EYMoeM/Dceuz9YsJVaTgjo1PnJC3q33jWeNMaT9nboMXGNHR+qzSs6tD95/sQN
         iLqj37AqbgBZZ8vMW5MicXY5fdfOt6hk1A5bwMBEOQpDqynZDiZMwEE9H+p+aUwpCy/3
         mF/aqDGVTgYVqL0CdXuvdRlKuPEdDmmN8K/cxZyPJVnUI6x8Ygo/gIs5f32kQIgGIBhz
         oHL2UuMGGGISPmQQVYTlVFcYLqHrQgDhHvy3ddFbS11U2kk9ZPxvyeLLdekbCnYzY6Bq
         0ldg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Be2EYg4mUnrSQjsMDQyX3JOLd8Sjn9v2UL72Y9IWObVVsVdGWeq4hGybKVC53tYQZAj1N1uRrVCV@lists.infradead.org
X-Gm-Message-State: AOJu0YyaKAj1Sn2ajoLSuKgn3BPzO4PYgRp44cV9CZg5EYzlceqgae0X
	3lDMO6d5Q1Z1PnLdHULsIIUT9qLjlliSMuQ3YfHXYEyuN7Z3uowQ/B6qrtoXs9vG1MwzlN2l/eZ
	dH8eWN/Ai5QN4ssAQoJRPpNy8lNVopg==
X-Gm-Gg: ASbGncs/LEdRuNDEiRjC0wL0CWxnvqev5CiQmd0effdFyv0JlFGfIfvCkWs51t30Gd6
	lox7nK0cS1DFRehd3aQb8iDB3miIYtYbMvYdYhnd/11boXIkd9fZzHZZgPZROHUoUyso2al0fIq
	1Bkl1Lqkb7JxP8ko7Z4vOv3TYcCbICKhESG+SNQz0sOwGj/tk5vl8UwgWYLwla6Gc=
X-Google-Smtp-Source: AGHT+IGv7nMMBhCO9I/kxpkV9tKggZGisNrEMKyC/c6Ko9L3Dq41EcoCpqVkVTtWWh+LVoU3WVL2eqPBB4U2dHwA3RQ=
X-Received: by 2002:a17:906:d54c:b0:adb:4203:cc9c with SMTP id
 a640c23a62f3a-addf8fd4675mr119512666b.50.1749021382308; Wed, 04 Jun 2025
 00:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20241128113036epcas5p397ba228852b72fff671fe695c322a3ef@epcas5p3.samsung.com>
 <20241128112240.8867-1-anuj20.g@samsung.com> <aD_qN7pDeYXz10NU@infradead.org>
In-Reply-To: <aD_qN7pDeYXz10NU@infradead.org>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 4 Jun 2025 12:45:44 +0530
X-Gm-Features: AX0GCFsYorPtf7YCFjzZMLK3eHzgUo8z6eXW6_zwZeYqi4jYb7D58zSfQuMfz0E
Message-ID: <CACzX3As_FH1tMgZHMoCJMPhnuB__oh7KBzd9Z_JLtg2CLFZ4rA@mail.gmail.com>
Subject: Re: [PATCH v11 00/10] Read/Write with meta/integrity
To: Christoph Hellwig <hch@infradead.org>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	martin.petersen@oracle.com, asml.silence@gmail.com, brauner@kernel.org, 
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_001624_267978_BC3801F5 
X-CRM114-Status: GOOD (  16.14  )
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

> > Testing has been done by modifying fio:
> > https://github.com/SamsungDS/fio/tree/priv/feat/pi-test-v11
>
> It looks like this never got into upstream fio.  Do you plan to submit
> it?  It would also be extremely useful to have a testing using it in
> blktests, because it seems like we don't have any test coverage for the
> read/write with metadata code at the moment.
>
> Just bringing this up because I want to be able to properly test the
> metadata side of the nvme/block support for the new DMA mapping API
> and I'm =D1=95truggling to come up with good test coverage.
>

Hi Christoph,

The fio plumbing I had done for testing was pretty hacky (e.g., using
NVMe ioctls directly to query PI capabilities), so I didn=E2=80=99t send it
upstream. I plan to submit a liburing test. While working on it, I
realized that writing generic userspace tests is tricky without a way to
query the device=E2=80=99s integrity capabilities. The current sysfs interf=
ace
is limited =E2=80=94 it doesn't expose key fields like pi_size or metadata_=
size,
which are necessary to correctly prepare protection information in
userspace.

That=E2=80=99s what motivated the ioctl RFC I sent earlier =E2=80=94 to mak=
e it feasible
for userspace to construct metadata buffers correctly. Once it gets
settled, I can write some tests using it. Do you see this differently?

