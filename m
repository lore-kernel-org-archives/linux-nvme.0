Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E0EC61DB9
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 20:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BIsnd6xgeWrgcQT3jCCMdd8DVWxNR+Gr3QkvZG2o5wQ=; b=W8rww2M11Gl5V1Y0hQZNrNkkXP
	s1XyHqh1QBtnH3qgOs8yZIb7X+5xqz6QPLXggWdp08LxsQ2yAck+IGf24Rw80IWmqWsq0vssOMD4y
	5h7EVY4He7tY3vOlUxJIeO1CWmWK6qqeYMkBqZlxeUCaW+t+OZOfpxbskHKpUyMXH9h1o226DXdIF
	1NmHNetOBzdlRVLjBk3jBOYLS8zCUEjCtQVNgOyYSWfiQgBiAEn5Avws14Yl9geRkj53+1pG45R6J
	PECm7h1TGEYFCC8Oble1ogr4uDQYpOqO+3Uk+piXshT9L4ed9SO18AYX3gMoR/ZdYfccFs+7Is13t
	qZBzkKig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzgLu-00000004kSP-03Ca;
	Thu, 27 Aug 2026 20:05:34 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzgLq-00000004kRz-4BwB
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 20:05:32 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso1599845e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Aug 2026 13:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787861128; cv=none;
        d=google.com; s=arc-20260327;
        b=Qum1vQhdhHOQXubOYna3pGK6qRJD7gFe8a/1ayVNqhyhSIAIMQN2C9aOCiQFTGQdk9
         DBU8MW5UzjIOWKQ5H8WSk/V+QMbKZ4ndyGd6TPP4sTx29bw4ACVIWwRsEIgNfq8aNYAd
         KUULz2WlReLOiunDmlPdruKiOt2689Yurc1y8/bpIgC3C8AGl7TAsoIDxttjsUcdSisG
         0jQz051rdyEfdV1J6FMt6Xy1q3nfmEfg4ROeHb+W28Dt/hPkWr9IkUqfBAnI4mGXBc5H
         3zqedSk+nZ+n8He6kcZRXcjZUr9XNE2R1mgdZMwjONYigsqCQaihC5eQZ5F/W/z8lek0
         +ZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIsnd6xgeWrgcQT3jCCMdd8DVWxNR+Gr3QkvZG2o5wQ=;
        fh=wjLD6D9AMG70W+WWoOIVbEaD28F8Urg1MSaDaDqgTu0=;
        b=coEE2zkYZFap31/CNtawVrXOgmwvT18bofhfimfS/4rc2wAD41q0BqTPxaKeTlxIC/
         26rcbscCjoDnfLz7uhpoHSPzc6qkR8eRfbPnz8xQ7E3KGPeJpdiLhMgTIy1A9hBFP2yx
         t/2vR61pbsa5km4zHc6biqnInCOdB7bLcG1HR28WBb7zu3zzYRuJFfSVprp6bVGOayzP
         XL1bOW97CZ6Yga2zp/LtXqIVM7HJnWgC9rBUkd58MqclejqeiMr8hSK9jYSYG+uZ4JqU
         D3EOlgcWeGhu9YZaOYeL4eNz2iQ1fXbsegZl3Th8Lpt8eqdXwFesVxVTcKIaIHhG73c7
         qJRQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787861128; x=1788465928; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BIsnd6xgeWrgcQT3jCCMdd8DVWxNR+Gr3QkvZG2o5wQ=;
        b=bo2rtvy4P29Iei0bYtN5s3JJZ6aI4CfqQITpyVzYPvBuvXKMnA79fBnedYDjR+i5nL
         YAlFIXyqAVXly1y1KpTTNorotMNJJj3dmSHAbM3CHMSxDKB9k8caRExZqAWZES6hWEBJ
         bQIxCwdgsLMA6nGr2kDA26ft2fxrLn0BGuEYKAxQ2HM1yqtArAY893UGDF9MoYi+9cRn
         yG4ye2JcJuPfZw/8835gAiEpM5TFBjQXaX7Gt6vGDTXn7Fy2lKj9j0M2aGQkGvU9ve+w
         cWs6igqenuoYyYnfIwKp6Qrm3QagnAa5wzgf2t0FMy0A+d8DAOXab+vuuSr/mPg/0S6G
         jzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787861128; x=1788465928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIsnd6xgeWrgcQT3jCCMdd8DVWxNR+Gr3QkvZG2o5wQ=;
        b=P+8UfdgjyeU87nG5LfuguSgngliBL3Dbp+bXCGYjlPa17jZZoLamv17QVBZeHcMvxm
         o+uR40S9dndv6iDCZll3hZYv3oCaZOnLhFdxtfZd4WiASrsvbHu6WwWe1HFJmePK0wCf
         gf7ayQNac/Y3JOdTyljCLr0kCoheDrhXCl0+hUn1cBvmQ5nZD74+PCA4lJ2sJx1D0eaj
         0iWsoIJ+Ea5MJVnzJCQerbJdP7Rcxv0kppQIT6qYoBPJFx2aOOPjduhB4mj5+WGWMDfi
         YgWAJ/pbFoa/9YzdM9aSRDrx1Bjr3Q1fGTJ2Nnj5KQkGDVjoOUzF3a83giHanTJHGMZ1
         2enQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOkwylYanSlXryYOe4oy8r8Tq367vAIuu4XCkZq7x2q/r/ACi2ypU+54shu7mrnMqvnq5e3h8sVUz4@lists.infradead.org
