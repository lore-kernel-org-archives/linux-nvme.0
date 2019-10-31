Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65986CA9EC7
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 02:57:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FE92080F
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 02:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hRTKcHO6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT6wZS8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FE92080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nwbzUkplp4KPBFqIdUUjt0aN67Q0RoHSiJqtYsQHUkE=; b=hRTKcHO66SkahP
	y83E6JW9ZXWuXuhVAyluswYnGZW/wFLcDDkI+zHAEJb7A3echLyYgewcZtnQUkruVRXVnYbH4exn1
	4veFhBe8jPcaZoax20nWzg7vQkiiAgK8/ZzUMOoiHEnvYfWVrRzUjQBk51DK8A8hXze4yEP1uhsPL
	eieEHuauN6vtwAsAyeHvo9pk2gx3fi+KCFFbGxdqbsbzuaP7c9k02CsA06onWHoNylLLdBieONGaP
	i83WrzERFHVXDwGIepiUf3ZvB4Wnx/SGV1IJJFAqOGypwO9lt6eJYmkzpiZFEnnKw164LOGNQOzjp
	mKxa1kHDfpULqzyIaG2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQ0dw-00073Y-Lx; Thu, 31 Oct 2019 02:57:00 +0000
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQ0dt-00072u-Ov
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 02:56:59 +0000
Received: by mail-yb1-xb43.google.com with SMTP id m1so1822395ybm.1
 for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2019 19:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aJO3rPJnYCN99UMBnTEPYqbSpc3oGtdecVHenBhshis=;
 b=YT6wZS8vPtr0Po4GP5zcNJvZRaxjNr9ve0qmPKEPxPmxHNqdyPlTf4hQSgQ+CqQp3y
 1gZdwzTm8hBl4cOS1mILpx5gSGkox7M47WmsF3ysXKAej8uasSpR3UzftQxJC3wyDb9E
 N0VN+ao4j6q2BiHQ+WpKBZYC6wmGK9NQyjMif9B57FRGbTC9WGhfhVVANYYJxe+G9RVY
 DzoIeuM/1BSffwYCHcIM4AY8OWFAGCJf5kOsGIqjNbFsF7YQCHb/5YQz7AzsrU5ZoJ4D
 zkTx8XsgYoybAgPNJ8vmNHzZRFtELgmOBWt5gf9JWjEYOSFg62tRJg0koXAvZxT8a43I
 V68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aJO3rPJnYCN99UMBnTEPYqbSpc3oGtdecVHenBhshis=;
 b=QGFXwfGP9gH0DOTQ2bN0XdwGuH1myVfFAVueHBqb6kkr9mlR+Dt5/gjs9O/SMcMTu9
 0C3Ah7YIvJUObFZzGU6u+mVnrLpEpAY7MEfZoK9+lDJHBR1ZoL/Ak1CspcjNYvnb3+wj
 +L92fmbHggNqmif4++yNrldpky1/wj76yzTXtxOc5nYGJwbn6NuKXLlCcVDLqS+OziR2
 pWnGiZ2Fjyhd5uI7sIjnSo8/IiWjLJmNF7wqXovZNEP+4xxQELeYZyNNb+0T/SekbOtL
 PTF3DkksrsSoNtXkYA9jqISEK2QjTnwhZlXyL32q9CW9k4ezxu0wp1dEqIwDsW5ZjOYW
 3DDQ==
X-Gm-Message-State: APjAAAVYuY/WRXsjtXW/NQDa3MBqStJmQc92GLJaKZHigp8HgtFuVZkJ
 CPKX7lWolqc+p2kDoAr0opE8o3kife3EMEeaJSNe7L4K
X-Google-Smtp-Source: APXvYqzfsqTgSqeZBMfG1PTYRqcZbGdxx6KFujyW4svBF6S+sF/upK4s5/tM3fBMjdKIgJ0nAlsXhhhbaz1o+BwO/cI=
X-Received: by 2002:a25:b5c5:: with SMTP id d5mr2135170ybg.44.1572490616359;
 Wed, 30 Oct 2019 19:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <CANSCoS8HakAy6zHgEjDiYQ87z83RJy-OC9ZfktRJwr+9kgnFKw@mail.gmail.com>
 <20191030063233.GA16863@redsun51.ssa.fujisawa.hgst.com>
 <CANSCoS895GAsmZQkvErgL+yDJ8wpNM3648RGrP6Ya0cEkTKVUg@mail.gmail.com>
