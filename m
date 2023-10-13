Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FB2CDB482
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 18:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6iO0mscVZltk/HGalOm5s5AtgW0RI/j46gDoeifEAU=; b=42279Gm4luLB23zlyVWU1RXLcH
	rtQRe+JIHwfggloiwPKclo03vDApB/KWgZ8bVWJKxEr9ThhEW+VRRJ5rMERU9PO47+1bVRcLR5ZlG
	Us+uGEpblLzs8Xe156LkOeLP57+74Y9dqqb+ogclc8Uf4DXF9YuqGmmR4l7UQJ/bsXiN5GAqgupQj
	VWjrr0m6CWmCscrAUUAHcmCEt2XyspFsOC+lV+uwPRAHYHFyDBClZHgGmIdSrJ+ptndXVfEr69+CC
	I1j9DfK/mRu76AEmZ7WNdxDSTbNXJWgq5DJxFCkfCbsDONJbN1Bj4jQkbNNNf2VsVgSnIZL0SGB/K
	KMQDIHmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrN0p-0043dI-2L;
	Fri, 13 Oct 2023 18:35:51 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrN0m-0043co-0t
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 18:35:49 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32d9effe314so673164f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Oct 2023 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697222144; x=1697826944; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6iO0mscVZltk/HGalOm5s5AtgW0RI/j46gDoeifEAU=;
        b=VCU5ZefvLmryMjQ5O7acyaaZ7NZs+0ZSbKJwxW6fVWETEOz/kB4WqZTwNp+9v9bAMf
         enZskAu/cHcyWa+rTDBRYpqHOSoPuJvLXzW3mNsgIqkXx6lFiPHBYxUtX8YrId1cfwK9
         J5+FeDKbDNqMwZek2XrXaIAV4NCghWlQHJFWruCFX8tq7e2e3YiSeDWcrzPoiEmCjAk8
         Ngki3GWRkwUTxQfdfSEfqfz/xrDQ1NtISqAsiME4WvAW0BWweK6c/ys1PrWKb3JQZhfW
         Xm6w5iy0/7lQBdfzqyzcwhLdBOWLrTi+HgCQ/AQt1n5Jo7OQBbnT2fDc01BHMGO2lvc8
         vi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222144; x=1697826944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6iO0mscVZltk/HGalOm5s5AtgW0RI/j46gDoeifEAU=;
        b=gnPXj1iKV8mAduWGNbjDQFZ0L7wNKYHp3YeKjSxMKh5KsY5I2f8xHj54cynVxG5KkY
         6F5DK5PIphc5dz8YeBikjp4PQHl3rTTXanhy9PL6Ii3tx6flI4z/XggnFlWdMjOGHR1k
         vS7L1akBCbL7PQuNOGydHcxNqCi6GyjdkzLkGY/gtPLB8nIZyDo5exwgRk7xWXnUhFdE
         tfU+kwdUMI1Zn0z5LdQG0XZX8dPLkM/afGjEh5bx9yEnvAZXhpN0L/yy8JKvcHEwHGWc
         vTVMGdfoDa4xgCe3WGrrFfSn2V8SQ+g2JV/qN8+Jd9lcT2im82IO0ksJVAaDxdN9cIQ7
         1/UA==
X-Gm-Message-State: AOJu0YxbaVhYTfthmdTdlOqTl8+cASMM1bSg3r5JDDCMlDHE2cVhyOcK
	UG1Uvh82Gc6OGjpZN09dL1qL4PZtQU2AtvZB7To=
X-Google-Smtp-Source: AGHT+IGwYvFbMeA4IHW8jmxr+wUkgsFLxnKr66nqs6vB98wMt5LihFSiEIQs/EF43V9R+rHiSeT1pIuKKbnHVh6rCbs=
X-Received: by 2002:a5d:628a:0:b0:320:254:b874 with SMTP id
 k10-20020a5d628a000000b003200254b874mr25160488wru.11.1697222143924; Fri, 13
 Oct 2023 11:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp>
 <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com> <20231013154708.GA17455@lst.de>
In-Reply-To: <20231013154708.GA17455@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Sat, 14 Oct 2023 00:05:17 +0530
Message-ID: <CA+1E3r+gSWvN3VR38Uu=rHLy=9+iC-G5ta2sXq6LEXTG+OK_-g@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, vincentfu@gmail.com, 
	ankit.kumar@samsung.com, stable@vger.kernel.org, 
	Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_113548_316180_D76F208E 
X-CRM114-Status: GOOD (  17.73  )
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

On Fri, Oct 13, 2023 at 9:17=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Fri, Oct 13, 2023 at 08:41:54PM +0530, Kanchan Joshi wrote:
> > It seems we will have two limitations with this approach - (i) sgl for
> > the external metadata buffer, and (ii) using sgl for data-transfer will
> > reduce the speed of passthrough io, perhaps more than what can happen
> > using the checks. And if we make the sgl opt-in, that means leaving the
> > hole for the case when this was not chosen.
>
> The main limitation is that the device needs to support SGLs, and

Indeed. Particularly on non-enterprise drives, SGL is a luxury.

> we need to as well (we currently don't for metadata).  But for any
> non-stupid workload SGLs should be at least as fast if not faster
> with modern hardware.

But nvme-pcie selects PRP for the small IO.

> But I see no way out.
> Now can we please get a patch to disable the unprivileged passthrough
> ASAP to fix this probably exploitable hole?  Or should I write one?

I can write. I was waiting to see whether Keith has any different
opinion on the route that v4 takes.
It seems this is a no go from him.

Disabling is possible with a simple patch that just returns false from
nvme_cmd_allowed() if CAP_SYS_ADMIN is not present.
I assume that is not sought?  But a deep revert that removes all the
things such as carrying the file-mode to various functions.
Hope tomorrow is ok for that.

