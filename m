Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A4CC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 17:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rZlu2C7bjo1Jm+XpIP6zPA4FF/BFq2GFxFKfhQbylos=; b=c7rxL314a6x4Opbn9MZnOVdXRm
	VZ3+3JiLRJn6U/DOBxq4QVoXOk+62klKa+IixBEORkCtWMTuqtTlDZsbUIqZVgTjiPzTXHa39+KZi
	vswG6fDPCdisVhYD3OHF49ks17n3VVvRSrZNVVTYvPG+khv7QamZa3Ny6YcAwn7HFW6Shta7gnFAb
	ElSXd6uBZoBfirC8KhYWnN8TuWp5gvXeWVWqIeqgmWyx9T4dAN75TS4Cap9IcTAC0GQq8DUSWCeFp
	EZ8P9YFa4YpdUpp87ECmkDz9VJy50aHQ462gIZvXAzjydeG8Q7x55RIL1TBtSr6WYqXOg9JXzLQSv
	nBSqBhXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxAuW-00GV4X-N8; Mon, 21 Nov 2022 17:48:48 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxAuT-00GV2h-9w
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 17:48:47 +0000
Received: by mail-il1-x136.google.com with SMTP id q13so535162ild.3
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 09:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rZlu2C7bjo1Jm+XpIP6zPA4FF/BFq2GFxFKfhQbylos=;
        b=KVAEO7qlfLwokklT7inydkPgIpH7WyUZiLqXHrOeqUJW7wDZ9sqfSDcnz/GF8RE9A5
         Eqe/shlit+h8FxjFtec0veVzGfGaYhK3gF3rsRx8223on7RTbgkvYihJH7iX6r9V6N/f
         jA62jPoeTwzIoexTNWe4O5BkN08+vf5RlgXyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZlu2C7bjo1Jm+XpIP6zPA4FF/BFq2GFxFKfhQbylos=;
        b=G1V8xcRxbhc7+FooCIB8Eb/LNGV9QiOzzPykyHkVVWd1z3DIvWI3PQsKDljZmsOJYs
         TJsvHLdBai6eQJ2ijRnn0WMF3uHiX7AL9ZiE+cURa6t6RNl6fhyfPPfumiPaZwgXiaN9
         xeE6PJAZa+GlfjAeeKB/KmvjlM65K1hy1XquHg/930d8hHwz3jP637O6Qtf60+AScW2f
         UQ/7Z9SJ8c2a/EDDqmKhp+qZ077xxAJaDpJeuLaATTVipqrRfm5qo7WR/IpVt7g4Txu+
         GCyPyXoioynnk/0PuI/tVr1Qq+1R6kUUwxatwmse0b2JGuS45cBqFz6b0GakXz3gGNaz
         xB0A==
X-Gm-Message-State: ANoB5pk0qhly+GT/O/FdQHZkoS4JsUjkrI6FpneOOsLpJiB4Aupva1AG
	yRa1Gw3Aw5cjOe6AdoqMLWoahaTWXRjqkKc+vSc1YA==
X-Google-Smtp-Source: AA0mqf6eiJEdoCujYaaK66CnVIOkXAJoX8+DSC0p4aFUSMCizYzrP+vkyTLeS3LEjVhnv/J59RD1zVBQB1zKZK9v6ck=
X-Received: by 2002:a92:6e0a:0:b0:302:4d37:9e69 with SMTP id
 j10-20020a926e0a000000b003024d379e69mr3194561ilc.160.1669052922375; Mon, 21
 Nov 2022 09:48:42 -0800 (PST)
MIME-Version: 1.0
References: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me> <20221121074039.GA24507@lst.de>
In-Reply-To: <20221121074039.GA24507@lst.de>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 21 Nov 2022 09:48:31 -0800
Message-ID: <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, 
	linux-nvme@lists.infradead.org, Uday Shankar <ushankar@purestorage.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_094845_663476_8ED32AF5 
X-CRM114-Status: GOOD (  15.54  )
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

On Sun, Nov 20, 2022 at 11:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, Nov 20, 2022 at 01:24:51PM +0200, Sagi Grimberg wrote:
> >>      sector_t capacity = get_capacity(head->disk);
> >>      int node;
> >> +    int srcu_idx;
> >>   +  srcu_idx = srcu_read_lock(&head->srcu);
> >>      list_for_each_entry_rcu(ns, &head->list, siblings) {
> >>              if (capacity != get_capacity(ns->disk))
> >>                      clear_bit(NVME_NS_READY, &ns->flags);
> >>      }
> >> +    srcu_read_unlock(&head->srcu, srcu_idx);
> >
> > I don't think you need srcu here, rcu_read_lock/unlock is sufficient.
>
> So the code obviously does not sleep.  But I wonder if anything speaks
> against mixing SRCU and RCU protection for the same list?

As I understand, synchronize_rcu() only synchronizes with RCU critical sections,
and likewise synchronize_srcu() only synchronizes with SRCU critical sections.
Currently nvme_ns_head_submit_bio() is using srcu_read_lock()
but nvme_ns_remove() is using synchronize_rcu(),
so there is no synchronization at all.
Since nvme_ns_head_submit_bio() sleeps during the critical section,
we definitely need to keep using SRCU there,
and therefore nvme_ns_remove() needs to use synchronize_srcu().
I agree RCU would work in nvme_mpath_revalidate_paths(), but as Paul points out,
nvme_ns_remove() would then need to synchronize with both SRCU and RCU.
This seems like it would complicate nvme_ns_remove()
and require waiting on readers of unrelated RCU-protected structures.
Is there some cost to using SRCU over RCU that I am missing?

Thanks,
Caleb

