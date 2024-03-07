Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1055C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cQxEvRem4MCjLjmNRZYfQipiZ65wMk+OZ1LYktPKLRA=; b=U070gQzb/a8Rts1EPOkXCIA4MT
	bGwM/WdFth4y6o/3U0j/Jh2RML7N7yNa8i0cZ8kjaXmmfNDNrGPi1ul/Zg4IxgdWb1FJTb5aVxaq1
	cxhXeGc6qEOqU/y+RrrWo2XQ33jrRQVBNqhaIDXEpqA/rZ12BIC/Tpst22JbvJBg72cQm6eXlojqt
	tAEqB1LjxtL52iRQdXkclVFj7qqkuT0ahHZFku9V24lLbasyMgc3WuWri6rgMMB4orR7sQ5bjMSf6
	i4VYaZVuZyA+3C4k/b8P2lsFjL7BkqNb5S9zc6BwCn75X3tDTnBHnpkKlPulIZqrQIpRzhPeB+47S
	SNkqTtzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riH49-00000005ahe-2X4M;
	Thu, 07 Mar 2024 16:57:57 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riH46-00000005agN-1fbo
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 16:57:56 +0000
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7c86e6f649aso897739f.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709830673; x=1710435473; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQxEvRem4MCjLjmNRZYfQipiZ65wMk+OZ1LYktPKLRA=;
        b=OfBihwt/zil92uj5YMcy9jNy9W22/7e1Si8z+KrO+SnbFG+xKGkA/fiLzubF43R18e
         q+UwkV+/StrDYTVDFEH98EM5PmY1Y4WspHhX4/oLgbjfVAjyzH5h7/zTMzDlWwNUP4qH
         9IzXVQb1/cfoLHm3UTuTMAZYmeZP9qbUCvZSo0zapas+zOrfqyCjhD9gt2woTjjstHic
         X/kV9KPkzGBtwQ8ctwQ3YYH2c0YwfItl6+8+Me1NlZKhwjnRG2cyjXrjCJXPcwhmMFSV
         S4NoZTtw31We+AcbjzbepAFDp217PDZ7Hq/QZzL1h2/fNH0RBlI1sCRJyHS3sfiuUpGL
         qETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709830673; x=1710435473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQxEvRem4MCjLjmNRZYfQipiZ65wMk+OZ1LYktPKLRA=;
        b=iIxJw5wO82lJfNdOQq8r/QkYGNbOzgIBReWjKrP0NhL23nkb2kVIEZQxuMeRMD3HcV
         QkzLye2CuGWAppcAwGlQi/bUpA+0S7YRfwyqgmZ6yXoFOxH+tO2NFgSlULj2Bajwratb
         8sRYTg2YcYFrpdXOu1vnLI97DdpFZYBOcMIDiJuO1d4J09XvQmQBWbhgMaAJ+9DPaI2K
         RO1V5uXu0T+vMOuRfCksQI61dcBsc+1UtOkYdzbngNKp+am7schQSMrYEZnwePd+YzyC
         9lYAf1vufnVqyeTaCkK2wsAn58IGE8wF65JawtTILj9hzXqnmy/M8ivHbGRVlX9uGu/P
         UvVg==
X-Forwarded-Encrypted: i=1; AJvYcCUK0TqDglqaw8W4x7t+Ys1CqE+azac6vdtfV9LGm/E9Rl1CA8Unp++oCvCRJQ3Zzd3AlvrNJd1+gPU5yTJmhZcP73I2YRs5haOdsqiuvA4=
X-Gm-Message-State: AOJu0Yz8WwNI8Qtzja27WWWgcfY6DzQnZCjOy6P9ffOKfotItQWJ7YYV
	/8Mn9yIhlr2nf+FLY2BYaoZ1PkxoPyxkmCBTVMJY4kiS0SNzYfH40zVPQLHgL/0=
X-Google-Smtp-Source: AGHT+IGhmhAP0I1PU2oEgm/01jWd4i6QNZBikqI4jo2bTh4C7EBbuMUrtk1OcNT09WhWAuN6h3TDpQ==
X-Received: by 2002:a5e:890d:0:b0:7c8:7126:a44b with SMTP id k13-20020a5e890d000000b007c87126a44bmr2792285ioj.2.1709830673074;
        Thu, 07 Mar 2024 08:57:53 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gs17-20020a0566024fd100b007c8197e8473sm1731021iob.5.2024.03.07.08.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 08:57:52 -0800 (PST)
Message-ID: <f11b5b7f-584e-40b4-8421-f729c3958095@kernel.dk>
Date: Thu, 7 Mar 2024 09:57:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.9
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <Zenidge11HKo4JXr@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zenidge11HKo4JXr@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_085754_686293_C0B4E167 
X-CRM114-Status: GOOD (  12.14  )
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

On 3/7/24 8:51 AM, Keith Busch wrote:
> [resending; first one did not CC the list]
> 
> This is our first nvme pull request for the upcoming 6.9 merge window.
> 
> The following changes since commit 268283244c0f018dec8bf4a9c69ce50684561f46:
> 
>   nbd: use the atomic queue limits API in nbd_set_size (2024-03-01 09:08:22 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.9-2024-03-07
> 
> for you to fetch changes up to 7e80eb792bd7377a20f204943ac31c77d859be89:
> 
>   nvme: clear caller pointer on identify failure (2024-03-06 06:29:01 -0800)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.9
> 
>  - RDMA target enhancements (Max)
>  - Fabrics fixes (Max, Guixin, Hannes)
>  - Atomic queue_limits usage (Christoph)
>  - Const use for class_register (Ricardo)
>  - Identification error handling fixes (Shin'ichiro, Keith)

Pulled, thanks.

-- 
Jens Axboe



