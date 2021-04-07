Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD1C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 15:45:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D9E61382
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 15:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D9E61382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5rKMoGvnOXPnZv9tUY7zvoNn6eI6ZE99JSR9iaXEGVc=; b=iMFMr4L4jIMVeqKTxz4Gj8xhO
	5w6xVFBx4+lXlurU1KRX03pGZMMkRU85J7hEPMV05NWwilbgcvRFc+lElbrhAtTeRB8BSuvtPr3q6
	vrHWysksNg0IWhm/ZqoX8cv/46HYCnHrW51UEybXwDfdNbkY9yNG0aZXKy8Frh4WfY8oRaJhstSCl
	EIne81j7FHL6d5+vHngm85uBxfKGyAVSuQjlDF3txarIEPDzDnttrJev2Tcwx12Yp2mx+d+ARJ8cV
	U2A8ZMhxY7VrICUFQ53XUc9NBb7+D+SAZvNGx908wm+OlePeoPIyDk+tFGdx1weLXHxmqVsAPLtS5
	fuRUB9kPg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUAML-005JF6-OB; Wed, 07 Apr 2021 15:44:49 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUAMG-005JDt-Px
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 15:44:46 +0000
Received: by mail-pj1-x102f.google.com with SMTP id ha17so10018614pjb.2
 for <linux-nvme@lists.infradead.org>; Wed, 07 Apr 2021 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iAQ1jzEJSw7VYuWjhXDBKcmLj6px3H69GM+4iTa8wSA=;
 b=rOi+2AnV5uXqcL5DbJLJBrYKlipxhkSYAhwsIr7KomcU4kq+/f4qGjGtpl+Eo2EPl8
 XOLabi6nt5o+5AmGHqkFr8U1GS1gJqVD+EpAI0cUYfuFoJjKeIv4WRPtrcFzQdTknfxY
 Qg9E1NVTZjQaRgw9S3xoVTIoD8qw8a33xjO0Bordztbnzoq3OatjgdHhke7jKi+LMMTn
 NDKVMNrOhv8XXxJPK1/DtwflftRBZmeNWEgxwYfsf2RADYWaeFrjYi+eQBOdTodu1TRd
 VyrUgLcWu5KhTyJrEXNKWnKYl+VUrsAYUj5aAsLOrozJNor6YbE3qB6Wk/R7vRLb8D/f
 FjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iAQ1jzEJSw7VYuWjhXDBKcmLj6px3H69GM+4iTa8wSA=;
 b=XBRn44JkXyzY0vGNiPekQg/j/tp6pRzf8crEJQUlaBbwYngfU8e/6WzHq+Mekh15xP
 1xbVtddkCkxkktG0ow++Xez4pPEt5d+Oqv/B0f4C/zPiTBRVvPwJLww5eIkqHJzVy1UZ
 RRX9C2CAkdaoNFEGuUcGEPPYnkF9Ta/ydTD/YqR1SW+yEaGJXEUHtwnt2yM9wc5b7XZ4
 nncr2lkn6I4so3vjEaTaYGPgGD5cZ1NHDx1YmwBdRHUtVBBwAaZ8ogOLvb/iGn42TSqQ
 qC3s8WFle52pkOMWJBmqER/DnLAQYoLw6z1ysJ0+UnsebBa0GhioUZi7KgC2ipUDr/v5
 vuAQ==
X-Gm-Message-State: AOAM531+3KXFvwNIBtsMLeLvm0tjR/rB0fxkmSqr9rkuE/QHun1jbcWX
 /BGfm+SZ1jPgkbM5xpwyyVk=
X-Google-Smtp-Source: ABdhPJxk49+vRNEw7fQchwE17Fmf4jPC4BNRPvuq5WjFU9ayur2upE439/qT4l6CuhYsgnq/U2M23w==
X-Received: by 2002:a17:90a:4d81:: with SMTP id
 m1mr3841149pjh.143.1617810282057; 
 Wed, 07 Apr 2021 08:44:42 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id y15sm25741263pgi.31.2021.04.07.08.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 08:44:41 -0700 (PDT)
Date: Thu, 8 Apr 2021 00:44:39 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210407154439.GB8667@localhost>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <20210406064841.103393-2-minwoo.im.dev@gmail.com>
 <20210407131527.GA15142@lst.de> <20210407141128.GB2805@localhost>
 <20210407142152.GA20466@lst.de> <20210407153536.GA8667@localhost>
 <20210407154000.GA26718@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407154000.GA26718@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_164444_923150_40898E8F 
X-CRM114-Status: GOOD (  25.00  )
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

On 21-04-07 17:40:00, Christoph Hellwig wrote:
> On Thu, Apr 08, 2021 at 12:35:36AM +0900, Minwoo Im wrote:
> > 1. During the `nvme list` command, controller ioctl for the ns_head has
> >    been not coming out from the mutex_lock_killable(&nvme_subsystems_lock)
> >    because it just gets the controller reference and return it without
> >    unlocking it.  So the first change point of this patch is to unlock the
> >    mutex right before the return.  But, Is this a real issue? because
> >    this changes are not from this series though.....
> 
> Yeal issue, stupid rebase error when I stated to split and move a few
> more pieces for better reuse from the chardev..

Got it!

> > 2. Can we have the check whether the ns_head has disk allocated or not
> >    by getting `disk` pointer out of the #ifdef CONFIG_NVME_MULTIPATH?
> >    If it's not allocated due to some reasons (e.g., !multipath, or CMIC
> >    does not support multiple controllers, or some failures during the
> >    allocations), disk will never be allocated.  So, I tried to pull the
> >    `disk` pointer out of the #ifdef from the nvme_ns_head, but maybe
> >    this is not what you have intended....  It would be great if you can
> >    give some feedback on this.
> 
> This looks pretty sensible.  If you give me a signoff I'll commit this
> as a separate prep patch.

Please have a tag about this one :)

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
