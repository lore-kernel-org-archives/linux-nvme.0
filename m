Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676BFC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 17:52:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0D02084E
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 17:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oIK4jUqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0D02084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M38NGA/sJ1bWwIcJUGDOACVbM9IzJRiZv1Gzu2Eit1A=; b=oIK4jUqs9IcC+GA1zQFSs/A4v
	6pUd9N+DBJUWkdSQFwuTB1JtKrsWPGK72VQIAVNIukuAtPl+Zt9hG/Al3NdKDNTAltgjd87Jrym5x
	x0uqApjV/XfQWYyhZZwGSf3yafy+uJI7c2nra4y7VUKGOgRGClNRZlnmJfflCkLHzF3aeK1cbI1cJ
	hmZR5CX3NYiarGqQA2ynnu9+kRq3Ji5pewYyq9SIiff1DPIO2pDRo2XDOzl3x6L/20Qz7QsTLbzC3
	8S/Qva9caWnIDxm4VJxTkrbVc71DY8ba1vjWYuedJ7GXkeKkA18I/QuUVmvckog0xlJVyZkAyDuQc
	vsh7gecaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUaLH-0007bd-QR; Tue, 12 Nov 2019 17:52:39 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUaLF-0007b9-Ap
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 17:52:38 +0000
Received: by mail-oi1-f194.google.com with SMTP id i185so15606182oif.9
 for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2019 09:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v+IGMNkPWzNGZY0e2PyOy9LPi+yLSN6rEKbm674EmsQ=;
 b=mjVJ5seQXz+yWCH/EEMwN9+ESYRDUl4oj7eORFp1URQqqORTPjyVym9vpIF7Qa/gt4
 p/Lgp73muijmdfIXUQf3nMEK8A51IRrSs9Mgo1cCQIdAOwsLhIZ4Em8GTEy9l9FcLh4U
 sHmJVR0zd95fv8ez0mDU0Kr79+5sgMMEKjr7raEU4+2/EqVETw88Px+LUvRTJ0eYOmoQ
 V1gebvxjby2XiCP9+8Vp/o49NHbUVDxDjsFCVQjUIRfudvOKm1rJXCNeCwegTZ/c0BRu
 +L0EsGCuHRhgWPncZn79flXCoGR2Nsuu0EzFcM59p4mpKRYQPgnY0Hv3/3j+hEAKSHvM
 ZZhQ==
X-Gm-Message-State: APjAAAVuHaj8VzxdKEORIn0uM6aSWcqWDReOCWBxP9rePiHLtcYu0nHP
 lC0mnbaRsoF06dvoEVaqyec=
X-Google-Smtp-Source: APXvYqy51fWaRYWNkQUiTYJTX7v6biV8Ukrq2f0uVG12V++I01gXOJVKWkv5VPfrCRiK+iGs/XaI/g==
X-Received: by 2002:aca:ed85:: with SMTP id l127mr133547oih.75.1573581156706; 
 Tue, 12 Nov 2019 09:52:36 -0800 (PST)
Received: from [192.168.1.114]
 (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
 by smtp.gmail.com with ESMTPSA id v11sm6172592ota.13.2019.11.12.09.52.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2019 09:52:36 -0800 (PST)
Subject: Re: [PATCH 02/15] nvme: Fail __nvme_revalidate_disk in case of a spec
 violation
To: Christoph Hellwig <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-4-maxg@mellanox.com> <20191105174904.GA18972@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b1675bf8-b4f2-e82c-583b-d9d31d808901@grimberg.me>
Date: Tue, 12 Nov 2019 09:52:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105174904.GA18972@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_095237_405899_ADA92936 
X-CRM114-Status: GOOD (  10.91  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +	if (ns->ms && (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)) {
>> +		if ((ns->ctrl->opts && ns->ctrl->opts->pi_enable) || !ns->ext)
>> +			nvme_init_integrity(disk, ns->ms, ns->pi_type);
>> +	}
> 
> Can we just have a flag that says we have working metadata support instead
> of having to duplicate the checks all over?

Agree with the comment.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
