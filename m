Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F76C2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TV37ILeA7/lofEWj0cmWADZWIpnQtJlHI4fkmPb1Z9k=; b=RBZndrmfjB5J0uJQWdq0FwBKOf
	HR4l80zZYQo3q5HJd3j/EYI0sA5m7XcDTI2E59QEygAwkd27k/+AtngjjToeBEn4a9AW9byPPatA2
	HcqIMlNH+MijwUM2OWAwxg4nHVd6b3v3N/yTXnbi8GTdu7BMtwm2/P7V4LDJRfcFdWC8aEKxMPq+2
	RxChuW0QXUMFroMchl+jGzPTO9R+afkY1MtqdtsXEOCVDE/UmrTrt9rekRukXgcWWlQxcaWSuA8t6
	r0+cPphotLf9LAwJzMOpMKOUhb9DGxHDyYfxkktRlZOCXPQ8xQjJXrLb3FBUL02Xawxmu6DEz3I9v
	72s2F/RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r59Z4-00Ef6h-1D;
	Mon, 20 Nov 2023 19:04:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r59Z3-00Ef6D-2g
	for linux-nvme@bombadil.infradead.org;
	Mon, 20 Nov 2023 19:04:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TV37ILeA7/lofEWj0cmWADZWIpnQtJlHI4fkmPb1Z9k=; b=KPgw5que2QUziQdbQi4uj1qI7F
	NNpVUqZvKv33AYfght8yumD9+rcS0Hof2cLzWeLLOS2edn0drVz1yWzW9DHJ/Z9ihwR8qnBVdMOE8
	7gNQ7NyAbMFuVYLKvGQCepE8kKXUwC9u0yv07PeGoOsDk+LDMdPNNMz+gENwhgn1Zbq3HNekYo3gs
	WjDBhi73dp32ePmMIWhE/hi+7Dx5ATn0nCMrSf/NHF8E/UlJPBi7gr+3xWtadFHYkU9KxMy2oZpoR
	MPCrTjGYCLVi1121NkswFMZrp+3NNySs9hZT8JA6JJZz1zGz3cwd1hDauf6whC9F6tCn2/OSW4qsv
	FqRRYExw==;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r59Yx-00B51M-0p
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 19:04:05 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40837396b1eso2834015e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 11:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507040; x=1701111840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TV37ILeA7/lofEWj0cmWADZWIpnQtJlHI4fkmPb1Z9k=;
        b=hMU/oPVBbdbkfR6bDYvPCAeIuj0bNEYG7ffVjCDiv9feiDFMUDnlQvzPxjS6caee8h
         9/o0at9i4CuIl4HxfO+bkT06cJg2aoB3JYihV0XXFo5YiSRhYMjrsHw93ZGVoKYluCP6
         2JCs0nnf5mN7Xdbsz4CwABQ6p5joprtfWjwVRWsCUEs9HV3j1T/wZQUWR6Hu9rZ7SlRO
         TgJtqZ6xpjOqIhGlnSdmHax35ciygO53Ld5vGugZ1dE+FBanN23f1C+nQnjy0a5GYDGO
         IxwnCNXn8vhlWF8NLygaR7/Q+kQx5uOJtDVRLgvwlsY5nznYfDA4r92zrs0g67so51wi
         RsZw==
X-Gm-Message-State: AOJu0Yy6NSaXvBtIWwgrkqIQigUjlU+W81MdG5gQEZhf2Rge3AfQL1of
	M45PRRZQ4qgwliqvV+m0H4A=
X-Google-Smtp-Source: AGHT+IELEEpIjTOFm/ENI5FBVDZaM12CeTscXh1bFBNaGumTHkw6lOCVNS7UOLHcRlSwJxhWo1WMOw==
X-Received: by 2002:a05:600c:4512:b0:405:4280:341d with SMTP id t18-20020a05600c451200b004054280341dmr6932768wmo.4.1700507039916;
        Mon, 20 Nov 2023 11:03:59 -0800 (PST)
Received: from [10.100.102.14] (46-117-95-192.bb.netvision.net.il. [46.117.95.192])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b003fe23b10fdfsm19213298wms.36.2023.11.20.11.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 11:03:59 -0800 (PST)
Message-ID: <ebd89ea4-6d94-419f-b632-6ebb8be5c7ac@grimberg.me>
Date: Mon, 20 Nov 2023 21:03:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231024061337.35621-1-hare@suse.de>
 <20231024061337.35621-4-hare@suse.de>
 <a1ce2c2e-4f67-4271-ac67-5a1e8c5ebfb1@grimberg.me>
 <3b2164c7-961e-4cfb-bff9-517e7b77fd61@suse.de>
 <828693f2-1aa5-416a-9d9c-e1a1e9edcf2c@grimberg.me>
 <c12357a6-bb33-42ab-9e8c-c7dced7a10f1@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c12357a6-bb33-42ab-9e8c-c7dced7a10f1@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_190403_432634_77958E01 
X-CRM114-Status: GOOD (  13.69  )
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


> Yeah, indeed.
> 
>> If you are not able to connect even a single queue, I'd say something
>> is wrong and it could be argued that you _want_ to fail.
> 
> This is in conjunction with authentication, where some controller 
> implementations use external entities to calculate and/or validate the 
> DH parameters. Which takes time.
> 
> Scenario is that the admin queue connects fine, but the I/O queues take
> some time to setup, until eventually KATO fires before all queues are
> established.
> As you said, TBKAS should avoid this scenario, but non-TBKAS is still
> a valid setup.

Well, I'm not opposed to starting the keep alive sooner, but we don't
need to change its stop location.

