Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FE7C61DB9
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 21:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kqBamkmhnxpQu01OYVCgjjVqjgGXsL5/W693jooZv34=; b=XcqerEuEukHy9u+uWF48p2CERu
	W/R86hE7e84JPxEsfKbsbbrn6/RC/gGkmNLJ1p+Odsz2dWaG+0+T3KThs8lRLA9Cxpnvl4Y6T2TJb
	TYzZx+yzd3YtnkU0kQ8u9r74CFR/xNt8In43LDOucMaSHzR9UHX5PuZopqOmm1RdwjNBv+KgV2bM1
	Ui6a/6bNbKQmKHSmWRRfcLRh3aTixgU7wnu7f1kfxz7wbsTnFnxZ8H3k7hKNSlFtxV5vuhZjb0GFm
	X1slw0eTOu59WGOStFCtDVwfdvd+/jFUog4SAuRgyzFkNXg07jBlGqlOJuq8wp4D3R1vTqVyMJ0aO
	FvqX9wPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzhth-00000004pez-0MY4;
	Thu, 27 Aug 2026 21:44:33 +0000
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzhte-00000004pee-1N3P
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 21:44:32 +0000
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-43ce24c4978so45769fac.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Aug 2026 14:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787867069; cv=none;
        d=google.com; s=arc-20260327;
        b=Ke0muHMUkossFRfriqgBcZg82jfYKWVM21E7j8wsD1HZ8HUfObxxkjIUOfBrWu3KJI
         aDUviYg2nR/jgCKNKw5w0rlwFWRTUv/JXiaNSTQj3DJzeyPbTEgXSJd/cwM2gwGdc4GI
         J07rrqCljjykSIPmDI4p7D6ZBz4KwmwxtXKvKHQ/lDgDnmusGBj2xp59Vm1ZofBKOt8o
         ecjIeiO9w18IcOPXSmc4LKiTLPB0BVKaN9hGOBMyXNWVDn4ri8rPo6HhQD4wl/JZ/7G3
         ubn5Sch4JGXVrqn7u3b9ZB0wkAR9EINx1QKuVBZaiSs9xq7Se8VXbpLbp+Fa/fCESK0t
         MooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kqBamkmhnxpQu01OYVCgjjVqjgGXsL5/W693jooZv34=;
        fh=vg93KHmexsCjZ35HpJ9aGKvRYnCdEfXl+4N6g5O2TtE=;
        b=tDzc1Ztg8pAlmRLWMaOYRzbhxqwdQzHoTp2eQ/VmR6DYP+LsD7B82L6v3OtHbi9SOZ
         KclmTWY3RxNiCHIKEmg+RTLz2GH3keBqG7ckjlualjzqlHIk6ZmONA9BrvM1JNryCvpu
         NlMfkxwsj8sv2dwVv9DkbU1cCyyrMbqSFna30Yo6hbN2br+Ks20OF9pi2scbvM0TbKoA
         zOlgrVGcxWsiPprB94CFdELbagwvqHxYJwflYZgWZSyOa3qEd1Dyvq5b8MtL2NqR04MV
         iM2wMEfKoR3nD+1ogvj8HEED4St5HsanqUDQGqdLHeC4fEfeUU6f+Jo1EsJZoY/sUHKZ
         T/9w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787867069; x=1788471869; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kqBamkmhnxpQu01OYVCgjjVqjgGXsL5/W693jooZv34=;
        b=ZPisLdkq201Uq3ArRAywWJq1sLSAQrlkjunXTYQ7uSbS/00FOx/8El9ijGtOyCud4G
         Ad3q7Uxhy/26FIuCsOol8k1noVfKCQZFL3V+C/jJ4PMN2jNcARgtjJruENNfb+Eh118P
         RvU71ZE8/m2MPzJcbASb5SRluM4ypdJXumKNYBshYgGD6585n85a/dSn11fKgGabEMk0
         QC4BYJzB7OBe/e15pkLh70BEai5M2jN9k7qOpNYGgClnbmprokN54LjM+k8/vAUwbJyy
         KSZluQsEh2tFRsh/9X2fxyIH5Wa1xM08+p/ylW9SE+O4SJuNlv6TczXffP3v2hE0uD4e
         OzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787867069; x=1788471869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqBamkmhnxpQu01OYVCgjjVqjgGXsL5/W693jooZv34=;
        b=bRLismWOGWPenIhdARpQ6OJIhdAi3m65BMPHtm32Sih2B/oeNN3dwAIXiNWuNxZusg
         wZlHPvKqPhK6+t4XEGP+ljzocZ8vsBpQQUNVWib6BjdyI5+cBQN9X8Y3rmrzGLRnscD8
         feyqDDyflTMZ3gDD2+Jgkbo/LRa1GfY+OvcB43Bcsi3lPxh0lQeqQYOjxObTtUotpJzk
         /i1+mnua+swVpHH38S3UCN4EHUHF19scolcjzR7XMBW2ka198V0ukr6vCR+TPLbBpjuW
         Ee1dBrDuIR22ytzQceYIQ3L1jKRFF7r8TIz/3TFiWSax+Gz9zPPkBmgR5cE67L1eFtBY
         WXsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqR0oqXPqQRxa66ao7zgBeLD9QSjLVjwEf3cpdt1OC4XUilQJbQ3mR+prZPv9EYKoJR39i6R+m7jXzJ@lists.infradead.org
