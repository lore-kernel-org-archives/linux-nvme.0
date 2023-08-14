Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A34C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9O7uVavugQIWG4+/30ol/uNZ+vUipg1yWncf1HB7Z8=; b=ywYtvpzqW/gVg90zOydyWkTZmG
	euxaPefKe0C2UBlsGlvrZG0lTEePVyWjFRKA1QHeZ1I0CiV9yRHFCyylLAnEYeXGPQ925h7xb5F06
	hKMErfwiQCooqmGDbU6DzZHMvSRmaxZFc5qPHmqyHVkR7K9sLkDFbOX0zPdladht22Hrj2FGFWrch
	ceMKIwyYA/vAxrPzS9ru3rf1jq8B4jSDGo0AEOKXez29bKVOZxDsiy7UsvMVEzP7131N/m1EA6Li3
	8cTItSCw4dDVfey9C7HIWnA9a3i1WJtJwVXXbdLoJsM06+5/EP1cRjH/MlrGTck1PE7QsGUP1Xb61
	gDhUkRCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVarU-00Haq3-36;
	Mon, 14 Aug 2023 16:56:12 +0000
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVarP-00HapB-1n
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 16:56:10 +0000
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56c85b723cfso2903991eaf.3
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692032166; x=1692636966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9O7uVavugQIWG4+/30ol/uNZ+vUipg1yWncf1HB7Z8=;
        b=SXLBBu9oNOxnHeWHA3EzDEcQx4zuwk/WnRawLjvMOoFNw7dpzT1cc0Zh3imGGu5biH
         hF3gj0fRHQ72e59mu7XzFNFxxtuLAL6ZFxOgG2j4wOX+YZAVs3TkYanLQVFe+jZctHSn
         gRxqqBRQ64EUwLZkoQs6MhwsohiAS+iuZrEPX6LlKTe7wKlVSVqQ5ZUWMS2XWnv3ukdN
         xlx8rrlrQqId4/tGMozDD2l5xfvpRrFWtivaal0jSX3deLqfh+C3I6DXAEvX5W8/UQJ5
         CNDQmsfU8Esw1uGGrTs5LBHBGY5zVpcRKJdL/zTQ7JbJGkTBRoprtkOUNrZbBBQ1Hqzm
         u1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032166; x=1692636966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9O7uVavugQIWG4+/30ol/uNZ+vUipg1yWncf1HB7Z8=;
        b=YVwYeelFxoH+hgPTgZVZcgGfL5qkfxDIh2iCk/C5ZvwWCIq8mWWbF5QzLDYj+pXqR0
         FRcILlFDLgwhk8oC05DlUMy5pyimW+RrajbSjvptYalfN3LeF3CQEuLWtxrwxWbuWVJR
         O+mPOwgu8QtShENUiKuv3gRXXsjpdxLObxKj/VfG4uG/dQV34V1jMSN2Bv//42Gmj/wf
         iXA7nqbX++7OU8tih78txR3R1Iyl+EDF19cLEpieeTmXKGUwMsLuPHU40aE5LUN29Tic
         4a5l0nwzGd732LxI0FmbeSp/8IlH4Q8dzTv9vbEM59qk2IqngF4GUAL4YMaN8voh1kC/
         FLEQ==
X-Gm-Message-State: AOJu0YwjbfP85IiY04RMft+HJ7pVhCZeGeSqGY4W9gWL394XBhjmt93e
	q6yMMthwHiTaNrsEL/t9rM/P4vLNqGWf09Hj1so=
X-Google-Smtp-Source: AGHT+IGRiUAbrBbY9Vni9Tn8QSBhVGIX9TfUXofBqPCsNnEmk1YYklY4fqhqnWDK5MhusbsyCSnQmJcr7FbUisha/AQ=
X-Received: by 2002:a05:6358:9212:b0:134:e952:16a8 with SMTP id
 d18-20020a056358921200b00134e95216a8mr6760283rwb.24.1692032165879; Mon, 14
 Aug 2023 09:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230811105627epcas5p1aa1ef0e58bcd0fc05a072c8b40dcfb96@epcas5p1.samsung.com>
 <20230811105300.15889-1-nj.shetty@samsung.com> <2cc56fb5-ddba-b6d0-f66b-aa8fffa42af0@acm.org>
In-Reply-To: <2cc56fb5-ddba-b6d0-f66b-aa8fffa42af0@acm.org>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Mon, 14 Aug 2023 22:25:54 +0530
Message-ID: <CAOSviJ1b5ySAugzKExa_ZQgOzvQAOWB3D-ZRMQeGmNpQbaoBSQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v14 00/11] Implement copy offload support
To: Bart Van Assche <bvanassche@acm.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com, 
	linux-doc@vger.kernel.org, gost.dev@samsung.com, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	mcgrof@kernel.org, dlemoal@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_095607_620417_68AE22D9 
X-CRM114-Status: GOOD (  16.48  )
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

On Sat, Aug 12, 2023 at 3:42=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 8/11/23 03:52, Nitesh Shetty wrote:
> > We achieve copy offload by sending 2 bio's with source and destination
> > info and merge them to form a request. This request is sent to driver.
> > So this design works only for request based storage drivers.
>
> [ ... ]
>
> > Overall series supports:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >       1. Driver
> >               - NVMe Copy command (single NS, TP 4065), including suppo=
rt
> >               in nvme-target (for block and file back end).
> >
> >       2. Block layer
> >               - Block-generic copy (REQ_OP_COPY_DST/SRC), operation wit=
h
> >                    interface accommodating two block-devs
> >                  - Merging copy requests in request layer
> >               - Emulation, for in-kernel user when offload is natively
> >                  absent
> >               - dm-linear support (for cases not requiring split)
> >
> >       3. User-interface
> >               - copy_file_range
>
> Is this sufficient? The combination of dm-crypt, dm-linear and the NVMe
> driver is very common. What is the plan for supporting dm-crypt?

Plan is to add offload support for other dm targets as part of subsequent
series once current patchset merges, dm targets can use emulation to
achieve the same at present.

> Shouldn't bio splitting be supported for dm-linear?
Handling split is tricky in this case, if we allow splitting, there is
no easy way
to match/merge different src/dst bio's. Once we have multi range support th=
en
we feel at least src bio's can be split. But this series split won't work.

Thank you,
Nitesh Shetty

