Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734A3C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 17:12:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D017611AE
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 17:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D017611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rm1Yu/VOdhVwU/1bWTx8rRXwy8TU/ZDf8aXgfVnXrJE=; b=oyS4uUB2mmqAWfF/71wEdOyvD
	7cEDvTEjUnc3imVu84ohvQ9NWywiucKKD3pSyDOEiKiG45Lz1+1Ek1X15CG2qoEONqhNk2HoUiqoe
	XJsS8JMH1GFwvtRxlHFDJSvacNdw0Ik0JGD4S1ZMYTqNE+ajSSmxdTjoShOcnyuN2UpSKFt8YON3V
	MGnLiB+zGtNXwjrV91YlAlR1NQq4+x7i7aPaG7bwwcJZ+YCEUrBGQa5nmNxU39wSKUqEJ2Rv72FUE
	JEqgJdP/pMhEbPXz9GDDjGyu39Cm8DLsCNBx6WW8+ZJOCWNidX4pw387b2KPFd2MK8/T2a9XMZUTX
	45ISStKbQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXS19-002uSP-NO; Fri, 16 Apr 2021 17:12:33 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXS16-002uSA-PC
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 17:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=iYO+h9/pPElF5xRtH81qVcZRLIBEZanluS9s1mxpRmA=; b=Ez1J8djSWxZ+eDS2AguJmPhHv4
 1S4pPO4iJTR3UfySEMPKDV7XevVqHUbewZIEGBHm0308C5MN6iVBdsDpD08YTFzKRY8httbxxuczM
 Bsm0Dsq90Cslv2UE5du0UjhsrvXLw0uexjQm3oJniP4YCu9ulkVkvhS0axz2/mNdP1LE97fxQ2bu4
 /dMWgfL9EPuv+SqyqZZajY1fs2fQNSpO/VzmpcC/2ORv8QK0xa3HwEPy8xubiHhumsYmZM96b77Ud
 +f2D2MRvWG7ao/OZyvYQSGuIbNlCLcKUV5Z4kECX5Z3cLvunds2MkxPX6xnR8Cqerur04u/9O7Ii3
 tUXXlYNw==;
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXS11-009aJL-LA
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 17:12:27 +0000
Received: by mail-oi1-x22e.google.com with SMTP id a21so15473425oib.10
 for <linux-nvme@lists.infradead.org>; Fri, 16 Apr 2021 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iYO+h9/pPElF5xRtH81qVcZRLIBEZanluS9s1mxpRmA=;
 b=MPOnwmZRVUdCIy3ydzrwJe8L4KiU4rnYvgplGLm7iZbFw188qql9Mw/jeq5k5v/xjK
 q4l1rL1lzOm2cz/CnbAeK06YG3xdEkBsidoaGxf3c9kZQB8P+LtDPHPusDNxYNv3koPX
 PrCvB7dtQypDYLnS4jq6Ue/pVJfHLMimQv22w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iYO+h9/pPElF5xRtH81qVcZRLIBEZanluS9s1mxpRmA=;
 b=Gz055Ps32IS+qh7MYNMmKi/rRaa5c1gIFSavUeGo1lu7WuNCMxf+Q7EkCNkBxqMiZP
 JvwICxO6cnGFLh8ZuhAaJz9bBWsPg1/zlDfM4+WZOsjxSyAlXxSHfivdpsDeIq/XYl+8
 gHEgfJg2QXbpRpc2S4hlf0CzupnlyFa3p6kqE8VSKdmTZiVlJkACmUESbEWSmTHPzRmh
 HnVSd3f76ngIEP9pCQec7hYz7EBIM2DMFMI59SYEQwMEuXG6HMYAH+OS96pQlOogSwL0
 xXRoG0S783lU6s7QyrDukcupuU69QKriFVyd6Gq3PcpqY3ylcWmjQ1SURhkgJnABzgw/
 9n3g==
X-Gm-Message-State: AOAM533w5J6FjYkNkux15kw6LPuFJv3PbkDyEjr9WTfe0187RV9hUJ8M
 cN9dGt/EQW0cRYayc+PhKKsH4FHxfNcUFlTvAjCqoA==
X-Google-Smtp-Source: ABdhPJwEmW6zsugZig1r7cYr2Qubb8k8Jjjo7KdKDJp/MA8zpRjkVORVHfwp3lqpw4KysSbWmmRLdCLAcRvcBDNZBzY=
X-Received: by 2002:aca:d556:: with SMTP id m83mr7394899oig.71.1618593142437; 
 Fri, 16 Apr 2021 10:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210416165353.3088547-1-kbusch@kernel.org>
 <20210416165353.3088547-2-kbusch@kernel.org>
In-Reply-To: <20210416165353.3088547-2-kbusch@kernel.org>
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Fri, 16 Apr 2021 10:12:11 -0700
Message-ID: <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, 
 axboe@kernel.dk, linux-block@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_101223_812532_3C77C653 
X-CRM114-Status: UNSURE (   8.00  )
X-CRM114-Notice: Please train this message.
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

>         if (poll)
>                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
You may need to audit other completion handlers for blk_execute_rq_nowait().
How to get error ret from polled rq?
>         else
> -               blk_execute_rq(NULL, req, at_head);
> +               ret = blk_execute_rq(NULL, req, at_head);
>         if (result)
>                 *result = nvme_req(req)->result;
>         if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>                 ret = -EINTR;
> -       else
> +       else if (nvme_req(req)->status)
>                 ret = nvme_req(req)->status;


-- 
Regards,
Yuanyuan Zhong

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
