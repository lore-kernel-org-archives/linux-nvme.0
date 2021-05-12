Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F0C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:00:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82993613C0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82993613C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vMkKKTIIjYhoec0bVxsDotXC8PtKpL1XqEBzMuQEIOw=; b=LwZlkBvHTWgvav4kVZbwNjClP
	Fi/qJvoISVgpsIdEsdWxi2J5Oi3B6gdad5e5ZZkkovuGdbVXSP9G9Xl2WTbbhprLg1SDzTetEqIao
	uWJS0UfyJjjup+lwoVvug3XJYumTrsPck0T+mdQSAIX47oEnKIKYO0fOcK41U8pG5qfB57QONexvP
	fhEkOHA5FRVmGAmrMy9CteBl7ACIwJDYS0FJ18YnB/qu0LRoJnReBJEtgra+3FP+VIM7bPA8Tr7GQ
	OSRU1U9VMpV9KGC7nkKO8ooUceYTfattVYWHfiXUFwSdSGCnuY4VWVuxRXZpLBut5Yver9l9ZA56n
	XLRPcAUYg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgvxW-003yWs-KZ; Wed, 12 May 2021 20:59:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgvxS-003yWd-J4
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 20:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=Go7H7PwMWkBae4rrluCRBAjjPsYYEb0+NNdtXUfQr0s=; b=YMi/pwl1Yg3yznqyToSIj0Tbq6
 kW7+wKZlTWaAeS9BZ68xBodp2wYfp8lBb7yNZZvEiozknUTLrAgDYNufwaZUn2F5RuIx97cYcKIlw
 IwIQLPWC7dSK4+MTL1MH41u7TYUdm6ZXkt7MZTrE+C1IR5A3YsrtDHtXqhovwmkVB2kMDq+bqSux6
 HHpBT7VnWWdQqFK5L1mUiNgY712BTJcI/DxOiYzdMiqWsacFbQEWy+rJ2yJ7FaXbx5SB+JuvknNiH
 tkzplg9BEGcAo2QYqCy5YniAay8MG0biIlTMreyYPyvaeNROhdtLxUWChtGpEwuUt8VLwS9O8MbsV
 Dj+Ar4jw==;
Received: from mail-ot1-f52.google.com ([209.85.210.52])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgvxQ-00Ap5X-7K
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 20:59:53 +0000
Received: by mail-ot1-f52.google.com with SMTP id
 d3-20020a9d29030000b029027e8019067fso21738115otb.13
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 13:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Go7H7PwMWkBae4rrluCRBAjjPsYYEb0+NNdtXUfQr0s=;
 b=s/IQOEJSj3CMpgyF/QhM4RhwyoUURzSQNo2KUDP9VXsdthvcuvItmCcQND/p2B6yNb
 WXuBDKQiJNUihQIsoywi31VRPYnQj34SXEmUk8ckb/Ln+Roe/XZWLDNn+on+ID/YHgfR
 HPVm2VrBel6mi4uQM2gT/hBjd6g0PfVZqnE5mJG0lgJsTxO9eAbTsp7IOOKhlGFlGdKw
 LHcrTwxRBejKT+MernxZzvflOxpz8jSioHDTwWV6c2gJsLUcvKQecTvDpgiLjXqHwUTQ
 rAfDl59aI8zzurJVqOkW1SQ/uQLJZ7Z6eMzQUkclLzBBKuBGWJDFcyCGtTjP5sjqEnhT
 FqUA==
X-Gm-Message-State: AOAM532c3mKeeyV+C8J7ZrbF/SLkEvWSHD/wsLIi/5RkR+FS6l73qE3H
 WsaNZszNlcfgYxXPuPbo9wUjVxuFhCg=
X-Google-Smtp-Source: ABdhPJwdgMe449USIr0N4Nta7Zk4lE57U8wQlyC8Xiflsdm4iW+ee9eDNncvOMiyal7GUqVTv/k+HA==
X-Received: by 2002:a9d:625a:: with SMTP id i26mr2062767otk.326.1620853191148; 
 Wed, 12 May 2021 13:59:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id e20sm237794oot.11.2021.05.12.13.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 13:59:50 -0700 (PDT)
Subject: Re: [PATCH 05/15] blk-mq: factor out a "classic" poll helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-6-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b35e93ec-d9b4-89bb-9358-b76044e91f5b@grimberg.me>
Date: Wed, 12 May 2021 13:59:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-6-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_135952_297100_D65FC634 
X-CRM114-Status: UNSURE (   8.62  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A bit convoluted diff, but looks ok,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
