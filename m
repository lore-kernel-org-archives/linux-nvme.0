Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81E2C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:41:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BEB061132
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEB061132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tCqxdHkavLTtlYexM7/A0EVwxzeXq0IWvk1MZ5yg4fk=; b=k17A+kCQz3Kt/A+0u6yKurFg8
	86D4YB0f8aHvOA6mBuBuMhMmA8X93Wgs+HZMsSmhHBMeg+dm8pG7n44AvDgQsWttLOnwr81qfDgcy
	CcwlfzHkzuvRyMAyysZm2pnCUZOeO6fSoIPfPRZYsPxlO7C6BjsimWgQg3FF1Rc9hGSEhkGAtR4bB
	1rKUsB3bc4ohOBT9cbBDfdxyYYpKduTIYThB/eWeQ7jAy//ODycrMyirCTQhX82WdLQT1mqPh6qfo
	YvPenZw6JqA14hg8PcAs3VEWnWSB1Nl9X7jlmSruhiwWrbaPa4JFlAPNyFQVFnBuemLCwDvMA4HAZ
	zycDjLbqQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTyS-0081mH-Hm; Thu, 08 Apr 2021 12:41:28 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTyN-0081ll-U7
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:41:27 +0000
Received: by mail-pj1-x1031.google.com with SMTP id ha17so1067147pjb.2
 for <linux-nvme@lists.infradead.org>; Thu, 08 Apr 2021 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ROaakQh5DzE8ZfZBaX40jBVtzvkPG5QrTOZfnk87hmI=;
 b=bq15TIrWfzV+QhHlhMIVeghMSB1ZD5KIm//WreOQWHfU1foK5zDpUMuQtbMAVv5OIi
 xLdIwBevfDn3Cx6RnhMRhYUkfHiX+885lJd3okaunN5hxC1LUaNyRnRcGNRRmzVKxWNG
 j+cD9dJgTPg2MBt8OoetZXGJzOVgB6vG+LIkw7O/k1CJCmlXXvYAUPqg31F7OlbUUHY5
 840KsuwOxByAY9OwzKeRBlnEi8vwy87J4UAMhLPiEMINE73rjCqaiDp6RUwP4V6gkIJm
 AYrR3Hol7j8rsjGtQkHi8nMxQzONeh/slov5ExXqeSuWsh4JX2o92r5DxNjCjQoH1duX
 FMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ROaakQh5DzE8ZfZBaX40jBVtzvkPG5QrTOZfnk87hmI=;
 b=rWoi8m/c1qysk8Zeav1q7ats5VTwTz+hX9d7eWOeaO1pnEyEfnz0mGIeXKz8kc9GOw
 CbHORkSW4btj0uzVhXrnMbuKsS84878PecDgm6Su7o/E8tsnvHNeYV5OhuNB5vJuJUNg
 Muy8I7piErUdth8ZdKtOJ+zG/E5DD3N3Q4ryx0Y2/ji1UZ+zp1/b9XlrZZZA/rHvQQLE
 ku908y+LrkWO07kTs3bWOwfvNvYsIkjPNROqAYq7CWd0Y20NrB9cKeVTKStBBF22sSww
 fzZLbxIvGFPzFcbHxPN22aTuQ+6k4t85hsOUsjw1jNvuQsfIk5wZfMgNNMxUWJ50FSKq
 O6HQ==
X-Gm-Message-State: AOAM532dRfqZoPtKdQL0BrNvj8f5v30w3usRhvyO44RE//70X+LBh5hk
 /a5OLV7FyGe++sDg17w0WlSrWkOwM4jRMQ==
X-Google-Smtp-Source: ABdhPJzDzZBiuKFbf5joMHhOwOXf/W70g8I8L8Umcz7cDAeylIhyzKCX91gV4vRfmPKHgg+zJbS0wA==
X-Received: by 2002:a17:902:edd5:b029:e9:7477:5f0a with SMTP id
 q21-20020a170902edd5b02900e974775f0amr5617097plk.81.1617885682344; 
 Thu, 08 Apr 2021 05:41:22 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id a21sm24257906pfk.83.2021.04.08.05.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 05:41:22 -0700 (PDT)
Date: Thu, 8 Apr 2021 21:41:19 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210408124119.GA8865@localhost>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <20210406064841.103393-2-minwoo.im.dev@gmail.com>
 <20210407131527.GA15142@lst.de> <20210407141128.GB2805@localhost>
 <20210407142152.GA20466@lst.de> <20210407153536.GA8667@localhost>
 <20210407154730.GC8667@localhost> <20210407164818.GA31878@lst.de>
 <20210407170905.GB9994@localhost> <20210407171400.GA32592@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407171400.GA32592@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_134125_182412_55360306 
X-CRM114-Status: GOOD (  19.96  )
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

On 21-04-07 19:14:00, Christoph Hellwig wrote:
> On Thu, Apr 08, 2021 at 02:09:05AM +0900, Minwoo Im wrote:
> > On 21-04-07 18:48:18, Christoph Hellwig wrote:
> > > I've force pushed the branch with the updates, let me know if this
> > > looks good to you.
> > 
> > One more thing I'd like to discuss is that the current branch does not
> > create generic cdev in case that nvme_update_ns_info fails.  And this is
> > the one of the use cases of the generic devices, so do you think it
> > should approach as an another patch ?  Or, should we make it supported
> > in the current patch ?
> 
> It should create the ng devices when nvme_update_ns_info fais with
> -ENODEV, which should handle all the ZNS cases is was created.  Or did
> I mess that up?

Oh, I missed the patch [1] about the unsupported features (-ENODEV) from
the branch.

Thanks :)

[1] https://lore.kernel.org/linux-nvme/20210408120842.1450092-13-hch@lst.de/T/#u

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
