Return-Path: <SRS0=l4SY=6N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D8AC83000
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2020 00:07:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD2620737
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2020 00:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GmAmVl36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD2620737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=GmAmVl365he2DdJ7Vqd4nSnQC
	6OcyebT0Xs9AbSLS7yueLhOv7Fb4j6N4+LR7XXqRxvo5rO09rI95QnsmZ7bzOOvfPJ2TsA4/YvtNR
	r9zeuBXgkw2ArOXiOlgX6HNUXygIGTLrnzCx05Prp6qZHCyy6XPUWrr7tCv9ST+1wr4LcLwU0XVav
	UquZoZfIvG6QK/IF9D0gsQ6yrFhilk7TnwSNY9OOcAjS+pLLVU8D8NcnTzKyadcun6WBGewuCniAl
	VtIqfco89/oUXuTRPDaMN//YGCgLYkUAyYz6GcittWZNDRxfjZX3iQ3CgdG0NlTiUXN9xkBlZRmb0
	58CoEITbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTaGK-00081B-CV; Wed, 29 Apr 2020 00:07:40 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTaGI-00080n-59
 for linux-nvme@lists.infradead.org; Wed, 29 Apr 2020 00:07:39 +0000
Received: by mail-wr1-f67.google.com with SMTP id t14so363460wrw.12
 for <linux-nvme@lists.infradead.org>; Tue, 28 Apr 2020 17:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=OOdkJpBFf0EY7KfuPeP3to4LwObcjq2MxbmOvAJ+tT5r+nI+89+IfOS+4Xvc5w8KJN
 P5h249YqQOkvVF1cyIxPz2rljFVMXDLprm+5BNBX8v3a//Zxs0XN3qys6VTSbzJZsKTf
 aFV/Q6tjxAyNiHwTRPjfYGumKgiYbujaDq0D6Gr0zO7DS+IeU8HRZXLqympbnK6sdDfm
 5GyWFLfjNcVb7GowGaS3IFAfKgi0y+Oc8fYTRxqV+ysOvbu/BUZn2zU8XY/qMjwX4jEj
 Y46lHJCPqm8SKyQYqQ4MRF6zUO+bBApECgrPdEW3wQnVQro+NTjqwtSMeTWOYsa37hs6
 bLsw==
X-Gm-Message-State: AGi0PubQyNSS0JwXdkI0Elbm+CzhcfwaKyWkFJgYzYzHJJjidgGL6lfr
 qBTtliWhno5BKnHqNDb03cjcrAra
X-Google-Smtp-Source: APiQypLkmpzvuAOQfcJLtmJdGD7+zEtbh1uPnIXX0kYqBFL7eKE6igICnehJSYsjrSBKNJXlzf4G/Q==
X-Received: by 2002:adf:cd12:: with SMTP id w18mr36300451wrm.177.1588118856661; 
 Tue, 28 Apr 2020 17:07:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5185:4503:ed8e:c2bb?
 ([2601:647:4802:9070:5185:4503:ed8e:c2bb])
 by smtp.gmail.com with ESMTPSA id c1sm28773725wrc.4.2020.04.28.17.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 17:07:36 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: remove last_sq_tail
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200427185446.2139232-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <86ed40f5-9732-6577-f407-a023f14c59d9@grimberg.me>
Date: Tue, 28 Apr 2020 17:07:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427185446.2139232-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_170738_188860_95905B39 
X-CRM114-Status: UNSURE (   7.89  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
