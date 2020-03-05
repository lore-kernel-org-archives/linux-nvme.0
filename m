Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8C8C3F2D1
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 20:40:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89202072D
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 20:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ukXD+wOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89202072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=ukXD+wOFG/1FY9S40Jkg2/gaM
	zKQeRtOlc17esacPDbplrQZq+BY5B+cN6a/F6rEEgFlLcQG53yiHWWUcixxzHhvDj9NeoAzQXHyTr
	CDBMMfjcLDuI+VzZ3zBrUfa9PKbLQZf2UIXieLEEFwPhlCrKikuUXAZob+WgR/dqZNEquMATRrofj
	RUmVm2eNE7+Xs6tJYtbemJfeZeWMOuAhWVzjaqwFST79fMXAXf0KJmkhPcE+mZsJEIUu5tfnlDRU1
	heS5CWZvWiPgIZr1kJLC0FnYivv5QqiijRtrqbCBIabR3nN/GmVVM/vRpP8ak51yNR/wCmLLo0Uwl
	TR+jlMbFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9xIN-0003aY-Sy; Thu, 05 Mar 2020 20:40:39 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9xIK-0003a3-VG
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 20:40:38 +0000
Received: by mail-oi1-f194.google.com with SMTP id p125so200941oif.10
 for <linux-nvme@lists.infradead.org>; Thu, 05 Mar 2020 12:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=rUUGXUzQexQYN9w5o7Nz0HhIeWF8zwfowrBqE3FBD+eJZkTCQF8Cj3QBneI2Kx4lEJ
 g1j/fj78R6buh4MlZRSILjg5YleKFlRs/jzKMoNHmSq2N0FJ98FDdmQJs1+D3Omlrp/o
 JsDGZl8wIBVYOYA6MmXsfyjK1Uxj0Rn3lCRHKSAd+9f2fAJk8TFGxeDAs2b9NW9kvKi0
 7s8P2VJBI/kVb3tsYTL9gjjcIJGTXJ7/u5zsE55DA2y95ISBeWIT1jWjukFg84G4wmYQ
 q3OOUcQlCUf/jcdqQ5F2n+kR64A3JVwGljL4yHY0K1Yy08qyuBnHV8qdjcPNLyuK4a7Z
 1EzQ==
X-Gm-Message-State: ANhLgQ242T2JeCQUIoCURTfRyJyKdxLf5q1Yg1S6NHQ82ASo1fpFNFVc
 P67ttuklRVJvbFt9wMn4vW8=
X-Google-Smtp-Source: ADFU+vtF0opppUuvfnLIh9sqnL31fbzgtDyzUoNEUnI1G2oexwP6O4SKp5EDS12V2VRuODnwZHgGuw==
X-Received: by 2002:a05:6808:244:: with SMTP id
 m4mr186357oie.125.1583440832652; 
 Thu, 05 Mar 2020 12:40:32 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id l8sm2527520otd.43.2020.03.05.12.40.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 12:40:31 -0800 (PST)
Subject: Re: [PATCH V2 1/3] nvmet: Add get_mdts op for controllers
To: Max Gurtovoy <maxg@mellanox.com>, jgg@mellanox.com,
 linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 Chaitanya.Kulkarni@wdc.com
References: <20200305095530.132858-1-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1720ab47-4542-9a53-dda4-6e726f968dc3@grimberg.me>
Date: Thu, 5 Mar 2020 12:40:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200305095530.132858-1-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_124037_013436_5BDEBC4F 
X-CRM114-Status: UNSURE (   9.98  )
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
Cc: krishna2@chelsio.com, bharat@chelsio.com, nirranjan@chelsio.com,
 bvanassche@acm.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
