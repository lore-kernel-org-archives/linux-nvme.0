Return-Path: <SRS0=YKC+=YP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A69CA9EB9
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2019 19:49:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C7621D7E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2019 19:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="us1CZR55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C7621D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=us1CZR55p7m2UXuWemTM/NEiW
	kIoWcIobgBzy62hZqUkmM0QYYnUl9O6kXEaQxrzeBu/7mRHrMfojYQQ410/EZxB3aj8NDBcEvibDe
	pxQnZvZZVJ6AUIMwCnQ592oVcaNjah9WbMFUwSD1kt+mugUlULsV5lsIKiMxt3hFmUvtJeg1+diVD
	F3w02iyrI4OZNHfkUy1EN33D3gt74KCbZtyJHz3o+0Q/6UKKdY6VdmfkfCNQQFtocMGoOswzhuAXy
	NdwOMpceDygggP56gC53xgtjJE5QnY8EMxIlHOdBKH97DPSVh9aMLFxNm9EocFzz5X2FRNd3xZHBJ
	XjHkU/v4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iN09G-0000Wn-KU; Tue, 22 Oct 2019 19:48:54 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN09B-0000Vx-40
 for linux-nvme@lists.infradead.org; Tue, 22 Oct 2019 19:48:51 +0000
Received: by mail-wr1-f44.google.com with SMTP id v9so8149671wrq.5
 for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2019 12:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=PN+WYB5s4sXFX/WcjiwLMAHsTzRprBrAsa7KV0EiP1oZY5ayP/g8fM+1kvjMiKlVFp
 ZA+Bz8YHhi7HVFCIbtT5H9VWLMeT43M9/Z3uCNVDJ4U9297T+BsJgBEEBtNxznJMcjLX
 KNQLjc94DV9iiSGYyzNIrgPWnb6+yauiyaymRjbU209Oj4YPaVInn44v2Tv/So3i0hoU
 hllOB64wPBgrYvHC2QPu5bsqQSWiOG+fW4nn4kMactug9ZF9HCUGnZ3lN4x3ualan1Lj
 Z54mJHNXrBf5oZgFDEOFz7wcRlMsfPHxuN8iYfXa+sSKvvD6sh2u+hULqYRSKpXDzL6v
 Z0fw==
X-Gm-Message-State: APjAAAUtgoLZVBken4/xjQgTELXu+/vOYtUSe0zHbQjxlFNnYlFxoNOI
 f9sUYPQPPFOAhMrsXR350QY=
X-Google-Smtp-Source: APXvYqz1Rsl5QXbCHRtvKJrwqB7noopdhzbImov7Vm7RP8zgt9fv4HPMxeeTnajKmbcgYI8ku/k53w==
X-Received: by 2002:adf:dc44:: with SMTP id m4mr3497898wrj.203.1571773726742; 
 Tue, 22 Oct 2019 12:48:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id o187sm7472889wmo.3.2019.10.22.12.48.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Oct 2019 12:48:45 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvme-multipath: remove unused groups_only mode in
 ana log
To: Anton Eidelman <anton@lightbitslabs.com>, linux-nvme@lists.infradead.org, 
 hch@lst.de, keith.busch@intel.com, hare@suse.de
References: <20191018091016.GA25478@lst.de>
 <20191018183251.501-1-anton@lightbitslabs.com>
 <20191018183251.501-2-anton@lightbitslabs.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1883af58-814e-8aef-a8ca-681b0eca371a@grimberg.me>
Date: Tue, 22 Oct 2019 12:48:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018183251.501-2-anton@lightbitslabs.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191022_124850_291753_CCD00C97 
X-CRM114-Status: UNSURE (   8.97  )
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
