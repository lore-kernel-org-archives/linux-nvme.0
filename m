Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE0AC6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=++1bVXHus0v2bPaiJbFSkli9vKZrYftJzLm+Sb2cxQE=; b=yURwQ0XAeO35VIMjUsSsmCcMeW
	d6z8lkVHK0qmg6EWEFdQ/c/8flCT7jgV2y3kHfFUtggL83kAKmx6QnvunShffUWeRyRXOOe+2TyrG
	WfqoPW+phUCr8hxBRxBlKB1+oGrANX3HSlK8KjZVQtYARPfKMXZ/F8+VDWvBoGlfx9ZcViteRsWTG
	LoQ0b9znWJjIakjEEopac42AxTDKYuBwbvSv99drShdXE6yEAq8iQqhGq6waGlV3YLRP36X/6vjGC
	QKB1QFvyTra7uM3G3wsn1oVMgVaqGGQGj0E706Ct+kqtZ9odgLtOTzA8kNfEWRztms1jZKW2t+ZdR
	WLvuhR9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phuAB-004GGh-0m;
	Thu, 30 Mar 2023 15:26:07 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phuA9-004GDp-0k
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 15:26:06 +0000
Received: by mail-wm1-f50.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso12047990wmo.0
        for <linux-nvme@lists.infradead.org>; Thu, 30 Mar 2023 08:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189960; x=1682781960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++1bVXHus0v2bPaiJbFSkli9vKZrYftJzLm+Sb2cxQE=;
        b=goQgvqcPouPItSWsPmnY9D2I5QJ9qy6MPYoVHWaa13f09E+oeWzQWXG4bYnOJxSV+H
         uJ5ZVYYcVr0zWtqlpHMnpo+aJ1pZ4QsGXdADG5xUok4dq4a1XobZbkPW71ApGJNgOftj
         gkxwCwy6/wLEmhZESh2AwQC1xB96+QYaVJQSaDL1Ivfgj/ot6AyRATSPN3ArJO/xp6ce
         7dxMCVKg9gNZk5/onO5hHRoglb50HG5ea0SIJWTbWhOpgHKNru3bjovkcf9vJHh4mOql
         YzqureYFlDMj+B49GjeRaX35kj5/3rV1t0p1m+HQtTvy66FfgDJKDX0T8jQv2/FF/xi6
         BEhg==
X-Gm-Message-State: AAQBX9fLrx65wRcRFGU/u7r7ja3sffOSjThSZSlRD65VPmRDy0Ccf3Pq
	JJC4L5B4v56FHNeHxSNwv7o=
X-Google-Smtp-Source: AKy350a1HaNmrAeHu/TeS3LbkF0eUcRyNpsCPETB0iXsfKhAK/V12FmL75Lp178zMPXXhbVay1Ef+A==
X-Received: by 2002:a05:600c:3503:b0:3ef:7795:e5b1 with SMTP id h3-20020a05600c350300b003ef7795e5b1mr8919746wmq.4.1680189960284;
        Thu, 30 Mar 2023 08:26:00 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b003ef6bc71cccsm6865399wmq.27.2023.03.30.08.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 08:26:00 -0700 (PDT)
Message-ID: <a50f13a0-6e15-0cd1-cb5f-ac522eb32e6f@grimberg.me>
Date: Thu, 30 Mar 2023 18:25:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/18] nvme-tcp: control message handling for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-12-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-12-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_082605_264886_84E49AFE 
X-CRM114-Status: UNSURE (   6.42  )
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

This looks fine to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

