Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BEFE7AD44
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Dec 2025 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4sd9dYjXkenqQupf8A2IMgR8ufMui6YRHhpSwrBay/M=; b=XRqi1o/mQrt78rnA8oUP+Xrn0H
	jyYwAtXAxnKF4v4zNC17Yf4innAP3GOgLclU03vKZ+Lv7prdRcS2I6p0VKQziZyTwob85g6zVIg+I
	aZnqTmvQyclv9wUUlC3OmUhfyXGXC6HK9BnJbq2SGngstrnf27kQJCUaazLJPJANucgXjZAW5ljgC
	9k+RuWKOv4mvP3D3Tk50uiXcM5eSPk9hyBDIiZMOyxlLJgKxEJhZK8MwGW7SVSN6G3ppN7Nbm0D4z
	j9IhCpRi8fquztIUb2OVcM6zYqQGc/8BxauaiV6mIsMwCm/eCe1aKcbyKM1dsTRSYmRiWmtTGgaug
	Cy2vxbQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYlPm-00000000Rbf-1g8t;
	Thu, 25 Dec 2025 13:30:02 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYlPg-00000000Rak-2yBn
	for linux-nvme@lists.infradead.org;
	Thu, 25 Dec 2025 13:29:59 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso67215785e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 05:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766669395; x=1767274195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sd9dYjXkenqQupf8A2IMgR8ufMui6YRHhpSwrBay/M=;
        b=qfZx6R8GGMWPPliubXmJsxg9cn0nwKKtYSxIaP3lTIbdw/VfMDen5sY5Hcr2XpCAwb
         ZMWYQYL+GMfaP9HVs9Xr2u/wmMu9lvDMRojsGRXRs2bdZY+Tsz3Sat04LyhOS/44x+O1
         vpxY81gaP9PG0BcRGBG2Jx/TqPiEkIZgEQF/fwQS0n/wu8qy40y633bgD+njX6AvHYCl
         a+zWAU/8JlcyUTiYRkobA2kgNtaG94MQmdC/EAkJSZgfp8gVhc0bBo0G+Fnba3TveIpw
         GffBWIDYqhfHi/Q4pfSfnnS1FMgOStBkZcLdnq/x8zDvfHYaFMSJS6amTjZPHz0M1/YG
         dIuw==
X-Forwarded-Encrypted: i=1; AJvYcCUpBRWDilcuNqFxBjbLZZdGfTXezP4AcJWn7nWHQO7IZ5bzRgCYmAGEBVkudvxsAmwNgKJdOK8T7uWD@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4guJNfgG95pssInjETa44g6su9Bs78TD4NACcPqF0g8ey8hwJ
	D1tXbWwxGm08ZMjSXWVjTd0Y3gIUyjtibF6N9lE8dzMYKkFTTDxQUC9A
X-Gm-Gg: AY/fxX7JItE1bmWj7fhbGriAo+HRNu6AxDuruGfNu+xy/xdDIjKGQB2F2ZKMBk9yqKD
	TWAhmWDxYqfhvzlJYcu246hWRZ1qe/kDxfRsWFW0Dv7oQd6dC5FrdF6ner/6xkOe8i/Aec3uGyL
	poeJhYWk7zf0zVqVaDXoEp0kqTiwjyhftr6bjSq67RxBQIYcbHx4rxZxz576rv/soa7IxBg+AXE
	Q09P9jO4SrYdUFM7/XXb82fZTs42j91QLcNxwzl8xQThbgaOwX7kc+hgVUPVQIDCLxxqgs7y+DZ
	rjUxvQiV3auSSQ6cnTFU2Gj2CuiSeArmgMVFpZsXGAoiocDWsq31C9ZS4HYX0vf3p+R4jPl5NVL
	oQQCPatx90WyhS1cT89UjZ3rxfZylSvJib4OieTEEiF2T5o71gHy0/fsxCPgEHxYt8epYaA2VTJ
	b6M+UoNd1QWmBF0sERaNIV20ta2Rz61qAMG3rQxA8lbSUUUw==
X-Google-Smtp-Source: AGHT+IFPES71QjGOTgGEkackpnMHbs0cevNfhfxVitS7PdL54rAx+Ncj4W0HtihRveEL9oncqVy1Yw==
X-Received: by 2002:a05:600c:620d:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47d19569c23mr255792135e9.16.1766669394572;
        Thu, 25 Dec 2025 05:29:54 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d4e91sm335601365e9.13.2025.12.25.05.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 05:29:53 -0800 (PST)
Message-ID: <e9bb2664-9d96-45f0-a39d-6deaad0829e9@grimberg.me>
Date: Thu, 25 Dec 2025 15:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/14] nvme: Add RECOVERING nvme controller state
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-8-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251126021250.2583630-8-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_052957_061884_0970D029 
X-CRM114-Status: GOOD (  21.34  )
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



On 26/11/2025 4:11, Mohamed Khalfella wrote:
> Add NVME_CTRL_RECOVERING as a new controller state to be used when
> impacted controller is being recovered. A LIVE controller enters
> RECOVERING state when an IO error is encountered. While recovering
> inflight IOs will not be canceled if they timeout. These IOs will be
> canceled after recovery finishes. Also, while recovering a controller
> can not be reset or deleted. This is intentional because reset or delete
> will result in canceling inflight IOs. When recovery finishes, the
> impacted controller transitions from RECOVERING state to RESETTING state.
> Reset codepath takes care of queues teardown and inflight requests
> cancellation.

Is RECOVERING really capturing the nature of this state? Maybe RESETTLING?
or QUIESCING?

>
> Note, there is no transition from RECOVERING to RESETTING added to
> nvme_change_ctrl_state(). The reason is that user should not be allowed
> to reset or delete a controller that is being recovered.
>
> Add NVME_CTRL_RECOVERED controller flag. This flag is set on a controller
> about to schedule delayed work for time based recovery.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/core.c  | 10 ++++++++++
>   drivers/nvme/host/nvme.h  |  2 ++
>   drivers/nvme/host/sysfs.c |  1 +
>   3 files changed, 13 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index aa007a7b9606..f5b84bc327d3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -574,6 +574,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   			break;
>   		}
>   		break;
> +	case NVME_CTRL_RECOVERING:
> +		switch (old_state) {
> +		case NVME_CTRL_LIVE:
> +			changed = true;
> +			fallthrough;
> +		default:
> +			break;
> +		}
> +		break;

That is a strange transition...

