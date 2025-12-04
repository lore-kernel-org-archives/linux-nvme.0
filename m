Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022B8D2A521
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 19:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K85hLvlaLvTs7QWXRfbHiJadW8G+Kx4QGeXhEF8abl0=; b=ArtpSi9D/ILAaxo9fTZM+pyyKK
	vNDzJqRXCMEeq3sGlIxYPalTKyk0lEEubhXTcVRJ2DyZa3EgYUwxfXYFadYjyR11kkBYWw+XZWIUw
	F4zoy6fUl+I9lSHUfRWdSAK0j6+oagK6jE9DMAzfqy1dUVXZ41jmuFgQcANCo9qqfda4fGL6b7kSp
	nEdOiqkp9XTdMTvdchYtfO/bIRS2iRpxuwXOmdcQoThhSzwGHWYFarlwfk3wF4ycLyZAPPLmHOidF
	s33Fw/XYrBVySz46BZXbLQp0YvnCUGXt4moH3tNJAwgVLRdM+3Gs8Ht6W/zUhv7JzfeVR4l95Yy5w
	38c2Hpmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRFSp-00000008XLi-0O2G;
	Thu, 04 Dec 2025 19:58:07 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRFSm-00000008XLG-39u8
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 19:58:06 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-b79af62d36bso234699766b.3
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 11:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764878283; x=1765483083; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K85hLvlaLvTs7QWXRfbHiJadW8G+Kx4QGeXhEF8abl0=;
        b=YLaL/IBIoeEOW0+UXBnS6cF6Om8kcZDbfr5xp+PbZqn9nuTf10DUT8BoxS600pPWMs
         B0vN5U40yhHDjDCw/xc+bW9lEWe5MtL4/KRzqmsVHKiRG+FTBbb6Gyt3Qd8Gn+UI5Qzt
         2XWEOBwT20Knc0gOzuWPOWr7QIy/0lO3pv/lXS4+MsHua6D1Pmf34myp6Gv894/iQlcx
         UwcPPoHpWX/A41b9vb9u8rhPKqeueBQQ89psJCsLzX3m1BG6GgYt0TMrRu5C+WTX39NJ
         rcFHGqpnLLNaFof8moKc61nNt8Ey68WlYEYjuv5ESvtB8az81KGwG16l9SYpST+ixIGG
         Xc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878283; x=1765483083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K85hLvlaLvTs7QWXRfbHiJadW8G+Kx4QGeXhEF8abl0=;
        b=XDDEVXKrvM5xPOOaHVPrnVSiE1DeCe+lOuyVJNF4zzLgXSICIllfMCMtD/vUXFwzIu
         4hEt/NAAOeaQMOJ0jbqDvWohGdNKml2zlvN94EvCOSmTxD+ks2kYp/Kvom5Jo8r+t9ZA
         /9AztanVcJa52udFDUUIcX4pEbnn5rb97jQZpOXSBAXOeU9eK68mAno+PPYlOtSex11F
         mXfr5RFgAS3Ar71Y2VozuKq6oK1NBkIvhZzwJpzgB61RuUo88pZ0HbRApxAGm8fZK/wc
         S+GYDnlu1lcvAbTrXwW43rXcjvv5SjxOm3Mj5MJYj5EY5sikhl1zRrNh9wK4b//uAyzg
         dRmA==
X-Forwarded-Encrypted: i=1; AJvYcCUqFqtyeN481DdtEgsV6i9jiKsftBDhuv7A2/18M2SDDy6clWTMPU97l2bJlC4SoBOIQeTQR8hMmfj7@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4sOcAYzZ6aOUU6we+ECqyVIrTiQrKnLdfwxHabDLZcMPD+n52
	f0JSgTn6hdf3E7gPLIo+zdk/K3mEbc0NmCXRBbZCIQXunMH1X9RkK2S+xo0fd7ctgXE=
X-Gm-Gg: ASbGncsCkhWmom1ZPrQn7OFZbDZbeHFQnTU+WhgRrPhEMieCZBshUXVl4vknO4ZgTBk
	9oKL/XIKcq+Mc5MVJy4ZMRUZ9/TG6sF4S1J2HE3805YVGdlu919Lf7Kkll/+uujSu9cJ0i5IQY0
	1ilnzjMAK3F8DlCocACVY4GyOoay2qVW8iMHc3fpBsNzkqxO7YCoWbUSwCplSv+YDD4VLtmOTUn
	t7HWdO+CtdLudH3rzOcOKqLg1xnfRMHzMESPQ1mfPuhNEdCkBc60feP1kVbfanLI25WPy2hUvlv
	aDNj2H8/jz7kPpfXT29Vwg13z7uU/bOtGr64XloWeoRgFuZHcFM7yg1+dlVy08G6quHQzjqAgPT
	wf7xTbZICPQ6WRfN+hbm8twRV3AXXZnZsf/6sVKmHaelKjrJfqbfvO6Wgb4hGjJBKg2Ng1okunS
	9teqwjByTRVq1EVTVKQfGMvq8Etc+xmgo=
X-Google-Smtp-Source: AGHT+IHUPzhRdk1tJWg+WYux5jYGrf/7CZPDqfa+5xnHk5ZwVdIiMDev2CwK7tTMHnl9R6P38XGmgw==
X-Received: by 2002:a17:907:3d8f:b0:b73:9a71:13bb with SMTP id a640c23a62f3a-b79ec67421bmr451758966b.32.1764878282667;
        Thu, 04 Dec 2025 11:58:02 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a640c23a62f3a-b79f4976027sm193456466b.39.2025.12.04.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 11:58:02 -0800 (PST)
Date: Thu, 4 Dec 2025 11:57:59 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <20251204195759.GC337106-mkhalfella@purestorage.com>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_115804_871005_42A329D1 
X-CRM114-Status: GOOD (  23.14  )
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

On Thu 2025-12-04 09:31:55 -1000, Bart Van Assche wrote:
> On 12/4/25 9:15 AM, Mohamed Khalfella wrote:
> > The stacktraces are from old 6.6.9 kernel.
> 
> Please always include stack traces from a recent upstream kernel in
> patch descriptions.
> 

Good point. Will do that in next version of the patch.

> > However, the issue is still
> > applicable to recent kernels. This is an example from 6.13 kernel.
> 
> Thanks, these stack traces make it clear what is causing the deadlock.
> 
>  From nvme_timeout():
> 
> 	/*
> 	 * Reset immediately if the controller is failed
> 	 */
> 	if (nvme_should_reset(dev, csts)) {
> 		nvme_warn_reset(dev, csts);
> 		nvme_dev_disable(dev, false);
> 		nvme_reset_ctrl(&dev->ctrl);
> 		return BLK_EH_DONE;
> 	}
> 
> Is my understanding correct that the above code is involved in the
> reported deadlock? If so, has it been considered to run the code inside
> the if-statement asynchronously (queue_work()) instead of calling it
> synchronously? Would this be sufficient to fix the deadlock?
> 

Yes, the above code is involved in the deadlock. I do not see how
running this code in another thread will solve the problem. It will
still cause a deadlock between blk_mq_quiesce_tagset() and 
blk_mq_del_queue_tag_set(). The later is holding the mutex and while
waiting for the queue to be frozen. The former wants the mutex in order
to make progress and cancel inflight requests to let the queue to be
frozen. I do not see how this will make a difference.

> Thanks,
> 
> Bart.

