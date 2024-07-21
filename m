Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83900C3DA61
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Ae4tloAMoTEXCRXPUuNZ/WEcgY
	djABsK4qxHn/0VPnU2hVP8xYHXoYRecBV1pf2OYM/ud7fldhkvnApwoxnCBZZtxdlF4ezG4oRV2V3
	09uYfZv9YtMkViCbx9RiaHWxVFQMW+A00Ciy0luazkng0lb0kdXZ3sntjMHPbtqmKzJazYWyPic3Z
	6IKa7ZiRIxLAUNzIbhM24zRnitt4tNQD2anf21BmPi6lh3y9uRO4KqhWVYWn6UtFe/USmV9kMXKNI
	+EE70yFqYCcVrHK9YcK4HW++Ox6NniIwdry4Lscxhjdq+ikj5FktXM4LMdqv115jagnzm4jPfIMoh
	OdRrDfxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUXR-00000006hsJ-3kbL;
	Sun, 21 Jul 2024 11:15:37 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUXP-00000006hrp-36TZ
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 11:15:37 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-426659ff58bso3579425e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jul 2024 04:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721560534; x=1722165334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=j+cUCprhQpVe3nMT1YLJKA5BpcElf5X5labF6XzFVvKhrDWpMY/vi2qDoT1EqkVjgK
         PdfJl7YveZgwu7s0I4BZCP3xwpYUsredz18B1Tnl1ANK4eGELiKOzFkctz6tOy+1qk0Y
         6borKHm19qBkaTIn4EGhbo2ICSj19pCe1g8LuBFvOzJKWYp82QNuB3v6F2Eekq6G/UHR
         pivTb4mn+ktKQYkCCFsrZXkRmd0Za7QOTk4iyPQSwBye2k9AEZbHLfmAALwZU9xU/nQi
         g90Vi9di06TsYG2XzfLxC8u//wpJjoipnPxefD+uoj9txfGZl1ZwNFiI7qqdUlPbBwf7
         K1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlViOrXb8o5zcIeiKvUhUIIyx6vLDfWj//VOMivFRio0RjzTTJn8QLFAQ1yq2EpLIqUvfyDoepp2BwcG2nesMswa6zj6GhNDJaenTZd9o=
X-Gm-Message-State: AOJu0YyTYgc9w2Kbd27Vce+/2H1Bih6R6jlG2E5Bs9KLR5IL7eEbsNQg
	00P8FdC80epk+3x3svcU8nGIB0HKzorF84Lwpwl+ti00CO65NSV2
X-Google-Smtp-Source: AGHT+IE6pD6JBKlVueRuuKlyudJBFdS3cwDziRInxNb9/ihPTLKNFyeLFb11Y3jb/gJpd335fncgrA==
X-Received: by 2002:a05:600c:4f4b:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427daa927f5mr19860025e9.5.1721560534058;
        Sun, 21 Jul 2024 04:15:34 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d68fa394sm86739535e9.3.2024.07.21.04.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:15:33 -0700 (PDT)
Message-ID: <d9c3cb24-1c67-43d6-889c-fc3fb8dd20b1@grimberg.me>
Date: Sun, 21 Jul 2024 14:15:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] nvme: split off TLS sysfs attributes into a separate
 group
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240719083901.35399-1-hare@kernel.org>
 <20240719083901.35399-6-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240719083901.35399-6-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_041535_800962_AD77F784 
X-CRM114-Status: UNSURE (   4.76  )
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

