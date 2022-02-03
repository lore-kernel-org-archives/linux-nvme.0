Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCB9C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 13:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jEmZTW5pCklTtp7/YD7w5gzPh3sxfUyWJY6h++iXFGk=; b=AINveDFNqxfnRiaJDydfMjZ+QA
	lg8MjFcI0xecSnsZrLai8mfSBJ6NX4E5DdLQB15q6iPEtE/rsvT569tVWjcUz8aokZMxPOsfe1PIT
	/MUSnrXSmzAuwWAPq6rPFB9csPjPvigvkd5qFARyb60hmL/9T4+E3W5ZKsbUS4FC8iH3NAAIfrWS8
	+k73K1NuPcUTy4qulpnF455K87C/lN/QS1/jXIjfa6is+YGw3sjE7tDFS+8myAD59z8CTj6rKI6kU
	SjflBcBgVlgz2pnpcoBM3T/fy/W+4lZUxFtv8/8GX0bWyuSAuG74idymlktvPmQpvc/otE0bGERfp
	w1Lpbv6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFcIU-001Rxu-4f; Thu, 03 Feb 2022 13:37:14 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFcIR-001RxD-Uj
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 13:37:13 +0000
Received: by mail-wr1-f50.google.com with SMTP id w11so5122802wra.4
 for <linux-nvme@lists.infradead.org>; Thu, 03 Feb 2022 05:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jEmZTW5pCklTtp7/YD7w5gzPh3sxfUyWJY6h++iXFGk=;
 b=TKz8AE2AOJg1CsbSBrEPHokcCjOK26sr5mMnqiwx7d5XW6aHjKwoCgCY27Gmlpamtx
 YJESugfNBO7+J5j97DJwmeLtGG6FaBhW/vDkmWUL78Yb87yLFxu9qV1dUUgSjMgIhRmL
 sUvrC1lYLjjR0PFOyh4WpkLp/8gKR+ydsopIp3LtJBNasqzuCdnWRjO3w8bJN2qftyW2
 ZJPz5CW4ra75xCcpxjR6A7z9HgXWKHCGtv3o7lCHN/ngJcwxbV5bgrufMocC6Kph3efZ
 4IVJA3nWGBF9a9z3kf34W28adboiIHo+lQjnXYoQGy8Gpms+qAn4V3R+PEWMKpTLjkcm
 0l7g==
X-Gm-Message-State: AOAM533lKoRKbzTeSSwZW9vAixXg6ir0Bu6VxUxTXD3pVuBlKF9q1Ck7
 Mow+oZFn16pj2jSL3IlwKqI=
X-Google-Smtp-Source: ABdhPJwiyY1tgA/HG3h6hvvTt1CKhI3zW9ZLz37TKijIlJlQfZ7W2lP//JAl0xU0CmHdcAlUBnas3g==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr28869381wrs.363.1643895429624; 
 Thu, 03 Feb 2022 05:37:09 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id bi18sm6592855wmb.20.2022.02.03.05.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Feb 2022 05:37:09 -0800 (PST)
Message-ID: <37bcb94d-bc95-6ccb-abf9-32e15bcb2a1e@grimberg.me>
Date: Thu, 3 Feb 2022 15:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V7 1/1] nvme-core: Add verbose error logging
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Alan Adamson <alan.adamson@oracle.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20220203081153.162956-1-chaitanyak@nvidia.com>
 <20220203081153.162956-2-chaitanyak@nvidia.com>
 <87a89963-edd7-a0d9-02ba-723efe25f498@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <87a89963-edd7-a0d9-02ba-723efe25f498@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_053712_027617_6A838DCD 
X-CRM114-Status: UNSURE (   7.54  )
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


>> From: Chaitanya Kulkarni <kch@nvidia.com>
>>
> 
> I've no idea how above line got added, see [1] this is how header
> of original patch looks like.

You managed to confuse me...
You sent this v7 on behalf of Alan?

