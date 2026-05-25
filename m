Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC8ECD5BB1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UkcDIh6lSzwJOlp8E1YoKOARe+/1ST0S3JizOOYpoio=; b=X6VnJrDwYd5gsIyTew/fg6SG9Y
	yE21tzL6Yb8s5Yaz5vUt9cDI5iWRq09LnNBld5w19Nh7qbXWPeK70bnpuQldB6V2yQ4bcZJsP23Jt
	hkcun/FPsPDlorAZiohJ32c/+2nnZQ8qcrm4G5VNd4BlQ8CDBtQQIYFgKLIiKTpVOGiNTMCSJ43/j
	uU70t/r7+qBrzkOF7nIMNl639ixfxhB9/nZNrDlGysVC1s96PfGPJ45+xzxpuFdHhZFlMLvu9ynqA
	v2BkShQPhVJT6XQb/UAopI94BUnzb05G5bK6FdDpRXe8XtelovQsPNQYxhQY2Bq2LeiX8gyoaD57q
	5T71xbDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYUo-000000003rl-27wk;
	Mon, 25 May 2026 16:49:42 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYUl-000000003rF-42eX
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 16:49:41 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-83ec36a13e9so4738191b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 25 May 2026 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779727779; x=1780332579; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkcDIh6lSzwJOlp8E1YoKOARe+/1ST0S3JizOOYpoio=;
        b=d10qO255rT613L8AfIkrLYIPp6aeoxP7WEUxvAHvx/F7ZLtN+uLq9yNI2aVhwVm3Io
         SAWQufjWQtXcCBscztNJ9pDV8kmBsch0m8vW3f2VYX1sS5sQHAf0gXdSHiPNtwFsrpil
         ikVPgBE62F29guy1hF5pdZZQk1g9xtpza1IYzE5t6eucKggJbuH9XI4BnAE7cy8aFulG
         vKIwBBI/WkzRlP88QWC2rjZtyzkhQwn0XkxfwNoT7Q3k8MUaiIQ8z5xJxg1uyD4ItGWD
         PDv/C59B4Pl534edi4PRLufHLHBWyoNDfcMlO2pBODMaIQXe0iYe/p3mh28xYtOy6vUM
         4DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779727779; x=1780332579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkcDIh6lSzwJOlp8E1YoKOARe+/1ST0S3JizOOYpoio=;
        b=KwAQVDC7tt6Wqa2vi9VMtACRYZmqPRMfXFJX6MpCYMr/NqRpqZLYNNKT1U9+M4Av1C
         PwCVZ+aQmHbt55fhcngzCk9jm5gfbo0d8OAveV8mo3I2Gl8CFyuS7wb3i/meDExAVL/B
         9gZgAZtPr2wH7hua9sdc4iKVXvxXAwIrqMI6fq25GPUaKwpo9h7ODV3fn7mp8oY/M9Kw
         hL4X7WAgTpK4gDvyeiAvZVUNimtO7raIEmt0KPh9kInjghAtEWKYp9wie4UgFMYW0AO3
         77f+7J4nUyzwUVPJbTPHBz76seLu4ORpCcxNKBJmlqKYzonWaGKXTfu82jk/8kc7kIVH
         v4+w==
X-Forwarded-Encrypted: i=1; AFNElJ9yUbwJcMLHf0sC4znsE0Ap/XpmJTM0whVVb2Ke6wPUDnPJ4PNJd05baiJhQzil0ttw05CBK+wl1n6F@lists.infradead.org
X-Gm-Message-State: AOJu0YxrWtdss8iSuoAlgtP9u4PbZz3nTO4Rlm1iyib1Xg2h9BGUH95P
	gNAJjsFekh7sjGRo9qITirDztE5PD1CMCaBPXnHGZ16avypovKfR7NMJv25LqQdkEZM=
X-Gm-Gg: Acq92OEMTCjy5AoQ2h2R5ky5NubhYnljrUgPperPkqyHXieFMH+c2vUHr+AJL6BU/mL
	QhDV3llem02tqDH1BXodo5PglzpCmqPuD2/GasMuUAdEWW+GAC4KdAT6zG4QmUQWAbc59vCsN8y
	y4Ke4obN8CfIKhYmPSasm4SdbunkAXJRxEGU3+TECZi03XZ30SAeEXgpgw0/edbv1fYE3ybORDg
	dZJAwrcnDSqIIASNAVFVhmHJkTsja73M8l/9xoseulb9NMsG4CSeKyBlZltiLnsbcS23EgQX8DP
	E9juhvmCHJG/Ii3vf4/3nE4jiLLZcOFa+qKB9YuaXlSiEUB8Smfb/3buAZ/LEXiud61ZSbzD37L
	DXKuJwuSES8hPBS3delGXL21sJCBbarTLTlmdB+6CfvwQBypYgB2k5waTSFfy8K44npozTJ0D9A
	WxUPu61rLfxvQl6t47ZVjNas5d2UAEjWe/zm5mpIQwRuCGad6hE7btBG9jn4NG7raz3f9DFHQif
	E8+4dI=
X-Received: by 2002:a05:6a00:8c10:b0:81f:9b4c:81c0 with SMTP id d2e1a72fcca58-8415f58d727mr13761843b3a.41.1779727778848;
        Mon, 25 May 2026 09:49:38 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:34c9:7e9c:7c33:58d6? ([240b:10:2720:5500:34c9:7e9c:7c33:58d6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841648a2bf2sm9129616b3a.0.2026.05.25.09.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 09:49:38 -0700 (PDT)
Message-ID: <f71e9ae5-921c-4f5b-bb5d-66729396b8fa@gmail.com>
Date: Tue, 26 May 2026 01:49:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: reject passthrough of driver-managed Set
 Features
To: Keith Busch <kbusch@kernel.org>
Cc: Chao Shi <coshi036@gmail.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Jens Axboe <axboe@kernel.dk>, Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
 Maurizio Lombardi <mlombard@arkamax.eu>, linux-kernel@vger.kernel.org,
 Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
 Weidong Zhu <weizhu@fiu.edu>
References: <20260523225629.3964037-1-coshi036@gmail.com>
 <cda74a96-cff1-402a-bcdb-745c85f6c87b@gmail.com>
 <ahRvhmaMCCqnxV62@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <ahRvhmaMCCqnxV62@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_094940_004456_CCF98C0A 
X-CRM114-Status: GOOD (  12.63  )
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

On 2026/05/26 0:49, Keith Busch wrote:
> On Tue, May 26, 2026 at 12:34:03AM +0900, Tokunori Ikegami wrote:
>>> +static bool nvme_cmd_allowed(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>> +			     struct nvme_command *c, unsigned int flags,
>>> +			     bool open_for_write)
>> The struct nvme_ns does already have the struct nvme_ctrl *ctrl as a member
>> variable as below so seems not necessary to add the function argument struct
>> nvme_ctrl *ctrl.
> This filter is for admin commands, so the 'ns' parameter is NULL for
> this case.
Okay so how about that to use the function argument unsigned int flags 
instead with adding the NVME_IOCTL_FABRICS enum definition?
enum {
     NVME_IOCTL_VEC        = (1 << 0),
     NVME_IOCTL_PARTITION    = (1 << 1),
};
Note: I mean as possible as we can it seems better to avoid the many 
function arguments for the maintainability.
Thank you.

