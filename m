Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E66C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PhveZTGN0h/vS9NmxXXstYNT18cOT72G9MSmwKlcb4E=; b=zIBm1h2L7UDmUGd1aXKCLW2yBs
	1P2tpmBj5LQGNw7zVbjo9IQSMJbO8Ci/Bb4h9oQ+/73F6QI8Zdv3rKLDOKsQnYSKI5Gy5DXLJK/mE
	DPNcfJ8TMNi5DGNQPbaUKVYsqsArbx2BAyRJ8gEs4fqDs6rJrh/sPYXyZPLtnAyFQXYVd0Oh/dFH6
	VPg2UxHd8/wxkfkznLmf6YS4t8g77NjF4VAKp1lztvfUuTFDMDmn/O3w33PjiGWI3aelbK6oHB/LD
	CFvevR241jikJkz4YAvOqfueG9GkWwvhHnlmcY+3kRaZFV8TEb5inewz42jT1TUDO0+erKB3pOx0l
	N8Rn54fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWdxu-00B05C-IG; Tue, 22 Mar 2022 12:50:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWdxr-00B04I-Bj
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 12:50:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647953417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PhveZTGN0h/vS9NmxXXstYNT18cOT72G9MSmwKlcb4E=;
 b=Og35q0Cao6Z5eFOC0J/16Jb+6eOK+2rVgLKnIdmZxlYlECs4Cgy0S85w4yafhNibZWSW1s
 9PgrDD/cZd/N9rMuaA/Io8HlfnGwX/eL+SN5pKPCYqasH0xO6lWYklzw6RzX5XaarjZnCt
 DyxSUYjj2enWdzwwDv8n3w0jj7BB6ns=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-E6iRT3YCNi-fcv4Mu6hkFA-1; Tue, 22 Mar 2022 08:50:15 -0400
X-MC-Unique: E6iRT3YCNi-fcv4Mu6hkFA-1
Received: by mail-pj1-f69.google.com with SMTP id
 m12-20020a17090a7f8c00b001c6d1ae1ef3so2912217pjl.7
 for <linux-nvme@lists.infradead.org>; Tue, 22 Mar 2022 05:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PhveZTGN0h/vS9NmxXXstYNT18cOT72G9MSmwKlcb4E=;
 b=NTlK4eVmaEw9qdD9qFHaGYeA+RlKKXR22w0YeTF4Fw3YgjS5qOcK8fF03/Q+XYPA9U
 9mlF+5yjUHoSedBdvcXrUl9h+ix3PxsWyBStzBogqF5+tl4NNJ1QmApyh4soFCsWNA2D
 DxELr3jCYG2RPbDAwylVslFGYcDeVOs+3GufWBkDDjyeOMWjs3IB3loeWo3tGYpXUmZF
 upMvP9IhXVp7CnhfOxwj4453KZHheBZwrPGRfVEFw4h1Vfl8ezzy+CGM5bv+l5Y0/ALb
 eH3q8ZzjFEhVFJS4+9cKUvSZR3rSlg7j8cFgf/fw70jVlQv0P6TeI1A6Gz99fb3gboBK
 uJUQ==
X-Gm-Message-State: AOAM530oDi9OKpmvPXTlUM0+vDuK5NYCJPkTKhrCXsi6ZIlR1SDoWvUY
 Ss5sThidzPvBsXmneDX7SrCTBtGujJtu6O02y4GAsl4VMZ2ScCXPkvlbYYs5f6pjKbEnTLeNSoD
 ulZlj2dqTdzS4XTGBzNWJz023561vZxCah0mBx5Rk8Co=
X-Received: by 2002:aa7:8004:0:b0:4fa:c50c:1ffe with SMTP id
 j4-20020aa78004000000b004fac50c1ffemr35124pfi.40.1647953414907; 
 Tue, 22 Mar 2022 05:50:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLnFYgel0MDxcAclGPXOl7DEEjJFFlxPmtSZj49QkL/5VyFNSZKfptbYYBiUftRVxXIcHkZmsGbDYh9k+kBtQ=
