Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087C3C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:41:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC3E20786
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qKkZBQnZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZmmHUPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC3E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j4pHhzv6Qn+iT3eApDRJG0BRJW/LEokUhfMILyR+cyg=; b=qKkZBQnZ6rZIbK
	ju2v7y2dPH48FoGmkQMvc+xlZ8nwCygCQjitmMdiXGctWB6YwfnreXKxln/5i8ULRXHIm1DI8LSyQ
	VymcmpeaYAsk6b/vGzjxnfQ1gsCeSN4jJUdrx5U+5tWwhIb0YPoIPAnTCwN2k3QXFyOsxNSFwhOQz
	wnGJlDylW3GvGdf78VKTF/aY1ibGsqxNXUUA2NR95fKubu6qfM7IOfzqCx6EAC4jjEuXW504FIo7n
	5w2zdd0InwD7IjtFeXDtvwB7d11801U7AY3g8hzQy3EICVvlWXJdzBz5USTRA21eEfUJFYnnXjOkx
	FOAU4Xew2N3OUfpv+04g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJ1I-0007Wt-PD; Tue, 31 Mar 2020 15:41:40 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJ1F-0007VS-FV
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 15:41:39 +0000
Received: by mail-ed1-x543.google.com with SMTP id e5so25671701edq.5
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2wWk4Yrept0mSEZI6KGf+NXqIHedOATOcRzI/MDQwpM=;
 b=cZmmHUPzBp3MvHQoD1lFelA9O6a5lqlh+IM5N+EMFiku8rVXWuRv+dGXFEJFLbVqZV
 9tN6Mdp2wEEhfB8N3vbsWoz4XJZFZzCaxasaej6qlF30vwbzlmls3ghtCWzWBIAjEwVC
 Jo0RRvCwsO1C9ys6im8TRsS6lHzUvc6dO2Gxk9+lPl/3CVqFyzq7OhbVDLF4uQdHUbIe
 QVNelgk3Wl17UAp1kjQiVDQk5P3x5jyaUZtvfvjYcUq/TQp3313u4pCcKxhPgeG9qCfl
 R6YQtg0atA0pGLx8Hw7bo5HiIQmfRaXLb9LPYb+0c8tsAboHeBllyZbExCYhuTIzW23B
 ueJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2wWk4Yrept0mSEZI6KGf+NXqIHedOATOcRzI/MDQwpM=;
 b=lzULF8CgXofDKZk851fzPbuoBIRFyautAXg3LrjeUCfuCVjeXaV4jOTjeStfDmbhz6
 47TYO6E2JLMeAxEagubdIvYdqC+AF/UafwAY6YtdpuciOT4Que/nPlBq+JFPfevsSjET
 jBSjqY3Piu3Pzu2Yl55VQvupGDxziVog6Yhfnmsc97x0OxMqfB3TX4yFm5vGYxNyQSNH
 Xyk9yIqtqQiWkboQq0twb83xDPC1mgT53iTldWuPAiZZhxXqsJXP1dnKpr/Nlh+KLgdf
 LEdDyyx5i7bOIHUF7GWsX5cuR7yiV2mMCT4VZhLWR7RSrLG0TuqFIyJdbUT1kkRXNxnQ
 nNYQ==
X-Gm-Message-State: ANhLgQ2K9QVMirfUcCc9twYOZCQf0O8XYLfjPt7K3j30SfLm7kwqcWTM
 Pq+PQEXB+qST5QtcM+PnhbFQ0UICljlStOtgl5+XFXd0
X-Google-Smtp-Source: ADFU+vsIjjp/cnq9WmdgsZufnmAgP7eDmy2MJoBW/vH5sPfR9sYga8uwHtvZFQeI0xr6XZV1swcpYL0X3eyOlj4Bse4=
X-Received: by 2002:adf:bb4c:: with SMTP id x12mr19985554wrg.137.1585664043653; 
 Tue, 31 Mar 2020 07:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
 <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
 <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
In-Reply-To: <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
From: Joshi <joshiiitr@gmail.com>
Date: Tue, 31 Mar 2020 19:43:36 +0530
Message-ID: <CA+1E3rJV2-qig0mj9s1rVZo-iScXiPqiuLF+EDszET6vtounTw@mail.gmail.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To: Tokunori Ikegami <ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_084137_513951_45541D44 
X-CRM114-Status: GOOD (  25.49  )
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
Cc: Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Ikegami,

