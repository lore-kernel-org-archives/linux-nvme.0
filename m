Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF480C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:37:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B710208B3
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ombVtuVd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVGEdp2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B710208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V7CECHSl9NpHdken2YCmZxpp8Pm4JkdKrgaRxdiCqfo=; b=ombVtuVd8ldxK0kwOA74X/AJ9
	owvhuXEZJlyZL/YAUyZt2jG3RCuH08/jdqP0N++Lc/ZHcXSmQhn/AOvj1Jzlt9Rsc2/sRnmekh/LH
	/gQA0NG8ha6IOLYhSwg4lmvGmUD5znlDfXG/YMUu0vd4SLY8nCPRikldHeFBqIfNa4wfGIFkuyKj/
	OFFZmYtutyIbv4LR7gWhcYCiLcBsHwnqjem0GtWr8cakMn3/OLLu5hofVGm4VAWEwhe1QnbqZumT9
	nJlexS9crsYYjrBrVElmg3SVWQtg/jNy3p/t8LbHIqRzc/MeZnh4LLbEUiGHtAbe5Jysp2LMb9Og5
	en3z73l5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6blw-0007Z4-P0; Fri, 14 Aug 2020 15:37:36 +0000
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6blt-0007Yf-GO
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 15:37:34 +0000
Received: by mail-il1-x144.google.com with SMTP id k4so8777941ilr.12
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vedeg1TU63CF1kJq07P08JkbOKRTBMhiE4Lkx4pw3ww=;
 b=dVGEdp2G0bpJ2M3oeuYgPNh2qgAVGLuQhqA51LK0XANheAGq0fQvyAd/vO257KcvKC
 Rs0LhdFT12NIrcsZ+1iE50AmgtR6ko8REmEB9QQQsz7XsGxj21N8r9w/NJTdfc5fcGf9
 s1w6AiegnLwWuH6FPJptx/vpYSwXRcUEtlIZW2M5MtcaqJCPk7KxUdzfwQH4gGxSmbf9
 /xUQ/8dJ6IKObPccSeR9Lzaboytvr82HCHaxymIOaB9QrqT3tSIOv7BwIweUsw5yO3LH
 /Yl2RPCYw8bidP6FtFtnWgqdwl2J0nohGVmszV/kOJmZKidB3uWS0Q4EH5nQzK9XE85r
 axdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vedeg1TU63CF1kJq07P08JkbOKRTBMhiE4Lkx4pw3ww=;
 b=QmrF0Vri8Aq3/lHfaITNndi+zn959gYeUb7RKRjJG9CAp4GyOjgTZ4DUzCgYqJ6qCf
 JkDyEGwwWD14w5OOKWU0kEyo1tZNw6gpI27KbFXjCsXZHEDzncgXVu0lbyHGr9FyZWSA
 sIXSEizXeY9yRKKBYkT3uwbpGiR5fNTnh1qplMAgdTrIy+2QLpHa3j81KMg4PBISZwOT
 eKjugYVw1mtzETKoCdIyfwIUE1VHywO58RzsjCx+qbDzfOeCSFTECAJpZSAi0RLiWlNF
 uH8v9hrQh0oId2LKB2rdGmZMMhH3Jt+P8qAPTG4cxvS0GeAil+ggmARpulZbcU+kFr2Y
 kqmg==
X-Gm-Message-State: AOAM532WXh5Mix0l+KaR+gtX103G78FQmazk9Y8iplFbA+XNI01pvTa8
 4JzTEAlXKLTyMXB23hyE6cJ2e+KtHemn3KTEc3Q=
X-Google-Smtp-Source: ABdhPJzr8YoG2sJ/oGlkT9eL1HVlhZ78Dq8uWzSBloF+h0eLPkcr9aOKHLL2us1cqzw7LbDsBozTCeioYS4Sijl0C58=
X-Received: by 2002:a92:c524:: with SMTP id m4mr2864709ili.306.1597419451648; 
 Fri, 14 Aug 2020 08:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200814071431.201400-1-ztong0001@gmail.com>
 <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
From: Tong Zhang <ztong0001@gmail.com>
Date: Fri, 14 Aug 2020 11:37:20 -0400
Message-ID: <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_113733_586500_789EF04C 
X-CRM114-Status: GOOD (  15.56  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith,

On Fri, Aug 14, 2020 at 11:04 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index ba725ae47305..c4f1ce0ee1e3 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >               dev_warn_ratelimited(dev->ctrl.device,
> >                        "I/O %d QID %d timeout, disable controller\n",
> >                        req->tag, nvmeq->qid);
> > -             nvme_dev_disable(dev, true);
> >               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > +             nvme_dev_disable(dev, true);
> >               return BLK_EH_DONE;
>
> Shouldn't this flag have been set in nvme_cancel_request()?

nvme_cancel_request() is not setting this flag to cancelled and this is causing
__nvme_submit_sync_cmd() to return a positive number and eventually
this will allow nvme_init_identify() proceed with a timeout error where the
problematic nvme device has already been disabled by nvme_dev_disable(dev,true).
The reset of the logic in nvme_init_identify() is not going to check
those already
released resources. -- in fact this is UAF --

> like the timeout out command is the only command to have been cancelled
> by this action, nor is it guaranteed that getting here will mean the
> request was in fact cancelled. The controller could still provide a real
> completion.

what would you like to suggest here?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
