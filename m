Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5767C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hWNk4us8op0b+wJiLg7HIDjnopxPEpD5VgycDmXyYzA=; b=qycrHfQ4YJpGYG5p3FiomQaLz6
	aT1ttBzbpDwIvP+u9/XPOJnCIUP5KIC25VJjis+DUVAj2wi5XkahsdcMTHU2MKs1JE9y7Rhh6TysR
	hAw4YeKTZTqXJlVurh2Mh+9PdW45gdIRHBzgnGd0MeNumBxqlh0M5UqZ0bNpQfcCAByPFrrmddpGd
	IC5yZMLV8hpUA/fZw28dP7MhQ3PiZkCaIVtbqL9VBC0POvCDXqeD7dmizf+y4lHJjZBWQhcn+qBB+
	tf/TO29J1ce7eqWzfNdHjibC+3zRrJPpm21+xAGrM3HYwKePCPdcH9OYNC2SxLiu4FPyHDiHOv+p9
	gAGfNSUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKiA8-00B9PU-Kz; Thu, 17 Feb 2022 14:53:40 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKiA5-00B9ON-9G
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 14:53:38 +0000
Received: by mail-pg1-x531.google.com with SMTP id 27so8527pgk.10
 for <linux-nvme@lists.infradead.org>; Thu, 17 Feb 2022 06:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=hWNk4us8op0b+wJiLg7HIDjnopxPEpD5VgycDmXyYzA=;
 b=0CArP/gwlQRvcpiaXCGErcBTurFuCrJ2cas60eHKzs6UH1KGNOFVAG3Fhf9ohu8LQx
 LM3ioGDDZtvpc3dReOMoF6Fh00kJa0wFtWEuC1Tyf/V+C3iy63P8BhWQdb59c0WEeZIP
 So15CzC4qKzVM6Jc+7imzy49BKxzNSrj8S8dWZbu4n6ck7Hr13qmB/wX3WbAD5aJ1UUq
 /Um/Kw36eg/OZqGHbar22/To5tsRod0ai0dyh6KDAj4GuG2CmXEhEKZPGQ4oIEVKxdgP
 WtY0h97QM8hJeRidzM2GXWyjwWXmWhdKeMAqYeKfLrFdwhHphKwpOKELe3WzDoKeJw5/
 gRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hWNk4us8op0b+wJiLg7HIDjnopxPEpD5VgycDmXyYzA=;
 b=D7wwKrWRMSNYrngjq0+i3rccIUZrO7Ug+CxYrDHAI+lYk2FyEIbJWCJAw6GTSjWY0Z
 MZimk7p6sXrrbgY3n+Ly+28x/Q/Lt7P5W8lX/W84+dlIf7VXp911ga62//HxXaE8MibQ
 KkH66ScAiNX6YfVXvB4gBOy4bnjCqOW9gkympGlx3OFv8LAoKU9DlZ7s5jo+VddU9zIX
 /fU3kzuvpcE9h0igKwIrAdzR5TBVtqDMWuJm4qGyiaHDnUU+BYVrgrnpylzaJMBS7YO4
 ogbyduXM0xyZSq4n6Ze3O0odRir7WkvTvzj+Wnp6qtF0kVl6qLmRnaICAqqSdUl5GYTq
 wtJg==
X-Gm-Message-State: AOAM532xEgUS7+AbRL7A4dyxvf7v3Ny+ZdqLGbJELmEzavZSiF1EGoSj
 RfVY9L+g9PjnkWIdVmUNhNVe/A==
X-Google-Smtp-Source: ABdhPJxW7afmkKFjzfcCg0HmJf5RhvRYLphPv08F70x0dWvJm45BTosHGiOgq3k6MuwoCP5HHJNC1w==
X-Received: by 2002:a65:6e93:0:b0:362:da8d:88d5 with SMTP id
 bm19-20020a656e93000000b00362da8d88d5mr2703141pgb.194.1645109615299; 
 Thu, 17 Feb 2022 06:53:35 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id s5sm8651284pgo.37.2022.02.17.06.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Feb 2022 06:53:34 -0800 (PST)
Message-ID: <43426c0e-8c50-9288-05cf-7bc1f71c239b@kernel.dk>
Date: Thu, 17 Feb 2022 07:53:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V2 04/13] block/wbt: fix negative inflight counter when
 remove scsi device
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Laibin Qiu <qiulaibin@huawei.com>,
 Ming Lei <ming.lei@rehdat.com>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-5-ming.lei@redhat.com> <20220217074502.GA1333@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220217074502.GA1333@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_065337_453571_9E7F13F0 
X-CRM114-Status: UNSURE (   8.06  )
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

On 2/17/22 12:45 AM, Christoph Hellwig wrote:
> Jens, can you pick this up for the block-5.17 tree?

Done

-- 
Jens Axboe


