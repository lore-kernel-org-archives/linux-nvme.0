Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533EDC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Nov 2022 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/MErsuwWcuWHOBDnRpZUToDXZo/uyhLgvgKdcFHlv0=; b=gnYhV7SaHY040sDPyvzdzHbp25
	3rMvE+ijzbwtS3EHFL73bWTMYuNiDhv8wEhkDgXvKVxyRq6a9CPLlv5oHptg+4grunpBjJxCJJHO4
	S6kAu/rS9ao9FOjZKGp7zMmaBrne1fPPXPeg3YYfGGlc0yR1BpkcZXZLtx83tG2PFWLkGgNT7pnPO
	rMpQzgvhnyaMrztq2FWKc1sgp2RXKmRqsHx9CDwUoCJgcjSPCmQhDCJb1UFySVrc9KTYtSKzsmUyM
	dr8kytnsuXs99yjzFcqxpa8UZzxzD0cSkvYrkkKFOHMWh/wxW57i6X4XIVo6lBKq+9TDm2hFlqYhf
	qmU1K1mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqheB-001jkK-6o; Thu, 03 Nov 2022 21:21:11 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqhe8-001jjr-S2
	for linux-nvme@lists.infradead.org; Thu, 03 Nov 2022 21:21:10 +0000
Received: by mail-wr1-f48.google.com with SMTP id l14so4602717wrw.2
        for <linux-nvme@lists.infradead.org>; Thu, 03 Nov 2022 14:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/MErsuwWcuWHOBDnRpZUToDXZo/uyhLgvgKdcFHlv0=;
        b=yF1j57FLAHC1J/Y6Xc5jilXiuNZhyYeAEgGJYRGRkm33/tiHhGoM+xfOxiw90L0uFa
         HpB5qtpKKvSEYsHoMr+BnmFAGGJwgfOAJmAKa+AgFFN4okboQnzy7BamHnbPH11pwwdk
         Nmb4TieeYmm0yEle0j2ow2SbcWcsaNclk7T2I3m+iW8itbIck2wUse37CxyutUYuOnlS
         4yNJiejMqGREEW1yTZdro2hZljbQ9BtngkmezqAyDiJdJfKvWMRDCx3dFDVJtRW6NVDJ
         nTbKGFNJzMsrdx9gw0xj7Ovbn+zsLe5tqqvpEfjIeBySPN0IO+wsNbA2o1z4DmzWdPdP
         bN2A==
X-Gm-Message-State: ACrzQf2W3cRMrO4tCGYJALI/soLge38pmWK8w78EJEN+m34rlHvHmdQ1
	bpnrNV+JMnGGkzNr9/cAtwYr2w3AuwI=
X-Google-Smtp-Source: AMsMyM5anlDcNkiopgpcfnEDm6cmT/P9k/PuxKUa4yoZAB6V8cCdjbOyR/refqwgy39pgfFx2uLeZg==
X-Received: by 2002:adf:dd91:0:b0:236:a261:6930 with SMTP id x17-20020adfdd91000000b00236a2616930mr19925558wrl.551.1667510466777;
        Thu, 03 Nov 2022 14:21:06 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b003b50428cf66sm922337wma.33.2022.11.03.14.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 14:21:00 -0700 (PDT)
Message-ID: <c87192c9-24b6-e6fa-8912-46c812a14d47@grimberg.me>
Date: Thu, 3 Nov 2022 23:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/6] nvme-auth: use xarray instead of linked list
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20221102075224.70869-1-hare@suse.de>
 <20221102075224.70869-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221102075224.70869-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_142108_935980_893B8A8F 
X-CRM114-Status: GOOD (  12.50  )
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


> The current design of holding the chap context is slightly awkward,
> as the context is allocated on demand, and we have to lock the list
> when looking up contexts as we wouldn't know if the context is
> allocated.
> 
> This patch moves the allocation out of the chap context before starting
> authentication and stores it into an xarray. With that we can do
> away with the list traversal and access the context directly
> via the queue number.

Why not just allocate the chap contexts in auth_init() ??
its always the number of queues and is mapped 1x1. It IS
an array effectively.

