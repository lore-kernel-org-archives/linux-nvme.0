Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD85C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 07:38:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5BF2080C
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 07:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i9Op9c4u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AviZ1SR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5BF2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vtoTU8CDzZswUMioG6kWjCyt8YkymYYX5zCuI65PR7k=; b=i9Op9c4uQKoWDDzqxiStgiLq/
	iv8MhdqbbEoVET9uJLy3Q1ix2J0VKlXilQhVDd59foggd5YsAYWV3YVpKBvVL4YtctxMcoSgkJ04k
	NoO2dD7MrSznIIzHSje1Psn+jfPrOLCi6z6HealK/bMo9cLL3s6FrXt3R3pmlThhigkspOuWXmIxF
	/BVf67aGBdTyRjEm+gp9lA9KDkjXNfYs28ptqwVreJd4Yo56U+Bpr0O1vivuJXB8Zt6KddzioNRap
	FywrneR2f+SeBzg4XGvsx7edPLGIB+XHvQpPzolR+8FihG/bNuRLqvwEzalFskPwqzQ4W0QnInjQb
	7V3H8Iqvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8f9M-0006Fu-Ly; Thu, 20 Aug 2020 07:38:16 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8f9K-0006Ez-Ac
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 07:38:15 +0000
Received: by mail-wm1-x341.google.com with SMTP id x5so678993wmi.2
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 00:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tQmGB+boenn+8AWQYGoZFj5ruu/kBTP0OjM4DoRcBzM=;
 b=AviZ1SR1z3KYs/8oZaCL1cwH2GoTYKUaG1Mf7v+i8czULqXqUw5TOw+ZLKDfIYI+/P
 5pgLSO7AAtAcdIC6ilZqNd58/QJbswRzm2H8QTbkGMxazUqSDiN7Op6SUAPOGmfnrrc6
 je7fyhZTZ/iSQoIrjYE2/KbBrcX3nAY8KH5a3lzZLNofdM8/VZyNOMfChro5Sk2SEYTP
 TriwhY59mSH9pR9JTMlh34jQKmHdZbasI5wR8+JP+UHImu0Tr5QPMfucQW75o6yAM9ey
 7s8tKEwQS3s5MJrRHaDV5z5efziaDVP1okOS27kT0lXZItiM8iqWshBv5aXY3bPjXT1Z
 yGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tQmGB+boenn+8AWQYGoZFj5ruu/kBTP0OjM4DoRcBzM=;
 b=GO+dkUQfp2eTlZytk1Ppla3LUojNduTcCYPdJh/kg2+rprOvHAk2MmD3gv8GODWTXl
 gUOECOEr5zR+p7NTELtqtcROiVgMxPLw/PBE0v6YlSeyE4ajaLUfVjfe7i9n3oRYCHU9
 Leb57aps2uidgbr/YLznwEpGeIzfkEnhfQczCi5RVIvvHEBLOSXoOEdvVGHU6Es/OWSE
 O6LjhOFnKW4rx0dj6uFeMS9GDLYw0BNLHTFV8fOZF2xZpzC20ZFNPqp9FeyP4K/UfPLg
 AL7CaEDmq8g/XiNNHKtAHHUgyRz3DALv2zedpVe9fY+7bujSwTfESvvRjdskcKKPPJ8h
 cQew==
X-Gm-Message-State: AOAM533GMwXo5BDZHtaemReTlREPx3ZQAYxhFCU1jLNbzjjrOPG6gGMY
 HQ8807Yn62h8Z6ACudpug7QV4BvUwFVuW+rkL0U=
X-Google-Smtp-Source: ABdhPJyrhHyKEtU55iuD+ebeNI3eJX/NhcCqjNEYNHfndZ9F16tloec+To42PB17tAUBxv8xmPrMo8joNdVnrXkAe7Q=
X-Received: by 2002:a7b:c384:: with SMTP id s4mr2082840wmj.138.1597909093072; 
 Thu, 20 Aug 2020 00:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <20200819214248.GA26769@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200819214248.GA26769@dhcp-10-100-145-180.wdl.wdc.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 20 Aug 2020 13:07:46 +0530