X-Gm-Message-State: AFuF++lIqWUaEMUAyTygkQTclWsOdoUg4CGU07xPFEQCmJJahvEtdoHY
	VfYhAZ3m07nuLhOnqYrTpgst1gM7uK6ZT2B8tCZeGp5Bz3of3JggOzSwtF1efbBN4Y7Sw5sQwdy
	9Ize5PvDZMPBG+0DHYiisZgLEMy9CxVA=
X-Gm-Gg: AR+sD11SU/dGn38wW0iBcDFfZRIqFrb091Q2vUBDmRLW6BH3iTDDT+w9Bw6vGE0x1t3
	yheLOsH4+CxAc+9Fiugr8KMirmsxhGwyQ3+0XrWvIoP1A+XuRnoxwIA5Ta5WakvK/5sk6G3Mjpa
	cun9YWfeXaaTy1PgiXCAm+IMO5KMoX8m4WVEH0GDrLHj65/iQmZmq3zOLCSFYqoA0tHi4N9J8fn
	7Ow1b59bvzdBhGyY9txABIeTL8P3r6FhRHG31x3sA9TBzUad4zstlTZvA0OgXw4dpaWBGPwWpOH
	RkTp0D4bLWX6tFQikZlb6R3ogwPtXNc8K5l+zv9U9nM6HOLTmWzH+AhPvxdeAwvOgoyZUT+pOfV
	qH/kIm8wDDVkvaZTIOjdiC9AOWuQ=
X-Received: by 2002:a05:600c:c4aa:b0:499:d513:e507 with SMTP id
 5b1f17b1804b1-49b91c17d72mr16962265e9.2.1787861127504; Thu, 27 Aug 2026
 13:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260827185722.3234622-1-csander@purestorage.com> <20260827185722.3234622-2-csander@purestorage.com>
In-Reply-To: <20260827185722.3234622-2-csander@purestorage.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 27 Aug 2026 13:05:15 -0700
X-Gm-Features: AcwNN1UExlY2vL2SpJh0tNQapsYMiZcr3z5sWaZZFYGrbWrJd63x35h50FR6wzE
Message-ID: <CAJnrk1YfTg-Lz+TmM+c=Asc8N4QGuY9_g8zUXtaNr4O7hG1Djw@mail.gmail.com>
Subject: Re: [PATCH 1/2] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, fuse-devel@lists.linux.dev, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_130531_058330_4793ADAE 
X-CRM114-Status: GOOD (  15.53  )
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

Hi Caleb,

On Thu, Aug 27, 2026 at 11:57=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> In preparation for setting the io_uring NVMe passthru CQE results from
> the blk-mq request completion rather than the task work callback, split
> out functions io_uring_cmd_set_res{,32}() from io_uring_cmd_done{,32}().
> This allows io_uring_cmd_done{,32}() and __io_uring_cmd_done() to be
> consolidated into a single CQE-size-agnostic function with 3 fewer
> arguments than __io_uring_cmd_done().
>

The conversion looks logically correct to me but the interface feels a
bit annoying / fragile on the caller side.

Is there a way nvme can get what it needs without changing the other
callers? Would it work to just keep the existing
io_uring_cmd_done{,32}() as is and add a separate API for special
callers like nvme, eg:

  void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64 res2);
  void __io_uring_cmd_done(struct io_uring_cmd *cmd, unsigned issue_flags);

where io_uring_cmd_done{,32} would then just be inline wrappers over
those? afaict, then only the nvme callsite would have to change and
fuse, btrfs, block, ublk, and scsi_bsg could just stay as is. Do you
think something like that makes sense to do?

Thanks,
Joanne

