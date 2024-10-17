Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39013D37487
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M/sNAOttTRehTqH0GNrvZWX70JRS2nI++C9n6sUsvlg=; b=tAWp8CzC+0Pg+DDooYni/ZXFd7
	EC/aGe2x8wNjC4KLC65tB7FYgsOj8Kde6S1mj0/QwYf7TIMDVjoBeb+2HrYGeryaDooYnlTfvnRlp
	NiYwK/6pfyeKDwpKePzY991FAIdQw2djPWW3hU9+RZMLQKWduvtRMe1FqnNcqXRsKlDRUzRs2G6rd
	OUJwSI15d3GSEoAm+cNtJCqPNV7S7hNKQFNIBU0by9gCmWlDRqy3KKeQXAJvlau9tz5G18nShLrLV
	IC7vlahox3C0dJ4vNFLmj3qyuvyi1YtLEW1+omdBR/QE0jeC8meblRIX88H8g9X7R0CDuCf1Wp3d7
	DCQQxkbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1QEo-0000000Es9r-48yg;
	Thu, 17 Oct 2024 13:08:22 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Q6u-0000000Eqw9-0dwV
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 13:00:13 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5c9fd6dae47so902211a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729170010; x=1729774810; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/sNAOttTRehTqH0GNrvZWX70JRS2nI++C9n6sUsvlg=;
        b=Jyy0jy6MAbXXftrAwV5+4XPaLRv8w5XCdiEp3sQeRuhAghhz5BLKYTy9dUzQbgKj4t
         7x9aoyI9FFYdocJ7Gf7x7WC2u1KJIBt6qQorHvCwJoLLbXNl7XGvdtaCDVIiA3lZz5J4
         92NXhcue2Gf4rHCO/koyNccbUTdP9EvYL1v9nYJ/zMHNuj6tzUf+cnbtdEMZFr/BUncV
         6Xcma/RQwDRIx7cbmOkZyvejWXcNQ2nDslQLMtS7c9I6ykJHMId5FXPGY6ub3pGT/4NA
         1rztBkA8JzAtV/mSn8UGe0GMLBskNkD/6alRRj+Eae0iAIk+oBOGHuOXzVauvSJpCykb
         bYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170010; x=1729774810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/sNAOttTRehTqH0GNrvZWX70JRS2nI++C9n6sUsvlg=;
        b=gHYJefLxBlaC9GqRy/B8zD8h4aRJQs6YaZeUSaKLgR+aNbGI/oh9zvxlbioxcAl7Ot
         WFi9yjsi3DdUBpd1qfj+zuGaf0jk+FpceWqCkQSeLp8vUtNp+eLvjzCDw23EQxfKpYhL
         UaR4EFQ4NVaTQz9gUGOAZXqWXkyPNkjEWhP0b7hK+HiGbkaK8jPXjzYRDI+goYDbqpiP
         fioOevRfZbWT6oam1V5T05Ttle8OzN3AxHQHDpE5vwIu04znRSlQN7AOg2F2XDQoCCCk
         VHVih34FuTj09Ak2/xsrsGonaX8EB62zBNMA1MuYuLAWOe0h7sLofGH2d6mLNLlzyEcM
         Bsow==
X-Forwarded-Encrypted: i=1; AJvYcCUKOVZHn0eNW3MyrSC+exQW2HUSJhdU74xk9AbW0L9cn2JVTgnVXOBfmZnu5OG53/D4BxBWNYOAKSWV@lists.infradead.org
X-Gm-Message-State: AOJu0YxgegOqbSs9U573a3Ct0qMLhMSLFq+b54aBcr+opg8tRg3WxMeQ
	zLYunzYt0xKhzDOlG5HxMkapa3O3x6IA0SUXLSwBtpwOUs5RmrNgn0fyWWgobHPidJwT61mLSEv
	n8avxLmHp+Xypr401fzVprugGqQ==
X-Google-Smtp-Source: AGHT+IGamr6o9HLDmizk/nvlvLBMhG6G/RCi0w9Y4JF1DiWP92T0nkk2YMw0YxLct0p0RxUNoQIKIat0oNYuXcfKwF0=
X-Received: by 2002:a50:cac7:0:b0:5c8:a01d:314f with SMTP id
 4fb4d7f45d1cf-5c95ac0d47amr10642342a12.12.1729170009425; Thu, 17 Oct 2024
 06:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113745epcas5p1723d91b979fd0e597495fef377ad0f62@epcas5p1.samsung.com>
 <20241016112912.63542-7-anuj20.g@samsung.com> <20241017080015.GD25343@lst.de>
 <20241017104502.GA1885@green245> <20241017120102.GA10883@lst.de>
In-Reply-To: <20241017120102.GA10883@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 17 Oct 2024 18:29:32 +0530
Message-ID: <CACzX3AtdmWgEggmQsfqHU-GjdbQHTq9DwCzW07VG9zaoXaWfgA@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] block: add flags for integrity meta
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, kbusch@kernel.org, 
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de, 
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, gost.dev@samsung.com, linux-scsi@vger.kernel.org, 
	vishak.g@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_060012_217469_C430E1E0 
X-CRM114-Status: GOOD (  16.19  )
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

On Thu, Oct 17, 2024 at 5:31=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Oct 17, 2024 at 04:15:02PM +0530, Anuj Gupta wrote:
> > On Thu, Oct 17, 2024 at 10:00:15AM +0200, Christoph Hellwig wrote:
> > > On Wed, Oct 16, 2024 at 04:59:07PM +0530, Anuj Gupta wrote:
> > > > Add flags to describe checks for integrity meta buffer. These flags=
 are
> > > > specified by application as io_uring meta_flags, added in the next =
patch.
> > >
> > > These are now blkdev uapis, but io_uring ones even if currently only
> > > the block file operations implement them.  I do plan to support these
> > > through file systems eventually.
> >
> > Are these flags placed correctly here or you see that they should be
> > moved somewhere else?
>
> They are not as they aren't blkdev apis.  They are generic for io_uring,
> or maybe even VFS-wide.
>
The last iteration of this series added these flags as io-uring flags [1].
Based on feedback received [2], I moved it here in this version.
Should I move them back to io-uring?

[1] https://lore.kernel.org/linux-block/20240823103811.2421-7-anuj20.g@sams=
ung.com/
[2] https://lore.kernel.org/linux-block/20240824083358.GE8805@lst.de/

