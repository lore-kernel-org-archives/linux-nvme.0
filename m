Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D4E103E302
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 00:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F6OWmFfQV1izCG9EYIG9kbDlfdem/4leScUohX3A7eM=; b=D8pA8iblCYZP/Hvn3kpviA0D/8
	WRkIm4NUgYTCz2wFLFJ7XSQxzN60dtnXinUfT7UxZUJ6NouAqVXxiVEI8X1Skh5veec87NJNIdfDg
	Nukhx+cKYQRXuu8jjV2g5oT0LzbAQm+jKVzTFSLB6GPL3Gtj0FRxXUZAvZDiaIHcpE1dePb4G77Zp
	uKBxjfk6hTGSydFnu8QRxb5ujc7T48VRbMr5uS5GIFTTYKxtclV+2OKRVc5qG11JWs9+B4yY/tAkh
	x1mf9/E++0CB8iiKgk9fwJFOaDc67e7iQzk6icZX0jObNdrQ3+RSxCyFRI/ieblrlmsjy1QJxQvao
	1BPpa56w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0q3V-0000000FrUC-0dFp;
	Fri, 13 Mar 2026 00:07:05 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0q3T-0000000FrSh-2qxO
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 00:07:04 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so5387a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 12 Mar 2026 17:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773360421; cv=none;
        d=google.com; s=arc-20240605;
        b=Awmn5Up/aJvADflEj1MTkhI3RGCZei7HinXZK+WlZso+kgcgkYjzXuwMp8rE0mt8MJ
         Kmoxbnjg2XGItPKHLqRmBVqxe8FkrvSD1o8USVzlOHdEha8BKEbEnfuHzhBnUk3u9LvP
         UXKroqWYdFjW8qTzyP5PhmEi0q68J9L3/mrEqyz6e88nR31dy/jBTbGs0tqOpmoKRUQx
         jeouj3UZb0L3Ez2ioE0lcB2siWiqRqKLXmgPfqtSRP+Z9TuZBz6QKrmTH+PaVH/K96fA
         9FQ6CqryRBCJ8Ch/WXDFuNtxvVBHrWmwMJ4BgTaf4u3V8CFCMbHMu/1D1qkiky4oOkFB
         O6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F6OWmFfQV1izCG9EYIG9kbDlfdem/4leScUohX3A7eM=;
        fh=RVS0oSYfRsf8ojR5AM5IO3Dgmi0jCi/YHNiQhjK072w=;
        b=k2EZ/4XRCjROLnEZ+9/HmACE6ky7HmrG9UMHgsUno5UqszzlMKiaJQ9REhOohwcYuQ
         AmG0imRYDT38Kr8Cuu4McuC3o72Eliy0B8Q1iC1fuYMK1Sv2MRToorbMENITCCBGX0BE
         7HmT8aHZhPQy3isxCzXd17WTqoY7KXuzySTsvsuTfAAbVnTvPjj3Z0xWE6HYH1fVU573
         O4TsGG1vYl55jNP92S7e2aeTTG87m7w8x6J5+5TiKz6bktuRZ+SsprxffrkwsfU5CXXA
         WEuXD+F5HIiMT0f5VMxjg4uA+7QhW+3UUfoRxed4BMKTSV0lLBsTe4tRbtGm/2Q/bVCT
         3niA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773360421; x=1773965221; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6OWmFfQV1izCG9EYIG9kbDlfdem/4leScUohX3A7eM=;
        b=jQeXIBM+lb2NFCOYb8ZCKbtmrrgVHKO+0sCNwaRMidLZXiHjfTn9abXocxBTsdOzC6
         zmL8TEWRYWczGT7LZomQZx3hYMFtrHjwBAPxd5EXduV7rRR5iFfjghhXuSIuVlGQMVwI
         Ct4B2k0AS45o4mXj5phvoWV+N3O1jrAFbeci4tO7e85detxLiunX17ZPeiIBH/s2gpDF
         adwkVCSb+L5Wsq7JjgBDLA/maKwp7sTkg67WVvvYm1MJyjYe44OFnH44tUQ3cZ+9aHhr
         pgrjo50Iz6VYyqL4VEdX5DwGH1vEA23qRRWViPzqPbBv9trQvTU/WruHZQBItcua1apJ
         Sx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360421; x=1773965221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F6OWmFfQV1izCG9EYIG9kbDlfdem/4leScUohX3A7eM=;
        b=qC/LL9Yreua2ko+D+QZzR1djBOz5BNzxl6N/vzW8KiRaVVBkCI9vNwni3jL5cFUXzq
         /64Ma99kkW1mhElFPdRqfY/3NhWrNy0ta8J8H+pPeH7sbAf4Otjm7EOu3P2em6ayQ4+P
         xqBZPw3QVUJpVBy/3cV1CvC2dYyDMFpeDbnAhoJ6fsFGp2hGfS6gmmd4gZh0iTXspnpi
         5D4QG2TXAcUXDuqhYxdy5GWyrc/o/Sr8inv43BOv5uAcbSnw3e+ti56NTS+q1Cmc2gzt
         xLaA2GYr4FNIrs5QVvN4uhTrufCID9SCRj8OJSQCPm/U3K6s6ZweAzWsR8rsistYdB1m
         j5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNFKwDK4GLgYGDYPuup2IjSZuw2QmCpuM7WeJ6vtu2o2SqSTw6LEtcFxn9KKOaT/QpEJLplheFOw0N@lists.infradead.org
