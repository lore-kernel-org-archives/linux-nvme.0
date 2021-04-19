Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4176FC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 17:28:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CC9611F2
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 17:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CC9611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=il0NjHOe2DnEw/0cHP1ks9Fv/Oa4ARmhIavLGHI7ijU=; b=nrrJ9mS5y4z6RgS/IeZ0MfbyV
	UJFRZLkQKjYsrPLg+h/1lfRk7QVOpgI9Jq+whOpoEbq2lFOHeRFBHcGmDwIlky3ICuBaGZmY4Qxf+
	sHBWD42AFpzayodr4+zSuMBnpFTa2yu1o4ZN/4pqNeY58Tv/xqSMhlli0369GL8GdXK4KYJ46ZPeR
	zJ3MNwl7VE7iKwX6lX8Jj77mrZmB7TCYWfsjzVUPGPnwWSROsZ4t6lyq605kpw/op+Uc9RpDn38mk
	5UztkjAt9rYwlZwRcZah5dKa35uHnxgKGYGvVXz8pBn01L7XeHTdt7BaXLJNRcbdufOYJmTUXS6p9
	Wn4CYrUkg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYXgp-00ALEG-J3; Mon, 19 Apr 2021 17:28:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYXgm-00ALE8-7P
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 17:28:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zer3si/7X5ySMXgF2gktWrTQrlEkz2gg/oEe2rOReg0=; b=T2wh51xfmmNzTROIjFku2twsgV
 4UzM+aoHpLFhmkA/sqNwuBjmOs2wMLz50XjMwklAH8gZDfebvSAxvYzvnJR+/v3OO1Rcs5HwTlRFi
 tv3QtXKxy6/JCxhjhJMeMoBp1mFYJ10eIDM7aewa3u2WUxhz7slRglkbqwG3fqwt4EE7FQyjTYBIm
 I6OqV+7/3MSGokQLVcw1VXu6sMALZkdKWp1lDEM5xyivLd3x2KOaWEbFviBiT1MeIsLEo7DJ0MWXg
 kC8o6Y+2Vnp8c9IqTCFVbSpOm5zp0RxBhP4dq6Ii0Ruyp54NRk8/UhJA2DeDGnZS3e5NScWHYrgPC
 4QcG5X4A==;
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYXgg-00BYc7-D5
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 17:27:58 +0000
Received: by mail-ot1-x32b.google.com with SMTP id
 v19-20020a0568300913b029028423b78c2dso24674487ott.8
 for <linux-nvme@lists.infradead.org>; Mon, 19 Apr 2021 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zer3si/7X5ySMXgF2gktWrTQrlEkz2gg/oEe2rOReg0=;
 b=l4pz55jQz9YaxS1S8/DqS234Mxoc385oRRYH9jS9t4dWeEmIs6GhYqqNZUUUFyzIZi
 bD5qOuX8cwbjRpYSiZcBnWQDTt9fQq2DVgU9vpB9qNAMDR0jjWW4zLUaKjRJzZ7LMnhq
 b+1hp1aOgq4Ab80yzLmZcTEbqLvUBqO9XygjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zer3si/7X5ySMXgF2gktWrTQrlEkz2gg/oEe2rOReg0=;
 b=KT1VA5b5LxYW8n+yAoGtw1pUYAZvgopkSic2XiH9Sx1/BZp7l3QKh5kc5kOSb/JBFj
 bzBh7uRcncLhYiRawM4tpXwyz1uAT9CU9VTTP8XqcwF4wRcR6WBdVV0RemyZnBYxLIC2
 Nl04qBZ/nDpYNahouUmv5/kuNbvDALddVchHtMsJhHYrnEU0m/Hyo1Wgcr29PT4c2tCK
 KLHeMmWLaYwend6ek1E/lBIaY+iA+VBgXEpgr/EyIj8UraZ8rv67u5jS5n270wef1ar4
 QBeHh7mFCFuPcuFuq0tkRs9o3o75X9el9z/a3sikoDjuwRcLdg/oJkr8nT3fpU2ma8PK
 G/cA==
X-Gm-Message-State: AOAM530KUsUA8ZlGl0tW7QDgjgFqvDmMtUKOiC6/bJkkQ/siiAwTpTM3
 JSFlFu32Er/SSz/WaLtUaqhoRN2JaSHLuWyUQ9dVlg==
X-Google-Smtp-Source: ABdhPJy9FXaOlhwVd2jzTlK3ocPguHbumX5GXOLbiE7p6yLCR8BGfYE18OuCrvCFQTNDYcKqvT1lMJl0ahTWEh7HzN4=
X-Received: by 2002:a9d:7a53:: with SMTP id z19mr15086585otm.40.1618853272128; 
 Mon, 19 Apr 2021 10:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210416165353.3088547-1-kbusch@kernel.org>
 <20210416165353.3088547-2-kbusch@kernel.org>
 <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
 <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
 <20210419071605.GA19658@lst.de>
 <20210419151437.GA12999@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210419151437.GA12999@redsun51.ssa.fujisawa.hgst.com>
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Mon, 19 Apr 2021 10:27:42 -0700
Message-ID: <CA+AMecFXLCm3zsrfGdjT5hW4fvvgDxJxGEZvxOEA0bJT3X11wg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, axboe@kernel.dk, linux-block@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_102754_555563_4BBA82F1 
X-CRM114-Status: GOOD (  21.07  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 19, 2021 at 8:14 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Apr 19, 2021 at 09:16:05AM +0200, Christoph Hellwig wrote:
> > On Sat, Apr 17, 2021 at 02:17:35AM +0900, Keith Busch wrote:
> > > On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> > > > >         if (poll)
> > > > >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> > > > You may need to audit other completion handlers for blk_execute_rq_nowait().
> > >
> > > Why? Those callers already provide their own callback that directly get
> > > the error.

See below clarification. I was wondering whether the way you were going to
propose for nvme_end_sync_rq() would establish new convention for other
blk_execute_rq_nowait() completion handlers implementation.

> > >
> > > > How to get error ret from polled rq?
> > >
> > > Please see nvme_end_sync_rq() for that driver's polled handler callback.
> > > It already has the error.
> >
> > But it never looks at it..
>
> The question was how to get ret. I didn't mean to imply the example was
> actually using it. :)

The question was how to let nvme_end_sync_rq() propagate the blk_status_t
error to the ret for __nvme_submit_sync_cmd(). That's part of the problem
here: __nvme_submit_sync_cmd() may return success for a command that
failed submission.

-- 
Regards,
Yuanyuan Zhong

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
