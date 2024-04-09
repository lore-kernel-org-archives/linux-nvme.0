Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACACACD128A
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 20:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEA7dHQgHE1uFqZ9aLUCdxhVQ2BEQSowcQOkzZwh8KQ=; b=udPqoPdFSOIjwEI+0cVBLgVxjO
	nRkD5xdo6nYlCsXuzefhD/ENJMe7ZD064sV7RsFfdNsA9QF7YLCT8jN11m6lRYEDQ+UrVe6Xhx433
	5gQ1heohC7w3wmUUDKwQo/ZXdrLmN58czLNREzZhVuKk8yUtkBDfZijA5+bCnp1B2BwsymZ5ptdPD
	6iQfZl3z4BZfneGToTKaPoL7FBz1biTzvzSs0joKvcedmYQGFFz0BWyBBkWa+rwRthZIBSVOLuIZY
	CxkeOkZZfGcGstiITE4/Cl89D/EKFvh1JGll2skCnlRKDXhkHas6RphuULPGTTfdc3R/kvvQh/D/Z
	5R7DuAww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruHye-00000003h91-14Fa;
	Tue, 09 Apr 2024 20:21:56 +0000
Received: from mail-lj1-f175.google.com ([209.85.208.175])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruHyb-00000003h7Q-0UqW
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 20:21:55 +0000
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d874b89081so5702501fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 Apr 2024 13:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694110; x=1713298910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEA7dHQgHE1uFqZ9aLUCdxhVQ2BEQSowcQOkzZwh8KQ=;
        b=Z4S9EG92PXmj8ZJdhOmWW83rjpK7NVb66lDTdyt3vn877exOD3Sg0CVCnxT4kWqnKp
         1hDlCvNEFgv6p4jfjbWNbfCd7Y7S1AB0Rt/Jo3H1zPjzMjBrqFJJ5hz+Ome0aSZh661l
         OT6dgaqOnyCHD0Vf3r80hVDJ0PXKswAQJdQx73sNdoV1gc/YjvMKUtWX3idEOtx3KKFd
         rYIPK/Kt1fQw4nCfTHTujAznbp2Vj3ACzJjjkRb/6/sTd3LTyeZGEXqSuKe8nSfrLZKG
         sN4aPE6qxF43xmHD4hQytaKPMyLwu+DepFb4kXg14dQIy6rKh+CfQKH0CkU4HJbqRONw
         Wpmw==
X-Forwarded-Encrypted: i=1; AJvYcCVztk6/colrIbPaiDkZirTg56tZDEEQPiua9ONW7tyd+PoKmY38wSTOO4lzUWnId+FPfHjhEyzzFwZMVFMAQur2CgNkyVBXFtfO+hCl/Oc=
X-Gm-Message-State: AOJu0Yy2LMVR2CAJTsqhACM6kL7ndgVLJPnI5lC8eYodxdDBthCdFqko
	6wWbGkOSIR21PAXzwgEacd+mCm1Ky62IvJ3N85vyWSAybKHoYyPb
X-Google-Smtp-Source: AGHT+IHRCn26vGDmNKTaP3gt7MYF3CGzWIP/8l1UoEUzxQrqmG4j+DpgrF93Vgy/+PJxtO/b5lLdMg==
X-Received: by 2002:a2e:968f:0:b0:2d8:c62:5e20 with SMTP id q15-20020a2e968f000000b002d80c625e20mr519979lji.3.1712694109834;
        Tue, 09 Apr 2024 13:21:49 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c1c9000b004166a8ad81bsm9512177wms.43.2024.04.09.13.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:21:49 -0700 (PDT)
Message-ID: <23a5c86c-9f68-4c13-832e-7cf4e6953639@grimberg.me>
Date: Tue, 9 Apr 2024 23:21:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] nvme-rdma: short-circuit reconnect retries
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-5-dwagner@suse.de> <20240409140054.GC20883@lst.de>
 <ZhVOcGMuBzC3nyMB@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZhVOcGMuBzC3nyMB@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_132153_206132_8E78AC1C 
X-CRM114-Status: GOOD (  13.82  )
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



On 09/04/2024 17:19, Keith Busch wrote:
> On Tue, Apr 09, 2024 at 04:00:54PM +0200, Christoph Hellwig wrote:
>> On Tue, Apr 09, 2024 at 11:35:08AM +0200, Daniel Wagner wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> Returning an nvme status from nvme_rdma_setup_ctrl() indicates that the
>> Shouldn't this an be an a based on my highschool english.  Or does
>> Eeenvme count as a vowel?
> It depends on how you hear it when you read it. If you automatically
> expand the acronym, "Non-Volatile ...", then it should get the "a"
> article.
>
> If you instead try to pronounce "nvme" directly, it sounds like you're
> saying "envy me", like commanding everyone to acknowledge your
> awesomeness. Not sure if they had that in mind when deciding on the
> name, but it's kind of amusing. Anyway, pronounce it that way, it gets
> an "an". :)

:)

