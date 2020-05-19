Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B832C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:57:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610D8207D3
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nym/fnTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610D8207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=Nym/fnTMfjFpHwgoBGPmYoUdN
	1YiaF2HHF2rFf1VH5Lk5okGmMfGUmXsiPOvQZAMgxMLBwuBaZgW6PvJ2bDDOdgfmmWtFctQ6ksPrJ
	VJYcCu8AvhkUl+x2e2AnnnAlP/UQI8cmOdvkGoBlIp/HpfEEnDDyIMvNts0ow6T906Kx3ioSQakbd
	EQffT01grasXvnt0hchWFBC58Dj3mOrAu+FsfnHLgVpDuIdGYtDq95X1+aBeh3DycDAyXxCEbePkJ
	7AieWULdjGa3ePHXvLE3oUsDew+0KM/Sfb+bQVM5O5nrzycK/Iug1vzJ8xX5eYYeRabkinDm84ku/
	1upLTD52A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jay4G-0007f2-71; Tue, 19 May 2020 08:57:44 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jay4C-0007eC-T0
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 08:57:42 +0000
Received: by mail-pg1-f195.google.com with SMTP id j21so6074844pgb.7
 for <linux-nvme@lists.infradead.org>; Tue, 19 May 2020 01:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=qvf7dDx5p1Z123U14AjJ6y4nbbE6d/6ERmnIPg/HsRBmZfexRyow6OIUZMFyOysoi0
 DO3Djvw5Gq7BVH2PVv1uKRXwAU32u/XXyqoFXfjZSRgjWBBOTZdtGeRehdSRrcUkys97
 XJLLrwPKv3Q/XNMuK7QlWulgWcfxpcw6Wv6EM+FkFj4Decpv/TYxMj3vszTM25PA81CO
 STW7e+tdLcyaFtLCvprJvhRE6kuwZ5F67EURQWVArM9rk3hRK0482WXiMdpfbIaO6XpA
 Fh6TUlrOt0W+ohM3FBA1UR9sRrV+LbePLWoRjJm+QpbttJqSUPiD6n6JjcYuLDkVjPFZ
 YnnQ==
X-Gm-Message-State: AOAM533si9+jPfDFUehUBRnaa4UVWXCzNeV7m3SMNRU1phr0fkTL8cQ5
 qr5I/5TfoyDb6qGt2EQtqBHPvxhJTT8=
X-Google-Smtp-Source: ABdhPJwBljJbXdcFSWVZWNfcI7VgF7cpki6qLfsBHrUxJZQ3U3abqFXkTpgcpYYSvpbUjE8KzbDFTw==
X-Received: by 2002:a63:7a12:: with SMTP id v18mr17996716pgc.131.1589878659691; 
 Tue, 19 May 2020 01:57:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:507e:6065:a37d:f691?
 ([2601:647:4802:9070:507e:6065:a37d:f691])
 by smtp.gmail.com with ESMTPSA id k65sm10827875pfd.156.2020.05.19.01.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 01:57:39 -0700 (PDT)
Subject: Re: [PATCH V4 3/4] nvmet: revalidate-ns & generate AEN from configfs
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
References: <20200519080630.3500-1-chaitanya.kulkarni@wdc.com>
 <20200519080630.3500-4-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5ecaf2f6-6c06-f68d-00c8-32cb82e9435a@grimberg.me>
Date: Tue, 19 May 2020 01:57:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519080630.3500-4-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_015740_937494_E4FF1263 
X-CRM114-Status: UNSURE (   8.46  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
