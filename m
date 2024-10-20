Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FA6D3C92D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 22:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=rAmjEKQy2EppUhmW9jj1QhE9lC
	o7SNnToaFj/Ws7Rw0Gu+li4E3c9ownDY8AbN7Atkrd8+Zos16kl7/6KFQ0+4ncXD6+5Ld3T3qdYFc
	6iyTcVHQkqhTp75oNZFlKucxvp3KXsFcOEM+ddEAN1QJspB+OnZlYN2A0xoRBk79fh4x4H/gVKYXM
	YzoN4CAIYmjZ9vwasWgdkzaIWQw8ZwJ3aYS4Rhh9IYoNh1vHw6bpq7mYLcDBPZTPBYwpISk0szXXY
	m2l+ikp9dqIyU1eUYngIBsrpGOIbPup3H9tmnsXbYiBCC45pv94ARD8Rr1J1L8K+hd+LiuKT9rPRU
	J+TuRZ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2eXe-00000005Z1O-0ku9;
	Sun, 20 Oct 2024 22:36:54 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2eXb-00000005Z0p-12we
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 22:36:53 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431695fa98bso12934435e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 15:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729463809; x=1730068609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=sSM1Xlf8p3CkZ/oSeNO/009Bv3UMHqwUGcVB8cPcB/+Xy1y/oWHk6SCQb8U/Om58+H
         Q3lLgqZa/WaIkuuZJBYRHT3BN/HSg29Ui6YBK9XRiUOO3CeCoXU6q+prrS3W484PkjBy
         D59g9S0m6SIq4/G9uwBqaJm4dWTtnDFvEdq5qrwBbdgwAMX2023Z6qnzTEvXAh9hx8yz
         gdv90/4AD6q0QI3HcogbR96IP9fJUv4tGz481FTeL5H4so3VUClFUD7FmiVLIeI2P4Zs
         RLcIHWtvqG4tDEnxOXVaqEvTO6DzFlJsUtnPItbgqQ90bajWHe8GcOk95JBIrP/i90vK
         YPHg==
X-Gm-Message-State: AOJu0YyVlOv8StOe3Q1DovXn9aq11Oh+H9zyvOKiNs1FPOI2yPjUXfGl
	ufhV7RyfXut0yEV/cnxqaMYhOyyKlLJWw6oRhZctoLH7ig1q8RJS
X-Google-Smtp-Source: AGHT+IG3nu2w3AXZYaGr4Ii0oLwNF2kpEGvXfxo46C0UisGc7os7J/2isMmsJKv8Xg/kFoHblSL+xw==
X-Received: by 2002:a05:600c:444f:b0:431:12d0:746b with SMTP id 5b1f17b1804b1-43161693937mr54706975e9.35.1729463809326;
        Sun, 20 Oct 2024 15:36:49 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58bc6esm36837775e9.24.2024.10.20.15.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 15:36:48 -0700 (PDT)
Message-ID: <3713644a-b67a-4406-8350-ceb6038b1653@grimberg.me>
Date: Mon, 21 Oct 2024 01:36:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 1/2] nvme: add reservation command's defines
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
 shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com
Cc: linux-nvme@lists.infradead.org
References: <20241017044809.122021-1-kanie@linux.alibaba.com>
 <20241017044809.122021-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241017044809.122021-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_153651_297573_3A689A9D 
X-CRM114-Status: UNSURE (   3.92  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

