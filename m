Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75D2C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:24:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F3C208B8
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nhkiR1q1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F3C208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XmRHD1HgXTdOTfefdQ9EgPB9zwUZT5pL55oF+rJA9XI=; b=nhkiR1q1OuN7oWtcRYFNzH42Z
	KktjyxwzGFDEnp1IkOjAGHQJHK3eRdJnxtmgc0XM/rj4jMfB4GvD6+2++E8jcYgetesyhE5QMAYzU
	8zIJ8MUi+DJcbjMdY5dT1DYKB01xOaPVqjhOFrk+fy4dDB069G4NkuE4iGvOpvnmqOg+YjQVXQtvw
	DuWzGWUf/7DJs9kguSgACxLdo9m9w3G0wYX5zIIYEJAhs8u5xAtdDALbaQ7rbyhPg0/UiIObFOboP
	4plWl+ZqLhrxsvx0lVuzG4E3FyDlN+aaL0MN/zEE8thsc2tsVhxx35Wa7Efff9tzhzK2YqhL8nLsV
	DkQe/W2ug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKJ4-00033l-Ty; Tue, 29 Sep 2020 18:24:54 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKJ2-00033G-Rf
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:24:53 +0000
Received: by mail-pg1-f195.google.com with SMTP id t14so4522735pgl.10
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 11:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cv+VtdAufAAEWbfdy6MfzzVxHEHSITCss8O60CesZRI=;
 b=cI8LYomxpfEtTTdJ2bvy3v3EJwzDHmNeQCBNByVzhQTQQhqCsruLkNDS9OJKndtlUQ
 ySXMYMZQHHQDJqJVMxOmU2yrCVrRxl9dk1LLQFdCzZyTLbqj0DHBGQyAgCmBCNo7Op6Z
 o2MW/wEe4YFfDs3BlPKjqPmkiGP426oxdy0ygHqktny7O6X+Y65CYm5bYI5wOyYelmnp
 mv8svnttOViM1dQM0eaGNdYK3RhWZX7bJUXTly+iZ1q77FEw3pXKS7Uw/35zPL0YkNvW
 x3Ui6xO1TNlo/kUr5sStjc+iC1w9g44dBOSNsIxSfsKAXXyGD8U1S+RYED3iO1kISv+u
 nqAg==
X-Gm-Message-State: AOAM532+jOZh7bFsrOb60ukIXfbdCYGrIcQ2BtbFy4QOeE80J4zNb9zQ
 DJ9YatGrlxmn3/Sv4S7P2YU=
X-Google-Smtp-Source: ABdhPJwR+inYO61Gp1C9kisMtoi7s9azwzq1iyNQo/GL2lBe5OlQ8O+681Hel3isFB/Jj9f1DrfKRQ==
X-Received: by 2002:a17:902:9041:b029:d0:cc02:8540 with SMTP id
 w1-20020a1709029041b02900d0cc028540mr5533911plz.41.1601403891897; 
 Tue, 29 Sep 2020 11:24:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id m5sm5229070pjn.19.2020.09.29.11.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 11:24:51 -0700 (PDT)
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200929091358.421086-1-leon@kernel.org>
 <20200929091358.421086-2-leon@kernel.org> <20200929102046.GA14445@lst.de>
 <20200929103549.GE3094@unreal>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <879916e4-b572-16b9-7b92-94dba7e918a3@grimberg.me>
Date: Tue, 29 Sep 2020 11:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929103549.GE3094@unreal>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_142452_938069_881EC6EF 
X-CRM114-Status: GOOD (  15.23  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> The RDMA vector affinity code is not backed up by any driver and always
>>> returns NULL to every ib_get_vector_affinity() call.
>>>
>>> This means that blk_mq_rdma_map_queues() always takes fallback path.
>>>
>>> Fixes: 9afc97c29b03 ("mlx5: remove support for ib_get_vector_affinity")
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>
>> So you guys totally broken the nvme queue assignment without even
>> telling anyone?  Great job!
> 
> Who is "you guys" and it wasn't silent either? I'm sure that Sagi knows the craft.
> https://lore.kernel.org/linux-rdma/20181224221606.GA25780@ziepe.ca/
> 
> commit 759ace7832802eaefbca821b2b43a44ab896b449
> Author: Sagi Grimberg <sagi@grimberg.me>
> Date:   Thu Nov 1 13:08:07 2018 -0700
> 
>      i40iw: remove support for ib_get_vector_affinity
> 
> ....
> 
> commit 9afc97c29b032af9a4112c2f4a02d5313b4dc71f
> Author: Sagi Grimberg <sagi@grimberg.me>
> Date:   Thu Nov 1 09:13:12 2018 -0700
> 
>      mlx5: remove support for ib_get_vector_affinity
> 
> Thanks

Yes, basically usage of managed affinity caused people to report
regressions not being able to change irq affinity from procfs.

Back then I started a discussion with Thomas to make managed
affinity to still allow userspace to modify this, but this
was dropped at some point. So currently rdma cannot do
automatic irq affinitization out of the box.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
