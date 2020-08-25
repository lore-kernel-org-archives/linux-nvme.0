Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D76C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 17:36:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3C720782
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 17:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tZy42VIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3C720782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=tZy42VIN6/Ys3tKmfkQ/65I55
	80zcDHK2PaZB4fVHC+IWiaft9vbpjQUNsjV3L82hFCZJUvz4y0ufaavdsSB1EqS1HpZXf9eFJ5XyH
	QAkPpWzTy8UlbcoMQbWLmnTAMkVbaEXN3+WQ/1i8Aiqhj2itoHpQa1l6PjcB0xX3CNd4Y9wNM+qn9
	jQDkK7OIFhuwugMAJM+nZmDeoXVUuU/TuhaznQw9NY3n0+MFr5fIjF7NImA6knMmrj0iuN49J9C0+
	MRjdHC97Vcdq/h4Zl+f/9fB90bYTZLXKVR9XjTEJE3UN+3l6Xofqi/DpTXC1pfULsNzfL9HnTsPry
	IdTYi1wGQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAcrp-0000w1-HS; Tue, 25 Aug 2020 17:36:17 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAcrY-0000pM-3Q
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 17:36:01 +0000
Received: by mail-pg1-f196.google.com with SMTP id g1so3517334pgm.9
 for <linux-nvme@lists.infradead.org>; Tue, 25 Aug 2020 10:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=s9DgWV0RoE9WwMqZ/O8mE2RNTNFlNnHuugZgn54KlRwc33kpEazheNHTJnFMja3wQ4
 fkrXY7OFI+QxCckyQ8pCnFRFxfp3QhhUww6r6Yh/d45NE9+b/+/NiAfKDvno21lVWxHn
 nAfgr5xb7jqmX+7OJhwGtFuKrx2Xfc727oeG5O36A1gdLmZfB8fEX47ZCq64GWhu0PVw
 IaUIuuD2SOfCjTfDe3T9Fa79RwNmGwInGJsZnDh1XfKqarFHWlA2BPDJzQKIwvbW/6ze
 EeRSHuLKkHw027xu5IXU3wwXcRX9XT3MRcsSEvqqui6SrArm1im+hXbvHwsVJ4ywgbA4
 RqTA==
X-Gm-Message-State: AOAM5314/gz0NmKrIwTIdW76Gf9FWiLuRY7cNW08W91kT4xzwKbQuiAR
 aH4LIxwN7mbxDDOiORu7Ugw=
X-Google-Smtp-Source: ABdhPJxqt40MI3zWHcEKQkvXN7gTpn+u7Sk6XG+uAhgNrbnYV+celB4baiRBFtxluZeJFj4rW26Clw==
X-Received: by 2002:aa7:97b7:: with SMTP id d23mr8700968pfq.264.1598376959068; 
 Tue, 25 Aug 2020 10:35:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c51:77cf:ef42:8603?
 ([2601:647:4802:9070:4c51:77cf:ef42:8603])
 by smtp.gmail.com with ESMTPSA id my8sm3066555pjb.11.2020.08.25.10.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 10:35:58 -0700 (PDT)
Subject: Re: [PATCH] nvme: only use power of two io boundaries
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200825163516.1706267-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2f9dbd9f-14f0-5e2c-c5cf-7f84a8d31c9e@grimberg.me>
Date: Tue, 25 Aug 2020 10:35:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825163516.1706267-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_133600_223767_7BF595AE 
X-CRM114-Status: UNSURE (   9.95  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
