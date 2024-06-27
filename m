Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EA0C2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 18:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QlxmnszsaSQ4qJCFcqsLiE5hBNHHurOxzY8wO4JdUo4=; b=DmkMdbOvnX/F4KM0YAlFtc86+c
	jhL8Ih+CwO69WFFbY6czmIEghvf9GM8CMvMEMZYuoqks/BsRhcftlmdWx3XP2GmCaaQZ/nBX12RXQ
	cKwZ5FYKyZA+gDl8P+43Q04Q7D3cNVcBq06UngYcBbl2RFMQd2ZIgteoM1Ct6+iWmxHdJC+JeDce+
	iDim9tfrPUZYbr9jUVK2Z8JfBc6K2suhUWlX+DtrByHw6yWzp32uFSXuP9XpCeDkgRMZUChP42S6i
	pIC4EOtle/k+xocyltPUWj+FP6101jQan3eNvrQVldwKxQ8qkJ8E8fxyS5xoKbc1h/1vzlhYEEf1c
	npdzTvMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMtex-0000000BMdG-25vF;
	Thu, 27 Jun 2024 18:15:51 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMteu-0000000BMcf-0IXR
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 18:15:49 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1faa9d5d25fso1260065ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 27 Jun 2024 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719512147; x=1720116947; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlxmnszsaSQ4qJCFcqsLiE5hBNHHurOxzY8wO4JdUo4=;
        b=iff5yzY88llMFGvm5aIdysuxHsKOg7wchpT8PohSiH2+WQQyLoPNpGab34bD50CtAK
         AA0pE097spMXxIG+gBVPTNH364y5U6fdRoWlGMc5QIERhlXxaLg/uymngFUkdd2e3gVq
         jnznQi6tnCLMai2p41G6FTL8g6vppWxJ1hEk6p/jBksqPCYPwL1vTufEzzOp9pXch6UH
         slofj+UsbBQBossTs0gLFjSGCP1EjI4in6v6cVRgL4OzHD7ty9HbZKTVMu42NYt+OAWV
         chPfaGS7YVJlA9KhgTpAD2V9VuDgc40PQ9ZS2CV8Yfo2lQtA/3EOZFyQ53ZE8FB/XmnO
         NgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719512147; x=1720116947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlxmnszsaSQ4qJCFcqsLiE5hBNHHurOxzY8wO4JdUo4=;
        b=ZrA0hcBg/Wac9i/rmfKxvY0RrPY3tOlEbpBfHKaSOej1eCk7ZEcjjeTi1b19+B+3sS
         eqOJjf6lL15NUUbsaSPg2dT1PuL6cUT11csciaPNkv8Jq+wTTFS7OT8lWYbMJucL9T7J
         cL/5egCA0h8myivQlDsZgb97UIyCRCN7+tqMbXvLIU3SShQTyB30t+SsyopvUN1892rM
         1rGriyhSgqDmsq636OVxP2egE9HSc2vrmmw+XB52d61VSZ4oNCRyDn8GAT0pmqbJIdDj
         H7rQ+eNYvB4+lm/QH3LtPcCI9Z95dAFZzgkKmXTIheh8ipxyKc2TC/2PCCFp4cL44W+S
         hwKg==
X-Gm-Message-State: AOJu0YxGPxwihppvIcgZpC4cU2xZIFbzhYW3rqOBK9JNa5vQi/Pr/IVw
	5qkNfbo5d32po8C9w1oMGe/nO6NqZLSfe8qCiLGQ1sb7nbtsLOZoY2ext0zjClw=
X-Google-Smtp-Source: AGHT+IE/F97uFjBU3Wts4KR6zBBe4s4+ZBpF2GC1MeDRg3tI7HGrRdwXRSrThQZpmfufJgw/5HAITQ==
X-Received: by 2002:a17:902:e54e:b0:1f7:2b3:3331 with SMTP id d9443c01a7336-1fa0d81773emr177962355ad.4.1719512146794;
        Thu, 27 Jun 2024 11:15:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15388fdsm506625ad.127.2024.06.27.11.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 11:15:46 -0700 (PDT)
Message-ID: <29ff079a-f61e-42f7-8521-a56c35eb1bcd@kernel.dk>
Date: Thu, 27 Jun 2024 12:15:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.10
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <Zn2pgbTvj8TYr_W5@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zn2pgbTvj8TYr_W5@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_111548_148487_D5583650 
X-CRM114-Status: UNSURE (   9.53  )
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

On 6/27/24 12:03 PM, Keith Busch wrote:
> The following changes since commit 5f75e081ab5cbfbe7aca2112a802e69576ee9778:
> 
>   loop: Disable fallocate() zero and discard if not supported (2024-06-14 06:21:25 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.10-2024-06-27
> 
> for you to fetch changes up to 440e2051c577896275c0e0513ec26964e04c7810:
> 
>   nvmet-fc: Remove __counted_by from nvmet_fc_tgt_queue.fod[] (2024-06-26 10:13:04 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.10
> 
>  - Fabrics fixes (Hannes)
>  - Missing module description (Jeff)
>  - Clang warning fix (Nathan)

Pulled, thanks.

-- 
Jens Axboe



