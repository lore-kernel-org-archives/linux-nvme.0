Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C4EC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:16:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8CE206F0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZKTa4K/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8CE206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=ZKTa4K/tVgQ0pu/zWToJPpcmg
	ndfFnqHw70oY63EFmul0bZQBkYz5Dzn3u6OvSEb8lUCnFjijMohCNpQPowzA4roP5NN8YJatjEKUE
	JAB3xEL+p1C4B9vn4X47696ZRQ+xYm3eUYfr7EZqQg2Lkk0qY+JO14eqT7Xf/8z+FUKE26O2MhcyK
	CdMdxk9xSU+ipYRVLu0SIZkqc5EEDPBteQIt9H0rIXIxGplaw//lWst/suDomXWLKfnZ2DDk28wZ6
	ha3SI0NdyU6Y/AEfTTZZSAxbvEj+tWBecfa1aGm/yuPmNKX4PDXZ3YFM1gSzS8+NgyyXIjv+3ytaB
	BiQibN8Qg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz6vq-0005RO-Bc; Fri, 24 Jul 2020 23:16:50 +0000
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz6vn-0005Qu-Uf
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 23:16:48 +0000
Received: by mail-pj1-f51.google.com with SMTP id mn17so6218285pjb.4
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 16:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Gts/TOIIONe73+HAVjkecLM5JUbLqKnKqb7LMhAZ07A8XTy4MmM8Lddw+p4ZS/VINm
 ojW5Z2aeTjpXHtUS8zdyG81KSmQ/1fZjJbk2Rdfz801aXFIXHjtOBMh4jCi0lWHe3yml
 oTUk62Dq8jimHSETGjOgMQ7XQaAqjxhYOxXIMe++unaNyw/fwdyNMsKfBhrd44xYdpv5
 /M6wapU0m+C+Alji/g+XXavEECnYxeX1TbUUz/LYeU7O8isyvNEOTAOsLrs8I9B0o96X
 zwV3PGZ8SUSLU6kDcN6/UeqXJdsB1Nmf13Id/zRv5M0q7giuMbAGry9pKiX6INs50hV0
 RJnw==
X-Gm-Message-State: AOAM530vfqpjDODY9GPrBzu05sboAjPzFoR/uruMwrx8hRFUSu68Ik1g
 tnL5B4gWQDsrVCWHTELhudEXBwPN
X-Google-Smtp-Source: ABdhPJxI7PmDQ4vS9Qc8crtPXF55decfDgnBys2cBqPtpK2iBViBcQ4MDpFIgbJhcN0hZQlLHH/Jbg==
X-Received: by 2002:a17:90a:39c8:: with SMTP id
 k8mr7857836pjf.118.1595632606325; 
 Fri, 24 Jul 2020 16:16:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:ac47:9fc4:b59:66fa?
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id m26sm7659845pff.84.2020.07.24.16.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 16:16:45 -0700 (PDT)
Subject: Re: [PATCH] nvmet-fc: check successful reference in
 nvmet_fc_find_target_assoc
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200724164000.49831-1-jsmart2021@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <00b58143-d019-e01e-b44b-a572fb4acaa7@grimberg.me>
Date: Fri, 24 Jul 2020 16:16:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724164000.49831-1-jsmart2021@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_191648_001959_0844953A 
X-CRM114-Status: UNSURE (   7.46  )
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
