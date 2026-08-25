Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C973C61DBC
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 16:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+G+f6/zjd8uOjlOFFFuS9kFtoy+MaAtVcFc3NRBELBU=; b=MjMDvS0+Eh9P1+CAJsoDyaXuGb
	d7enuXzXlY4sXoN66UxBSrzQG/ERerper/7TnSrpUVofGQ8yf8AOtYAaUiV4b73nwl6VVRFrDE0bq
	aEg9u8lfss8y7azmoaLP1PLFykwxYZHcSNjtKJLeo6+u805QxqXqJdTJYdf9jxOsdFkKoJmFdDOh/
	WEQgr4xG9V5hIkLuWrmaoVMjh9WlkX6mKPsu4H8ee2dTDf3YCHo6h2rsayuAtFdElSEZr9FGlHh29
	MO5Q9p0xugYIXQH6tkIKhfsbEy/c7on+sqjZUEN9w8pqeTgOOBMHSRIzZ1fGyhKeu97dDC2KnNqq3
	1TcP85kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyuJ6-000000019MW-04rf;
	Tue, 25 Aug 2026 16:47:28 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyuIs-000000019GT-1MGH
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 16:47:21 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2d6af66ca14so800885ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Aug 2026 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787676428; x=1788281228; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+G+f6/zjd8uOjlOFFFuS9kFtoy+MaAtVcFc3NRBELBU=;
        b=ePBoRKzgbikiUBjbTkFuGwBK2eZuhyiP5MWhc1UJWaruyA5IhfnvbsCk+3jphTlTW5
         m0oW4IhW9QbUuMECsTXMMm4B7bPZfcnJxaYNjISnMrjIuUsSHJ74OuAQLDFALd2/v/Rx
         dcDTpgBA8PiBdOUCicZmC2x0rMnHtvgNx7q5hJFd3Ae7LXb2Y+AuhOQq7veC0KXP/Yn2
         6E7QISLrk/PYdBa0f1/+tBKiR4qR4nq4mYHtsEuH+6YwrthXLjEmIU5fUyIsaYQbNXeZ
         RG3SyoxtKJLDc56G0MJou6TEQ6xOCh/g7HbONcGrbOnsjSClW278trGcdDW2sFCeG27h
         TENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787676428; x=1788281228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+G+f6/zjd8uOjlOFFFuS9kFtoy+MaAtVcFc3NRBELBU=;
        b=MqDr3ZkA0ppGQZB16Hf0AWRqRRk2UfZiosEzIgHoL9inT4f469e7KHFKCxJiW7nJb4
         Qt9gjZTSqGa1us0/48jHqyzsEJaZX5IPkuMZwazCtTcTdods7xDdvoPLoD7XUAJc85V+
         PHL3arE42POayZ/MTxdWAxt7JJvqvb49vUmgwflfKhmAfRab+Q/78ryL9+zst1G9bgdj
         XQync01Y/lpx/UzgXcdfD/9aHDUSWq2g/7AgzsnqKKvMYON4sIAukxykuUgAk+4PqNjR
         ZSQPtcG1OZQi25sSk+LF/2shf58AguWvHAedpZ86UWxN/TIQ6rtuS9MxCGahEsQLwMGZ
         Fyiw==
X-Forwarded-Encrypted: i=1; AHgh+Rqpvd9vDJre5Z2mzA0JvIXogpMAhmiWTlL8HwGsDO6iGSR459hFbSt8Z1EOU8JMHhrf0iULvxkZYU+g@lists.infradead.org
X-Gm-Message-State: AFuF++lORnRA9RSam4IohJpxuKevG7dMG+smxRG8i0aeQRyemaRtXoP6
	RBKFieuupVEIZV0pp4qPC2BFRAR5kOd84jMkVzu84HVbQ1MmmtV6cC8Xzb6nUDH7pOU=
