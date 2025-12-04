Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF509D29FAE
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 18:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cf+kn5lOp/6h3Y1AiGLVlIFXGKeJySsFzdzukNmqPPI=; b=HNO5Bx76IR67uicwR/Yky9DgkV
	tgPNVfv3NfTt86BN3d90QBUoAVd1kPQp/1C32X/hdMrnIWHZcBjiI0P3ercxvhqCigKlFMrxFfED4
	u9IA7q2GxGa0oajzWr6xO0s57nedX3n9YhtOaJuGxxCYEnEUClDmHj5GOcESwcNnRPdbED5+IkF7t
	1o0s/WQkZt8VImtUOhnjicVfxBMFnk3dC1GciRZn0Gik0S9A80nolrGLxLXUrXxSdjAsP0XwSjpiz
	mv/x5GvZXK8oUGExdNhwrXbtU647RKHK9EdkNedZB5gENGi3ytdLarfj4bpEv2CmFjbEiYGCfTP/m
	XhTCZfSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vREI2-00000008STS-0Xs9;
	Thu, 04 Dec 2025 18:42:54 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vREHx-00000008SSw-2I4P
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 18:42:53 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so2049670a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 10:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764873767; x=1765478567; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cf+kn5lOp/6h3Y1AiGLVlIFXGKeJySsFzdzukNmqPPI=;
        b=dqRdkhmNEmLInCOqYQYXH2ZnfCWilGHsbi5kotKsVWq2y+vn0GCS+UEY9V/fVqpvkw
         6yj0sfO97gM7xIfeXIjvnIZRhficd9b1MnslMnFWQlCnOgYTAQjPINavY4msWPGgtDcH
         rv5nvd2Ts6Y9ePnu2t3jcakoJz5Sm3oj9HSMD8VBbm4fjDReWpo4Utdu5V3C30X7heoV
         FNN9DRVf3w565bd19W12uB6jrCqf0oF7F3r0cdIgNW+i6z5gdDuDPgiIy9WxYOjH3qRp
         ms1iwB3vkbx5vDvNzPQIxDDVqulWRKCJB5C4dTJMMrf/PBD3ca2nOYx+JAW/1bYoYe3T
         j+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873767; x=1765478567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cf+kn5lOp/6h3Y1AiGLVlIFXGKeJySsFzdzukNmqPPI=;
        b=YkdlEhXsIomAvgJul/o4bt+jGgIaUnXXPG7pexEv05C3TWVozBfkkpv5JqhmNFARqO
         b8py0+TZd948LL054Hx59/YkLmKvBZf3eRaPFpEi7KEKsjV5lUkwHnL+eaL7qhAtspv6
         j8LTnJGyGQb3Nc3kP7DBT9nRFOBdS5rwoFd3GUrZLgJD7q6b3X0ESzqkPZEHEQRzxnyN
         c1IJZouWAQcGA2WIAJ0egReMjx+w2xuKPQoeX1juP+VGLyV38Hsw2K8KyU0+ik3ScHzL
         c7td95Ei5ZGS2267LM2rI8L+Lm4K27sde2JzR8cx8iRMtOGlh5uxEAR757IvvYpUAyKb
         f6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHA6d2Ke8oaF5KnwWIGtCnov/4hTH4DwsluXwJIxriscr9Nij0S69XaMWSgJKyY5pIU90JYSVZ67p+@lists.infradead.org
X-Gm-Message-State: AOJu0YyzcLASbeRbRAOBKoEkYbzyCQdnqMZHwu4Enr0nPlIlFHrbqVcJ
	MLA2Ec4YsaRG3Mu7oEBZnEWaYQvRdo6v66oWsdTiGMcUK5Ad8Do7qO8eyBZqknQhKsY=
X-Gm-Gg: ASbGncujEBrAmBdSW92XhK1Jk/oI6z05mYUUSgYLVZwv5MEoThwiOeR4J5KVA6gCzRk
	dI8OPC0C28sTdsYmOXBY1pcUByr1PKsCjMo+rSj2tqVsRmhTR2DRFHOSHrHtKgx94DPbSi/3yPj
	vwG9mnLTPBmlEM/7nAK4aXpi98yXWqp/hC2WG3FpfPCpnt0W510Y2zg63XsWpY5FPiVdskS87Ds
	LlxENJ/fDizCCKMcTka5wBvJy4gVD/D5aLXyksgFVM6ctFeh3Ghu8QztJSwM/sjnmJu3+yEiqB6
	mPz5Oo1rZKwYX/tqDedD8CYlfEp5Ps2xCfcLfoTh47NGmUnAwqRLlNeHRWRuB35gx85mgZhxzfM
	3R2dvW2UC2nCVFteKQIYkboaBxrnz2g0rVdF3TD+E0NIbkcoB0UyZ9J8IP55JaBCsaGfEpI2gxI
	I6C7BgPlFCcVcfp2eCxUmPjTD53Hoq3H0=
X-Google-Smtp-Source: AGHT+IGiTSXfiAWCdvi1/VdObVRjj6OaYx7p5aqm+cw1Klk7prZUSljRTg9EQdF+dHv1zTm36XZmlA==
X-Received: by 2002:a17:907:7252:b0:b72:b433:1bb2 with SMTP id a640c23a62f3a-b79ec406510mr444593266b.7.1764873767283;
        Thu, 04 Dec 2025 10:42:47 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a640c23a62f3a-b79f4a558b3sm196108166b.69.2025.12.04.10.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:42:46 -0800 (PST)
Date: Thu, 4 Dec 2025 10:42:43 -0800
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
Message-ID: <20251204184243.GZ337106-mkhalfella@purestorage.com>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_104249_651645_C1C825DA 
X-CRM114-Status: GOOD (  13.29  )
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

On Thu 2025-12-04 08:22:23 -1000, Bart Van Assche wrote:
> On 12/4/25 8:11 AM, Mohamed Khalfella wrote:
> > @@ -4302,6 +4302,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
> >   		blk_mq_update_tag_set_shared(set, false);
> >   	}
> >   	mutex_unlock(&set->tag_list_lock);
> > +
> > +	synchronize_rcu();
> >   	INIT_LIST_HEAD(&q->tag_set_list);
> >   }
> Yikes. This change slows down all blk_mq_del_queue_tag_set() callers.

synchronize_rcu() is necessary before re-initializing q->tag_set_list
because of list_for_each_entry_rcu() in blk_mq_[un]quiesce_tagset().

Is blk_mq_del_queue_tag_set() performance sensitive such that it can not
take synchronize_rcu()? It is not in IO codepath, right?

> Please fix the reported deadlock by modifying the NVMe code instead of
> slowing down the block layer.

I can not think of an easy way to do that. Suggestions are welcomed.

> 
> Thanks,
> 
> Bart.

