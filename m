Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8ABDC98318
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Sep 2026 05:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pVIiyRqhME2rfVYUFjEtU86And7QcpxR5cM22u9g16Y=; b=VDv2sZqdVP2Ki7yiZtKywUdvSV
	tXmOWstTqdwC9E3lMEPy6DbzaIXPW3jp+D6dMvij7zVdDr0TKMYJBJASCjDOr2AkvskJpSJRmw3s1
	zAS9jPz1+LjBhHLGaJQtSPS6DiC9pDEwjtxMqzFf8y/+6inXtzWMF37aiiOGyTrqmav6aWUfqqbX6
	WUhIzLVYhRWBZP5h99Cn/Z+FCReb/BsmN58lUvNb//VDXpdPB6yJFLh7nOFTeoru/uQMxBp1TjdxS
	9SvwFcxjzK4hO3a+YRe37sH7exSAmhievrMXcuXuUF8Cw/E60vdBw2PaNioWMNnG/j/4k7P3iPvT0
	KdNMn/Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAKtq-0000000F1N6-3Wqb;
	Sat, 26 Sep 2026 05:24:38 +0000
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAKtj-0000000F1Md-3bQf
	for linux-nvme@lists.infradead.org;
	Sat, 26 Sep 2026 05:24:32 +0000
Received: by mail-oi2-x11.google.com with SMTP id 5614622812f47-4c206dc8b0dso1238458b6e.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Sep 2026 22:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790400271; cv=none;
        d=google.com; s=arc-20260327;
        b=mRzUKrC6O0gW+gtUctCSOzveCUKvpvMSpZF4sVEBkoa0LOinx5EOXwtDb0wkmMBP4l
         FYfpUWjEWnjroBLlUQZzQIgf8aVdjGN9aA/wRB2+ZACjJyvH0YdVixt3yOs/3K85tT47
         GgvB83aRZnTI++KGqqWaMR9mBinuAa1CDRLkhOo+fkza0b/Wz+o1ipr0qDRdmJMfoc35
         8E2SDj0GnxNhvvSKTbND7lw4bd+SKso1C+Lgg8kFnoRp8h2FFoaq72uGYXD+/UW+Fmsp
         NxPqeoOnEwZDFV4q5xaqMQLEH3EZ/08ZMClRGhUx6ndyclX1Mvevd6/beBbJm+5zeoRt
         iJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pVIiyRqhME2rfVYUFjEtU86And7QcpxR5cM22u9g16Y=;
        fh=iumGe3dNxWrEuduJG6ICvSbzWC24f1Wa9kHzsgxE9Lw=;
        b=OqvAJJp/y9KfBFZgpbfjhhpp5ThNheb0/R1zMUw3FXuLk3gbn/Q0AUPenqMOgWbTJ/
         6tqxh2nO/URNIvbf/avBsvl8dlUAJFWnLHJ2+6ouoHfqJyuDdWze0kaM0dr/bFA6unMR
         dEuTJdc6WgmapKxILt4dbFMqcApLrzFt16BezsJ2NtmavIPX9x1vOCRWhTAHXVzzMBGM
         LEAFCB/14pngpmaBQJU7qlaIuKMdgUVpUcYm1mqnqf1QEFD0oPPL/vq30SNwxoKZV1KP
         gmeCzVK515T2Wat4U+2cm9B/e9RV7iDfXlI54I1oDHxXXABiFmT6SY05xJeQs6yphiom
         YpCA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790400271; x=1791005071; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pVIiyRqhME2rfVYUFjEtU86And7QcpxR5cM22u9g16Y=;
        b=oVB6JQ26z85SkNRqnKfNNHk3qxHdgqH9dCLyOJU0ZsB7CUHOUuOmz2+J6GdfrGXx75
         EZOHF8xML+L6czV7L+yNTwnVePYh+Rz65GvPSv8zWQF7zIDV8XIzyrU1MegB8nVGC99y
         M22+yhD8UdnVLV6O/0uYqtxZ/w4QZ+GJL04O0QAQCsXfdIsV/52ezPQFLNHJajqMe/+u
         VA6cJkJVOKUqw9OhM1rWJX5qrM5Z0g/p3/Tqh+xGxKGemClF9gQIoUdF3Xa1xwLeVkIi
         mN9bFfG0eaIAIg2xOEO4TejnvR/W3QsbqU39GU3eg1VKOB8FS07lrixha6YsX4Q9yArI
         AvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790400271; x=1791005071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVIiyRqhME2rfVYUFjEtU86And7QcpxR5cM22u9g16Y=;
        b=yzQ6Li/fHzjUcHUVXs2WMMthBY+HWFQUMpP3QdxJA5m5xZYmrYmCo6qTMZvAGV8jWP
         BILmy4XfjPYxXYkCeTGX8IrmjiujKRbnYB0GIQnvP7DLv5uPSKEQaaiYiOF/F9YD1ppd
         U4+MCxW0OZLPEF+2XetqUpeuaym+m18LMMoFRBNC/ked9MVvtnIMtZsktTRTjYSu74+E
         CvM+/0enk59UynRCz40SWSstvGSUf4+OMs09aKCahhK9VIqSpMym4no3/Sa9wr7utl0x
         1CnQtXrDwNu/KTQ1Vjm1iBw6ogdo3yyqnD33ypjAMunDigGJ0sC64PwwiLAGjK/L2V93
         7ZUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgLB+uEzZMjcaWrW4AG8pLr1xTanwMBpJplf6OIbnRlf4xjEgNay02aQUjG6rhvRrrTJjQdVz8ki3I@lists.infradead.org