In-Reply-To: <CANSCoS895GAsmZQkvErgL+yDJ8wpNM3648RGrP6Ya0cEkTKVUg@mail.gmail.com>
From: Charles Machalow <csm10495@gmail.com>
Date: Wed, 30 Oct 2019 19:56:47 -0700
Message-ID: <CANSCoS8VBMgLMDjfRH7WX5hPZ1ddxfjJYZMB+voiMQSKo+JUXA@mail.gmail.com>
Subject: Re: nvme_passthru_cmd64 has a 4 byte hole
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_195657_814993_3D4CC93D 
X-CRM114-Status: GOOD (  18.95  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I think something like this might do it:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dc..80b17730b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1453,11 +1453,11 @@ static int nvme_user_cmd64(struct nvme_ctrl
*ctrl, struct nvme_ns *ns,
        status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
                        (void __user *)(uintptr_t)cmd.addr, cmd.data_len,
                        (void __user *)(uintptr_t)cmd.metadata,
cmd.metadata_len,
-                       0, &cmd.result, timeout);
+                       0, (u64*)&cmd.result, timeout);
        nvme_passthru_end(ctrl, effects);

        if (status >= 0) {
-               if (put_user(cmd.result, &ucmd->result))
+               if (put_user(*(u64*)&cmd.result, (u64*)&ucmd->result))
                        return -EFAULT;
        }

diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index e168dc59e..4cb07bd6d 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -63,7 +63,7 @@ struct nvme_passthru_cmd64 {
        __u32   cdw14;
        __u32   cdw15;
        __u32   timeout_ms;
-       __u64   result;
+       __u32   result[2];
 };

Need to do a couple manual checks to make sure the old/new ioclts both
work. If they do, does this seem like a valid patch?

- Charlie Scott Machalow


On Wed, Oct 30, 2019 at 7:08 AM Charles Machalow <csm10495@gmail.com> wrote:
>
> Ah yes. I'd greatly prefer that. That way the new structure can likely
> even be used with the old Ioctls and the 2nd u32 should just stay not
> get set if used in the old flow
>
> - Charlie Scott Machalow
>
> On Tue, Oct 29, 2019 at 11:32 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Tue, Oct 29, 2019 at 09:43:20PM -0700, Charles Machalow wrote:
> > > Hey all,
> > >
> > > I noticed (via some debug) that nvme_passthru_cmd64 seems to have a 4
> > > byte hole that isn't currently accounted for in the struct:
> > > From pahole:
> > >
> > > struct nvme_passthru_cmd64 {
> > >         __u8                       opcode;               /*     0     1 */
> > >         __u8                       flags;                /*     1     1 */
> > >         __u16                      rsvd1;                /*     2     2 */
> > >         __u32                      nsid;                 /*     4     4 */
> > >         __u32                      cdw2;                 /*     8     4 */
> > >         __u32                      cdw3;                 /*    12     4 */
> > >         __u64                      metadata;             /*    16     8 */
> > >         __u64                      addr;                 /*    24     8 */
> > >         __u32                      metadata_len;         /*    32     4 */
> > >         __u32                      data_len;             /*    36     4 */
> > >         __u32                      cdw10;                /*    40     4 */
> > >         __u32                      cdw11;                /*    44     4 */
> > >         __u32                      cdw12;                /*    48     4 */
> > >         __u32                      cdw13;                /*    52     4 */
> > >         __u32                      cdw14;                /*    56     4 */
> > >         __u32                      cdw15;                /*    60     4 */
> > >         /* --- cacheline 1 boundary (64 bytes) --- */
> > >         __u32                      timeout_ms;           /*    64     4 */
> > >
> > >         /* XXX 4 bytes hole, try to pack */
> > >
> > >         __u64                      result;               /*    72     8 */
> > >
> > >         /* size: 80, cachelines: 2, members: 18 */
> > >         /* sum members: 76, holes: 1, sum holes: 4 */
> > >         /* last cacheline: 16 bytes */
> > > };
> > >
> > > (Since I doubt we can functionally change the structure at this
> > > point...)
> >
> > Well, there is no official kernel release using this structure,
> > so I suppose even this late in the rc cycle, we can change it with
> > appropriate justification. I think an alternative to padding is to make
> > this a __u32[2] field, which should also be backward compatible with
> > the 4 byte result passthrough.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