Message-ID: <CA+1E3rJgvvebEex-zVBGtqK_BAaQUtcwq9nDoFm+Rd=DD20zxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_033814_428996_0F11D4B9 
X-CRM114-Status: GOOD (  23.98  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, David Fugate <david.fugate@linux.intel.com>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 20, 2020 at 3:22 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Aug 19, 2020 at 01:11:58PM -0600, David Fugate wrote:
> > Intel does not support making *optional* NVMe spec features *required*
> > by the NVMe driver.
>
> This is inaccurate. As another example, the spec optionally allows a
> zone size to be a power of 2, but linux requires a power of 2 if you
> want to use it with this driver.
>
> > Provided there's no glaring technical issues
>
> There are many. Some may be improved through a serious review process,
> but the mess it makes out of the fast path is measurably harmful to
> devices that don't subscribe to this. That issue is not so easily
> remedied.
>
> Since this patch is a copy of the scsi implementation, the reasonable
> thing is take this fight to the generic block layer for a common
> solution. We're not taking this in the nvme driver.

I sincerely want to minimize any adverse impact to the fast-path of
non-zoned devices.
My understanding of that aspect is (I feel it is good to confirm,
irrespective of the future of this patch):

1. Submission path:
There is no extra code for non-zoned device IO. For append, there is
this "ns->append_emulate = 1" check.
Snippet -
        case REQ_OP_ZONE_APPEND:
-               ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
+               if (!nvme_is_append_emulated(ns))
+                       ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
+               else {
+                       /* prepare append like write, and adjust lba
afterwards */

2. Completion:
 Not as clean as submission for sure.
The extra check is "ns && ns->append_emulate == 1" for completions if
CONFIG_ZONED is enabled.
A slightly better completion-handling version (than the submitted patch) is -

-       } else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-                  req_op(req) == REQ_OP_ZONE_APPEND) {
-               req->__sector = nvme_lba_to_sect(req->q->queuedata,
-                       le64_to_cpu(nvme_req(req)->result.u64));
+       } else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+               struct nvme_ns *ns = req->q->queuedata;
+               /* append-emulation requires wp update for some cmds*/
+               if (ns && nvme_is_append_emulated(ns)) {
+                       if (nvme_need_zone_wp_update(req))
+                               nvme_zone_wp_update(ns, req, status);
+               }
+               else if (req_op(req) == REQ_OP_ZONE_APPEND)
+                       req->__sector = nvme_lba_to_sect(ns,
+                                       le64_to_cpu(nvme_req(req)->result.u64));

Am I missing any other fast-path pain-points?

A quick 1 minute 4K randwrite run (QD 64, 4 jobs,libaio) shows :
before: IOPS=270k, BW=1056MiB/s (1107MB/s)(61.9GiB/60002msec)
after:  IOPS=270k, BW=1055MiB/s (1106MB/s)(61.8GiB/60005msec)

This maynot be the best test to see the cost, and I am happy to
conduct more and improvise.

As for the volume of the code - it is same as SCSI emulation. And I
can make efforts to reduce that by moving common code to blk-zone, and
reuse in SCSI/NVMe emulation.
In the patch I tried to isolate append-emulation by keeping everything
into "nvme_za_emul". It contains nothing nvme'ish except nvme_ns,
which can be turned into "driver_data".

+#ifdef CONFIG_BLK_DEV_ZONED
+struct nvme_za_emul {
+       unsigned int nr_zones;
+       spinlock_t zones_wp_offset_lock;
+       u32 *zones_wp_offset;
+       u32 *rev_wp_offset;
+       struct work_struct zone_wp_offset_work;
+       char *zone_wp_update_buf;
+       struct mutex rev_mutex;
+       struct nvme_ns *ns;
+};
+#endif

Will that be an acceptable line of further work/discussions?

-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
