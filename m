Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8290CEACF9
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Nov 2025 00:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eAID62moHicGe2k4UKZIbBCzCB4bxWM/huwTLEBy+XU=; b=x6/xRhQgCO5XMCtD/Wsm8Nc1mj
	yXQKmW6boEV1lJiSNbVBpbjXEKOdA0y5oVpdMrQlMDO7PZ000ByBuxkActzr94go8nQBtUSlLu+iL
	byktNU30JvVKAY9RzLvjUnWfkCRxW08DV8Rlf0EKib1JWSZhdIn30QZeQBPNhYTcnSvPNvqQY0e0j
	w9SLnkOexNfijbhINxYOuP8p8I3shd7PW8oW66F6GjVc+8iXPtF9KoiwLJE3/oIffayt2SnOCWObd
	7Ho4r5+1N24RAafKe8ZXwap6eQlIDeofWQRvO5Hxr4kn63TpL+M48FGGSlG5GX5f9SNDF7G1NzY1X
	DdoZH3+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK4bU-0000000DJGx-09SP;
	Sat, 15 Nov 2025 00:57:24 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK4bR-0000000DJG8-3TwB
	for linux-nvme@lists.infradead.org;
	Sat, 15 Nov 2025 00:57:22 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so2812757b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 14 Nov 2025 16:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763168241; x=1763773041; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAID62moHicGe2k4UKZIbBCzCB4bxWM/huwTLEBy+XU=;
        b=QRYYO7Roz5EIZmEkPk6C90uLZPvoSjQD8zLBfwDVT3IKBeCsEN7WGXqRfMGwI7C8ZL
         SDdPy25bMYHFj63FsjYtTJgI0uYdzZiMbbCX+A8CRC7F0zgSwziAPHV5GmcefiZhvE9r
         GXiro+0wWseTrp3UMA+sQ5MwYDmiPE1hDJSltM7Q/n1FOsiDmHuAnvu9iLSb6FNX1VY7
         Zk0lFy5uwybvEDSSGCrKc7QhUNuzcVzgAuc/JyTn4Ij8bq5wX+rPzRDw6+b8TscXHgU1
         RsMd81l7fYiTHWMLqrIu4sccEwv5+VBttcV7260HMWZesv+Zd83peYTLbWlMB1stPF2e
         2uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763168241; x=1763773041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAID62moHicGe2k4UKZIbBCzCB4bxWM/huwTLEBy+XU=;
        b=da/gqqQfhoqNQ/SF4pEn1nRaXYr+Bb/IpzX8jwE3ZqAUlaMAP7Pc4kYAJ0Yp75n7e3
         NzTAlsDO2FAT0oKh2pfFmXKa9fM94tj+UyrERyoc7FGJFqIVXB2UL8cyzKw6CCHGuCxo
         L2jmTg9VtZBkoa9OTIzJZHGma6o3xMTPS9nzZ8xnIcwZP0iKXSNWYrGCInrkGztdqFwJ
         KoU/g66933YaLFqWoForlEO0JHuVgSgoQ9OrlMB/RHqRghN5vZuHR7cloV3wJYlHG4EA
         nfIf6SYaHcJpXDumOeoemhpL8YkeqqE1o9np1s4Nip4VV7x79ei/H+c02pmzS10lT7jX
         LoqA==
X-Gm-Message-State: AOJu0YyvINsi54/w6nrhcrGYn9KLduljYaSxGYdjhVAZ5eQF3IT3UkYI
	I605/ghNd5eqgNMtc2HAnZqpTt+MvVL6Eg8Lau1CcYqGCAxrXmabI8TN+hMq3w==
X-Gm-Gg: ASbGnctDHaSv7TOtZnQkT3SxhmEMLavyPzIMymuS/uCnLSGGAyXsf4V4i5IVao7Awyd
	to0OD45EpPqDTw0cDf8yzQ0d8gH/44foW/Ww/ugDoED4Kw8dvUqLfz1+E7ULBIyN1Q05VThTQlk
	zRGgTiDnTjPY/Dn3+CngbayM0QJiPxVg2SmTOAaEhwbKBfLQtte/vzWA9pt/82/cgtIECRGgCfK
	It/6gNnkih23Ox4EXO5I9zgqezshlD88XF+a2hIzTORwTR7rpe/FTK1ri1BAyslfGjtlWCYBHtd
	cH/iPgQUoB9UIdUTKYqq9cXgf/yHRUalAW/Vu6qysRDaEPIuIBoRb507n33sx6s1IbnB76gaeQ6
	9dp2ObiGE6IR+86/Mp8KFV0kX22crCVTHkHkPoYIJ0O2FG/nUvD+llALm+EGWWZmjEu8/+2SfEM
	PPcBfMZpCrFYPgjkXDrXkUK56KYjBLtw==
X-Google-Smtp-Source: AGHT+IH5KHySLFLB5XozfYu7n8/fdwaXx2q7DgWO9HYbCnIDND5ENujmU7u78FGOEd2QxuGU0KBlBA==
X-Received: by 2002:a05:6a00:b51:b0:7b1:79be:1273 with SMTP id d2e1a72fcca58-7ba3c087d40mr6320720b3a.26.1763168240681;
        Fri, 14 Nov 2025 16:57:20 -0800 (PST)
Received: from [10.230.4.183] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba611682cfsm3402314b3a.26.2025.11.14.16.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 16:57:20 -0800 (PST)
Message-ID: <05b455fc-d08c-4fb2-81db-a818771b9c42@gmail.com>
Date: Fri, 14 Nov 2025 16:56:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
To: Aristeu Rozanski <aris@redhat.com>
Cc: linux-nvme@lists.infradead.org, Ewan Milne <emilne@redhat.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <21255200-a271-4fa0-b099-97755c8acd4c@work>
 <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
 <6440e968-a181-419b-b203-a354b924341b@work>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <6440e968-a181-419b-b203-a354b924341b@work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_165721_898482_4D15BB66 
X-CRM114-Status: UNSURE (   6.70  )
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

Hi Aristeu,

Is it possible to share the sequence of blktest/nvme tests that were 
executed that resulted in this call trace?  Or, was there a specific 
test case number that results in this call trace frequently?

Regards,
Justin