X-Gm-Message-State: AFuF++naDfP98NObzRYb+p+GBuU5jQyRuJx+Pl0NmUHmsa8tOWtnYrwj
	J0Jq9pmDRAcpNDYRyEd/CuPIm4K/4rMV4NgLhXCldJP9z3ZjGuIDReI8LZTqWu3VswI5d05PNI5
	3JivOdAwr2+fQOYqrzrdEQ4rqLwCi6uw=
X-Gm-Gg: AYBFou21sSR9ThOHkpoqNWtLKjBAVOpdutqPBoqJSMYL1MEw9Bprn1o2F/NRkQ+BU6m
	NH6D5vTwjTobJoXnPnLNqiv8PNAb9EXkGTXUm5xQOkzGg9YgBz2n2fTz/Ikr44m8JsFxhe8Wdcm
	nntFRDqZiT26kIsTX9mMm1oL2ieJe2dB0gRc+c2oLkOVByP2hM5OArUFlkOV7eYxr2fzlMqpoAo
	oSa/ZvJOcgEvLI57gURJeSww+MNsKZSo+9O1o3t+7l5cO7dVN0hqTg2ikt8aXfjnWRSoDAkcmOf
	TRy/bNs66JzCt3wO/ns4nr7uIsDCr3/zrL7wFpXYUknbLVmVeQemZB5E90/TFSmjzM2mmjbmwAx
	wRp1E2fydGtKxQm5O7acBL+s=
X-Received: by 2002:a05:6808:1782:b0:4d6:92d4:c806 with SMTP id
 5614622812f47-4d72be3a1f7mr8385532b6e.62.1790400270638; Fri, 25 Sep 2026
 22:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260923152653.40953-1-yupeng0921@gmail.com> <arP0TmdK3FnNfbwH@localhost.localdomain>
 <CAG3TDc0bQJATmJR5dF5j9RoDp1ti-tbAiUkLRGq4zX2CYD3unQ@mail.gmail.com> <arZFtIkV0vg_aQR7@localhost.localdomain>
In-Reply-To: <arZFtIkV0vg_aQR7@localhost.localdomain>
From: peng yu <yupeng0921@gmail.com>
Date: Fri, 25 Sep 2026 22:24:19 -0700
X-Gm-Features: AclHuK_i4TetM7wyRpEb-4NCnm73C_jTw7zDqMN5n0xOhknlW_0BTd0EVzLx3Ao
Message-ID: <CAG3TDc0zdhUaTYy1tk39VcSE6PipiTLDMXU0cUZ04yOijOgWOw@mail.gmail.com>
Subject: Re: [PATCH v3] nvmet: add cgroup_path to charge namespace I/O to a cgroup
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_222431_906602_844CBA47 
X-CRM114-Status: GOOD (  31.53  )
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

On Fri, Sep 25, 2026 at 2:59=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Wed, Sep 23, 2026 at 09:34:48PM -0700, peng yu <yupeng0921@gmail.com> =
wrote:
> > The LVMs are close to my real use case, so I mentioned them to explain =
why
> > I need this feature.
> > When I write the testing code, I try to demonstrate the usage in a
> > simpler way, so
> > I use RAM devices.
> > Sorry for the inconsistency.
>
> Understood.
>
> > > > * The subsystems are exported to different users.
> > > > * We should provide each user a specific iops/bps quota, thus a noi=
sy
> > > >   neighbor won't impact the performance of other logical volumes.
> > >
> > > Why cannot you place users into respective cgroups and configure
> > > appropriate per-device limits?
> >
> > I export the devices to nvme target. Per my understanding, the IOs are
> > controlled by kernel threads. The users are remote users, so I can't fi=
nd
> > a way to put them in a local cgroup.
>
> I see, so the core of the issue is that local storage is exported
> remotely as NVME (over TCP) and you want to regulate IO on the local
> storage.
>
> 1) resembles loopback devices where original task's blkcg is transferred
>    to the kthread issuing actual IO. Is there any userspace component
>    fronting the clients? (whose cgroup the IO could be associated with.)

I'm using tcp-nvmeof. Per my understanding, there is no local userspace
component. The tcp-nvmeof listens on a tcp port in kernel space and
sends the IOs to the kernel block layer. So I can't find a userspace proces=
s
and assign a cgroup to it.


> 2) it also resembles FC app ids (blkcg_set_fc_appid()/blkcg_get_fc_appid(=
))
>    Could you look at that whether a common concept could be used? (I
>    haven't looked into detail how the client side is handled [*].)

The FC app ids export the host side cgroup. But I want to not rely on the
host side information, limit the iops/bps on the target side. I'm not sure
what I can use about it. If I miss-understand anything, please let me know.

> Thanks,
> Michal
>
> [*] And now when I'm thinking about it, I'm not sure one can trust any
>     app ID that is sent over...

