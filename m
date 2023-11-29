Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11315C07CB1
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 09:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cV3cidTfYmhmSEmql6w0XpvkQP5KN8Xk5Nui+lMKWpM=; b=wfT0lWbYJLfatSz03QIl/kMsOQ
	SWtjAllZyKWADORWjY1083lIfJ90/ktV9YB+C+VdWnC/llp1jygWeauyV4VwvK9dJTJOLUJHkWnGg
	prlEuUridwuwl6Q399sEGeRad584qkNhkHS4boa2WOZlyu7BQHkKMHTsjO0zNPYfmYYCOUntaKK0r
	JcKpsUwAzRarUEM/SLgFr0xE6t0k9wJgEuoZHoLVcy3HD/UaIc1T3Me5VzlmuLlGL6Tvv+rRFO2Xk
	fushRY8m5pGjb6fj4SbHKcenhTIFEK17pqQp2j1j5Weu7UjMgnNJzo+QBImKO+SDjxiWR1fOPqFR/
	Im5mjLjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8GrN-007dYA-00;
	Wed, 29 Nov 2023 09:27:57 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8GrK-007dWp-1b
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 09:27:55 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b54261442so2274525e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Nov 2023 01:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701250072; x=1701854872; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cV3cidTfYmhmSEmql6w0XpvkQP5KN8Xk5Nui+lMKWpM=;
        b=UqMxAWsYMMp4fk5v6VKm0BVwfbWq1U8mAZwpgLcj3qdcQMY09E/JB6h7YDTG/yVxjo
         Ioa0SOVZeB4f/hINnDPcq8bwMWtl3L08pDIBAp6UbhP0qNZHvXRVLVcmO65uSV66hagW
         3aWoowii9eNA7/j+zOsi4X+K3FK4p6bera7hRKqzQqlfrC6nL0Bb+UGax3OMcTLqTM2W
         MjEBraBkLaHliLsrVNsBKds+2W01O1qxiEqRIJxQ+z+cOFEfdjnF/8aXVrvhOqDYVSvD
         VYr8LuM8VODa9kvnAHupw/m6hYypGUUgqc/GczOAQA6P3g4eaJrpnoHsF/mdduDMfWpl
         dAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701250072; x=1701854872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV3cidTfYmhmSEmql6w0XpvkQP5KN8Xk5Nui+lMKWpM=;
        b=KaFfkTwHABqw3HvQLaXNJ+JCGSPh7n1tkx+exQsxt/3CQ4F6LcnudD5Pg8ndkJFKe/
         SrX4Uc27i87l8a5VtHP14pzwkBzx2DoarOht8DiMQ467t9V8xT8z7clmr/3fJpk8P3+L
         wox8w7Ey7xhO0QcAynsMes6+XGkXiADvnlu+1ZTWYXv+ACcDZ/LESHvSg2+z5uDn5Jzx
         rjsPSev/Q3Sw2AIeLJvZeuJQ1f/vm4jVq8N4GiiVYzkRHXm8ttLWPD9GrRsPfDx3fBP3
         nygm3evPIhQp9qpvmSXLWxS76l0lBjhaOqEpSP+hFF5UCjlffXQX7S2KJSc24Ti4B7VT
         mA8Q==
X-Gm-Message-State: AOJu0YxFJKLBsKZ9oSXULDMdsgpWPfx6lpfhcM7Z27rPlqRJeJEo8QZI
	chZZS+92pnbclrY7y4PVdUDWTg==
X-Google-Smtp-Source: AGHT+IHzeJKMk7WsQi+AyV6Jd4iYFuZOhQ4zg5yYm8Obs7Iu0VnUJhTR/zfpZ5TmSWIfoCzkEkWPQA==
X-Received: by 2002:a05:600c:4e94:b0:40b:4bd3:f8e2 with SMTP id f20-20020a05600c4e9400b0040b4bd3f8e2mr3616704wmq.22.1701250072542;
        Wed, 29 Nov 2023 01:27:52 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b0040a4751efaasm1517697wmo.17.2023.11.29.01.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:27:52 -0800 (PST)
Date: Wed, 29 Nov 2023 12:27:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
	gost.dev@samsung.com, nitheshshetty@gmail.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: prevent potential spectre v1 gadget
Message-ID: <b94b300b-8c09-4246-bd98-95f7b4291c49@suswa.mountain>
References: <20231128122958.2235-1-nj.shetty@samsung.com>
 <CGME20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6@epcas5p2.samsung.com>
 <20231128122958.2235-2-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128122958.2235-2-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_012754_538838_2834E436 
X-CRM114-Status: GOOD (  13.02  )
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

On Tue, Nov 28, 2023 at 05:59:57PM +0530, Nitesh Shetty wrote:
> This patch fixes the smatch warning, "nvmet_ns_ana_grpid_store() warn:
> potential spectre issue 'nvmet_ana_group_enabled' [w] (local cap)"
> Prevent the contents of kernel memory from being leaked to  user space
> via speculative execution by using array_index_nospec.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---

When it comes to adding array_index_nospec(), then I don't know enough
about it to comment.

regards,
dan carpenter


