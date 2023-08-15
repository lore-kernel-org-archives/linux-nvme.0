Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C12AC001B0
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Aug 2023 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nLeu7IXVB9GuSEApvEJZew8ULFnMzW+UHkUIvjcoK10=; b=PR2/5tNDHyDbirDoIjy4b0g/XK
	MZpLwU87i/+W7sgToVttcPszkRoo3PGCtfSeE07Xd9BYQS2JTLsXbcBqZ9y8Ucty+czXa/HCf787A
	905eacDVh7iS3vMiOwrKZ9+N3qQeF7ClyLhladPyZh0dd5vX3L0kszW8nNkyDY9J7NtJ/qTQKkhF2
	4WYMCfRiP/+BaXU5m9BK8+CvlO2SGcFDijCWA39zc1zB5YidtUxHb6AZ81Fz3ixouMz3nmdOe1/Py
	jK2e593QoFfi5jrWhqa2bt/26LUQHyDliSOL7KYzVmja2Uy4AK7qCFRBsxR4BSXD6xJH0sHHSpZ/M
	j1IyzJPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVuC3-001hEi-2e;
	Tue, 15 Aug 2023 13:34:43 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVuBy-001hE2-1K
	for linux-nvme@lists.infradead.org;
	Tue, 15 Aug 2023 13:34:39 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fe3194d21dso9326995e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 15 Aug 2023 06:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692106476; x=1692711276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLeu7IXVB9GuSEApvEJZew8ULFnMzW+UHkUIvjcoK10=;
        b=KIGJ+VNOyMWEEU3GvMbtgqjZ5VwoqHkRnQ3R7dyaHeCgu53BOj0xjekkapGyBrZo+F
         BjtZItmQhxbI5yeSei0a4IA6xK/cdeGsJuzJZgmNXVdjevEhoTibEwRABACJf+HJ8QXb
         PFBaninohHKYXZJE0Qehs/oabjdN13UL6I/xVgvttZeMjBDpo2o3tQE3jKVfK9mqAxFm
         namMZJaUtH/fsq9ORUjvqJEcFK+VEAbx9Y+99nv2wsMVFb5awcsu5PiiyaIql3UlTpcT
         eR0S4WadxRC5xDMMwPSWken7MhV/ePdqq++ULtPpoDd5IXnFGpPSUYcnD8G70uG37/1Y
         th0Q==
X-Gm-Message-State: AOJu0YxCc4KFlbXWUESIOpPTVNy41V4pZhWRh+Q/E7xZPtMCVHOFTlwn
	la3imqj/sKIRu2VXnY5wmwE=
X-Google-Smtp-Source: AGHT+IELEQqgddEUQOFSj2CbYrqz9r4riJqQkHL6Uy4ACdg6juPicR5XwbIdVqZNe6JNO0g0Yr+dCQ==
X-Received: by 2002:a05:600c:2258:b0:3f9:88d:9518 with SMTP id a24-20020a05600c225800b003f9088d9518mr11612100wmm.0.1692106475785;
        Tue, 15 Aug 2023 06:34:35 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d500d000000b00317ddccb0d1sm17878409wrt.24.2023.08.15.06.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 06:34:34 -0700 (PDT)
Message-ID: <6a0e9122-87f3-b0e9-0a54-dbcc4cd9d819@grimberg.me>
Date: Tue, 15 Aug 2023 16:34:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/17] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-16-hare@suse.de>
 <cf21000c-177e-c882-ac30-fe3190748bae@grimberg.me>
 <bebf00fb-be2d-d6da-bd7f-4e610095decc@suse.de>
 <a7e01b78-52ba-9576-6d71-6d1f81aecd44@grimberg.me>
 <fdb8caf7-78cc-c39b-3dda-2d9db4128a34@suse.de>
 <ce3453f8-807b-301c-f18a-3d7a7bc0bca7@grimberg.me>
 <1eca42a4-ee8e-dff3-adb0-0f4799e4f96f@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1eca42a4-ee8e-dff3-adb0-0f4799e4f96f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230815_063438_471484_30B6DD25 
X-CRM114-Status: GOOD (  10.27  )
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


>> How are you testing it btw?
> 
> As outlined in the patchset description.
> I've a target configuration running over the loopback interface.
> 
> Will expand to have two VMs talking to each other; however, that
> needs more fiddling with the PSK deployment.

Was referring to the timeout part. Would maybe make sense to
run a very short timeouts to see that is behaving...

