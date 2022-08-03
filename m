Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D753C19F2C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 17:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=81PY4yBEEjUXxYOBG5CambynNE+HXFQDS99frEnDmrs=; b=Mm0nvkafdP73kDajIVgjjQkVrh
	w8dQ0wJPeNi1k1YMOjLGeZEPXXZRRFH2TiO7TkHrl3yLhCuyCDjQ9XHRE5udR7ccvVPB+5dCODVmh
	inY5XUoeUiu1iiC+z+ltG/HnthbYPGqqrDbuDvdtYcOoua3Kb+rOBpb9zaiKM0ypwxG+wJgkNq05B
	fXgmGhj73ILgkmmt5qczapQtrnF8Irzn7ELhDjTK537Aor0MHioyOGYQzH2x+r9NJ8MSFxav293jN
	TNN8UrA8WF6RrO88QpYwzWsZ42JnNNvj15iYM239HcnV1PYSdqmXJJfyk755DvkZxJ5OFxx4giip4
	NqJRfuPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJI4u-007sz0-Uk; Wed, 03 Aug 2022 17:22:41 +0000
Received: from mail-pj1-f48.google.com ([209.85.216.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJI4r-007svz-RQ
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 17:22:39 +0000
Received: by mail-pj1-f48.google.com with SMTP id pm17so11594036pjb.3
        for <linux-nvme@lists.infradead.org>; Wed, 03 Aug 2022 10:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=81PY4yBEEjUXxYOBG5CambynNE+HXFQDS99frEnDmrs=;
        b=kotpbbDI5LrVa4utRDJ93MInqQrsxFZ9ZsvoDw7JOggVAFlvdkGGCW3FSm9bGtt54Y
         +lsJFWWsoMat5dL1X/jllYz5Ju7lqwGQney1q/kckEzeLWOfk6IbwdjcVcwibVbwEfy9
         K5TwrPJn5pZ5lzCI0gosPfVOYbtBLpcFeLnj/OohiObF7Z9pnRrnqTjdLpc4C1FwGtnX
         DQEaRDFd/2V6MANokFmN0QKPqo4vISkbGLnjbNk+dOxdfM3QyFkODbIxOg/u1ubzG3xN
         Y4BYgfUYTohUbMEk8aptRkJ1ZWjZw9Vn5SSumtaWAuT08DMeyRE5bW6PKHWwOO9P2Rnn
         oieA==
X-Gm-Message-State: ACgBeo1jGLvLaSHU6uhBTo4JShzV7nXwq9YRLFEfZRNImsbAQkKYc52v
	/t2w9vH8g+YI8yS213an/zk=
X-Google-Smtp-Source: AA6agR4qAuR4iHmzSPdpkQ3mxXc1SGakIYA1aA7y7JsrpsmrjJ0SDtdisB5YYBMJ0qKrjfikQnBjiQ==
X-Received: by 2002:a17:902:f54e:b0:16f:206b:74cc with SMTP id h14-20020a170902f54e00b0016f206b74ccmr1132384plf.170.1659547355934;
        Wed, 03 Aug 2022 10:22:35 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903244700b0016cd74dae66sm2275344pls.28.2022.08.03.10.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:22:35 -0700 (PDT)
Message-ID: <2616b59b-8c6b-a482-a396-d9408fa461a3@acm.org>
Date: Wed, 3 Aug 2022 10:22:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH v9 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
 snitzer@kernel.org, axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
 agk@redhat.com, hch@lst.de
Cc: pankydev8@gmail.com, gost.dev@samsung.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, jaegeuk@kernel.org, matias.bjorling@wdc.com,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527@eucas1p1.samsung.com>
 <20220803094801.177490-6-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220803094801.177490-6-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_102237_987659_7A751431 
X-CRM114-Status: UNSURE (   8.83  )
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

On 8/3/22 02:47, Pankaj Raghav wrote:
> -	sector &= ~(ns->zsze - 1);
> +	/*
> +	 * Round down the sector value to the nearest zone start
> +	 */
> +	div64_u64_rem(sector, ns->zsze, &remainder);
> +	sector -= remainder;

Could bdev_offset_from_zone_start() be used here?

Thanks,

Bart.

