Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE66EE0AE0
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ipzhtnDVXnToARvNhaKPdfPt3PEJtTONqIIBL4GOM2Q=; b=f1TLgwEwuCSZcHb8/DlHW9ON2/
	3o82U2BLoEPrjQN/eDWihWAXuASw0ISgcuXUZcMM5mk4/0N5uIoFEDXwkwpmqO2Rh7Fy0mudN+Tg1
	VNmIUXwDXkVto7nb0kYun3bmq8h4WkZzig3NicVorMr3u+phN4AdGJmejbNokPWqlIEkKQJp/aUUK
	ZL6bmavwvLNVCRKdJNV1vcRx7ufPxszr+x++cmU9fB5A2ZQY3QZQ7EXuxmCJxcyMdBVZse1eUSm9/
	7XWl9KPEPJK4e8MBBlDliN+Z8TLA6z6nENEfLsqEO9+xnT7gMa0W65/K6gKKyvac0vs14GrWn7gg0
	ev+KVCZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voiMZ-0000000CTtQ-0630;
	Sat, 07 Feb 2026 13:28:39 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voiMV-0000000CTsd-1KL7
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 13:28:36 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801bc32725so12137805e9.0
        for <linux-nvme@lists.infradead.org>; Sat, 07 Feb 2026 05:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770470913; x=1771075713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipzhtnDVXnToARvNhaKPdfPt3PEJtTONqIIBL4GOM2Q=;
        b=q5v/1R7+osSHDFyGwyjntaPfdV/aZHmC8YVLinAUZxjUaz+jnh2gm4qgqIVXVs+w4b
         gRV9U/KC51e95U4nUDr3sc4vqiPUJexMJV1WqUDucxrSa2J1epx7UzW6Tk52GJ8GQWjE
         MbRG9p+QvVC1K6lKmUkgTb5neu6ps/rlMKjWl9cw47HY7CYh0dNo76wvunZqQ9DabYi9
         zOqc9PR+4VEz4pTNhcBZRrWDZhZi0aymXPwlw7+FPs2maSvN9MSSWHFCTofe+RL9NGWL
         WXIdPD8HgSTRUuJ0xtLFTuLa10Q2dWfpX0ZDbcG3CepN/5N3PoUywDL3HrFDzyF8uVy6
         fDnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4+/U9NObDc/pGUhvtOeQXfza3vgwPI0CVT8bAVv9RRvfaDkGn8w4GkoP2uUw4BnyaecGjey8rtIjg@lists.infradead.org
X-Gm-Message-State: AOJu0YzZxHPeVIUQF65b569Ibr4y7IKDIDVQAucj5bpZO0/N+CS/hhee
	f+HP1CoREZcpK+u1V3bYxg7IpLXE+G8jk5JfS1/Gn1KN5NgmCxK6TCKW
X-Gm-Gg: AZuq6aI2+ZJzko7aTbm3CxW1DQmW8WaqGcESwnj/I/gC/HoYPY2/9SVaGETu4X3C0D0
	k1pyA6NoLYWLtNMYPcVt1tOL9tk67MZ1A+pCqM/bC4xc9LleMNPKPP5cvYeaPMlZodbldsJgY7G
	hX9H0vj7BUmPqkCmukXQo2NLRl/6wgN1pCTxw+m1CJ2aBWAFxUS9BKImv3nfyJP6RgdnI2WwnHs
	hX38l/12DVqUWWzWlAKLHzMpG3+wMVAsgrDuep4Ce3YksnZbJtQKZOPbTNJym37EWre3Hf6bJQQ
	n3fHXEowMdiLStS6O88KSf0VWlfaY6TzQ9pIeE0iH7rDRoimqsKnYcCDjJIOWvA+3mKdS9BlSvc
	xKdppUjDz2S23r8Qh+3mEIpgZrYK+sTghpLgt1ksMq/sAvYnjjLOwetMX3QfC5thM1BrWM3QY9a
	DICF6U4nmZEHfFbw4ygHkyHGZG37Gi4dc0UPSRsmTCKHlbyztyOkvwsw==
X-Received: by 2002:a05:600c:46d0:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-48320212c49mr81558005e9.19.1770470912482;
        Sat, 07 Feb 2026 05:28:32 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206b8ebbsm174458685e9.1.2026.02.07.05.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 05:28:32 -0800 (PST)
Message-ID: <172079af-d1c6-4f27-8fff-43ff2c7043c9@grimberg.me>
Date: Sat, 7 Feb 2026 15:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/7] nvme: export command retry count via sysfs
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, hare@suse.de,
 dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260205124810.682559-1-nilay@linux.ibm.com>
 <20260205124810.682559-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260205124810.682559-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_052835_366115_6F04060B 
X-CRM114-Status: GOOD (  11.26  )
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



On 05/02/2026 14:48, Nilay Shroff wrote:
> When Advanced Command Retry Enable (ACRE) is configured, a controller
> may interrupt command execution and return a completion status
> indicating command interrupted with the DNR bit cleared. In this case,
> the driver retries the command based on the Command Retry Delay (CRD)
> value provided in the completion status.
>
> Currently, these command retries are handled entirely within the NVMe
> driver and are not visible to userspace. As a result, there is no
> observability into retry behavior, which can be a useful diagnostic
> signal.
>
> Expose the command retries count through sysfs to provide visibility
> into retry activity. This information can help identify controller-side
> congestion under load and enables comparison across paths in multipath
> setups (for example, detecting cases where one path experiences
> significantly more retries than another under identical workloads).
>
> This exported metric is intended for diagnostics and monitoring tools
> such as nvme-top, and does not change command retry behavior.

This is designed to show an accumulated value of how much retries were
done on a namespace since boot? I'm wandering if this does not belong in
debugfs?

