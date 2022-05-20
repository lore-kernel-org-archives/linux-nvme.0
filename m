Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9266DC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 12:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f8BllMGt0DYrgZ7mzYdWgLIxWxCsIts4IW4I6pKKWtc=; b=ZJlunPX5nHPxtVLVclLoNA81Jk
	eEjYVSES2D4XfxAIl2EtkDbhKRkrK92C+Fc4ZRXNXj+hUS5ZXIMbtGL6Mz5zwfdCvlDH37/4BiyQ3
	1RbvJveLzyZe40st00qX3Hkolylkg7PRliTPGWOrAmkgp6Sds67jk+EDvyQn+jkF0QUa2HLcyI2z1
	0i+WYsShL0CrE1ETkxFoR1niR62RRtcC4QqfNzxheMg7eOXQQcgP+gO+U03SLF+0OZ1w2g8L0Knuo
	aFvgcnIJvHVxMhQIGgXR8tJmbMW+TrkUrv3zSpSWlcBOK+KRq0+SzRhl2Heq0DSBR7a5OLd+xVWjH
	gJqj6ijw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ns2C1-00CWNJ-Pn; Fri, 20 May 2022 12:57:21 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ns2Bv-00CWKa-40
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 12:57:20 +0000
Received: by mail-pf1-x42f.google.com with SMTP id u15so7672768pfi.3
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=f8BllMGt0DYrgZ7mzYdWgLIxWxCsIts4IW4I6pKKWtc=;
 b=RNcoXGypZDioVph1O0OX0LwHX7CKzO3XnZtlOeNg7NlC61e+KAmcG4AQq3E809aGtl
 Xb8cwnw+K2yRbGrxxq7/RnUnZbFfvZE0GQXKZQ2CoFtxNRyL2cCdFnLkMXzZ9sXwrOnM
 ytowWP12hICjzilfMWS4XPrHn5QBWKEptJGsySZoNUl4WPoTpc+UGK0MPGXhJ3FkLAdL
 D92xKRBmWKHFMdmSv+URdySvZ0cQHUes7N1MQBR4iGUhkowblG6EufVS1Lc+G03OwHy/
 59Knia68tgWhHXhs+2fNqiGMkL1knEfYYTE7jUqgiU/lpRDm1c8rfS/pTVkrp0MeyW22
 3roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=f8BllMGt0DYrgZ7mzYdWgLIxWxCsIts4IW4I6pKKWtc=;
 b=eSSnRAKCrasHybj0I2rDnHXBU1b+czukF3OTpE+rvbVavjzpqpl8JV155P5CuSysbV
 4cdQZU4rBA8gzVRkAObgnUpEHVppSmFdFtMEedxV9gfUWotgzbwh4QAZdejgBxMVzwrI
 qggomgQMvTbCyq3DmSsiXH4OkkReVS+8YBdagCi6+cV83SLo8ub2zgZeoXlVN/y2hX7c
 CQqu0gfMWMD8vLiL4jgsrGk/738i2Dt811UapUmlYeYCQBwTPzPOX+WTk1D4vS3pycQI
 uDJFJ5zMmXmZKazzosOA7N6kT6dh3GawMZaFn9ptK6DTbYwBgyVwy6xzsDvcp2E6QIl5
 ZNAQ==
X-Gm-Message-State: AOAM5323LzeNJV0mqVusFYtBZGWkdrKviOGtbs0D4wlLRpK3gU65fi0R
 KL/GT7UwOxSeR6CaWXpcuCkH3Q==
X-Google-Smtp-Source: ABdhPJxD5FYqpfytlW6KVR8LQY82NU50dB4cCl4CTAmPc7Zm3oIfI49Fwegv0EFUCAeqP32stnMsbA==
X-Received: by 2002:a63:4b16:0:b0:3db:2389:8403 with SMTP id
 y22-20020a634b16000000b003db23898403mr8505829pga.594.1653051433642; 
 Fri, 20 May 2022 05:57:13 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a056a00140600b00512e4b5af0fsm1806351pfu.174.2022.05.20.05.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 05:57:13 -0700 (PDT)
Message-ID: <98ad79da-7d15-2fa2-d15e-50ad5b2b3a82@kernel.dk>
Date: Fri, 20 May 2022 06:57:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YoaeuNGHGE/t29gY@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoaeuNGHGE/t29gY@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_055715_207499_5176537D 
X-CRM114-Status: GOOD (  11.42  )
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

On 5/19/22 1:47 PM, Christoph Hellwig wrote:
> [note that my GPG key expired today and I had to extent it.  It
> might take some time to propagate to all key servers]
> 
> The following changes since commit da14f237ceef059ff1a9ee14de283905c2dac11c:
> 
>   Merge tag 'nvme-5.19-2022-05-18' of git://git.infradead.org/nvme into for-5.19/drivers (2022-05-18 06:28:04 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-05-19

Pulled, thanks.

-- 
Jens Axboe


