Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6DAC43461
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 23:29:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D9921D40
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 23:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OV4Q2NQd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsPNaGLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D9921D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AbrIQKqeKTZe3pww5BlGZvn3VgMy5xhsKnqz5Z4OXgY=; b=OV4Q2NQdrI3jBhplTwaF7QtTK
	6WCYLHVZmbaBwdPV3CLaJR5lBTZtFvv5E5UHISGcojnmxe3mx3qqlDoaZhCCq1U5pHdCuyfafDpQA
	cxJjgSSotyS7dQKcrEZoxuV/vf1zZ5IM9enn7akkL88P3mUuXjDWOrKdVjOIelPdmnPyqHwdh72X/
	O5K9QNWxoUn9GUKXtuoJY228bVxYz/5VX2sxmJsEzYfVjzYmHkG9W3UCq+ofvIA7xA3ZW7HIdoQod
	L3VD1JbUDMg8xcHrSW4VFkRkUjydd5I+36RDC6K8YmNjmuVkYURGdOziOvU0t4UZM2C5XO142YP8F
	+VipUNpNA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGsTg-0005oQ-HC; Fri, 11 Sep 2020 23:29:12 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGsTd-0005nf-04
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 23:29:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599866947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRV2zfO50p3gtciWQXm6qslUoZUnBFQUVofw94w9HCY=;
 b=NsPNaGLNYSZMapESukl/DvFv8YBdgPPGWfnIrydbCG6+esx+xDInCTDNtHcDF2lGGkZtxH
 wFCuG4vBX9FYpDb61Q7w4BgbfulOLfzo5JhgCLFlG088tRuHWep4hGfCBP3/2sIblbj+/h
 pP66uhnGnR4ASBf0DuvhhBoGcqDcCCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-zyEZ5B87Pve9x4zzmCqFlA-1; Fri, 11 Sep 2020 19:29:01 -0400
X-MC-Unique: zyEZ5B87Pve9x4zzmCqFlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43CAF18A2244;
 Fri, 11 Sep 2020 23:28:59 +0000 (UTC)
Received: from T590 (ovpn-12-16.pek2.redhat.com [10.72.12.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FF2460C04;
 Fri, 11 Sep 2020 23:28:48 +0000 (UTC)
Date: Sat, 12 Sep 2020 07:28:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200911232844.GA172054@T590>
References: <20200911024117.62480-1-ming.lei@redhat.com>
 <4fb604fd-c081-5eb1-cb3a-860746b6952a@grimberg.me>
 <09d5cb96-b442-6965-96b3-d884c95a3ca7@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09d5cb96-b442-6965-96b3-d884c95a3ca7@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_192909_190997_39DBCB2C 
X-CRM114-Status: GOOD (  20.24  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 11, 2020 at 11:34:45AM -0700, Sagi Grimberg wrote:
> 
> > > Hi Jens,
> > > 
> > > The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> > > and prepares for replacing srcu with percpu_ref.
> > > 
> > > The 2nd patch replaces srcu with percpu_ref.
> > > 
> > > The 3rd patch adds tagset quiesce interface.
> > > 
> > > The 4th patch applies tagset quiesce interface for NVMe subsystem.
> > 
> > Tested some reset storms and target restarts during traffic with
> > nvme-tcp.
> > 
> > Seems that no apparent breakage.
> > 
> > So:
> > 
> > Tested-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Probably unrelated to this patches, but I do see new
> kmemleak complaints in the form of:
> --
> unreferenced object 0xffff9440dbf3c240 (size 64):
>   comm "systemd", pid 1, jiffies 4306444056 (age 25034.440s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 b0 fe 13 99 ff ff ff ff  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000f1d0b20e>] percpu_ref_init+0x5f/0xf0
>     [<000000009598103f>] cgroup_mkdir+0xe9/0x440
>     [<0000000001b93c19>] kernfs_iop_mkdir+0x57/0x80
>     [<000000001ed0f985>] vfs_mkdir+0x10e/0x1d0
>     [<00000000cac65f7e>] do_mkdirat+0xec/0x120
>     [<00000000956db630>] do_syscall_64+0x33/0x80
>     [<000000001c2b0e1a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Hello Sagi,

Could you test the following patch and see if the leak is fixed?

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd247747ec14..e8b7a8b66415 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4962,6 +4962,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			psi_cgroup_free(cgrp);
 			if (cgroup_on_dfl(cgrp))
 				cgroup_rstat_exit(cgrp);
+			percpu_ref_exit(&cgrp->self.refcnt);
 			kfree(cgrp);
 		} else {
 			/*

Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