X-Gm-Message-State: AFuF++kAR7WQg8WyIqy/XwXzjjQUmcltmpu7idqBN9AzkwyfLB0oxjA2
	VQ9j9fLf8HaxuErT/RPmTKGL7R7L+QBq0ByWtf4F85hrRnLEccSAok1yroTbK/E9mrWkqGJ5LJU
	FLwCHyUQw5A3csSgCey87tGcv+mnU93NvQha1HIar4Q==
X-Gm-Gg: AR+sD11oKHoIwtYGgjak5nzYFpLtkDy95nTg+/H8ihAfMuL7LXbASOiTYHF8dbuuGP8
	C/QRzDqJR7lcOpbi9QcREGtsNsxzZscGF6LO5j6GVGA2cRaFmo/yd4AXjjiSUOO5gFHvVzYZ9Wa
	uLKzrVf+Lxi/SztQQdCdF8aA1YeGTZ/vo4RdyG9X/1E70p/Y4WeyREtOy6MmFHNsORhqSHUX5Jw
	P2mpAEuEFWVddQk9y5rQsW4xbZaj7VXg0X5TkwkQHTr1xKvu2pgttPfVC5VVPM3DhyVlT9aFphj
	Zaodil/SS5/QdCVnBBJJkPo/Yri70s661wPsanGsSjyQuQ==
X-Received: by 2002:a05:6870:45a0:b0:42e:7e04:e9ce with SMTP id
 586e51a60fabf-468328882d8mr1702119fac.0.1787867069273; Thu, 27 Aug 2026
 14:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260827185722.3234622-1-csander@purestorage.com>
 <20260827185722.3234622-2-csander@purestorage.com> <CAJnrk1YfTg-Lz+TmM+c=Asc8N4QGuY9_g8zUXtaNr4O7hG1Djw@mail.gmail.com>
In-Reply-To: <CAJnrk1YfTg-Lz+TmM+c=Asc8N4QGuY9_g8zUXtaNr4O7hG1Djw@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 27 Aug 2026 14:44:18 -0700
X-Gm-Features: AcwNN1UylVUquZ8opNqZqu3tNIHriO6d1S55vB3s5Iygu5DbEGaADAEUlDBXhJo
Message-ID: <CADUfDZoEosgMMQ47BDWBskTOZrYZpg6VUT5c4kwczDLRLXYk=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
To: Joanne Koong <joannelkoong@gmail.com>
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
X-CRM114-CacheID: sfid-20260827_144430_549092_2B4E626D 
X-CRM114-Status: GOOD (  21.06  )
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

On Thu, Aug 27, 2026 at 1:05=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Hi Caleb,
>
> On Thu, Aug 27, 2026 at 11:57=E2=80=AFAM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > In preparation for setting the io_uring NVMe passthru CQE results from
> > the blk-mq request completion rather than the task work callback, split
> > out functions io_uring_cmd_set_res{,32}() from io_uring_cmd_done{,32}()=
.
> > This allows io_uring_cmd_done{,32}() and __io_uring_cmd_done() to be
> > consolidated into a single CQE-size-agnostic function with 3 fewer
> > arguments than __io_uring_cmd_done().
> >
>
> The conversion looks logically correct to me but the interface feels a
> bit annoying / fragile on the caller side.
>
> Is there a way nvme can get what it needs without changing the other
> callers? Would it work to just keep the existing
> io_uring_cmd_done{,32}() as is and add a separate API for special
> callers like nvme, eg:
>
>   void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64 res2=
);
>   void __io_uring_cmd_done(struct io_uring_cmd *cmd, unsigned issue_flags=
);
>
> where io_uring_cmd_done{,32} would then just be inline wrappers over
> those? afaict, then only the nvme callsite would have to change and
> fuse, btrfs, block, ublk, and scsi_bsg could just stay as is. Do you
> think something like that makes sense to do?

Sure, sounds fine to me. Thanks for taking a look.

Best,
Caleb

