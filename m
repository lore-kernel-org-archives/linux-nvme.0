Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4069CC04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 16:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qbTJgI9hMz3TcWSUElgCDi9gkofgMTMkwHO46HDtu68=; b=Bn1obtr51Iuli8UbFpqPaloNfr
	oOq5z8KPPNVh1/u+wMpKLk66Ru9GHOrIDfK3eVOF04FZ6jILfIy6nMuXT6wa1nY14N/DKiyfUtcM2
	ZquYvA83zcvhc1vKle1n2mM8wPRKoP1Z7o2BbjqY+FRp3Dx1gjdcLIZ8kLtPSSsmPvqb+A/IY6ie2
	3pDk+DTviHWcJwUP0L/TNiyfJs0PwfiLDjdwWm5Ah9N6f1vByCdIMymR+9x2F7VteaVfSb01vLvN9
	OwmeTpR8nVrcW7NirM6CcYzVw9PwacQXgdQZ1T0aMvMJOwYAgpowqgiEz04xzPmuy0xloPlIwc6Tl
	qND1ALDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMLS-006Cld-S0; Tue, 25 Oct 2022 16:00:02 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMLQ-006CkS-LR
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 16:00:01 +0000
Received: by mail-wm1-f48.google.com with SMTP id n14so4164810wmq.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 08:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbTJgI9hMz3TcWSUElgCDi9gkofgMTMkwHO46HDtu68=;
        b=Hwq3c1ZMoOOZDO9N1MQ8J6I11NKrSrVFq50t3yZL+vmofT78OiDfxHLR27nImQL5GK
         UQ+ardDDLtZl+Ge22FjZIte+XhKudfIt6qTYctY59YF/LypHi+Cs7AykrGvHoOpOQ8X0
         9MLUG/6OshVrGTsWU9pIrjRC8AbLWgqWQvhz/uF8wOeCMaTmhgpT8rUILIcrf3yxQlyV
         ftDggktP6jkOUWVDxH1LI85cmvjQYHiVBobmr0cQOreK6TeDqbNClSUqDmKyIn0gNTjp
         M06zBOQ6N3yPH/0WkJVxQ6wpuIzXmiipIP/69n37yaPGYlCQLnPBLqgEIJAzI/smlJDV
         2gNQ==
X-Gm-Message-State: ACrzQf0JhYf/DxJG2By+KhzH1YTs4Q9jye1yP/Cg4c4jggYi90TiJPfy
	fPRwY7w5RK8Xb16DWRsG+T8=
X-Google-Smtp-Source: AMsMyM7GG2QNd83/+8VzxzxotB8R79m64WEF7vmj63bn7acL4jVcSdhsX76wu+I42Mx4p7GpMwUpMw==
X-Received: by 2002:a05:600c:524c:b0:3cc:ed19:707 with SMTP id fc12-20020a05600c524c00b003cced190707mr10651157wmb.80.1666713597949;
        Tue, 25 Oct 2022 08:59:57 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0022ac672654dsm2910957wrr.58.2022.10.25.08.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 08:59:57 -0700 (PDT)
Message-ID: <3d95023d-58c1-3d8b-768a-6a986db00e62@grimberg.me>
Date: Tue, 25 Oct 2022 18:59:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 1/2] nvme: Include AEN CQE.DW1 in NVME_AEN uevents
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Clay Mayers <Clay.Mayers@kioxia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com>
 <20220929223955.3275715-2-clay.mayers@kioxia.com>
 <20221017132359.GA23141@lst.de> <96244e61f9b94ed3aff59f3f14ecdca4@kioxia.com>
 <20221025153846.GA24661@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025153846.GA24661@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_090000_726506_18B5429B 
X-CRM114-Status: GOOD (  16.71  )
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


>> What happens today is a warning is logged and the log page is left
>> unread.  The patch closes that gap allowing ZDC AENs to be enable
>> and handled in user space for things like RocksDB's ZenFS.  Kernel
>> clients will also need a way to handle them, but can't that be a
>> different patch series?
> 
> The problem is how the NVMe AENs work - the are raised and then the
> AEN command completion is delivered and they are cleared by reading
> the log page.  But if we deliver them to userspace, we lose the pending
> state of the AEN for the kernel.  Right now that is not an issue,
> but we lose all chance of ever making use of that information in
> the kernel.  So maybe the answer is to handle the AEN in the kernel,
> read the changed zones log in the kernel, and then send an uevent
> for all changes zones to userspace.

That is what I was thinking... I feel we had this discussion before
on a different AEN (maybe it was something that wanted to get ANA
info to userspace)...

