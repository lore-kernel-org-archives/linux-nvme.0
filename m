Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC17EC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=g7E11CcX62JOpiF3+q3ahy5oq+
	PGYFBFqCGOWgcnOFm/wZ1EK9S1bGwABuRvMgxzkLui3H/rvIL3OsgFKM07qgnAWODunMmRyCfTPdo
	xdXGmkKLkGiy62l3Bk0Q5oZU5h+ivbGgAuEzcYcFE7fEJ3nKnMkCk3eKPD8RtQrUUx/Np1CglxAw1
	ucbwv2DUY+1hIC6J+3p1RsUa0GCgKWpI9yv/binpWvdw/uXwsnmOgDl5oLwhnPX5BMwbo2K97/Abd
	h/XYdXR3qr0loTJl+0A27SLyshVqrdCiIK9b9fWj966GwhRLInerwKKpNO63equUQe7HMLprcH8tQ
	hHBjmcTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OWN-00AAQ1-V8; Sun, 25 Dec 2022 10:46:24 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9NSj-009ZtQ-3N
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 09:38:41 +0000
Received: by mail-wm1-f47.google.com with SMTP id h12so4879088wmq.0
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 01:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=F1l12/FszJJfBkNAKY23jbmWfPrxDQOIiurKHtaQ+iR0fuS/iB2//hSHt3CLezvqAs
         6P+IsnerahnnCL2hu8JCQodATd2KGcd2Pu9a4dOBy0KJ1Iw5g9w0p4qAtK5QEc4RjEFN
         gh6u8gxrUpggu4MbnrsqwYaf/EQm2lodk9pFZegKPN57eDI0YH8wOvkthtOOUT4xPyz4
         x+TQgb0qWL/wWxt9DXmRBgmo+ZsKkWALECe+Kdmpc7ddQnO2+mhQuIDRyCd/BMaOYPlB
         +oIf+4eIcfXwRCde8NUHQycmpeKUUK5xqWUzby/yLO/2FnmBomb0sVNu/9i19vicg/Jn
         qkhw==
X-Gm-Message-State: AFqh2kq3vkvERlJpebWp0fTNnCwDlvjVTGV/WRfkDN1HccDH9QHMIq5G
	CT3tIO21WtVIWC5TD0W3+NdZbwPX0qk=
X-Google-Smtp-Source: AMrXdXsykurSa/8WPu+DVbVuYqB3jEpR40pSRaxkJxqXPfBmvhgXmvmcFAGZRpOq7EdwjvzutIsIXQ==
X-Received: by 2002:a05:600c:1c20:b0:3d2:2f48:9443 with SMTP id j32-20020a05600c1c2000b003d22f489443mr10725383wms.15.1671961111179;
        Sun, 25 Dec 2022 01:38:31 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c210800b003b3307fb98fsm10015331wml.24.2022.12.25.01.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 01:38:30 -0800 (PST)
Message-ID: <f9706052-f07c-3e10-1cf3-0f9cff724be5@grimberg.me>
Date: Sun, 25 Dec 2022 11:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] nvme-pci: Fix page size checks
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20221219215457.711617-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221219215457.711617-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_013833_239803_CBDAF444 
X-CRM114-Status: UNSURE (   5.01  )
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

