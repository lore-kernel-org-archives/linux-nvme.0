Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA686C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g11YATVGlm9QDWdkZMVDHYSrW2eUA2Ft4/d478Ytd4A=; b=48niGC5dRJ6WXqxbY34I/aw7D5
	/0YRiDEOW6y1pXDNxJyEcDxmNHuPuUezXPk5VYrcawtasFf7wd73PBGfCfTgjTSPhtu/hnorJZeOZ
	Hea5ISgLZw04gLcmATtGvpzO+sigRMEoOW8J753xBgZFKVH+fQz3gJhZnb1s/Ry2KWJpwRY0zGRFD
	tPJlTvqiq6+cooHuooBehW8qIHmens6hDAIRPXU5tDjO0evYC9J1lb1UTt67ZWcd1HlHFOe5H7zef
	ix3HANYfj34ax2Slo4WR7eK8pQ3gDrSBsP9NSWehoXJyb/fHa+as3uajBTy3egsJwVTkzKwPjdhVG
	42dq5kpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxCwf-00HOWG-H1; Mon, 21 Nov 2022 19:59:09 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxCwc-00HOV3-AQ
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 19:59:08 +0000
Received: by mail-io1-xd35.google.com with SMTP id d123so9427152iof.7
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g11YATVGlm9QDWdkZMVDHYSrW2eUA2Ft4/d478Ytd4A=;
        b=eu8NSCDHBkk6c/Z8R8ps/kZgrHIVJ6w76HFMApJLjK3Iv+V2YMPkOb6BDlSCS0vkQQ
         PH2X+7Ih8jS8D6HC7Ad5ftqQljudWRmXqX7AI2mz73BzrXpsyAWCRKVGO/ahrkZkPIZF
         22h6lPSVgtLlUUS+vtKRqUN7Z13eUPa/h1tpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g11YATVGlm9QDWdkZMVDHYSrW2eUA2Ft4/d478Ytd4A=;
        b=X6U7FkvrWerb5ga2+nbJIn2O79vDy2POQZK6A4GZtxDo7MCB9GQiSg4RBg3zf4ogYm
         I/KzmODHiKUbGR7/JRG3DOEotIzpGkXIAXWws1sQWSsujUbt/losZTv+KcyHqLDGD9hb
         8AuXE4P96oNsGONHJPFU6hMmGgw6WExvB/FQWcWs8LlrdxXEGOwM+1zAscq+uN5bZpti
         w6woydQHwgODHFdhDmZLOo0cVOQ8+5y0xj+dbZ0MQ5UqKc3XnqjAvjeoLrDCgmKBsJGz
         cG+MStY3s/5y4pW4Q0WLUzAg+DfeV7+K0ya56MY/HSRwnfOY2iIi/3A2qc9Gdl1kpLFX
         iVbA==
X-Gm-Message-State: ANoB5plb9TU5vmRoLaCTf1nINydzW4bPKJDQyMDKerAMCq7m3qC7ShPc
	KRv2jT3MzV8GTWAlhGVLEmrtkH+piU7jH1jkYg5Hjg==
X-Google-Smtp-Source: AA0mqf6Q1AkvIqmPKk1ldt13r9CNwcytOdV6WadbRL8Iozw75a1bTfjwf0iLQnnCDkIknm3UmVYk0DGFWEmWYv3qC3E=
X-Received: by 2002:a02:c492:0:b0:375:c128:72a6 with SMTP id
 t18-20020a02c492000000b00375c12872a6mr9324845jam.151.1669060744898; Mon, 21
 Nov 2022 11:59:04 -0800 (PST)
MIME-Version: 1.0
References: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me>
 <20221121074039.GA24507@lst.de> <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com>
 <20221121175932.GM4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221121175932.GM4001@paulmck-ThinkPad-P17-Gen-1>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 21 Nov 2022 11:58:53 -0800
Message-ID: <CADUfDZrVT2tCnUkorJ94Mzd20n-Ch-8cZaSeT0LbowH3dwQ=yw@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
To: paulmck@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_115906_457779_B6171FB4 
X-CRM114-Status: GOOD (  32.23  )
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

On Mon, Nov 21, 2022 at 9:59 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Nov 21, 2022 at 09:48:31AM -0800, Caleb Sander wrote:
> > On Sun, Nov 20, 2022 at 11:40 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Sun, Nov 20, 2022 at 01:24:51PM +0200, Sagi Grimberg wrote:
> > > >>      sector_t capacity = get_capacity(head->disk);
> > > >>      int node;
> > > >> +    int srcu_idx;
> > > >>   +  srcu_idx = srcu_read_lock(&head->srcu);
> > > >>      list_for_each_entry_rcu(ns, &head->list, siblings) {
> > > >>              if (capacity != get_capacity(ns->disk))
> > > >>                      clear_bit(NVME_NS_READY, &ns->flags);
> > > >>      }
> > > >> +    srcu_read_unlock(&head->srcu, srcu_idx);
> > > >
> > > > I don't think you need srcu here, rcu_read_lock/unlock is sufficient.
> > >
> > > So the code obviously does not sleep.  But I wonder if anything speaks
> > > against mixing SRCU and RCU protection for the same list?
> >
> > As I understand, synchronize_rcu() only synchronizes with RCU critical sections,
> > and likewise synchronize_srcu() only synchronizes with SRCU critical sections.
> > Currently nvme_ns_head_submit_bio() is using srcu_read_lock()
> > but nvme_ns_remove() is using synchronize_rcu(),
> > so there is no synchronization at all.
> > Since nvme_ns_head_submit_bio() sleeps during the critical section,
> > we definitely need to keep using SRCU there,
> > and therefore nvme_ns_remove() needs to use synchronize_srcu().
> > I agree RCU would work in nvme_mpath_revalidate_paths(), but as Paul points out,
> > nvme_ns_remove() would then need to synchronize with both SRCU and RCU.
> > This seems like it would complicate nvme_ns_remove()
> > and require waiting on readers of unrelated RCU-protected structures.
> > Is there some cost to using SRCU over RCU that I am missing?
>
> The cost is that srcu_read_lock() and srcu_read_unlock() both invoke
> smp_mb().  This might or might not be a problem for you, depending on
> how fast your fastpaths need to be.  Another cost is the need to pass
> the return value of srcu_read_lock() to srcu_read_unlock(), which is
> usually more of a software-engineering cost than it is a performance cost.

Thanks, that's great to know! I think this is probably not performance-critical,
since it's called only for changes in the connected NVMe namespaces.

> Of course, the easiest thing is to try it both ways and see if you can
> measure the difference.  If you are unsure whether or not it is safe
> to replace rcu_read_lock() with srcu_read_lock(), you can just add
> smp_mb() after each rcu_read_lock() and before each rcu_read_unlock().
> That won't be exactly, but it will get you quite close to the cost of
> srcu_read_lock() and srcu_read_unlock().
>
>                                                         Thanx, Paul

Regarding your suggestion to use synchronize_rcu_mult() to wait concurrently,
I'm not sure it's possible to write an equivalent to call_my_srrcu() here,
since the srcu_struct is per-nvme_ns_head rather than global.
I think we would probably need to synchronize with RCU and SRCU sequentially.

Thanks,
Caleb

