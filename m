Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9810D111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=w0M4xRPhxUue1+uUDTYBvVFAls
	lsQ0gaijo8oj8Qjj4Uah/VnIEqfDBl3fEZcXB51jItPCm+iGeBAVuTJnhiJN436JK5l5A+x4sw2zF
	LUjZYzTKe60uPWETBnKnKN0nsh7xdtYR91h7loePRKefpFhrF0wWxA7YoQs58eEpTyAPOCqFSYYJk
	yqstokvJLmjO9aYZQ/WWf5coIEKcZcY3ZOIHOr1QssU2Gt1wMH9HYRnJ9KYryHbWyZDnGJ5tm1LIy
	8FZyJZbPdzQcx2HQ5ZcWTxXSXlWP1WM3Jy6A3s7IR0eixCpOowcVkJAdvvE3RdpSnmoF51hkVqyYi
	VSCze/aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqeJ-00000002fUP-1Rdw;
	Sun, 30 Nov 2025 23:16:11 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqeF-00000002fTy-1pUt
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 23:16:08 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so24521045e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 15:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764544565; x=1765149365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=EPk4P3gjXxuhtBXZ057FJDPMtOvfZEmMJgGuBKCxDmzCCNV4AJeMsLinfuZn9GL/ud
         h1bgIE+AKMC6xooF83BWwlZn20m4o64reBNM1hKbGTNWnymcsoy+TPsM7hOBm0cKm8lg
         mKg25lfBdQB8w3SYVKHRSVBSs3FkhqpjLbIgCe8pRHAUSvyq1mOlHMeSmQO+UPixQcm4
         iN+RZjVBIsQycAiStNdUrB+fyQ5MnaE8DuhzTMnvO3mqQD5dGNBzWPehZBSD8xy7LfHO
         lhOlmt2HTazXV+3RkfKu4lMABUhI0Uakx+5j39UeNMCIwCMKCoSyKsYV5wYHVyLeaEQ+
         Dw+g==
X-Forwarded-Encrypted: i=1; AJvYcCXraUkIEgqo6CBsjQtemnmR5e8qtIKmvZ6YwmzZUhB3fgStXp9xlkYR6PCUicYAsjt078CCy+CuFSI6@lists.infradead.org
X-Gm-Message-State: AOJu0YznSBcviNqYisCo8H+eVoP9TdJqCKzmXyH7yMkU6JE+nQTbOCpV
	3y1Je2sqeypc0J/h2yd5hM8CgUxN4HqZ8+Pjh8rZ8AwYr9sFvw/zUhMzJfcDsA==
X-Gm-Gg: ASbGncsTvtUEhf7CpuU0HozEZYa0vzakMBXSNatsr3NxWsjn9+DvuxXtuiIQhW72ttO
	hDXvRjo0rkIkoPvwXUUJMcYvPGvSpXmVT4TS/Ppv/9AzJfzodNdNhG3wM0b7uklxuK9eK/qiqDM
	bUtgX4+PGep69S0ddGLHo4Tox9Fu+EP2azsR9Tlr5bMbScAZ/N7H0o1QqLK4KZWDbBnQ/+4KUFR
	BfK9esb101efYlbeAjNitqHnXCIGSthNzMKyjAzIIxRO1zXbfth87V3F/3XSJYBii01ppRxtcLg
	QqugiiwQ0ivKadU49+OHzxqj93T7P7S3OvlLu6Fj86D+7JfiZ+iB6N30ird+O0QHOLFe+MNjdaE
	kJ4Z748fpvtyU9JVcL+kg3K5P0rxoHDUHjoxNaw0zpTuSq0h6p+HmJkgQzDMo/g0eNgD593YYRm
	kjrnRoY71qHhmecJmO/Pu0qa14L3dSF7fX3QZ1XfsD
X-Google-Smtp-Source: AGHT+IG9cbs1sN2bncPmkRtu6aLun7B80zr0T5ms0PyGDJOH31983/W8pFKPwCYOTHy3IW9fjtiA/A==
X-Received: by 2002:a05:600c:1d2a:b0:477:7658:572a with SMTP id 5b1f17b1804b1-47904b10347mr229648805e9.20.1764544565464;
        Sun, 30 Nov 2025 15:16:05 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052cfd9dsm143078265e9.7.2025.11.30.15.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 15:16:05 -0800 (PST)
Message-ID: <069ae376-4ec6-4fb4-b5e0-ddcc1e6493c5@grimberg.me>
Date: Mon, 1 Dec 2025 01:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix admin request_queue lifetime
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, ming.lei@redhat.com, chaitanyak@nvidia.com,
 Keith Busch <kbusch@kernel.org>, Casey Chen <cachen@purestorage.com>
References: <20251104225939.3641605-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251104225939.3641605-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_151607_581000_3D038EDE 
X-CRM114-Status: UNSURE (   4.63  )
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

