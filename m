Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596DBC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 14:56:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0336A23106
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 14:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0336A23106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2V/vZJpN/QH5yltfNBuOrT43JUW8ZXSD9uvbNsDPxlM=; b=bhQi+rsF1JpAJHJTQD3v9+dCC
	8njBY4nzFXxchSRWYTo3z5OdYhW5IC8B1YAbqCjzefpZkY5+WclUDEaneSLiGbsmSFcBm8fVXCS4p
	iLHdFmr4svFjAnuY74IMJoyfk70/HgUl+xlk79e7hdVOi9vz8ru1rt0fec8Y/mQAdldVmIIR9tqvv
	dHrYSmV1U8nG/yP47GliakyoZH+DD+N1uNXUqI3Qc9xUbNPL+gQHL3UzltVuKvo4LxFiXEzvSFeJB
	CHv2nkt+Q4E6MNcAec54Fp7/1V8w+5SjO/pIqKveERSP5jzoBGuIuXI9gj8BWG1RmXkrOWGSZVNWE
	G39V8ScpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxAEU-0002di-8e; Wed, 06 Jan 2021 14:56:18 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxAEM-0002co-PO
 for linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 14:56:11 +0000
Received: by mail-wr1-x429.google.com with SMTP id i9so2704285wrc.4
 for <linux-nvme@lists.infradead.org>; Wed, 06 Jan 2021 06:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0noFpQ1J5+J2UfwU/xuNZeWonaoRfYbRArFBMxfQC+I=;
 b=W21IYvgzNTtCjmVqOU81jxr2O8pYmfJL4b6xw4I5Kc5aYiH/r5BTwFdDgGaNyL/7FI
 jcZJUh4MFYiF9kZHw7UZBb0N28MvXidcryhGkjvnBdrjGcpugGPRWkvx7aLy44EwyGE3
 +eeojCJOLd5KpFSA9nBn5yk+2GTDzl6mBQwyP3KKbI/R+gJ4ZTeedBZ5i11ElADXfQYr
 3JXlsWcmMLdzMqf5l0McsDPKYcbI0ZpQ/niaSRkqQLvTeiCo4/idtssGLFOoH2gdc1c8
 dKEDtgu6J7NLhqg9LcC/fMWNJisgJoGonq/Z3w5TqQUFRaI8q7DcjpZUk9W5KWwg7Lhw
 3Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0noFpQ1J5+J2UfwU/xuNZeWonaoRfYbRArFBMxfQC+I=;
 b=rXp/eeSXsjP9sBsKp2vOWbUFccIArsHXLtZAy4xxVRzwzGN/e14oiSDjo1uEjbpB1C
 0reV1E8YYJlI8nMhHcq/b0WOjzTtVsdgJrR+6fq5gLMxLKKez20AdfMSPbeo9DxZvYKc
 h9EGuQLb8UqlJMGwpuXfHEslLogB5ggf1dC2KXHQaLt+xcDQfhiL25S0I3W1LV6Ifh05
 Jy41nMAtkor8tmIHZmcjBphXe54H6Fp3o3If4nwbb/aMJiQy2Kvm9xlcXt57rv3ZSr8u
 ExoDoiBB2EIN4zja8EspLoVifAE7Z1/JfxMWiblv/zNhQZN8WEs+XdQHxPiJ0vtvL4B4
 tebg==
X-Gm-Message-State: AOAM5307FGYoECFpJ6OOw8j6uRDQ4t4iYMP8d6XhOVG1gBudGn07kjJA
 4zDvN/ThC9JcEp/JU/ph5WWsZivkOg/MkOikHFo=
X-Google-Smtp-Source: ABdhPJzr1SGUVbGEYBoSpV2oKghNj4T77ApkEieST26nqMWZLsq4STslGta8orwnYwqRuGQdYRQbY+XN40CzjLLAIKc=
X-Received: by 2002:adf:ba8b:: with SMTP id p11mr4647484wrg.328.1609944969194; 
 Wed, 06 Jan 2021 06:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20210105224939.1336-1-clay.mayers@kioxia.com>
 <20210105224939.1336-2-clay.mayers@kioxia.com>
 <20210105235210.GA1278592@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210105235210.GA1278592@dhcp-10-100-145-180.wdc.com>
From: Clay Mayers <klayph@gmail.com>
Date: Wed, 6 Jan 2021 06:55:58 -0800
Message-ID: <CACyZ+O5TJV+WrdfNbih5vU5qFfZCeWxcMv9Jf3OG4Pq9u63fTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: support fused nvme requests
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_095610_839157_ED60E279 
X-CRM114-Status: GOOD (  19.69  )
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
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for the very fast feedback.  I will certainly reduce the memory
hit for non-fused cmds and look into dealing with a controller reset.

On Tue, Jan 5, 2021 at 3:52 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Jan 05, 2021 at 02:49:38PM -0800, klayph@gmail.com wrote:
> > @@ -157,6 +157,8 @@ struct nvme_request {
> >       u8                      flags;
> >       u16                     status;
> >       struct nvme_ctrl        *ctrl;
> > +     struct nvme_request     *nrq2;  /* Points to second fused request */
> > +     struct nvme_command     cmnd;   /* Saved fused first cmnd */
>
> This struct is getting a bit large, and we allocate 1000's of them. An
> extra 72B (3x its current size) for something that likely never gets
> used (and can't be used for fabrics) seems a bit much.
>
> > @@ -918,7 +942,13 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> >       }
> >
> >       blk_mq_start_request(req);
> > -     nvme_submit_cmd(nvmeq, &cmnd, bd->last);
> > +
> > +     if (cmnd.common.flags & NVME_CMD_FUSE_FIRST)
> > +             memcpy(&nvme_req(req)->nrq2->cmnd, &cmnd, sizeof(cmnd));
> > +     else if (cmnd.common.flags & NVME_CMD_FUSE_SECOND)
> > +             nvme_submit_cmd2(nvmeq, &nvme_req(req)->cmnd, &cmnd, bd->last);
> > +     else
> > +             nvme_submit_cmd(nvmeq, &cmnd, bd->last);
>
> There's an unlikely scenario where this breaks down, but it'd look
> something like this: the FUSE_FIRST is submitted to the driver, then
> before the FUSE_SECOND reaches the driver, the controller is reset.
> Because you're only using this through the passthrough interface where
> the FAILFAST flag is set, the FUSE_FIRST command is ended in failure,
> which releases the command ID for reuse. Once the controller is
> restarted, the FUSE_SECOND is dispatched to the driver using an invalid
> command ID stored in its 'cmnd' field.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
