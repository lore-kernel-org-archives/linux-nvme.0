Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F43C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 12:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DZg9xbU9yxm1xo3qkZ8efM5ifvw3Vhad1pHzBVlG+v4=; b=XjXk+KoaLss8RzuIQBI3Izmmyx
	/j2yrmu47F7e6HnYTlvfoyJtnz/W/gpu3aHrGk5ab7tTWIIpR8eSoskKUj77XbKIqcIBQQEQaqtNt
	jsN4noRH6ZmXcSblR7exvM1ZbpSZoIiakFCj5LD6XSUXgz3pYTMJ//DcN6nzmH79hZjlYe1LRpHMZ
	0wjt+e0gl6Z9/b8Ew39aeccbw4WSxYPWIXeKPY21LMRnUKzBwu2Cx9WH5CihpugNQnocJg1+HKtx9
	o5Xd9pAPvFpXSPJmQL/4J0Aj0dO142dEfPGiYkglW92AhOBomquf8g886ztB6E7jikHr6+F56yyB0
	0eOJn+dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuZSI-0003uj-8g; Fri, 27 May 2022 12:52:38 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuZSE-0003t6-QE
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 12:52:36 +0000
Received: by mail-qt1-x830.google.com with SMTP id h9so5291522qtx.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 May 2022 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DZg9xbU9yxm1xo3qkZ8efM5ifvw3Vhad1pHzBVlG+v4=;
        b=c8rxJq9OvPEKNxx0OsdTOP5PeIHfaLQkyOrsfMAukNcx3KdZBfPHq4EHCd3GzT7EkG
         rfDaKsshKLY4QF8JNCF6rIHWwDn0keL+VmJ6HQeSnw6AUBOvRIetbCSF+G1EM2xMQLQ5
         GoERoG81+Qb9c4okmPjnZIsYQQb7ULxkg/2myXfNNp8dkb19UZc4gUfYy9urR88FDNBT
         CjrK29poJXql55I3ofCKqznBn9m752tBucxlkIkers0jEoS1gCC7sUXsMfE/nnMHfY+V
         0cnGGKfVSN+z5yYAE8p3CO+3bD5XjsJKsrdEh9EoNZr+Fp7OA+hbozFXjD4RJ1tToij/
         8TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DZg9xbU9yxm1xo3qkZ8efM5ifvw3Vhad1pHzBVlG+v4=;
        b=fIyX6KKnSUkN0+YKGGkeF4Yn9qFwo9XEsSoGrZbJN8RAKLm+AieO8qSCGD/v58RvAX
         aShcOIwLeasAhFy2YWPn2uNoSkpHJ4qwfK96nBXH6O17klf/uKHnjDr207QO6shmidlv
         OR5OfTm8hQXxToBzs61+uzXY9BvA7Q1X4ghTNZavwQADMK9EV9AThHMcWWqerWDZrRqC
         V6zhTKJ4G+FZa1wRzz4IZSQLRg1t6oHCtznjFK9aY8tmFaMgNqI+qT3zKOGcJhC0Mv6b
         auMv40gswvEiHS+6JZd117Egu+/ibxTBh0gf2oQg1rSqbsPRT0O4fzKali+jGWNLHdqz
         9zrA==
X-Gm-Message-State: AOAM5322S7vweB4uQcVAGaJmd2rh8+18G6n05yYphriBt/ofFZVfKRZO
	7Yh2rr0fIJkrLAHyn0Tn2Xe6OQ==
X-Google-Smtp-Source: ABdhPJy9KUyIkr0thNdUR4pH5z2yU7qc34AvvkaLcG+UoNOzPuO+lRTxBz4xqGYInakIxnK5+bG0GQ==
X-Received: by 2002:a05:622a:1455:b0:2f9:3278:e95c with SMTP id v21-20020a05622a145500b002f93278e95cmr21944422qtx.297.1653655951920;
        Fri, 27 May 2022 05:52:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h18-20020ac846d2000000b002fbf0114477sm2473601qto.3.2022.05.27.05.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:52:31 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1nuZS9-00DTV9-86; Fri, 27 May 2022 09:52:29 -0300
Date: Fri, 27 May 2022 09:52:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Message-ID: <20220527125229.GC2960187@ziepe.ca>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_055234_887133_B13A1D4B 
X-CRM114-Status: GOOD (  15.78  )
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

On Wed, May 25, 2022 at 08:50:52PM +0200, Bart Van Assche wrote:
> On 5/25/22 13:01, Sagi Grimberg wrote:
> > iirc this was reported before, based on my analysis lockdep is giving
> > a false alarm here. The reason is that the id_priv->handler_mutex cannot
> > be the same for both cm_id that is handling the connect and the cm_id
> > that is handling the rdma_destroy_id because rdma_destroy_id call
> > is always called on a already disconnected cm_id, so this deadlock
> > lockdep is complaining about cannot happen.
> > 
> > I'm not sure how to settle this.
> 
> If the above is correct, using lockdep_register_key() for
> id_priv->handler_mutex instead of a static key should make the lockdep false
> positive disappear.

That only works if you can detect actual different lock classes during
lock creation. It doesn't seem applicable in this case.

Jason

