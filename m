Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB576C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wuRrFu5cUVUqipL227+fRPZtFhvEt9/85KsEOXh5jl0=; b=phAlYKeG9DUrkkDVtdSW7HnsGN
	pQAqdxvVq+Xg9crwmnfU4RCdmaXWl6frG17wr9/EtbZ0N+t1acQTPuhrVMFHqGjqQRV7B6uy2JcQT
	2NYIJ7oa4CF1n3Z9EmKjmPVjsNHRBD1hGRmdJRFeidYQKCtSes20HKoIB3T8MQDh7HiK95FU0sHbq
	dsIXdQCKjIbUfcHuJQBcY3ai2B6jVRkq++jn+WWP3sBI9UZT765yoFxIejx0nUntMA/LkzwiUeZZL
	qnGW7h36GjAJ7PtlAnQWeb1akFnaDk4wI1U2daeV4neLyP3VcZWhgXv6KXRaz8xR6PQHq5L5yoYRx
	6HRh53dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWZ4E-00AHo5-6T; Tue, 22 Mar 2022 07:36:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWZ4A-00AHnE-PB
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 07:36:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647934587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wuRrFu5cUVUqipL227+fRPZtFhvEt9/85KsEOXh5jl0=;
 b=jG5rtXDANFU3ViIeSWF7n4QeQNM8+vM/lxbSqVezgWiYigoUs48j4A/1ZssFqhNZ/3r2Jh
 QtT5WIrv+fHZ3C22KDIGiefhi8BoBIziKU87ZIYL26ZNkBYte0p3qA/5cljnj85c1qSiY/
 H4svxUj/lGm3J85JYpo6Qg5QthrzyTU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-OBZmRtq6PfS72cDIwziSPw-1; Tue, 22 Mar 2022 03:36:26 -0400
X-MC-Unique: OBZmRtq6PfS72cDIwziSPw-1
Received: by mail-yb1-f200.google.com with SMTP id
 b12-20020a056902030c00b0061d720e274aso13890417ybs.20
 for <linux-nvme@lists.infradead.org>; Tue, 22 Mar 2022 00:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wuRrFu5cUVUqipL227+fRPZtFhvEt9/85KsEOXh5jl0=;
 b=CWBg8A+LZ2dHgcj74b/nwkDwDgxb2VIr1mwnyY4rNaSZs77bLOk5NIKlyB7UCcegsJ
 fmWuPP1HnE5Pv3cNiknJyLEbxwr4AoW5UrBUijJzdRL5oa8OILJLXDNz8WSrd0kq36eF
 0D3cwz78bq4Wq0nT7SSPIeLq5TiTEsoq5iFhtsas7km0Xrod24b6kyGq684UOD7xzLwU
 9yocyshWX2q9vZRLwbmlb8dMFUY/KUhsfPZtSoXQGPPC65HRdYzG6i6PM48sv0DBRX14
 EDgCshBh92MujlxT3k/o/Lon6jrH8yiQD+wT/zV8GERJ1Gx33dmcNZJoOOIerLtRg6jF
 kiPg==
X-Gm-Message-State: AOAM531x2FXwrabHZwUWwRQ+w7GqCTVDnBvuRJYj8lL7ukhpPE4WDVy/
 8uYE5ekrpPEYPBrFudFu0w2n71FxMZMc5nLxULw+xrVbp9DN/udc4LLSr1q+KfJwxroBAPWE+Vm
 x2nxsXoqcXjzadPJ4RZnq+PNACYGdbxxX9EZxC8cZwao=
X-Received: by 2002:a25:6e08:0:b0:633:6ade:e95c with SMTP id
 j8-20020a256e08000000b006336adee95cmr24781872ybc.489.1647934585702; 
 Tue, 22 Mar 2022 00:36:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrNJf4CSwm5n2+dQ8e4PKJuYJ746DO4tb+dICt8VHxI9e7TiXuz2wEye8LJChdsYi6q/e266oM9xHuq7awqus=
X-Received: by 2002:a25:6e08:0:b0:633:6ade:e95c with SMTP id
 j8-20020a256e08000000b006336adee95cmr24781859ybc.489.1647934585517; Tue, 22
 Mar 2022 00:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
 <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
 <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com>
 <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
 <9ba8bfae-2363-e331-83c7-317a9456da31@grimberg.me>
 <CAHj4cs9cmOt=9++wuqJ1ehLPDJcaXJGyTKcHSjU-avWxr1CBrA@mail.gmail.com>
 <f5394785-aafa-784c-9ac0-b4abe19f65be@grimberg.me>
 <CAHj4cs_WQg752czaR4mtaZVPRW6ZqO16EAHZ10njRB+g+8gOOQ@mail.gmail.com>
In-Reply-To: <CAHj4cs_WQg752czaR4mtaZVPRW6ZqO16EAHZ10njRB+g+8gOOQ@mail.gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 22 Mar 2022 15:36:14 +0800
Message-ID: <CAFj5m9KD+AUn1nJ=XaqwuuWz4TQgZ+d8Uxq8n7j3adHvg8gR0A@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
 RDMA mailing list <linux-rdma@vger.kernel.org>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Nitzan Carmi <nitzanc@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=minlei@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_003630_934903_45F32B38 
X-CRM114-Status: GOOD (  23.95  )
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

On Tue, Mar 22, 2022 at 12:58 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Mon, Mar 21, 2022 at 5:25 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > >>>>> # nvme connect to target
> > >>>>> # nvme reset /dev/nvme0
> > >>>>> # nvme disconnect-all
> > >>>>> # sleep 10
> > >>>>> # echo scan > /sys/kernel/debug/kmemleak
> > >>>>> # sleep 60
> > >>>>> # cat /sys/kernel/debug/kmemleak
> > >>>>>
> > >>>> Thanks I was able to repro it with the above commands.
> > >>>>
> > >>>> Still not clear where is the leak is, but I do see some non-symmetric
> > >>>> code in the error flows that we need to fix. Plus the keep-alive timing
> > >>>> movement.
> > >>>>
> > >>>> It will take some time for me to debug this.
> > >>>>
> > >>>> Can you repro it with tcp transport as well ?
> > >>>
> > >>> Yes, nvme/tcp also can reproduce it, here is the log:
> >
> > Looks like the offending commit was 8e141f9eb803 ("block: drain file
> > system I/O on del_gendisk") which moved the call-site for a reason.
> >
> > However rq_qos_exit() should be reentrant safe, so can you verify
> > that this change eliminates the issue as well?
>
> Yes, this change also fixed the kmemleak, thanks.
>
> > --
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 94bf37f8e61d..6ccc02a41f25 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -323,6 +323,7 @@ void blk_cleanup_queue(struct request_queue *q)
> >
> >          blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
> >
> > +       rq_qos_exit(q);
> >          blk_sync_queue(q);
> >          if (queue_is_mq(q)) {
> >                  blk_mq_cancel_work_sync(q);

BTW,  the similar fix has been merged to v5.17:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=daaca3522a8e67c46e39ef09c1d542e866f85f3b

Thanks,


