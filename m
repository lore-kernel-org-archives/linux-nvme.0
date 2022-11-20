Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42C3C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Nov 2022 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JTmCM63v2z3j3SfZkNdzEI3nxwUQ/+vaKioTS5JqMhc=; b=tCsZKfIoPAMMdsV9ohl817P2Ut
	HFTl+Lc5q2Ec3gJU0DIDlnKhrWeVWTu+R/s5YAgUNx5bo9NoJoJUrmaOdRrpEuSMu8QPGYyN5p6Ld
	DxrUm+TocItMK/XPvzcSgpNmQ4u/X3kTdtUbrgjFZRMvQNlDTfwROw6b2ol9MaUXG7TQl4yFn4NXP
	FQvC4PaEqZ3q/+/Ro+qX/1CDC4oJtqRJAWSvvzG0UGWRJ+9beg+JhGCBzbVcxj5roP/wzasgQ9WmK
	DwxChNRE9RB4wtCRaCWQBJKJFLp3ui0nnizq21LMeQHZ0xhq6c/43BlJsentXng67L08v88goGVdu
	dX1APnzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owieg-003xCs-O0; Sun, 20 Nov 2022 11:38:34 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owied-003x4c-TR
	for linux-nvme@lists.infradead.org; Sun, 20 Nov 2022 11:38:33 +0000
Received: by mail-wm1-f50.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so8796697wmi.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Nov 2022 03:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTmCM63v2z3j3SfZkNdzEI3nxwUQ/+vaKioTS5JqMhc=;
        b=mTYvZPBhUZ2eS48JbG8ajyIXqlNXLT+3YEU8kipG/SgtrcLot/RJfqIkM07u3gDNRo
         Y4uAeLkT5E+JwgtUuxCXPeWEzhMBO0bhUHOR1eblQCMiNJyaK08d5igCXPN0KD+wuI0P
         hzkuGawkqHTQMd8vspgIiT6493+Xe+wWz68Hsgqx+Ly2BCLQSJQjOQ0kXrwWD7C8dXGb
         dznv6KOqXCBzAG4+n4l9PH84+iolbAcCQfTlbfwAr780OCFjcDmmTOaMYrWSBaaq1oe8
         O4yQfW6mQ7qvGL0l6LjwDfIChESeZwvktpt99Rv0iqO1YYxyyrsY3ekXR7HJta/j7COh
         MpbA==
X-Gm-Message-State: ANoB5pkXoyU9VEak9InzLcSp36jpljHXFc0HZGa0I2ArzMDAiyloeqTN
	kTZp92MzwO8bh4nnjchOJr4=
X-Google-Smtp-Source: AA0mqf5qvX3CQFAoE/8wizGUoMpDW+9Bgi4WkYfpQFUye4gJrZmAu/rVFRRmH/xfbxyZ26LfpszUCQ==
X-Received: by 2002:a05:600c:3d8c:b0:3cf:a18d:39b1 with SMTP id bi12-20020a05600c3d8c00b003cfa18d39b1mr12777929wmb.149.1668944309944;
        Sun, 20 Nov 2022 03:38:29 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c219500b003cf894dbc4fsm10327570wme.25.2022.11.20.03.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 03:38:29 -0800 (PST)
Message-ID: <2b6bae87-b008-6f8d-3c70-2334b5bd48b7@grimberg.me>
Date: Sun, 20 Nov 2022 13:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, lengchao@huawei.com, linux-nvme@lists.infradead.org,
 Gerd Bayer <gbayer@linux.ibm.com>
References: <20221116072711.1903536-1-hch@lst.de>
 <e5de54b2-4906-9902-c150-732718a77571@grimberg.me>
 <20221116132225.GA8071@lst.de>
 <1ee364d8-4aef-acf6-1cf9-38787ddac288@grimberg.me>
 <20221116132805.GA8496@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221116132805.GA8496@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_033831_979573_2C5A2E79 
X-CRM114-Status: UNSURE (   8.29  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> All the other drivers check that they have IO queues before
>> quiescing/unquiescing them.
> 
> The core firmware activation code does not.

Well, ideally it should, but maybe it would be more readable
if we condition on ctrl->queue_count > 1.

