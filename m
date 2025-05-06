Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D059C3ABBF
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jP4zyIh8pJ5KkYtWjVCSo5LjNzAbQBGRkGHtDhGVzDk=; b=n/1cwfV5W936HB5g2nGzniBZbp
	PPJjLK51cV+o1SiwkYmp7ZCEdz2cAvInfBQ+XVKNFaAeqS++rt4rB6qkoruFwoo5MeBMA4zQM3IP6
	be2XUGD1hJSk9QNRkNqUtQsrbfq+dAv6iUEmd26B5fyXWvsDpEPQUODIAzHg6ReDMe8o/awx07Gpc
	3kKw/kPcoLwMxVSAm7FKbxIhQ2EuqmtvGuUE+dAsPLfG7BLUfPlcPi+Nkl9pUbXZr7vHBE4hbbo4F
	z47RQ6blp9+OcQS4bJgbWsELYnnsK2Ne0d/Y9SaV6p4wwhSRhi8qYwqRgL/DjfLib0aUIKulHXVJg
	gVAOwu0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRpP-0000000DfxO-3V13;
	Tue, 06 May 2025 23:35:59 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCMnF-0000000CwmO-2X6o
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 18:13:26 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b0459668101so391564a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746555204; x=1747160004; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP4zyIh8pJ5KkYtWjVCSo5LjNzAbQBGRkGHtDhGVzDk=;
        b=SriRwLaSuSzbS8w4Cm2YG5y5bxv0TMMjtJTMTEosfpFqODOXQwt5Z9LoAASG5cQnNZ
         oex3+X+ONGCXG6oNnuEYusq2hbXTOQOvrzLwkp6RdTXyf0xRKPuxph9k5kmTQ4/Kaa+r
         wjAJ/j3KYWVPuLVzcwl4G9Op+px89ckAC5HrOxjQilqvC6UqG9eHGahi+jrja2Z+ajTx
         DrJHQm2BsdV9CYCSq5oJEj/QmMfbFb6ccHO21ERJt7HlsQKNw23EI47fJrU3BeJOd0v0
         9/zD3CRmsVFsQRRICvmvPHoLg3AAehhedfoJ8oZkHaatMxRNPwzISNTFRxxbuuyV/qYw
         p1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746555204; x=1747160004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP4zyIh8pJ5KkYtWjVCSo5LjNzAbQBGRkGHtDhGVzDk=;
        b=BXSgiObEJh90rBT9HNPy7qQMv5I1+SpIYrQOWyL4ImhiYTjrePgFhdiXO2LYf6ulIq
         tr7xiodh9pAwrEdn4GLQhI8Xoefo9GsMH6YnZ8KCI1L33IdOZFjmreRPq33z39FZobsD
         hITlt36FsgSrsu9zYt13Tf0lkoWdUA8fw3NrS44lgI+6Uyk4FHv3l9BTg181aEOho4l1
         q2MPJhzzM2R3djjlfRn4m4Z+IqIHIv4ZtUhym4M5hdjJ9hLt0nrZnPsjetANXkHabmcq
         e3UsyeFmPEewA/4VP4E/yLFKtFRTWastsIP9IaiANXaO+SxjiVbRios5h+aQ3RxfZTpL
         nG3w==
X-Forwarded-Encrypted: i=1; AJvYcCVBzvcraXQsOutYGMeWT78zjd8EAE1s+UfpjKTxi282l802an3b4wl3wGpQyn1gDPUVk9Ow3v9I/dXj@lists.infradead.org
X-Gm-Message-State: AOJu0YzNhR/dAhCAkF2Mu8sZVYBcLOcXDiFYea3oFuSh2fiWg6f24NMz
	VGctuEG5WqJ8nDlnGzwQA3GY/ifrxDgt1ONy3oJW4sCboqTYTbFcrzCsGBZuWrz/gR+S+058lln
	vLZ5eed+0QnJeN2DUGCQWf+FwtfsgDSBBfnjtUbM4Kh0Pt0aB9AA=
X-Gm-Gg: ASbGncvuYiPQy3+Z8oaRSV4IRulXLwrT6C95ujR0fKGenZZq6turFtYKXKJt7gpXE6G
	UHD2/VaZ8zaiKqiic60xFcLeayjQvoUFu1Us/qhVM+sxXnIOtTew4x0zP66XzTH8M+Gqbz/hm5H
	/gsBMjwWDDPOrnspZ9jn1cEA==
X-Google-Smtp-Source: AGHT+IE5IP6rwDd6bdxxX2LORDLF3oHI3zhsRn3/owr+ehYOd8v7XwuQAoKAqKF20zgZKf5sPjMpwfnAK4p1BuXX8Ec=
X-Received: by 2002:a17:902:e783:b0:212:48f0:5b6f with SMTP id
 d9443c01a7336-22e5ea9c75cmr949475ad.9.1746555204611; Tue, 06 May 2025
 11:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20250506180545epcas5p34d4857f38b838532678728db22df6067@epcas5p3.samsung.com>
 <20250506175656.23151-1-joshi.k@samsung.com> <6ce9274c-db51-4ff9-9d05-9d334caf2206@kernel.dk>
In-Reply-To: <6ce9274c-db51-4ff9-9d05-9d334caf2206@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 May 2025 11:13:13 -0700
X-Gm-Features: ATxdqUFHPwkWOEf1ziqkXSivUmp8vNCm5U3nSVDJ0aXObxfy3qo46KwKaoCgjSs
Message-ID: <CADUfDZoLvuu53GcvWe9qQ6yYz-iVof7BwHR0=--V5=acMNx5OA@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix incorrect sizeof
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_111325_643770_6E72E3B6 
X-CRM114-Status: UNSURE (   8.83  )
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

On Tue, May 6, 2025 at 11:09=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/6/25 11:56 AM, Kanchan Joshi wrote:
> > Use the sizeof(*head->plids) in kcalloc so that we don't allocate extra=
.
> >
> > Fixes: 38e8397dde63 ("nvme: use fdp streams if write stream is provided=
")
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>
> Reported-by: Caleb Sander Mateos <csander@purestorage.com>
>
> ?

Yeah, if you wouldn't mind, I'd appreciate that.

Best,
Caleb

