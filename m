Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCC9D13587
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2024 22:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2P3uhqeo2wP0mTXZO4fu14Fyb6NlHhOxOGdXvST8V2o=; b=ZJ9Om34/fNypMGOeHtih9XRte0
	LlnlM1JH7erC8nF1CHxzTnJQZ/pMJorbRSrsOfcOBfWclU8JsCI1YR6pDs/xReV3/QBNZRAaY2bre
	zZL6EUvExxA0wozKHZWt38+2yTX84IMVP4zKuEerO5JVZ4zRHneVJAZCSA6jLXJZ3N7MBmOMZaQJj
	h7rnJu5RER7EVvVfH4qHWPC8n4m95AjNmBZzqE/gq2oZF8h6o8M2qomXi/2oip+k/s2Xx3BL+O2jN
	faAiLE17PKV2lRYUFeL7e3Cgc84ndmotMQSIgKWYTfCjd+I4SgRxHk9wxHO6loVdkOwcNessdxBUd
	5HQVz5AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5BQO-00000008zKR-10H8;
	Sun, 27 Oct 2024 22:07:52 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5BQM-00000008zK4-0fAr
	for linux-nvme@lists.infradead.org;
	Sun, 27 Oct 2024 22:07:51 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so2777267f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 27 Oct 2024 15:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730066868; x=1730671668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P3uhqeo2wP0mTXZO4fu14Fyb6NlHhOxOGdXvST8V2o=;
        b=j9DYc3UpybRt3S5JR/vz5wC2bT158GijsI9xKG8w1B66v1BvjYInPXXdyBNBCx+XR+
         IoP9dv+HCoGOSLO2SCHHnA7olW9pMQ6nBPIOVrMCTkt/jHq3ZQyghLSpbYEQHnM+KCNS
         Hzlhvzv0R+fX/NOnT/bA8GcD4tnbtjaoLdbs6Tc4D8cxxqyuy0alZMegxoqMTSfAcrTY
         fj0IWmkrl1SPzIX6mFR6cP55FWblMqnC82Tk5BEm/pgQfp+CHpleRglpy7P3DXtj7hf2
         dG2DgFWbSrt6nWAkPMWgZaOSL8MYGvpsbsTkre/K8Lo+4IX25ifY1u59VjWBrfEnQ46Q
         8QeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj1YALBS1yHN9F5Zj13Z3ncMag9cJ2lDf8FqNp88DQQqwyCBId1m0/y7gCHFHmbE/wFRHGJUOpEyYL@lists.infradead.org
X-Gm-Message-State: AOJu0YynogF2GXPGPsc4DaWMhJcXbA/G6nI+R8rNRxjPnVlTNsmKz+YT
	lzIcMeKOObhCH12L9ufWQqkFRHiY8oD+tOdMyaHmmMXz+CRFSO3xMSoTZg==
X-Google-Smtp-Source: AGHT+IFfSJKW5jxH22KxGFw4fSoxVSlqnrP/n7pyzbHUYE/bgtNjYkLJVUVl6palOS8BgZT6ek153w==
X-Received: by 2002:a5d:44d0:0:b0:37e:d2ba:6f11 with SMTP id ffacd0b85a97d-380611f5c32mr4803380f8f.47.1730066868255;
        Sun, 27 Oct 2024 15:07:48 -0700 (PDT)
Received: from [10.100.102.74] (CBL217-132-142-53.bb.netvision.net.il. [217.132.142.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b567838sm120207415e9.23.2024.10.27.15.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 15:07:47 -0700 (PDT)
Message-ID: <2c77692c-5a67-4a79-a483-350ba02c8fec@grimberg.me>
Date: Mon, 28 Oct 2024 00:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: use helper nvme_ctrl_state in
 nvme_keep_alive_end_io function
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, chaitanyak@nvidia.com,
 dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241027170209.440776-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_150750_231232_3A8C3B06 
X-CRM114-Status: UNSURE (   6.96  )
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




On 27/10/2024 19:02, Nilay Shroff wrote:
> We no more need acquiring ctrl->lock before accessing the
> NVMe controller state and instead we can now use the helper
> nvme_ctrl_state. So replace the use of ctrl->lock from
> nvme_keep_alive_end_io function with nvme_ctrl_state call.

The patch description is not clear. Why do we "no longer need"
to take the ctrl->lock? What exactly changed for this?

