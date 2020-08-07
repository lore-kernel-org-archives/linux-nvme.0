Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62961C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:33:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3233520748
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h+lNnU7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3233520748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RACrlUPFelVqndeCkSma4fm455/lUupNFQKBMk674xY=; b=h+lNnU7Dc3yZHzNC3B0XaxQOf
	4+V+IZo6FzXyICkXKlXZb64+KhsdnPfNhB7C9zsXHHz2aIXixcbTRCWkAH5hPm6EB9TzDC4++s8XN
	36zxgoxak85kJQ4K8cgmHpoPoITp9FlI52txEF0DzXl2nMH1ub5+8Axb5khpoKkPyp+CvNQKnKn8n
	gfQOd651uOYOB9mzGeLrjuZv/xy5eiFbtKSGsxZP7GKFqGpWdc/ahad69Z1e9bJbAx496c+s74+15
	umMf858BfYHQoIOWWoaiCiF/FY2ce+G9d3qTImAyQMYiIIik8mkmwJccfGbktpVycLZSFbpFkB2Hp
	YufJdUNKA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k45JF-0005DN-9u; Fri, 07 Aug 2020 16:33:33 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k45JC-0005CZ-C2
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 16:33:31 +0000
Received: by mail-pf1-f193.google.com with SMTP id d22so1271369pfn.5
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 09:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xi6qNbxlm4nBqpkQhHd4iN49Q2+LzwqHrSx4XZx3xxQ=;
 b=jIstBhpr68125MQZyAdSWDbTiAdVK0XMqq6P6k0lHWxj/mm7vIRNz36QHTTK5PKF07
 zXKbHUwjLj+qVq9xpRAAz7uqlgaSWDk3D0ZJwJTVKUhfiY63kgEwFhNRiq9Feo4IUzGy
 KqQqqOn2eS70Y3WDlMVUwoV0/4DmyDfC3edhjXowYHf2zLx1vpT/1GoioEMwYwwWKEpq
 dOrOoBK/ue61B8UzBpXEMSuQTtGNOipcj5Hvv0FyfBkPi5GXght1I0keT3U7W1qBGUDH
 unXtuu5fVj8PD1XOdBdraW8guvcBiwl5MAxCrMgRh4MlIwnp0v7XNGYOa+9mN0waBHaP
 7wiQ==
X-Gm-Message-State: AOAM533/ExdI/gJ+x46a70SdiYKG2NtsLG38BHAhSg/7supJMyPRXtV/
 UWdmY5CPbedEzqM85h7Nyfw2V7M2wJA=
X-Google-Smtp-Source: ABdhPJy8gHmfno0lan4fEBscR233mTlgfjCyIl3hujRibbm2PJxIZZfs4YdiYcZEChsCxE2MTpVJjA==
X-Received: by 2002:a62:928d:: with SMTP id o135mr13232206pfd.22.1596818009105; 
 Fri, 07 Aug 2020 09:33:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id i1sm13705454pfo.212.2020.08.07.09.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 09:33:28 -0700 (PDT)
Subject: Re: [PATCHv2] nvme: skip noiob for zoned devices
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200807163235.4155607-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e0b2a374-9897-cd13-919d-1fe51cd2194f@grimberg.me>
Date: Fri, 7 Aug 2020 09:33:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807163235.4155607-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_123330_444028_A848C5E1 
X-CRM114-Status: UNSURE (   8.77  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Queued for nvme-5.9-rc

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
