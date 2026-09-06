Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304F7C624DB
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 00:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O30WhPyUzw73S5OTaRA96wSYtAP42PdjH8NdsrQKkN0=; b=eX4LUdoiz8YrJu8z4UhnMKka2d
	ZiacbdDmxoY/PMSqNKPUIWs2PTt4BMDFAXOXNR5EFZQA/u5C7HCwMgv6Wevozs9MrU49gQAggKjWS
	F0yBAB2T6gukk//4wC6ZxUzUHpAfwO4Li3L57Di6o8sYpOPsXmIUe6nPym+gU6hmEFulrEN5v7AkW
	lqBDQKQiRc9bnqVh4PtXlkMrnl5StWdkVP9CU2T7G+tNUJ+cKDJR6XTgfTqoYH/OP3UlmuPP+sYwF
	OJvVjFF1wWmwl+QFgiaPfR3rkB9dyE8T2fSCOENEl2ydwUsF6PIvku2EZ7V1i19Fao//h3Uitez3D
	AX8IFHSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30cu-00000004Ve7-0i17;
	Sun, 06 Sep 2026 00:20:52 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30cr-00000004Vdm-3GoZ
	for linux-nvme@lists.infradead.org;
	Sun, 06 Sep 2026 00:20:51 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4956869750eso18024915e9.2
        for <linux-nvme@lists.infradead.org>; Sat, 05 Sep 2026 17:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788654047; x=1789258847;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O30WhPyUzw73S5OTaRA96wSYtAP42PdjH8NdsrQKkN0=;
        b=fRXLwM57gLArBk3FZRJHzydLLB8iIeVKth7arbnxVO2NUA+7TR+GKEowkNgFrG5QPw
         CWdASQHdFtalbABt2ySdmjA+n9fQK1tEIaIM+sS+ETkw9a9QZiGuBbR3dCtl2qu8QoES
         vXn4N9CjsvwXFecUI5iPiYd5sfJZPoylDt8sna6Ytw+WmmIANtYtpFH7txvCKajMgNJ6
         YwpzCrktkoivG4BqqTuR3cIqR5fI/juZlH1Qaig80x5Jq31LFr06Ymjgkhd4/5wE7hF6
         F1j6QXziseaJY4Hs/IoZqKZpBfdINu+UCaWJG63nG+qlxJdS8AA/lyVMGiFooKTkXXIj
         IwEA==
X-Gm-Message-State: AFuF++nPJBJy4j21I81c5SrJRoQMm0Ir3s6eW0p7IHCttsOj5XpeuZgo
	fHPWrjd+Asx2m4LzYofbZTharV2zwMPFH5avwPUwzho8GXQVn9asU/LS
X-Gm-Gg: AYBFou0pX6tOp0J7e5f/E7YuCXqgIn4LQuAxqFv3IB8ZhFrtllZNIJ/C9rpDBiZNW7j
	W0QEv08nnD0uUj8I/fb7HzX1vMJ04wz4rkaw0zcsShl9XA2TpX84FuY/rmtcO2rhHd3PvBsuegO
	qwZYq486H5LaNDwVzlDrYS8dd5HxOC+62AHp3MgeDJYxTugpF6NgkJ7k25z3kVZct0o1J36xNC+
	2vYD5Gn0bzo8Ubie+q90uqNO1ngsaMbKPer9qeyIoFuHMiGCxsIpaQwTBOlT/9tNcZsVe6nAVKx
	qvlK/f8tiQDjTMmfGrWdLN1WQf+hLv7EhwObnbaP1nYZ/YBVL1XdYnH6iLrCqqEQ475VDVCKns2
	z5M3tn0RlVXonCuQ2Es9d3O4+mpiPq9SW8sCPa4k+cbnxJajZrNY8HrvWiEaDE8JW8sGOIn8Qxz
	Zj0nS+j0TUiVY3nV+g8BfGSE7CBpgltigrrAytm05z/mc/02tKl0XKok0+GzldHRV16wiAQvqEu
	qtI2YySlIu08ReQbRA0KA==
X-Received: by 2002:a05:600c:3b0e:b0:49c:eb04:1c49 with SMTP id 5b1f17b1804b1-49cf8254d53mr138099415e9.13.1788654047502;
        Sat, 05 Sep 2026 17:20:47 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm128270805e9.14.2026.09.05.17.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 17:20:47 -0700 (PDT)
Message-ID: <da7537c5-116d-48dc-9d3d-893994d08109@grimberg.me>
Date: Sun, 6 Sep 2026 03:20:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] nvmet: Add support for configurable crdt (command
 retry delay) attributes
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-6-sagi@grimberg.me> <20260902134411.GA22112@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260902134411.GA22112@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_172050_354068_18590752 
X-CRM114-Status: GOOD (  12.92  )
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



On 02/09/2026 16:44, Christoph Hellwig wrote:
> On Sun, Aug 23, 2026 at 11:49:01AM +0300, Sagi Grimberg wrote:
>> Paired with host side error injection, allows us to exercise host retry delay
> Overly long line.
>
>> behavior.
> ... and overall an exremely sparse commit message.  І don't really
> think we should add code just for injecting errors into the host,
> and it seems like that is what this is doing?

Yes, this is what this patch is designed for. However, it could be 
useful to expose via
configfs if someone has a backing device that supports different crd 
levels and uses passthru?
My intention was to use it so we can add blktests, I'm not hard set on 
it...

