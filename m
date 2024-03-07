Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAC6C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1b3cD1JzLzwXiFYhzW4TsWqoyMmImq6wp8ZpuvR6V0k=; b=0oirwMHa0suuJtVZdoDyIbZuWQ
	3iR8yOQ1m7V/cAbucP5Go4ZShSkHlpve7yteQ08fL8rCPJPk6T4T0D8vdOscbM7PjlakDRwwD309/
	6AGWMTSjCq/bgNbl/Ed55Aa2vaUIN7tcdK2JKQXSc/cOU9PLwKDcy4/yEV0EQ9Tq76jSKuJdTydTR
	g5/xjvEbSioINhTtMaOSZFPOTf5b5oZ+8uj6ao7pR5BmKJSsYZQc7JQLT0xtg6ipISCuy9xZfPZdx
	dcv+U+U0IaqzRkaf6lZLex9LshNGcRDgpd8v/NnEstZX8tHS8FGV8OG2KSa1GmNcAH8CryY193j7/
	eYCfrRhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAyc-000000045Fa-2jIE;
	Thu, 07 Mar 2024 10:27:50 +0000
Received: from mail-lf1-f42.google.com ([209.85.167.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAyZ-000000045Er-3CU2
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:27:49 +0000
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso301672e87.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807265; x=1710412065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1b3cD1JzLzwXiFYhzW4TsWqoyMmImq6wp8ZpuvR6V0k=;
        b=F+Vin0OYqi6lWOoorhkkKyBmp6UOrM3iE+hMWNkHgcliOiUtWX+Q7VLoTtgAXrCAtA
         Vswadc+uyuLrQ5aBAosIJH4XqXHkdGuUI0p50mmZgWM8Jt4wqrTs9YuE1/2pOUoNSky7
         piQYwWOZFeKS0V+EK0u5B+EYhPVePoh7AVFYjIuBFBegtJ1qLcqOHbjeCqNwL9vyUH62
         DYwe5+klp1KDTlcup9Mixo+Hb6lPtvqzUQEoMCJeh6/YYjDBfs5HERVYV5ZXz5Hcxh97
         6O9lmhObUpyBHuSqauk9NXAl/O8ankCnUQrJSBEdF6C946JxqrNZQzuA90OHawRr6NwH
         OA+A==
X-Forwarded-Encrypted: i=1; AJvYcCU0seqQq88yvBN1BEhEZKPNKrZVayR6qYHIi2ISQN5TET/pK1S/hSOE0e1v/ZPlYMwuc9ZAh7uRY0vHksLrXIaK9tLPfdmI74OJAqObkh0=
X-Gm-Message-State: AOJu0Yw2mnPMR5tgQPHnMprgzRLdLPYwJVrPFpLSu5JyHn40u/TKPAPw
	0zl9srVXlGjfY7PuJr5sMcG9RmP7SVMMGhJmIChzF5LYmSVm1kGq
X-Google-Smtp-Source: AGHT+IFgps20vqDI6X9001WLlcmXvxNG4XMdRKTXA56bfHc/jYT/w42AHA0Bzl9WrYACFz6oS3wHDA==
X-Received: by 2002:a2e:7407:0:b0:2d3:364c:2620 with SMTP id p7-20020a2e7407000000b002d3364c2620mr3590171ljc.1.1709807265309;
        Thu, 07 Mar 2024 02:27:45 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id bx10-20020a5d5b0a000000b0033df46f70dbsm20672235wrb.9.2024.03.07.02.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:27:45 -0800 (PST)
Message-ID: <342cf4cf-ad14-4fd0-bcab-fe5fcecf4c0a@grimberg.me>
Date: Thu, 7 Mar 2024 12:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] nvme-fabrics: introduce ref counting for
 nvmf_ctrl_options
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-4-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240221132404.6311-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_022747_838055_9E464F69 
X-CRM114-Status: GOOD (  11.92  )
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



On 21/02/2024 15:24, Daniel Wagner wrote:
> The FC transport is offloading the connect attempt to a workqueue. When
> the attempt fails the transport is starting to cleanup resources. It is
> possible for user space to trigger a crash because nvmf_ctrl_options are
> exposed to sysfs.
>
> This crash wasn't observed with blktests nvme/041 until now because the
> retry loop was usually trying for several times (e.g. with defaults
> 600s) and the test would trigger the cleanup itself. Though we the
> recent change not retrying to use invalid credentials the crash can be
> easily triggered.
>
> The simplest way to control the life time of nvmf_ctrl_options is by
> using ref counting.

Why do we need a refcount for an object that has the same exact lifetime
as the ctrl itself? It just feels like unneeded complication.

