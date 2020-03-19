Return-Path: <SRS0=OxAA=5E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F51C4332B
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 14:08:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1F52137B
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 14:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RDNpZI92";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NzNbbUsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1F52137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tN0R7oZFxJuk/Bds/V+do8dpfboryAtzcHmBPKX/keM=; b=RDNpZI9210VBNY
	nxEp30pV1L+B3OQFjwrtPIxUbYaFfl+FlcXoiKnLuV8CZDEJ2HkZ45o8QeRvglFLdDWCWXdXe4v2U
	0k7KSaanm7ttgBQyke6EtRVwmpYB3TBqnGXXVrI+hLAl2JkT5FvLVGjQ58td7zv21GXYBpBEA21hy
	DmyuS64pPyycuchaPhyxNgbxYtrsVj/Mmus+1WeWMxrDrszlWSmtXQOqnjnWLH0eZC/L0JhjzUTYg
	xdz2RS2fURaUbxp7oANDbVqXUKKYjKk8hCuXjXf7rrjc1dGe1ZKgeAVwYNAg+9HU4UDAjlkkbBpy3
	NVLZWi/fH4t3Vc5r6tfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEvqv-0007YA-LZ; Thu, 19 Mar 2020 14:08:53 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEvqt-0007Xc-6F
 for linux-nvme@lists.infradead.org; Thu, 19 Mar 2020 14:08:52 +0000
Received: by mail-wr1-x444.google.com with SMTP id w16so3130952wrv.13
 for <linux-nvme@lists.infradead.org>; Thu, 19 Mar 2020 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=99K2Gw3OyNC688bY0UbsB4VsbokKiE/LOqor4VmBdao=;
 b=NzNbbUsPHbl3jpzp+5eJSeEd92Hj76Z9w0lKlIO6KF3ap/PviXDMp+1zcCAJpuFDWF
 33y0qfJutWvtLXKQgG2y/m20jqhIat0vAXXtJ5uvFpaohYkeZUFkNOtB9oi5aNzjFp9h
 f9kU7z6171wUTxX4R3fmFGy6KYGmo8yzZwgFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=99K2Gw3OyNC688bY0UbsB4VsbokKiE/LOqor4VmBdao=;
 b=UprYc/0VrH1A1vr4AzUvORWF+2Qe2H3GYZ6V61YEhMDV4dCDZLdRe40S5DgO36svHl
 xEVtIbgvtSPRTMehyA8dN5dDMLESxlePrSTh/nJiRfTz1rOhh55psT9e03K9VWWfkhpR
 KJx8VcL4PvR3IYJs+I26pSh9zHKIoRe0nfc/v9qa1Pd9nxiUVSNOu+DZt0VJ0ZhQVxcj
 VlAPw/3ahVMa8X+4jUVP7ooKguwrdqYwV4dBjx9fwJ6QmEUQbIxymViyx233TT7Ntn75
 HYxYFk6XjHcOkUsccAI6BScWXSH7GBNt0z51gWd3vnKHZakNlZ3kk2dJyXvhY96F+HTY
 /yaw==
X-Gm-Message-State: ANhLgQ32QYDznwi2gvuA5gcxlqLsH0bo2uEBEyYIv/obAk+Ef2SrwRzy
 owyt8Yq/nfE95Z2E7eC5JYvvMQ==
X-Google-Smtp-Source: ADFU+vubzEV76oU1jJKRuuzpLgfRjDsA9/unbxRRyZDLkthpW3WE2Ye4dY/IF7WdPlNRrP35EEsr7Q==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr4474483wrn.400.1584626928770; 
 Thu, 19 Mar 2020 07:08:48 -0700 (PDT)
Received: from chatter.i7.local ([45.67.14.0])
 by smtp.gmail.com with ESMTPSA id j39sm3880051wre.11.2020.03.19.07.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 07:08:46 -0700 (PDT)
Date: Thu, 19 Mar 2020 10:08:39 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 2/5] nvmet-rdma: add srq pointer to rdma_cmd
Message-ID: <20200319140839.7a2opbgqpenlrtlj@chatter.i7.local>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-3-maxg@mellanox.com>
 <20200318233258.GR13183@mellanox.com>
 <1a79f626-c358-2941-4e8e-492f5f7de133@mellanox.com>
 <20200319115431.GU13183@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200319115431.GU13183@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200319_070851_236655_9519B18A 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: loberman@redhat.com, bvanassche@acm.org, vladimirk@mellanox.com,
 idanb@mellanox.com, linux-rdma@vger.kernel.org, rgirase@redhat.com,
 shlomin@mellanox.com, linux-nvme@lists.infradead.org, leonro@mellanox.com,
 dledford@redhat.com, oren@mellanox.com, kbusch@kernel.org,
 Max Gurtovoy <maxg@mellanox.com>, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 19, 2020 at 08:54:31AM -0300, Jason Gunthorpe wrote:
> > > Max, how are you sending these emails, and why don't they thread
> > > properly on patchworks:
> > > 
> > > https://patchwork.kernel.org/project/linux-rdma/list/?series=258271
> > > 
> > > This patch is missing from the series
> > > 
> > > v1 had the same issue
> > > 
> > > Very strange. Can you fix it?
> > 
> > I'm using "git send-email".
> > 
> > Should I use some special flags or CC another email for it ?
> > 
> > How do you suggest sending patches so we'll see it on patchworks ?
> 
> I looked at these mails and they seem properly threaded/etc.
> 
> I've added Konstantin, perhaps he knows why patchworks is acting
> weird here?

Not sure. Everything appears to be properly threaded. I see 2/5 arriving 
at precisely the same time as the cover letter, so 2/5 probably got 
processed before 0/5. I have no idea if that actually matters to 
patchwork -- a whole bunch of series would break if arrival ordering was 
that important. At least I assume that would be the case.

I'll check with upstream.

-K

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