X-Received: by 2002:aa7:8004:0:b0:4fa:c50c:1ffe with SMTP id
 j4-20020aa78004000000b004fac50c1ffemr35100pfi.40.1647953414680; Tue, 22 Mar
 2022 05:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
 <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
 <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com>
 <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
 <9ba8bfae-2363-e331-83c7-317a9456da31@grimberg.me>
 <CAHj4cs9cmOt=9++wuqJ1ehLPDJcaXJGyTKcHSjU-avWxr1CBrA@mail.gmail.com>
 <f5394785-aafa-784c-9ac0-b4abe19f65be@grimberg.me>
 <CAHj4cs_WQg752czaR4mtaZVPRW6ZqO16EAHZ10njRB+g+8gOOQ@mail.gmail.com>
 <CAFj5m9KD+AUn1nJ=XaqwuuWz4TQgZ+d8Uxq8n7j3adHvg8gR0A@mail.gmail.com>
In-Reply-To: <CAFj5m9KD+AUn1nJ=XaqwuuWz4TQgZ+d8Uxq8n7j3adHvg8gR0A@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 22 Mar 2022 20:50:02 +0800
Message-ID: <CAHj4cs8mHOvXdd5FTzGEYmHYn+ACrq=rHf4HfYm1c=+Ma24QEg@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
 RDMA mailing list <linux-rdma@vger.kernel.org>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Nitzan Carmi <nitzanc@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_055019_494206_691FC9AC 
X-CRM114-Status: GOOD (  26.77  )
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

On Tue, Mar 22, 2022 at 3:36 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Mar 22, 2022 at 12:58 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > On Mon, Mar 21, 2022 at 5:25 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> > >
> > >
> > > >>>>> # nvme connect to target
> > > >>>>> # nvme reset /dev/nvme0
> > > >>>>> # nvme disconnect-all
> > > >>>>> # sleep 10
> > > >>>>> # echo scan > /sys/kernel/debug/kmemleak
> > > >>>>> # sleep 60
> > > >>>>> # cat /sys/kernel/debug/kmemleak
> > > >>>>>
> > > >>>> Thanks I was able to repro it with the above commands.
> > > >>>>
> > > >>>> Still not clear where is the leak is, but I do see some non-symmetric
> > > >>>> code in the error flows that we need to fix. Plus the keep-alive timing
> > > >>>> movement.
> > > >>>>
> > > >>>> It will take some time for me to debug this.
> > > >>>>
> > > >>>> Can you repro it with tcp transport as well ?
> > > >>>
> > > >>> Yes, nvme/tcp also can reproduce it, here is the log:
> > >
> > > Looks like the offending commit was 8e141f9eb803 ("block: drain file
> > > system I/O on del_gendisk") which moved the call-site for a reason.
> > >
> > > However rq_qos_exit() should be reentrant safe, so can you verify
> > > that this change eliminates the issue as well?
> >
> > Yes, this change also fixed the kmemleak, thanks.
> >
> > > --
> > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > index 94bf37f8e61d..6ccc02a41f25 100644
> > > --- a/block/blk-core.c
> > > +++ b/block/blk-core.c
> > > @@ -323,6 +323,7 @@ void blk_cleanup_queue(struct request_queue *q)
> > >
> > >          blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
> > >
> > > +       rq_qos_exit(q);
> > >          blk_sync_queue(q);
> > >          if (queue_is_mq(q)) {
> > >                  blk_mq_cancel_work_sync(q);
>
> BTW,  the similar fix has been merged to v5.17:

Thanks Ming, confirmed the kmemleak was fixed on v5.17

>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=daaca3522a8e67c46e39ef09c1d542e866f85f3b
>
> Thanks,
>


-- 
Best Regards,
  Yi Zhang


