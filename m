Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87782C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 10:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=OTAbC09tuePYvmE4lWjvcO8G2C
	sCV7zGo0wVmqCnBja7uMxln+/DxuGob5/y4gcgHK+fDcdMTsDcs7lURiUoOdV0zvvy+2xT8ZG1cue
	OXrmjGQgiJn3SsvFsvLdWRASDY+/QdAItqx/eciVgDF9KCdeY7R7OfVpXLHrWU4Y44AKi1bru1j9D
	s2XM2xn+icBfW5aA0QEAJwpG7IntswFM3rgDTjvJPoFiWqgQLmm3jj252jO5FRh3P6lEG/FAf4hh/
	MN6AYtzo3Pvt7Sd9jMBIUnOjQ8cqqK3Mjr9m8qBVZ6B0f0KBRwFugWqSq6oGrukQ36bPScQ3Mz9hz
	Pyz8vtJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OWZ-00AATZ-Jf; Sun, 25 Dec 2022 10:46:35 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9NYh-009d9n-79
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 09:44:45 +0000
Received: by mail-wm1-f53.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so3330043wmb.2
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 01:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=p1M7ijiL7HyMTJsyJ5of9QCa6O7BDCbEnkFO7TrweUZ8pf4552iopmBqDlZ6Eu2zSS
         g4Ro3dzOYvU6nn7/7bNijEplDwMAH+yThEqjjpqOrVT/2z+3Muykxv2gxPIqvar6vBfg
         LRuqX/JadcNaDAYU3z3u4OrcnoAlqEvlrR7kbnyPbesW295bbVbiAchdaa/C1kv3iyvC
         UZOq1UT2wZCoCh1Y5Pl/DUsGwWOVcCODjSrV53Zl9QmBOgwcjP8hIDCCJAJTt3sEEZIA
         ZDCuQtod2Az2d6sJa50U0rqG91hUQG6gfPVG4JPiixUguArpvHt/wiWg5d3rOrJX7yL4
         XN/w==
X-Gm-Message-State: AFqh2kojn1YeVhGzLDA4+GI7FNic2a4mRS/o9V081wGmAU5yfwEvPjxA
	F29czRXQaNYiAvRkdutZOuo=
X-Google-Smtp-Source: AMrXdXvDGGaFPFPUIKD+18mU3s/eA6YmE1yjO+xa95fjzBhJUobEoTD8ocJ6ql5TSwIUjUKTWn223g==
X-Received: by 2002:a05:600c:54ef:b0:3d0:5254:8a43 with SMTP id jb15-20020a05600c54ef00b003d052548a43mr13021957wmb.38.1671961481413;
        Sun, 25 Dec 2022 01:44:41 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm10341065wmb.38.2022.12.25.01.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 01:44:41 -0800 (PST)
Message-ID: <95bdf3ca-b948-cef3-1d31-07b5c5715b2f@grimberg.me>
Date: Sun, 25 Dec 2022 11:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] nvme-pci: use mapped entries for sgl decision
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20221219215457.711617-1-kbusch@meta.com>
 <20221219215457.711617-3-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221219215457.711617-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_014443_307404_4A91B22C 
X-CRM114-Status: UNSURE (   5.24  )
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

