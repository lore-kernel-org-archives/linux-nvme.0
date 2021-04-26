Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC6EC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 17:10:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082FA6101B
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 17:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082FA6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h5RCXx55VmrH7nb/YqQS5QahYIBqDccMjyJK3WlhfrA=; b=pQ4s8FIxjwNKNv5LzUPr5wE6E
	mZKYchxGZPeRkluFyyPkeBGCr9SnGQJkXIgKG95ip1NxPvH927TT9IgwiMiLf8cAryvDYpEZ9nP00
	2idZmoBQXNJR0UbvbyDDPE18qtdtVN1Daewke8TUEU/ndxBm56J/bhzwnbAeMUOPWe24mVO0pqDd9
	0KLbwck/S5fLMv5GV52qRKPggoeclgj/GXD5t99XoOI3vTFEcHUrbiN3Z1wGRy8s1b0ssePBpac/L
	WnZy6Ir/IhxoAVEB+sGSuv5/AmenimPVwECs3dxUWRHuhW/fzLf7AQwvWTJctBO7VlvvD4Y7ThHn0
	ULARVn4Bw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb4kd-0088nu-Q2; Mon, 26 Apr 2021 17:10:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb4kb-0088nn-K3
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 17:10:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=eo5gmhYwD5sVKrcVF5GNYF0YYnYlBgHP6BRS3D74YoE=; b=lgqywr+jMn/Hohh22aPPM81cC7
 MK67mtVyQHLfzCRsYYvtS8UTas007ilhSVCL9fz+pZK3HTibYuY71CnB+Dpm/z5PKAUHLhzfY6z5/
 NLMQH00ykB9dOW00ehmoDVcPgom/jjOZSLOjY6QdBuh7LTFHQaFNk71wy3YiiBsaK6YCgSVo/QQr5
 ZU2TGSz8ihnt968DhuSIyoEzaLhZRnzS0eh445hJxZxVFGznX86L0jQvN77VcgSKbtYz992D0F7gy
 SJ4A1xex1QpnpcsB1gWakh6urz+t6C5rPRxsWAAL3kkaSOWsqx4ZYsI6D7PT5H7cYWkkiu3b5VcJi
 6RYXYzrQ==;
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb4kY-00G76r-BY
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 17:10:24 +0000
Received: by mail-oi1-x22f.google.com with SMTP id e25so27144717oii.2
 for <linux-nvme@lists.infradead.org>; Mon, 26 Apr 2021 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eo5gmhYwD5sVKrcVF5GNYF0YYnYlBgHP6BRS3D74YoE=;
 b=GPw1xKitvwGmyWq/ZcCbFojhlg7PpjTPrNz9w8X//20S5tD3/S3DKwuFtKXp/IxohX
 i0EYyHezVeSfUvGZDw48bgo/aZrqsMT5p/Ni9zAniIK/f6B7w4WDs8J36pjKVc8/9cG5
 erC+wzD2S8mdRu9hl0Or2GLawn1iXM0Yker8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eo5gmhYwD5sVKrcVF5GNYF0YYnYlBgHP6BRS3D74YoE=;
 b=PzMdaLw7EPBrjn9Xk/FcnNSixVHMPtLQW6GWyIwwDAEAQ7zqffVZJ1yjyUYmJersua
 ESNolrLj7ti27iuw5bPHQWAdpBJdHCRFQfOpaQPfZ6LicoHRd0XIxBp5i/1NDNkBMgIV
 QUBM7Fk/FOwKWT0H8VLRkO4zVJB4AAmKlVeSSaWcvxE37CRlXoa8iailN1W383PfnXtt
 KDskQl/X35yz7GIif0A3ApF+JkoGzRFAtHxd+JcKMyUZbEIk927/rr3bQolszUkvlb3o
 k/vqLZ0pRbboQuxMhcXytlAe82NJiHCqMrztuUXTX5oOAj6fbTED/MZUC+cOG6SfcPyL
 WWnA==
X-Gm-Message-State: AOAM53273edGY0Z1Cy1z0qWvvs8lOcr2TzfrPkGLxM3qydd2Hdtyv4b5
 y+j9z6B4XzJd+klBwsVbAjyikcUbwHrzholo0Y0MFdUEfdOkmg==
X-Google-Smtp-Source: ABdhPJyKCnqjd8rFzzXlpg/8c39CgYoVfclNiK/pBOeWWt28b4Po8FC1FuVbU0zVrHhWpYEjIT3hHcBdqKdfxGRNCmo=
X-Received: by 2002:aca:31cf:: with SMTP id x198mr45382oix.71.1619457019700;
 Mon, 26 Apr 2021 10:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-5-kbusch@kernel.org>
In-Reply-To: <20210423220558.40764-5-kbusch@kernel.org>
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Mon, 26 Apr 2021 10:10:09 -0700
Message-ID: <CA+AMecF+n+xVk8HcQn12oiO=YMJM08aC0AG3iM_3h8SgNxURow@mail.gmail.com>
Subject: Re: [PATCHv2 4/5] nvme: use return value from blk_execute_rq()
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, 
 Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, linux-block@vger.kernel.org, 
 Casey Chen <cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_101022_485461_0D0250BA 
X-CRM114-Status: GOOD (  19.71  )
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

On Fri, Apr 23, 2021 at 3:06 PM Keith Busch <kbusch@kernel.org> wrote:
>
> We don't have an nvme status to report if the driver's .queue_rq()
> returns an error without dispatching the requested nvme command. Use the
> return value from blk_execute_rq() for all passthrough commands so the
> caller may know their command was not successful.
>
> If the command is from the target passthrough interface and fails to
> dispatch, synthesize the response back to the host as a internal target
> error.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c       | 16 ++++++++++++----
>  drivers/nvme/host/ioctl.c      |  6 +-----
>  drivers/nvme/host/nvme.h       |  2 +-
>  drivers/nvme/target/passthru.c |  8 ++++----
>  4 files changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 10bb8406e067..62af5fe7a0ce 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -972,12 +972,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>                         goto out;
>         }
>
> -       blk_execute_rq(NULL, req, at_head);
> +       ret = blk_execute_rq(NULL, req, at_head);
>         if (result)
>                 *result = nvme_req(req)->result;
>         if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>                 ret = -EINTR;
> -       else
> +       else if (nvme_req(req)->status)

Since nvme_req(req)->status is uninitialized for a command failed to dispatch,
it's valid only if ret from blk_execute_rq() is 0.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