X-Gm-Gg: AR+sD13L5hDdrdyl1SFMIZrSrnYg0LYZzThmBa9PHe9sxktd6e5sXRsCz2mJhFm8KL+
	n/F0gggPAo+If+mWzqrTq9nUpWpFGPu/mVhUfP/1xYhWFnj5dOaTOylUx0QjkjiPrMxP1oFZnMe
	HLw+uPQoCHmLUVwgZVjFwakCgXxNoBru/XrnMeglg+Z5zwDnkb84J0LsQzfZ/1+mCnYM5xPgR3w
	wbTqEXPkv5WACPjh3/TjbB7GJuUi91t37DwXsOSnwGOG0x4utL1iAok0FI0p9wQ3DRHUPrx3vUq
	ALuto2Iw3202T553SGYJV0Jxg8+pEzCgGpPjG/D8IzdsPY90My7X20iaHKkYr6+03wu1ZXeaorC
	ORtlVNVg07XUME5/Bj2jZm8b0nqHVYzvJY9z7DbgkAlN0cTeDbQPXR9JiIDKnNnNiqgG5sutTbI
	oqtzyZWDdHKPdReZ1rZA0XpXpK3wL1rolXKJy/C72yozbruPjOsoEx/Xenl3GmXKx5cxhHKOJkZ
	HxYg1UIdA==
X-Received: by 2002:a17:903:38cd:b0:2d6:e074:9cad with SMTP id d9443c01a7336-2d6e0749efbmr166931885ad.6.1787676426753;
        Tue, 25 Aug 2026 09:47:06 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3283d60c291sm313431eec.6.2026.08.25.09.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:47:00 -0700 (PDT)
Date: Tue, 25 Aug 2026 09:46:56 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Randy Jennings <randyj@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove stale namespaces by NSID range during
 scan
Message-ID: <20260825164656.GF323015-mkhalfella@purestorage.com>
References: <20260823004641.1369895-1-mkhalfella@purestorage.com>
 <CAPpK+O0e5HhDHEnu6uUw5AgtJfFoXjCmB2Q+13QDz1HtSdgDUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpK+O0e5HhDHEnu6uUw5AgtJfFoXjCmB2Q+13QDz1HtSdgDUQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_094714_774740_B2704BF5 
X-CRM114-Status: GOOD (  25.35  )
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

On Mon 2026-08-24 17:21:26 -0700, Randy Jennings wrote:
> On Sat, Aug 22, 2026 at 5:47 PM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >
> > nvme_scan_ns_list() drops the stale namespaces in each gap in the
> > reported NSID list one NSID at a time. Every iteration calls
> > nvme_find_get_ns() to look the namespace up and removes it if it is
> > present. The loop runs once per NSID in the gap rather than once per
> > namespace actually present.
> >
> > NSIDs are 32-bit, so a target with a sparse NSID space can make a
> > single gap spin the loop billions of times with nothing to remove.
> >
> >   watchdog: BUG: soft lockup - CPU#4 stuck for 26s!
> >   Workqueue: nvme-wq nvme_scan_work [nvme_core]
> >   RIP: 0010:__srcu_read_unlock+0xb/0x20
> >   Call Trace:
> >    nvme_find_get_ns+0x7d/0xb0 [nvme_core]
> >    nvme_scan_ns_list+0xe8/0x280 [nvme_core]
> >    nvme_scan_work+0x18a/0x280 [nvme_core]
> >    process_one_work+0x197/0x380
> >    worker_thread+0x2fe/0x410
> >    kthread+0xe0/0x100
> >
> > Rename nvme_remove_invalid_namespaces() to nvme_remove_nsid_range()
> > and give it an open (start, end) NSID range. ctrl->namespaces is
> > sorted by NSID, so the whole gap is dropped in a single walk that
> > stops once end is reached. This bounds the work by the namespaces
> > that are present instead of by the size of the gap.
> >
> > Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Randy Jennings <randyj@purestorage.com>
> 
> > ---
> >  drivers/nvme/host/core.c | 18 +++++++++---------
> 
> > -static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> > -                                       unsigned nsid)
> > +static void nvme_remove_nsid_range(struct nvme_ctrl *ctrl, u32 start, u32 end)
> It is not intuitive to me that start is non-inclusive.  May we add
> a comment to that effect?

Yes, it is not intuitive. [start, end) makes more sense IMO. That is
said, this is how nvme_remove_invalid_namespaces() worked and I decided
not to change that because it is not part of the fix. I do not think a
comment will make a big difference here. The next person who works on
this code will read the nvme_remove_nsid_range(), it is a short
function, and figure out how it works.

> 
> >  {
> >         struct nvme_ns *ns, *next;
> >         LIST_HEAD(rm_list);
> >
> >         mutex_lock(&ctrl->namespaces_lock);
> >         list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> > -               if (ns->head->ns_id > nsid) {
> > +               if (ns->head->ns_id >= end)
> > +                       break;
> > +               if (ns->head->ns_id > start) {
> >                         list_del_rcu(&ns->list);

