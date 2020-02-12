Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52086C352A4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 19:20:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8B42082F
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 19:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nVbl18Pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8B42082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H4XWV96FBH2VcqKzjKmLuaWLiuGB0Ab06ofKQ1+fHd8=; b=nVbl18PffxgWC68goj2akQRQa
	KI6nLxV8MCo6389bvPaF6jv9iwL1VZpgW8jdELtNPtQafMRTS4QlpErWOPvcm4xJnmGcCSiNSpBbn
	dGcI/SBrxk1bieJiH5WhdUA/S2StWOJqJPnhLbl3gKIlcGo5mi0gyDcWusb1Y0dBAcel5NiSjr7Ar
	xoEFLY7r+QUB71HWye4f1igNlXHocNtnPcOuPbEOca4mqvjZtX8UyuC4sWkCFVrdbttRq2YYPQi2a
	PmUCaufixFggNwG7r3XNYCdDvfdMm0HzpsqUUPnkdqP6V5qS4hFqDEyMKPBbMCARkZ63arYaUJyLU
	bUUTXPnfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1xYy-0005aN-41; Wed, 12 Feb 2020 19:20:44 +0000
Received: from mail-ot1-f41.google.com ([209.85.210.41])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1xYv-0005Z1-L1
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 19:20:42 +0000
Received: by mail-ot1-f41.google.com with SMTP id d3so3093782otp.4
 for <linux-nvme@lists.infradead.org>; Wed, 12 Feb 2020 11:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3QK+GFFhvGK0Y7VbPldhEIX2jHCftIlTmyJ4uT0PVOU=;
 b=uT9O0i39kJ9fbIpGmWtuBrSFpyZERlW+/3we50NhCEbfPwL9MVtgLUD8OpawkyCB4z
 buHGjPM7nD71/0QG/aJuu3zS4iG7GV2FEBsf1dCKAOel2l4EmKJI1BAILa/OGgluknJ+
 rvhtJM4gH5fw2ciG+s5hjJQeXomg2p3TqOsM224Hx2k7kIK55e1RVV5wKKonxjso1qvq
 bqR/qo508/+Upjiyr+I62XXMGWNsz0pQm74BTkST5+6mOtzofKBLDcSMzLLIKtP4Pl17
 pD3EUnj58P1/9IGHbXsY0RF/nQOHGMVyIQLhfhJysIOEbzQjOW9h6s//VklzSz6a9Wca
 TMQg==
X-Gm-Message-State: APjAAAXLfeBAbmqCs78W52RVdcmvPsQtVHuXu4lkAkcC087/DzkaYYxd
 J+tLQsMXz3LK87ZCfb8xyAggiqw2
X-Google-Smtp-Source: APXvYqwGBSvF6VpS5TPrcAwdhI6367IxMRP2QBo7B/2fc1h9/+3vrNbFWR06J/uc00IX3Ja2R9aH4A==
X-Received: by 2002:a9d:7757:: with SMTP id t23mr10989492otl.315.1581535239664; 
 Wed, 12 Feb 2020 11:20:39 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id r13sm382284oic.52.2020.02.12.11.20.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Feb 2020 11:20:38 -0800 (PST)
Subject: Re: Case-sensitive host NQN
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <4973fdd4-8a6c-1218-8f82-5413d3fec37f@suse.de>
 <20200212173529.GA5648@lst.de> <055b0c4e-905a-7f3f-d5eb-595e127d423b@suse.de>
 <20200212175556.GA6014@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dcac682d-d6a5-b732-59b4-47274fd7237e@grimberg.me>
Date: Wed, 12 Feb 2020 11:20:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200212175556.GA6014@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_112041_691965_F8B329A0 
X-CRM114-Status: GOOD (  12.31  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> On Wed, Feb 12, 2020 at 06:51:54PM +0100, Hannes Reinecke wrote:
>> IE we would be perfectly within the spec to convert the nqn to eg lowercase
>> when reading it from /etc/nvme/hostnqn.
> 
> We could, but why would we?  Case sensitivity is a complete pain and
> avoiding it wherever we can is a good thing.

I agree here, why should we make that effort? what is the benefit?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
