Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9963BC27C4F
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jun 2024 08:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E81u6EdEvG55UDl4LbxoEBMbepuHWzs/Ve/isPi70fs=; b=JJk0eEmmqLDoDJgdZkWLtvr64l
	KWr6tza4sJWVa6jIe38ZdwKkqcIzWM2f8VNDvNHo5A7T0ha/YDNXLt36w+l2o/m/avzwA8jW4XdIr
	AzBQuBPQvbEgIgWbEosU5U7CXNV3caCy2IbN9eCyC/J0qhkO7KDntI8TmpHm9nLYBbEK5DmdyE44S
	4KMbTBk79QqVvOXw6NLnDbkfufiLZezeT6k/bwx1xywpiRfOG0vwEPEL4keqKFyRmvklao/jgL3Qd
	Ys+K+MePk/jLrX+PU3xkjUEx/km8aIJQqimWOq3RHPGepTsdhCnRGeNuNFfj/JK1LMg1Gle0IlY3N
	28jmIvkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNqOv-000000006O4-1Muh;
	Sun, 30 Jun 2024 08:59:13 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNqOr-000000006MA-3Uhz
	for linux-nvme@lists.infradead.org;
	Sun, 30 Jun 2024 08:59:11 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42110872bf9so2454555e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Jun 2024 01:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719737938; x=1720342738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E81u6EdEvG55UDl4LbxoEBMbepuHWzs/Ve/isPi70fs=;
        b=j9wOD7fvN/dg6T+kf81cB8RzQy8CWCrbQjrKbfnRivL+NzcElyNgFlE1hbS2KeAdmq
         IPHBNebvDH5+CEFUeq362OtbmRgJtq/7LPTzP1T/GPQFdt0j/viFIdeX1DX3JHgif4cw
         Z8v75KJ52AUWBnXWPHSmU/NrmfccuiIFhglVwasP2fW7pFXXygdItHMmnIa7vnL40VFY
         1JhnX4MRHsqVJQg3/Xt8mgNDtC0cjTEKsXHJZscVK/6XMSD5RMdPGXryuruUjHDekjDH
         CMHEtYai0wEy51IUWdKrdRtEu6X+RmwCEBrkhvzCfnXwApONLP347AKfqHzSDSlkQmzg
         n0yw==
X-Forwarded-Encrypted: i=1; AJvYcCWjlTUc3hSFfDHceRV22IksPCzL+6x47IyrbzVVN1d9aCSkiDR/67c33k7NREzGWKLqhwjnwQCd+4N1lJ8w1TGbUuZ4h/Sgfijj1MllhZc=
X-Gm-Message-State: AOJu0YxS8En7o5mMsjxy0DUuHsEsd2HVzyfNndWzjeMzEvkOsBPmznui
	0DumzX2yJD9+yNNvb57DYZcXaGxhwJRcgDpBXmt1tnXWeDEwqnP/
X-Google-Smtp-Source: AGHT+IEGAsRDUvjWOLgC/54rILbb6FRNzUF/Ag71hPxBY+9UOWOGXWoSTFhJ7i9Ps8ADcRPTERUqhw==
X-Received: by 2002:a05:600c:3b05:b0:425:69cb:548b with SMTP id 5b1f17b1804b1-4257a15ac67mr19343605e9.4.1719737937727;
        Sun, 30 Jun 2024 01:58:57 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd56dsm6890447f8f.19.2024.06.30.01.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 01:58:56 -0700 (PDT)
Message-ID: <0779b376-38e3-42ef-b32a-a9cfab2749f2@grimberg.me>
Date: Sun, 30 Jun 2024 11:58:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
To: Ping Gan <jacky_gam_2001@163.com>, hch@lst.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <20240626082823.48326-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240626082823.48326-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240630_015909_909640_4AFDCE03 
X-CRM114-Status: GOOD (  10.82  )
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

Hey Ping Gan,


On 26/06/2024 11:28, Ping Gan wrote:
> When running nvmf on SMP platform, current nvme target's RDMA and
> TCP use kworker to handle IO. But if there is other high workload
> in the system(eg: on kubernetes), the competition between the
> kworker and other workload is very radical. And since the kworker
> is scheduled by OS randomly, it's difficult to control OS resource
> and also tune the performance. If target support to use delicated
> polling task to handle IO, it's useful to control OS resource and
> gain good performance. So it makes sense to add polling task in
> rdma-rdma and rdma-tcp modules.

This is NOT the way to go here.

Both rdma and tcp are driven from workqueue context, which are bound 
workqueues.

So there are two ways to go here:
1. Add generic port cpuset and use that to direct traffic to the 
appropriate set of cores
(i.e. select an appropriate comp_vector for rdma and add an appropriate 
steering rule
for tcp).
2. Add options to rdma/tcp to use UNBOUND workqueues, and allow users to 
control
these UNBOUND workqueues cpumask via sysfs.

(2) will not control interrupts to steer to other workloads cpus, but 
the handlers may
run on a set of dedicated cpus.

(1) is a better solution, but harder to implement.

You also should look into nvmet-fc as well (and nvmet-loop for that matter).

