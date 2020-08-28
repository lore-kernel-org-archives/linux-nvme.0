Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2828C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 15:44:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9F320872
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 15:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WpsU2zJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9F320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tpMSbUV63DNDWCWxEtqIB6jyPq963ThJ4jnuEgxe+/E=; b=WpsU2zJkP/zk5QaH+NT6GaOqu
	Ubsl39/8F9oCj7fCOc6LQCtLIS+hxKQA/cf/YC2MgREQ/hUm7pimlpdqqZ5icZk30Cxo/3Vhbl2kb
	IO3x3AqF6mv11DJvgFJ02/Oe/yBuSYRxk5FFmQwnnElnGylH/mz60BGM7XUnt5cBrUFOagrCVq2rV
	zNI47F5i/jYBgW2vah/DZE+M0L/KQyi+W0N4Hto2Qlxwd+FpP3CAAWsTnIVZDiLSm3ciGIYRhm3jY
	zhnS0UPDMOFncMDV0zCd5ciGd7WY9C0hwBtxZgSj/Qo77t/PLQtHLgWVAEhBW0H2FHO16cGOC9XzK
	88fq8JT6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBgYP-0004tY-RP; Fri, 28 Aug 2020 15:44:37 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBgYN-0004sy-Ab
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 15:44:36 +0000
Received: by mail-pl1-f180.google.com with SMTP id q3so656067pls.11
 for <linux-nvme@lists.infradead.org>; Fri, 28 Aug 2020 08:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dGb2n0SGqmx0VxL2Jwe0Ulg6p/Ek+JdV7Oo/S3A5H4Q=;
 b=cTutQ+PIHP8beqFwIq99qvdGt/ZhACP6FILvRFgx2fnPeHifXLe782zibSTOujEllg
 VBt27W86Ap1lagjVkYINzLaxXhVY2YOQhYF3etazf585O9DXOwI76VNg931pENsQLeeD
 yW6sH9nk8hmi8homqJNxa5q3SLJgW3QlgvUSldQFesKDAlxCQmgzDYlM4vxsIdgkICgD
 yRFHwKU/3U/RFg2N1TDqko8dnL0zjm+N+YKBlk7s6Jt5M9F0Sp+pLQpjhgiYEZWBO95T
 Qk2r48pCL9ycma+1+eHbdidgJhMcCyyzSeVLPuyuzbK6MdElV73biOUSpoaQnlicTlTk
 pZ2g==
X-Gm-Message-State: AOAM531moE+Yljh9p0zmPe1gqQwZiiXXzei+AZML65RStbnaVxqNI6Xh
 M6wR4jyBGgi45j0Hw0VxONcrt7LqM97Llw==
X-Google-Smtp-Source: ABdhPJwahWarBqkovqZ04SPawTjiZOi/wvfex/judOXEhx5ZYf5U+PRtODHBVEnZl26g1uUGXvd6sw==
X-Received: by 2002:a17:90a:46c2:: with SMTP id
 x2mr1814875pjg.184.1598629473241; 
 Fri, 28 Aug 2020 08:44:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c4b8:3871:4bc4:154f?
 ([2601:647:4802:9070:c4b8:3871:4bc4:154f])
 by smtp.gmail.com with ESMTPSA id b26sm1713872pfp.177.2020.08.28.08.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 08:44:32 -0700 (PDT)
Subject: Re: [PATCH] nvme: fix error handling in nvme_ns_report_zones
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
References: <20200825095824.3542647-1-hch@lst.de>
 <654ed327-f30b-ad55-2fa8-831fe3bbb139@grimberg.me>
Message-ID: <b9531d13-ff92-f085-7bcb-432e939fe373@grimberg.me>
Date: Fri, 28 Aug 2020 08:44:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <654ed327-f30b-ad55-2fa8-831fe3bbb139@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_114435_376176_C9A5C8F0 
X-CRM114-Status: GOOD (  11.07  )
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


> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Removed from nvme-5.9-rc due to test robot complaints.
Will let you resend.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
