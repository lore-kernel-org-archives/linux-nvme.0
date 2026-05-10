Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE28CD3427
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2b4zVYWoPtHOY6MB9o8fE8FtytyyrBHXK9bnumgg+Oo=; b=KaE3IH809oJs9/N/WFegc3wAS1
	qKFFE2p9yZJpxZFHf8XSBDo+Vyil9V5LXf7oLtWQYrhUM+YpS6SVXNX/gn8nKe8yhpER2H3mT+9i8
	is0MpoKRb25IGkRucuxumhVNAL5zIUDhhbYZ+0wkkf2lT/eOMY1mzuCPqlICfNTmh0i+u0JUOeV11
	9FcpJDzI4XcKXLXhk9fqsQnRSjVgJO7OpnRpn5JKcAYDJYOSCgmzGmkbCXq4RwUmU3dLFaNaa7iln
	0rT+zoRNc/0WZN818t9jUS2HRV2Rem7jpoigCLynlSQWyf2of26U3c0MNg3zPi5DQZ+SuzwPmdk7V
	8PVKx41A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCoa-0000000Bm68-0hWZ;
	Sun, 10 May 2026 22:40:00 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCoX-0000000Bm5l-3pa2
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:39:59 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-449de065cb3so3426407f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778452796; x=1779057596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2b4zVYWoPtHOY6MB9o8fE8FtytyyrBHXK9bnumgg+Oo=;
        b=BvJRRTqQk3TlVovUCu3ombBXoQ4x2XGyUNUXwAbeBas+JYowuN3net3Lzt21xCbEqm
         W+FJdpHeXdVUFejNyIR7vlaxfBRh6+L6HClO1J9Bw6qQMc3vIh8PxY6Hbi9zbJMyuUu/
         rQvyWe+VOQ20rVzsCP/8ZC5aYpgUZj1OWE0ZYXgjgSkjldTOM78Nb6AQHQguVUXeEB/c
         x7xTz/G1t0msvGYNlsRjxPy4f1UGzGWaNvNCCMUYeXLV8LnirOSGKE7HU41zPKJMi6qe
         9uS39gxNnQXQ0ZO74lRfcUEWIwCPikt0SqRCVVs1zIWxA4TK4LVEhYM/IECJWTnKKAsF
         Jmiw==
X-Forwarded-Encrypted: i=1; AFNElJ+gRw3PJF94lUUifck4BVe8l8pkeLuEi9M5l3L8kwtxd6C4/+zM5wMtAthF0FBR9F7y8g8p3mRtOlyU@lists.infradead.org
X-Gm-Message-State: AOJu0Yyo6C16zFJDpVXeBit0tmBEPRTzMM0DCJehFnvvQcEOYGPlZCvL
	IdWQ2Hco6Usbp4+H2GFx7g/eEoWyyBw/RBIxNg2VJbMjzM4ik+2H3t9e
X-Gm-Gg: Acq92OF+xD2ZlY4obAo/yhAnl5BomiHguBdy0v+u6sxoPvsYTzrJ4I9aQyJFkeJ4nww
	gkzrdNmLlTPiy+JFWIZCSeo/VvmOD3/tg93ZrUU5DdqnRLxmA5L5zhgweaOw10im8lrShz0rgt7
	PMhZkK/1s2immzcsdY5uLdx0TtxlLpUtdBbtbgR5l0NeutjvvZXDUy6Nlgv6Gu8YZ5lNbHfWU46
	WkN5wVRi+zyzurUJVgJ6DonlkYuSErUOgvdnPqFIhQCnfu9KvkB9zxS2qKrjvSrmT91qQA9McgU
	PeOmgBVf1A2zMz0sOcXwLXBxk0tGbpJxET02YS2glFIUOT4TjhmEsciAPKcZxXzUGIYVQ7jQOUR
	TJv8nKP3RdBP4uAEmgQ265Cp/QherQ3HH1k4j6z+JgvYFp8GwsXMTCrF5HKKCfYOpb3JIOzv8cA
	jCIJLqN9xubKVGFccq5pwEKy4JqIvbILtRpHlWuaod
X-Received: by 2002:a05:6000:26c2:b0:43f:e272:edff with SMTP id ffacd0b85a97d-4515b056ce8mr35212092f8f.4.1778452796133;
        Sun, 10 May 2026 15:39:56 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491da03a7sm21253894f8f.33.2026.05.10.15.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:39:55 -0700 (PDT)
Message-ID: <63cf777c-2b40-439c-842d-33477f7602ec@grimberg.me>
Date: Mon, 11 May 2026 01:39:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] NOT FOR MERGE nvmet code to exercise CCR/CQT
To: Randy Jennings <randyj@purestorage.com>,
 lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
Cc: cleech@redhat.com, mkhalfella@purestorage.com
References: <20260430232913.129271-1-randyj@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260430232913.129271-1-randyj@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_153958_011414_4BB4F633 
X-CRM114-Status: UNSURE (   4.13  )
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

Was another round of this patch set submitted randy?