X-Gm-Message-State: AOJu0YzJCPrbchwP9S2zxSGV79AtQK66YHxmIV6Fk0jH5FbLnvyCP5XY
	qcOmTo+nlo5BhGJP4ZHBqQnhkrtZq1rq0vNj3UhAMcghfn4jaEQfiwqJ4iBFfiTkJCw2hqDhj73
	LmZk/ida6P8g95Ro8bNPABcDZMfhk/mDouIdHvVNu
X-Gm-Gg: ATEYQzy87DRsjwG3zZnvcGrdEyf3kISgh39Uhj87mtVAQahiPuykJVhQJXFbZlmysLL
	jvppH/eAiHFdYKd+RIBYczMMwch0GAAWP+Ajgdr0foIcDlUsunp5HB7jwlmb6vgDgb6JIPXykpv
	ZxxsI0Pb5VA/NEM06IKe1uzlz+def/jR9aRBc9exzbkNl//YHFT202Qd5CSEJpYPWYgDM0jKUl/
	VyF39TKUv/FzsWTJAP+5FN6nEJwwec/rG+SFH5sa94HBAxA2XiyIoX214zIwRfZ2w/Pv7prjKlZ
	3lrRJVqzNAbWIK7YsD8fBC2iTphY0RYa1Ik=
X-Received: by 2002:aa7:d44a:0:b0:660:b029:3d4c with SMTP id
 4fb4d7f45d1cf-663bccdc11fmr13660a12.2.1773360420217; Thu, 12 Mar 2026
 17:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260305202735.1773922-1-robertpang@google.com>
 <20260306142434.GB16612@lst.de> <CAJhEC06h=QwxoAkdQ7eyZmW1dJMdBZiiXF3TNHR9L+bhpYCPNQ@mail.gmail.com>
 <6cb1f8de-2484-449c-8cea-c39a39edd35c@huaweicloud.com>
In-Reply-To: <6cb1f8de-2484-449c-8cea-c39a39edd35c@huaweicloud.com>
From: Robert Pang <robertpang@google.com>
Date: Thu, 12 Mar 2026 17:06:48 -0700
X-Gm-Features: AaiRm51TXeNmFaetlGwf5nL0yIseeQS9ZLY4VK6ElRvNZWmUFQMDdQrNUOm6Mwo
Message-ID: <CAJhEC05oC2VZoY7VUycnz3Ho=-4wQxde5R3n2HMxwVVhuVT38Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: honor NVME_QUIRK_DEALLOCATE_ZEROES for unmap Write Zeroes
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Sagi Grimberg <sagi@grimberg.me>, bmarzins@redhat.com, brauner@kernel.org, 
	chaitanyak@nvidia.com, chengzhihao1@huawei.com, djwong@kernel.org, 
	john.g.garry@oracle.com, martin.petersen@oracle.com, 
	shinichiro.kawasaki@wdc.com, tytso@mit.edu, yangerkun@huawei.com, 
	yi.zhang@huawei.com, yukuai3@huawei.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_170703_734601_8EB6E706 
X-CRM114-Status: GOOD (  20.41  )
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

Hi Zhang Yi

On Tue, Mar 10, 2026 at 7:56=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> Hi Robert,
>
> On 3/11/2026 1:14 AM, Robert Pang wrote:
> > Hi Christoph
> >
> > On Fri, Mar 6, 2026 at 6:24=E2=80=AFAM Christoph Hellwig <hch@lst.de> w=
rote:
> >>
> >> On Thu, Mar 05, 2026 at 12:27:32PM -0800, Robert Pang wrote:
> >>> However, certain devices already use the NVME_QUIRK_DEALLOCATE_ZEROES=
 quirk to
> >>> indicate that they deterministically return zeroes after a deallocate=
/discard
> >>
> >> Those certain devices are completely obsolete first generation Intel
> >> SSDs.
> >>
> >>> Update nvme_update_disk_info() to allow the presence of the DEALLOCAT=
E_ZEROES
> >>> quirk (combined with DSM support) to set max_hw_wzeroes_unmap_sectors=
 to enable
> >>
> >> No. This was a hack that got sneaked in in the first days of the nvme
> >> driver and never should have been there.  It most certainly should not
> >> be extended to any new functionality.
> >>
> >
> > Thank you for your review and for providing the historical context
> > regarding this quirk. Given these insights, we can discard this patch
> > proposal.
> >
>
> I just wonder if you have such hardware and use cases, or if you simply
> want to supplement this feature for those corner devices?
>

It is the latter.

Best regards
Robert Pang

> Best regards
> Yi.

