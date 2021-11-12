Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B041C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 22:00:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B4861051
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 22:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9B4861051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VFN3YfKrrN4rviirmH1lG0NY9uufAM6YHK0vPxccEaw=; b=Jo8h4Na1gDfz3ofgIT3CK4Gyt8
	i4E4E/T8S1XRvtcK6XiMKSJp1Ta/GSEr5gs8gKmVNBP0pzKe050AJ6LFUJqR9GJNMRzdjUE8Pa4XR
	tvbr+xT+qmY48hqs09BcHtGydyO/oQ7J47w0tAGHSA+O2/CDt1/FvtbPylAgj0RnmiOrdsgpD8qCv
	hyQChIQDgOzYovR58i8povVNjeYjILpmweVO9eeVecU+ShWhUjPvCxqkRTL9CXZbK6eiEfwdcYjUE
	vihhRPtOvrDd97AUgV9y4qV1kcw6GxW+fYkKDaf5yOK7lQOGrTwzqm2IFUnexFEwsZrBLZrIX8+w3
	nCHilmuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mleat-00Bg7v-H4; Fri, 12 Nov 2021 22:00:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlYL5-00B2jQ-1U
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 15:19:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636730376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VFN3YfKrrN4rviirmH1lG0NY9uufAM6YHK0vPxccEaw=;
 b=IEmTYYOVu8mnNf8dncwvv63iPXnTzw+SDFVpHEr5SCq5O1ZxbPCmPqq7Wdw97KhFccVCcs
 PpvF0X6sLfvePo+htyPszZOVP9OPJFw+TC9+/jUt+DHqLVkcJdZ2V8c3AfrjHJX4R0Iaf/
 vTUFGcudgKajU4OGV7+iJCc739D3CyQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-ziZwumVTPPGhMUGCjjIkuA-1; Fri, 12 Nov 2021 10:19:35 -0500
X-MC-Unique: ziZwumVTPPGhMUGCjjIkuA-1
Received: by mail-qv1-f71.google.com with SMTP id
 q2-20020a05621419e200b003aeeeff5417so8608335qvc.9
 for <linux-nvme@lists.infradead.org>; Fri, 12 Nov 2021 07:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VFN3YfKrrN4rviirmH1lG0NY9uufAM6YHK0vPxccEaw=;
 b=mY1Rrc3wJtgFwuIsmfJOmQ4ZCFfI18LY0hdxdrxSD7/0jsasK5duphggTq0v1V4Xcq
 ZGWV+E1JVNdHJ1lERFExwwbS09opVyzuQ2/DWUWx90SQ5hghOLWpqPHJwQVC2jCvOYqU
 7IAiWYv0QN0Mr/+u5ZA25Kcfs0bMuPQs1gvJTbmLLUy+olxwTdq52wstTw90PHH24bDi
 JNlWyXlCFuSm/33Gx3agzWkdOVMXVcIqz6qlpj9iFTLvMMHBk91jUHXzgNTrUUUhrEyj
 B0Tqxybp41iH2HAuko22pvYj50/sHhB/tZc3QHxnwhH3kaUZeNvFKqhIAp1xZBErTuUy
 VD8g==
X-Gm-Message-State: AOAM530cotmucx3tRgp+95Uu/37EBiW1M2ph0GYni7Ka3z5QKgCeE7pr
 TxRfkYSGmnt7OEGR21X2iZke6Oi+UKaeeKKOyuREyuZqW7Rl4EO8c2cVgANLV6OY27E/S1dOzQT
 e620rDIVdufomefftXiM2+Arg0A==
X-Received: by 2002:a37:2f02:: with SMTP id v2mr13127480qkh.232.1636730375042; 
 Fri, 12 Nov 2021 07:19:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxk6sSDPzw7jrkKAxFn/K0PAx9HKUToVCIsJBG7fV34DkkAlHg0N9AMoil4JWoJAqjFdQQ15g==
X-Received: by 2002:a37:2f02:: with SMTP id v2mr13127438qkh.232.1636730374828; 
 Fri, 12 Nov 2021 07:19:34 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id az14sm2791255qkb.125.2021.11.12.07.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Nov 2021 07:19:34 -0800 (PST)
Date: Fri, 12 Nov 2021 10:19:33 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "agk@redhat.com" <agk@redhat.com>,
 "song@kernel.org" <song@kernel.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "javier@javigon.com" <javier@javigon.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "osandov@fb.com" <osandov@fb.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
 "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
 "ebiggers@google.com" <ebiggers@google.com>,
 "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [RFC PATCH 8/8] md: add support for REQ_OP_VERIFY
Message-ID: <YY6GBaSypKNPZnBj@redhat.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104064634.4481-9-chaitanyak@nvidia.com>
 <d770a769-7f2c-bb10-a3bd-0aca371a724e@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <d770a769-7f2c-bb10-a3bd-0aca371a724e@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_071939_261251_911FEF69 
X-CRM114-Status: GOOD (  14.24  )
X-Mailman-Approved-At: Fri, 12 Nov 2021 14:00:22 -0800
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

On Thu, Nov 11 2021 at  3:13P -0500,
Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:

> On 11/3/2021 11:46 PM, Chaitanya Kulkarni wrote:
> > From: Chaitanya Kulkarni <kch@nvidia.com>
> > 
> > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> I want to make sure the new REQ_OP_VERIFY is compatible with the
> dm side as it is a generic interface.
> 
> Any comments on the dm side ? It will help me to respin the series for
> V1 of this proposal.

I can review, but have you tested your XFS scrub usecase ontop of
the various DM devices you modified?

Also, you seem to have missed Keith's suggestion of using io_uring to
expose this capability.  If you happen to go that route: making sure
DM has required io_uring capabilities would be needed (IIRC there
were/are some lingering patches from Ming Lei to facilitate more
efficient io_uring on DM.. I'll try to find, could be I'm wrong).

Mike


