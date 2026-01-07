Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AA5CFD628
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qzNG7uqiHdzI8ewoggig0HskK8lGgAMbdXIS/XZZpZs=; b=G32TbpFgLXbRPUhBYiP044wOf/
	ZGTg5GwOUX5p3ShsIn2r6nyZdz2i+u4AYkpASic7kDTox7fDByuzuGVHaIpBEy/9tlv87d+UPp3UJ
	xcwAArTAjEx6V2KJCp7NwwVjDk/qRIJNJyGegyP45Ck5KmcjDVZU3VETJn7XWu5cUg1ybS+JdFyk8
	Bl9+7qU244kHR6FxHMTF7h+llnyZALsPiROGXo3/8Q8iNhVRnSALj9qjuVDsE+xEXis7TYwsdaA8Z
	AqFOCHT22PgdZKDFXwvfEVVH9jMXDfPZTFBM+LJqh3f0dbKAlwNAP5yeWYfGcQQj230E08ejR72oN
	NfKff4yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdTEg-0000000ExYY-1xOe;
	Wed, 07 Jan 2026 13:06:02 +0000
Received: from mail-ua1-f49.google.com ([209.85.222.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdTEb-0000000ExTw-145K
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 13:06:00 +0000
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-93f69720a7cso1254816241.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 Jan 2026 05:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767791154; x=1768395954; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qzNG7uqiHdzI8ewoggig0HskK8lGgAMbdXIS/XZZpZs=;
        b=SSywYLiTO8Ma33XQpaRCb1CHFyUiEgY+eIFobUttUM188NNjp9PL3ZsxCAN+9o8hBA
         Txxbsqa378IiFfv/PdUOmdL5Q9rLsyUS802sT7igLCbfvJ2Pry919DkwcZftGhcd5u26
         ApdxyUtMLyb/wsp6g86kQ2gQ8hTaUVmNYBacbKDCWUjRN9fJWEDUvAyRiqJZ//qhqRA7
         eLQ5nHFKXYXJguuMrjnhlePPuF4grr6eCoLxKzlNH8wRxwnAuE9opZnHV4IB45mv+xpN
         +Rdti+Kz1Af+jPoXClIgfzTfHOkPQQ6xw2MYonhMk9j0ObR874tjQj0qaOSzR0uGF2mK
         BDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767791154; x=1768395954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzNG7uqiHdzI8ewoggig0HskK8lGgAMbdXIS/XZZpZs=;
        b=eP4AGcmlxo+IrymPU/mAQP36SQB2AAv2JxJ7sH9DN7iJt4oPw2HO1//QfGnfyj2AN1
         taQn/eX23USMxz2i3F8ITO9EGWq5p+UgfBt8WyQa43tlqmI8UM3Icd7lyYgYzOhCfpNp
         ayLrka929C/lPHMTgL6gYVdlV/tXKVdKVu7/02IEmdq9ShG32v5Ud2HiqEP/7Bl0ymse
         s8oET+qYAyw0tnFldKY1pnSQ+6H+hQCf9VbYUriqV1f/Bdz98aByQZEsUtSvznfjNEvT
         imHIkO6abDFPr92xgihf5EttufqzWE3d6vRgEmNkONm2VLXvhZjD7IimOlxtrfwt5rYJ
         Ws3A==
X-Forwarded-Encrypted: i=1; AJvYcCWr/iFklesbcbeZHipW4Ib4CjJv0Zqpj3WWQa/lGNAIZV+miq/XrxU/+Y2evomY4/6oGBu60IH7sfLt@lists.infradead.org
X-Gm-Message-State: AOJu0YxMTNGwmEKzxPXUpM7VvtCKwKAF8OR4muqUrl4XzqhKSbanhXuB
	ZV5ZH1m0tgQkU8fE0+TCdX0FW5++xL2BW8qyHajGIYS+RFf4lRLBZ+EYPBLO3ytBbPb5+7LAehw
	BqV8RVJWv5PSMqmj9yAlOQcWgQrcmaVk=
X-Gm-Gg: AY/fxX5VT7JEX9jzAaM5zeH3NX7Oq40I98DxRhXo1m6+YayDgnGpEBSZdOXkBd3iHmF
	fqG1T8GRbx8Oxe/6CBgtTdJxZzvJx7HcoqTH0MdWQ+sbXO9aWxg9+sfs10ZkHbkAqE11j4EWl+U
	OxZE3hQCvjbuxIt+sMdLnkZ2r+5CWfdLsQnLpaa5T+/ufKSJ8Ks7E2KXl0mv8knzuN5TvoGlIda
	1Q+DuQxe/Nn5L5N3kla5+4/MerSzI1OCFfwUqX1QYBy5FkMS0PVrRZhtd1DQUqHVSkI5xgOhhPq
	kRbOSQIEiilEssJ8pJM3ix60CKqU
X-Google-Smtp-Source: AGHT+IFnNlNo6WDhAIrQsE84p6Xjc9YulduAvY+W3lIyNrnjsdyAHz3l5KS7q1vQazIQ+gufafyHW/niyaYPbQ4u/j8=
X-Received: by 2002:a05:6102:3710:b0:5db:f5d1:5799 with SMTP id
 ada2fe7eead31-5ecb69056c8mr956926137.33.1767791153625; Wed, 07 Jan 2026
 05:05:53 -0800 (PST)
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com> <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com>
In-Reply-To: <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Wed, 7 Jan 2026 16:05:42 +0300
X-Gm-Features: AQt7F2oYpr1KySfJY9yrBJPS500_11WcpTTT3dSzcpl_rsbFoDQJth87qlW7Iwo
Message-ID: <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_050557_324587_29E5CFC1 
X-CRM114-Status: GOOD (  20.71  )
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

> What is the actual usecase you are trying to solve? You mentioned "avoid
> journaling", which does not explain what you want to achieve.
>
> You could arrange your data so that it suits the rules.

I can't. My usecase is a distributed ceph-like SDS based on atomic
writes. Writes on a virtual block device have arbitrary length &
offset of course, nothing like 2^N, like on a regular block device.
Atomicity is implemented through journaling (double-write) on disks
without hardware atomic write support.

Then I found the new atomic write feature and SSDs with support for it
and implemented a new storage layer which can take advantage of it. My
new storage layer has write amplification about ~1.0 with atomic
writes (i.e. almost zero overhead). It's a huge improvement for me -
the old storage layer has WA from 3 to 4.

And everything was fine until I finally deployed it with enabled
RWF_ATOMIC (production setups should use safety features) and stumbled
upon the 2^N restriction... It was a big surprise, I never thought
that such a limitation could exist. It's absolutely irrational - the
device doesn't have that limitation and I'm just using the raw device.

It's normal and expected in the context of simple file systems like
ext4 and xfs. But for the raw device... I only discovered it after
several days of investigation with bpftrace and after reading the
kernel code. It's really unexpected. I think anyone expects the raw
NVMe disk to have the same requirements as it's described in the NVMe
spec.

> The atomic write API is based on:
> a. doing statx to find atomic write min and max limits.
> b. issuing a write with RWF_ATOMIC means that the write should be
> naturally aligned and fit within the size limits.
>
> That is the same for both raw block devices and regular FS files. And
> any atomic write boundary is not part of the API.

For raw block devices, you also have sysfs. You can look there and
determine actual restrictions. In fact I didn't even know about the
statx API when I was implementing atomic writes, and I don't use it.

And speaking of that API, why does it have to be like this? Currently
it looks like an API designed around existing internal restrictions of
the implementation - of two implementations more exactly: ext4 and
xfs, both of which are classic non-cow file systems. I suspect that if
it was primarily designed after zfs & btrfs then chances are the
restriction wouldn't exist.

Ok, it's already designed like this, but anyway, if the user is fine
with statx and with the 2^N restriction, then removing the restriction
for block devices also doesn't break anything for him. He'll send his
2^N aligned writes just like before. It's fine for databases like
mysql & postgresql because they always overwrite a whole fixed-size
page. But even speaking of databases, it's not guaranteed that **all**
databases will always have the same layout and that arbitrary atomic
write offsets will never be useful for them.

So again, can we please remove the restriction for raw block devices?
I can re-submit the patch :-)

