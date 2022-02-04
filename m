Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727EEC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ow88Lu4aUs6K7UkGLeI5Z43Nbv5HpcgNARMLv9ghlkU=; b=VgdxNRpK54qLUG3/J6SXj59mLi
	MHIfR4DMtFPBG7qj085YDBDQUyfm1LJfaZt4/LCtxzAS1s0nNdl4XNfxWR3NAHDTa+iCHIYeyXzkF
	5a3h0bZdDXyiGqG2u55otbKUxWVs8PmCvDtmmFN32NoWOggT+tAfSddlLr54SeeoeCHbFBBeFcefI
	Bd+WFirQgqFHqAvcZkOoLtYtW/QsDw2eBkUQ3J7OlXXmMV2bGfad8+XsLhf0Tu1U2ysSUGzJvJKPW
	1mrWW7gaNtNAbxkaxZHIec2vDunWHPHWSmNnLmBu0LXnnj65aH1S6C3r4xSiz+uPV7cBk9Ch3JgoH
	tak2vGSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nG4TC-005JaI-H0; Fri, 04 Feb 2022 19:42:10 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nG4T9-005JZA-R9
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 19:42:09 +0000
Received: by mail-lf1-x129.google.com with SMTP id z4so14651372lft.3
 for <linux-nvme@lists.infradead.org>; Fri, 04 Feb 2022 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ow88Lu4aUs6K7UkGLeI5Z43Nbv5HpcgNARMLv9ghlkU=;
 b=TpFi/w8V+E7pbO9sIvLpXZCpdWezLN3gUSIfpae0rAfXunnHQoI1jO+McdOkoyyvry
 rpUeXbR2S4FMUcIK2ROcUGKWUUt29F/xn7gfPQugn7xPgfsgy2RjXGSLTqvEFqxQizUs
 UemRWsnEtkd4NE/9MnMJJY+2kzZrILdV0UEahM7z9pM9c2PBRwlaavtJq04TKtp2RKMi
 SfNZHW788cW54l6at6TZuezDjBfN360XlNenjVWgmSNXGdnmUCR4lwh/F+hZxzOJfoTa
 zTYtOv5OsrlN8LnEyXtPgrSrhoEO0tFX8dw7kzuvq0hNgelyDruS6BhYPwSZgM8gE7FG
 /67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ow88Lu4aUs6K7UkGLeI5Z43Nbv5HpcgNARMLv9ghlkU=;
 b=uz/dgtCVYYmZnOFlRDejhDfUdia8ALvEmsMSbnJENidf2RdJt45TGhhrhTnHp/KE1d
 Ns5YxPn14oYllugChK+LKQtnpSArLoD/yv8Xwk6g76DhO/B5d4tIqnbUFv++QuJRJ8mk
 zhK7+ySYflBVgBAT9R7tKiB28Nx8iXs4C4fE6qQTvRArv1gFnR982IvmTcKPQTZcwkqH
 XaLSRRYw0MWvbyL8Jx7zE5UcCQ5BMvw+iwCgoyK/fxUBTeZX9tdUd3tNteV31OYh0BBi
 z4wGxwi64uAwYjaCny9rcEGagNWTlIvFsrZ1LzLlJrNsBPUSUyRKTyQMKzJKZdezbajW
 0Iag==
X-Gm-Message-State: AOAM530RXw+lBoqhmgKdx9pjHoJxWG4cCkbU3jr9XoV/n/gnjIfQHXKa
 VuBqyPvTYnZZej5dkZw+LpLZyxVYfv3wm1SYr4I=
X-Google-Smtp-Source: ABdhPJyHIm2s/AwXxjYIOHGmKgAxztwbsh5UaTIz/wUfKedoZaCqO6GHsMXWPEigismScFC9Hc7Iu0UaLWeROhbCTFw=
X-Received: by 2002:ac2:4853:: with SMTP id 19mr346407lfy.563.1644003723415;
 Fri, 04 Feb 2022 11:42:03 -0800 (PST)
MIME-Version: 1.0
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Sat, 5 Feb 2022 01:11:51 +0530
Message-ID: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] NVMe copy offload patches
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>, 
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, 
 "roland@purestorage.com" <roland@purestorage.com>,
 Hannes Reinecke <hare@suse.de>, 
 "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, 
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, 
 "osandov@fb.com" <osandov@fb.com>, 
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>, 
 "josef@toxicpanda.com" <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
 "dsterba@suse.com" <dsterba@suse.com>, 
 "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
 Kanchan Joshi <joshi.k@samsung.com>, 
 arnav.dawn@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220204_114207_902920_C0368851 
X-CRM114-Status: GOOD (  17.76  )
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

On Wed, Feb 2, 2022 at 12:23 PM Mikulas Patocka <mpatocka@redhat.com> wrote=
:
>
> Hi
>
> Here I'm submitting the first version of NVMe copy offload patches as a
> request for comment. They use the token-based approach as we discussed on
> the phone call.
>
> The first patch adds generic copy offload support to the block layer - it
> adds two new bio types (REQ_OP_COPY_READ_TOKEN and
> REQ_OP_COPY_WRITE_TOKEN) and a new ioctl BLKCOPY and a kernel function
> blkdev_issue_copy.
>
> The second patch adds copy offload support to the NVMe subsystem.
>
> The third patch implements a "nvme-debug" driver - it is similar to
> "scsi-debug", it simulates a nvme host controller, it keeps data in memor=
y
> and it supports copy offload according to NVMe Command Set Specification
> 1.0a. (there are no hardware or software implementations supporting copy
> offload so far, so I implemented it in nvme-debug)
>
> TODO:
> * implement copy offload in device mapper linear target
> * implement copy offload in software NVMe target driver

We had a series that adds these two elements
https://github.com/nitesh-shetty/linux_copy_offload/tree/main/v1

Overall series supports =E2=80=93
1.    Multi-source/destination interface(yes, it does add complexity
but GC use-case needs it)
2.    Copy-emulation at block-layer
3.    Dm-linear and dm-kcopyd support (for cases not requiring split)
4.    Nvmet support (for block and file backend)

These patches definitely need more feedback. If links are hard to read,
we can send another RFC instead. But before that it would be great to have =
your
inputs on the path forward.
But before that it would be great to have your inputs on the path forward.

PS: The payload-scheme in your series is particularly interesting and
simplifying plumbing, so you might notice that above patches borrow that

> * make it possible to complete REQ_OP_COPY_WRITE_TOKEN bios asynchronousl=
y
Patch[0] support asynchronous copy write,if multi dst/src payload is sent.

[0] https://github.com/nitesh-shetty/linux_copy_offload/blob/main/v1/0003-b=
lock-Add-copy-offload-support-infrastructure.patch

-- Nitesh

