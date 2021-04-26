Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5F0C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 17:42:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD45F600D1
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 17:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD45F600D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bYs29TfLLRtx9bAOOhWgjxr7gVahCzc3jZ6+oq9msTs=; b=HodJdOdAD/Jq4Wzr0AeHKC/qx
	ivqdNQjd1RtowCzF2yqr/MOWf4OPtmc9wWAUmzY+paS362fHHXwdTYh4pBjG7sbSv4ezoBa5bsXxQ
	531SKnfWCk7waVKa5AiUnJu3MKuFPAT6gVW6p6YWYLkMEU2decMp4DDf4pLMnlhlRs+pFTqBVDV6a
	pbc0v+0Q3il+up4k5n7Bsj6Mr9ZAp63wwD4XsShmuK8uD3DRIDlHCRAz6S801mUQxZk2u0LREi07c
	3RB3L2mAdyk/F72IPrATrkXz1aj6poxfRnw2pnPnyggOzZq25ZEcFUZUjptjd4fVECcVvlx+b/6K+
	rqK/nlxxQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb5FR-008CCC-Ok; Mon, 26 Apr 2021 17:42:17 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb5FK-008CAB-QP
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 17:42:13 +0000
Received: by mail-ot1-x336.google.com with SMTP id
 5-20020a9d09050000b029029432d8d8c5so26915998otp.11
 for <linux-nvme@lists.infradead.org>; Mon, 26 Apr 2021 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7XW66VMgYUjmmyM5tWjO/chrTso30tW7lctDhWTKas4=;
 b=JsFLAE239nzAJt8i0qo40W31Oesl3uZ76taSTcn+Ryt41AZolWe9C5BSc/kEzv0yLb
 nFZA7gRcz8NiRP6117IJC5Ia6zEn/azgEqgCu31/ysAP1hbKkeXMaQeQKwB+cvwpOBYu
 GC+ZfWn5G07O+uTX6ASZsdD3R0R/r9/oTidtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7XW66VMgYUjmmyM5tWjO/chrTso30tW7lctDhWTKas4=;
 b=PFqeb6LLZUF4NOynxXH8usIB7uC0Of5Dc01wGQ3yOUt+pabZgZWaTp0eVmm3zjW7PO
 G3Yq76DyqWb43elWeHYaum7JHdYDM5zGXhnhRGTdjkXhhi9ieD3IV7Ol5IiYUYtiI2Aj
 sAMcPeAq9FX9TFOE4oVb2K5RnqoDIaPVdPZBzcjvCGMneTgXMa7TST8lU4IWQJkof9cW
 bX307vsGSXrSSjWtnqydbvsvz2IpLpVKJPJArxCRjzqj3k2nAl7zQUHp3Vx/spKan4Hx
 cXypFNLnXfU60YUwDRrJsEf1e8K1iJB5mgkbdTSHZkFvwlzOCcWACy2VxBAmGjz/deUy
 lmvA==
X-Gm-Message-State: AOAM531CuSuZv3slJ1K6EjryaRmeAoxBVnVvx8lRgiWdz1Te2pW2OMhi
 3gCpBEGyV9XZp7hZ7ArI+FlfBbdllZ0Di4+rubeRPQ==
X-Google-Smtp-Source: ABdhPJzHGEvPWZLZcokhsPK2M5HSy/aKfUBIbChJrdWuuA/Xbhes//gv/T3yj3rRVz8Z0+CC4ibsTPiFN1BWSljpO8U=
X-Received: by 2002:a05:6830:11d6:: with SMTP id
 v22mr1642299otq.249.1619458808821; 
 Mon, 26 Apr 2021 10:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-5-kbusch@kernel.org>
 <CA+AMecF+n+xVk8HcQn12oiO=YMJM08aC0AG3iM_3h8SgNxURow@mail.gmail.com>
 <20210426171525.GA13018@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210426171525.GA13018@redsun51.ssa.fujisawa.hgst.com>
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Mon, 26 Apr 2021 10:39:58 -0700
Message-ID: <CA+AMecE32_L=gqymR6tkFPcytOrBSng4jbq85TBnNoSKdwyvFg@mail.gmail.com>
Subject: Re: [PATCHv2 4/5] nvme: use return value from blk_execute_rq()
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, 
 Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, linux-block@vger.kernel.org, 
 Casey Chen <cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_184210_991249_FAA34339 
X-CRM114-Status: GOOD (  25.27  )
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

On Mon, Apr 26, 2021 at 10:15 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Apr 26, 2021 at 10:10:09AM -0700, Yuanyuan Zhong wrote:
> > On Fri, Apr 23, 2021 at 3:06 PM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > We don't have an nvme status to report if the driver's .queue_rq()
> > > returns an error without dispatching the requested nvme command. Use the
> > > return value from blk_execute_rq() for all passthrough commands so the
> > > caller may know their command was not successful.
> > >
> > > If the command is from the target passthrough interface and fails to
> > > dispatch, synthesize the response back to the host as a internal target
> > > error.
> > >
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > ---
> > >  drivers/nvme/host/core.c       | 16 ++++++++++++----
> > >  drivers/nvme/host/ioctl.c      |  6 +-----
> > >  drivers/nvme/host/nvme.h       |  2 +-
> > >  drivers/nvme/target/passthru.c |  8 ++++----
> > >  4 files changed, 18 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 10bb8406e067..62af5fe7a0ce 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -972,12 +972,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
> > >                         goto out;
> > >         }
> > >
> > > -       blk_execute_rq(NULL, req, at_head);
> > > +       ret = blk_execute_rq(NULL, req, at_head);
> > >         if (result)
> > >                 *result = nvme_req(req)->result;
> > >         if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> > >                 ret = -EINTR;
> > > -       else
> > > +       else if (nvme_req(req)->status)
> >
> > Since nvme_req(req)->status is uninitialized for a command failed to dispatch,
> > it's valid only if ret from blk_execute_rq() is 0.
>
> That's not quite right. If queue_rq() succeeds, but the SSD returns an
> error, blk_execute_rq() returns a non-zero value with a valid nvme_req
> status.

Agreed. But after that, freeing the req let nvme_req(req)->status from SSD stay.
If the same req get re-allocated and get dispatching failure,
shouldn't the dispatching
error take precedence over the stale nvme_req(req)->status?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
