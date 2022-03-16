Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742D6C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+MlSG+PCN1QrvqAqdI+V/FmSzwhtZltZpgLHvQd0pA=; b=DsBFIw5xaHX8Vvics1empx/AqD
	yNe3U3+F/U4gIUOwrJ2F8VbfYUMY9GzvXz1iJyVu5ZraXTKkMgvlgobPwRqqs1vqtexHcG8jB2vRj
	CaOKmQvICEf0bmasm5UlS32jJIWXgqJOTZv8hYPLhGnO1MKVATsNzZM2usvB4gsg6+j5J2KENH1lR
	EoJzQxhSQd6057aqn3pYlEibvoyCKw8XI/Fb7ItywKSpaMimeyqWpNA8xvO1bYQpshYtGoaHghIHA
	ssaLNHNYYoqYJeNrXMf6EBNozUUE44lp8URui+u6SnOnEJj13qrBxdjQLEEa05Gp/hk5M9H0qUFPC
	uFNTV/YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUSDS-00Cg2R-DM; Wed, 16 Mar 2022 11:53:22 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUSCF-00CfOG-J8
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 11:52:10 +0000
Received: by mail-lj1-x235.google.com with SMTP id bn33so2771076ljb.6
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2+MlSG+PCN1QrvqAqdI+V/FmSzwhtZltZpgLHvQd0pA=;
 b=OAKcW8NA6yRBHIf3QblNXdLGjPWH635S3vjzYztlr0pdZxW0c/ANy635P52q0g0MNY
 Uf7MNzsx3YZ67ts6KGQlLvzN8H5iy4ltqcZfz+Lp3e/jRvLhj5+tx6x0hk1Bd7sq7POb
 Usx+nn3CkzPV01hfqNByV+Yi34xdJrI0CBLd3Nxyj5L+PWaE4RCbdGZV+ETES6yDLBt+
 GhEPaqExsi7y5fHHoVKDWpoy45AxXdJwKa/mf0a0DrjcyUseilG/Q+qDgmqEvxMCrwW4
 sIy706xfYgPvqY1nv+70xypy2zpNjsxMbTQkd3+EQuSRGRdd3ZRUjU6YO0ngy0ZJLJeB
 lBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2+MlSG+PCN1QrvqAqdI+V/FmSzwhtZltZpgLHvQd0pA=;
 b=W7Bx5feeF7e1l4xSf4kwlJv+v5K4MRtuDGG9RJw80MGBIOq1+wf2AN4lXrERr/tEpA
 YeTgeZnV4iEbPspdGQRk+panLHfgUSpV3VwXDMaM5bwLHBzdsp497NJgMvRHgqSyuZIN
 52Dg+NoGK6Sv5D24AA4J7/H8FGJ8vI4nPqrv3gga3ZtKEeUP/XvDK+IfNWGZ93KO5mIf
 rys0rBISy8cqjgasAEqoH9ydV320ur96JiV/3mSM1dDDg8i5uJBrDnitNghk+V9wFwx9
 3thtOtSApAtKpXyQeVDFCrwkggxRpBqIVAbEH8rRGeowLjlyFIzP8KX31TVzFpHqIQkk
 srpw==
X-Gm-Message-State: AOAM531ORForbkFdbcT6H9EwzXk+AYZ8CsacDI6znPWxtpjvvD+VK04u
 LdshJLq9jwWyKB4EKVTH/DwDhdsBGOvRtVLqp3E=
X-Google-Smtp-Source: ABdhPJxEP49r9yY0bwlO5aom4dubx0+xTR6k3FdpcyqkLKXjOmBJFreWsAbE30sIpImaY6vozz8Ganl72KbN7xCW06U=
X-Received: by 2002:a2e:3004:0:b0:223:c126:5d1a with SMTP id
 w4-20020a2e3004000000b00223c1265d1amr20117180ljw.408.1647431524627; Wed, 16
 Mar 2022 04:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
 <7a123895-1102-4b36-2d6e-1e00e978d03d@grimberg.me>
 <CA+1E3rK8wnABptQLQrEo8XRdsbua9t_88e3ZP-Ass3CnxHv+oA@mail.gmail.com>
 <8f45a761-5ecb-5911-1064-9625a285c93d@grimberg.me>
 <20220316092153.GA4885@test-zns>
 <11f9e933-cfc8-2e3b-c815-c49a4b7db4ec@grimberg.me>
In-Reply-To: <11f9e933-cfc8-2e3b-c815-c49a4b7db4ec@grimberg.me>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 16 Mar 2022 17:21:39 +0530
Message-ID: <CA+1E3r+_DEw5ABPbLzSp9Gvg6L8XU-2HBoLK7kuXucLjr=+Ezw@mail.gmail.com>
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_045207_657969_ED6524FC 
X-CRM114-Status: GOOD (  28.08  )
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

> On 3/16/22 11:21, Kanchan Joshi wrote:
> > On Tue, Mar 15, 2022 at 11:02:30AM +0200, Sagi Grimberg wrote:
> >>
> >>>>> +int nvme_ns_head_chr_async_cmd(struct io_uring_cmd *ioucmd)
> >>>>> +{
> >>>>> +     struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
> >>>>> +     struct nvme_ns_head *head = container_of(cdev, struct
> >>>>> nvme_ns_head, cdev);
> >>>>> +     int srcu_idx = srcu_read_lock(&head->srcu);
> >>>>> +     struct nvme_ns *ns = nvme_find_path(head);
> >>>>> +     int ret = -EWOULDBLOCK;
> >>>>> +
> >>>>> +     if (ns)
> >>>>> +             ret = nvme_ns_async_ioctl(ns, ioucmd);
> >>>>> +     srcu_read_unlock(&head->srcu, srcu_idx);
> >>>>> +     return ret;
> >>>>> +}
> >>>>
> >>>> No one cares that this has no multipathing capabilities what-so-ever?
> >>>> despite being issued on the mpath device node?
> >>>>
> >>>> I know we are not doing multipathing for userspace today, but this
> >>>> feels like an alternative I/O interface for nvme, seems a bit cripled
> >>>> with zero multipathing capabilities...
> >>>
> >>> Multipathing is on the radar. Either in the first cut or in
> >>> subsequent. Thanks for bringing this up.
> >>
> >> Good to know...
> >>
> >>> So the char-node (/dev/ngX) will be exposed to the host if we enable
> >>> controller passthru on the target side. And then the host can send
> >>> commands using uring-passthru in the same way.
> >>
> >> Not sure I follow...
> >
> > Doing this on target side:
> > echo -n /dev/nvme0 >
> > /sys/kernel/config/nvmet/subsystems/testnqn/passthru/device_path
> > echo 1 > /sys/kernel/config/nvmet/subsystems/testnqn/passthru/enable
>
> Cool, what does that have to do with what I asked?
Maybe nothing.
This was rather about how to set up nvmeof if block-interface does not
exist for the underlying nvme device.

> >>> May I know what are the other requirements here.
> >>
> >> Again, not sure I follow... The fundamental capability is to
> >> requeue/failover I/O if there is no I/O capable path available...
> >
> > That is covered I think, with nvme_find_path() at places including the
> > one you highlighted above.
>
> No it isn't. nvme_find_path is a simple function that retrieves an I/O
> capable path which is not guaranteed to exist, it has nothing to do with
> I/O requeue/failover.

Got it, thanks. Passthrough (sync or async) just returns the failure
to user-space if that fails.
No attempt to retry/requeue as the block path does.

-- 
Kanchan

