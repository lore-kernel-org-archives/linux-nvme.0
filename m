Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C69C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 17:36:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C612076C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 17:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PIhYTj0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C612076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=PIhYTj0JwdbkGAkPI0M+HLeZa
	f79uHX93C8fvDR3guw+vAbTiajsU6KvsJUu9FPPbBDsXqsq0iB4VCuaPuNXDH/7Co7dG4c0BQO4q6
	uJ8UPI7cvIkS4azxp/sM+ObwIEzGYuBMTOEGBCH8RrudoTnHhd2iGOIy7F/1DY1hSrP8XWuOT6ity
	/dsWszHjBQyQFBPNhhn1f3gbItIFiYGJ+1++ObmMmrGUcT9h5JCPe42tlfdzkCxbNeuiopFsaS/21
	dhazRJkKBZG8ttFw7AFGDi9spuxLCqwGtXHEPJudeH+AEOJFlzUw107Dbj8DGMbjTNiASzbbBYfjd
	2HXDaEYuA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAcsL-0001Dh-2u; Tue, 25 Aug 2020 17:36:49 +0000
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAcsI-0001Bf-En
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 17:36:47 +0000
Received: by mail-pf1-f171.google.com with SMTP id d22so7907880pfn.5
 for <linux-nvme@lists.infradead.org>; Tue, 25 Aug 2020 10:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=UVH/J2HD/MM4JqpLuQd/EfK9JV0DlpQl7rdUQhwOU4+8CCBNVCDNsFFTtlt4sSwJ/t
 QX+AZP7a7H6jk6V5FpfO24H9cMb3W+V1CHw+oHIHA1vOHdSY+HuoG2pXc3KzVQ34iUU7
 +jrrmDTEOy/h7GL/PIb8XUrGhyVk6P9PoRbsv3KKxuRGF2qJkKjB34ulz+fHHd8C8Q2w
 bUVJIpeNmztKV2t3OKBP1kRqrpUJ5Qyi4/FHMsvVibqcinihi+0RlFs8nkSM92fQhEUC
 fgM/1jO3vt5gDdxD8KJY6DXfV8a1LV4eWYXXF7L3gX1wHnoaLYqF26AcXfrVJ/SeiI27
 iCkg==
X-Gm-Message-State: AOAM530CRPjgd8aAbOv5ujZHNJU/X2YaWaYjI4gPLtUb2k0tB63Rz0j6
 2WBNevan8PTsYcR5KJgrcbgnG4NiU0mXFA==
X-Google-Smtp-Source: ABdhPJy3v/AtXXaSJe5zJrREO9SQhgEbLd22O43B3S6wfK/mN6wj0ehZp4A3zp8wWiH9WmKBHvsbFg==
X-Received: by 2002:a17:902:59da:: with SMTP id
 d26mr2417380plj.40.1598377004788; 
 Tue, 25 Aug 2020 10:36:44 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c51:77cf:ef42:8603?
 ([2601:647:4802:9070:4c51:77cf:ef42:8603])
 by smtp.gmail.com with ESMTPSA id x12sm15293731pff.48.2020.08.25.10.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 10:36:44 -0700 (PDT)
Subject: Re: [PATCH] nvme: fix error handling in nvme_ns_report_zones
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
References: <20200825095824.3542647-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <654ed327-f30b-ad55-2fa8-831fe3bbb139@grimberg.me>
Date: Tue, 25 Aug 2020 10:36:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825095824.3542647-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_133646_529406_47AB9B24 
X-CRM114-Status: GOOD (  10.65  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