Are you actually able to bump up the max segments with the original patch?
I did not notice the patch doing anything about NVME_MAX_SEGS, which
is set to 127 currently.

From pci.c -
/*
 * These can be higher, but we need to ensure that any command doesn't
 * require an sg allocation that needs more than a page of data.
 */
#define NVME_MAX_KB_SZ  4096
#define NVME_MAX_SEGS   127

> @@ -2193,7 +2193,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl
> *ctrl,
>
>  max_segments = min_not_zero(max_segments, ctrl-
> >max_segments);
>  blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> - blk_queue_max_segments(q, min_t(u32, max_segments,
> USHRT_MAX));
> + blk_queue_max_segments(q, min_t(u32, max_segments,
> UINT_MAX));
>  }

Since ctrl->max_segment is set to 127,  max_segments will not go beyond 127.

Thanks,

On Mon, Mar 30, 2020 at 2:46 PM Tokunori Ikegami <ikegami.t@gmail.com> wrote:
>
>
> On 2020/03/29 12:01, Ming Lei wrote:
> > On Sat, Mar 28, 2020 at 8:57 PM Tokunori Ikegami <ikegami.t@gmail.com> wrote:
> >> Hi,
> >>
> >> On 2020/03/28 11:11, Ming Lei wrote:
> >>> On Sat, Mar 28, 2020 at 2:18 AM Keith Busch <kbusch@kernel.org> wrote:
> >>>> On Sat, Mar 28, 2020 at 02:50:43AM +0900, Tokunori Ikegami wrote:
> >>>>> On 2020/03/25 1:51, Tokunori Ikegami wrote:
> >>>>>> On 2020/03/24 9:02, Keith Busch wrote:
> >>>>>>> We didn't have 32-bit max segments before, though. Why was 16-bits
> >>>>>>> enough in older kernels? Which kernel did this stop working?
> >>>>>> Now I am asking the detail information to the reporter so let me
> >>>>>> update later.  That was able to use the same command script with the
> >>>>>> large data length in the past.
> >>>>> I have just confirmed the detail so let me update below.
> >>>>>
> >>>>> The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS
> >>>>> 64bit).
> >>>>> Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
> >>>>> But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 4.15.1
> >>>>> (Ubuntu 64bit).
> >>>>> So the original 20,531,712 length failure issue seems already resolved.
> >>>>>
> >>>>> I tested the data length 0x10000000 (268,435,456) and it is failed
> >>>>> But now confirmed it as failed on all the above kernel versions.
> >>>>> Also the patch fixes only this 0x10000000 length failure issue.
> >>>> This is actually even more confusing. We do not support 256MB transfers
> >>>> within a single command in the pci nvme driver anymore. The max is 4MB,
> >>>> so I don't see how increasing the max segments will help: you should be
> >>>> hitting the 'max_sectors' limit if you don't hit the segment limit first.
> >>> That looks a bug for passthrough req, because 'max_sectors' limit is only
> >>> checked in bio_add_pc_page(), not done in blk_rq_append_bio(), something
> >>> like the following seems required:
> >>>
> >>> diff --git a/block/blk-map.c b/block/blk-map.c
> >>> index b0790268ed9d..e120d80b75a5 100644
> >>> --- a/block/blk-map.c
> >>> +++ b/block/blk-map.c
> >>> @@ -22,6 +22,10 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
> >>>           struct bio_vec bv;
> >>>           unsigned int nr_segs = 0;
> >>>
> >>> +       if (((rq->__data_len + (*bio)->bi_iter.bi_size) >> 9) >
> >>> +                       queue_max_hw_sectors(rq->q))
> >>> +               return -EINVAL;
> >>> +
> >> I have just confirmed about the max_hw_sectors checking below.
> >> It is checked by the function blk_rq_map_kern() also as below.
> >>
> >>       if (len > (queue_max_hw_sectors(q) << 9))
> >>           return -EINVAL;
> > The above check doesn't take rq->__data_len into account.
>
> Thanks for the comment and noted it.
> I have just confirmed the behavior on 5.6.0-rc7 as below.
> It works to limit the data length size 4MB as expected basically.
> Also it can be limited by the check existed below in ll_back_merge_fn().
>
>      if (blk_rq_sectors(req) + bio_sectors(bio) >
>          blk_rq_get_max_sectors(req, blk_rq_pos(req))) {
>
> But there is a case that the command data length is limited by 512KB.
> I am not sure about this condition so needed more investigation.
>
> Regards,
> Ikegami
>


-- 
Joshi

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
