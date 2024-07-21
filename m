Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C667DC3DA61
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lFbOMQfCROyDm0OZKxMGsU+e4FtaLGih+eCKQ0ekhdI=; b=gZiINOE5kACiIMOqPNIktzCZN1
	ls3K2Gy+wi5cbql4gd4GjAkm6Zes2QXIqgoSmM6dlz/PweQ3MMdEUPD3c9r8I+bJ1T6ShjG3miBae
	5HJURAXAgWhvcu9431RXTfM/jW7jMVrJOU7dYFO1cK+mNOBhaquw+kOgs+PD2RAjy/plh8RybQEyp
	fGorKFiyMSceR/NAjDnjk53twVD6//kZIPiaUOdWZS597Xrivqu38ZXBBjxybAArh4ar6pNhwXRX5
	5/MGXiNfL9LrpWZxp9p7BP1K5knsM08knI3LKJRgrxefJYA/PE7dtFvWxrNlAlPNwtmVNLUsnKExn
	Iu78TFwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUTG-00000006hNG-1qhK;
	Sun, 21 Jul 2024 11:11:18 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUTD-00000006hME-18j9
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 11:11:16 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-426659ff58bso3576135e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jul 2024 04:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721560273; x=1722165073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFbOMQfCROyDm0OZKxMGsU+e4FtaLGih+eCKQ0ekhdI=;
        b=VPjOquJsyvTkTlhqpY0hRfq6iaGwv9OfNK40bvtX7+/jFINpJt/xCDTebvabh2D1sz
         R2auiKx/b/k5j3ATilkngCcjZ/Q4LX97cVONYlRH58BQhMfGGuDUd9nFnfKQS5hZHQdm
         6sbziMHhmycpYqxg6JESGMqNEnrSJE1TiP6XYab6JaN7UoBCN3ZT5AAvLaArEgQjzno/
         GfSn5eDeyNezql8O0AB3r1RIj5VVgL2PMPFZBkhUOYN9Rx7yfEafY86Ecfx52UjTUcUW
         ovev5yuONNKVvRZDrZDeOsByNYPmivJGDirXK4/9GAMAa4IU/80Tz4+Jng9fMxAbIM3w
         Ye7A==
X-Forwarded-Encrypted: i=1; AJvYcCUPeTaJv8GA1+2n3H6+StwgHtLxGv7bL5yBUgdTs0fFx3T1vHdnJ9XffSlcjHvSjMDb+qDWCjem1FsxbxWR+/IuxXJkDTESLPcyl1FkzYc=
X-Gm-Message-State: AOJu0Yz80a8xXmRJoNUZDNik67xUB72WFOYGSPzUU90zjnOP+WOGAnO3
	G0yGZX8tzIldw0IywaozXfwUlFgqRJDMs6ZZlZ8kGLLY631N6D2L
X-Google-Smtp-Source: AGHT+IG8QaWT06bMoJ9JYOAlu6LzbUR4LC6+JY3JJJrgdendir6MaVu9kJaphBP/+uH+afvG+uTCqA==
X-Received: by 2002:a05:600c:4f4b:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427daa927f5mr19813575e9.5.1721560273245;
        Sun, 21 Jul 2024 04:11:13 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d69073d5sm87151215e9.25.2024.07.21.04.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:11:12 -0700 (PDT)
Message-ID: <9f1236a1-530f-4cd1-8574-9e377ae9f85e@grimberg.me>
Date: Sun, 21 Jul 2024 14:11:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Ping Gan <jacky_gam_2001@163.com>
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, ping.gan@dell.com
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
 <20240719053116.GA21474@lst.de>
 <0f15a932-1a42-4c51-a267-3f765866edc4@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0f15a932-1a42-4c51-a267-3f765866edc4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_041115_337243_0679E17C 
X-CRM114-Status: GOOD (  14.70  )
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




On 19/07/2024 9:28, Hannes Reinecke wrote:
> On 7/19/24 07:31, Christoph Hellwig wrote:
>> On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>> TCP use bounded workqueue to handle IO, but when there is other high
>>> workload on the system(eg: kubernetes), the competition between the
>>> bounded kworker and other workload is very radical. To decrease the
>>> resource race of OS among them, this patchset will enable unbounded
>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>> get some performance improvement. And this patchset bases on previous
>>> discussion from below session.
>>
>> So why aren't we using unbound workqueues by default?  Who makea the
>> policy decision and how does anyone know which one to chose?
>>
> I'd be happy to switch to unbound workqueues per default.
> It actually might be a left over from the various workqueue changes;
> at one point 'unbound' meant that effectively only one CPU was used
> for the workqueue, and you had to remove the 'unbound' parameter to
> have the workqueue run on all CPUs. That has since changed, so I guess
> switching to unbound per default is the better option here.

A guess needs to be based with supporting data if we want to have this 
change.

