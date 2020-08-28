Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FC7C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 15:56:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166492075B
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zde7nDZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166492075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r3M6hqya+E+vz0D+rOTcsnGTJPSHCV2vlhL9qWNU7J4=; b=zde7nDZ3OFYKZIJHDSPGExiPc
	JZ6WN6M+2d+GgB2XtOj35hOTOrdaJDu5T2VcvhkuYiuluwP16j+j1ix8/3yqFZcMYWb4UMwLfEP2Z
	bBfEBOaIjC0wZCJrF9wcVNatsojGPqmiXpAGKRmdpaQarjoJxE2NCmhmsaEYx0kMK4Qa9MC6qL6b7
	Cn6KLH3AUUQulsOwbm615RDJhPEOUBN/4TBJABnU221vpZU+9BOKgtbl7ZhHwfgcWxNTb6RqcKGB4
	jmFouaAehE9fxJlA5bSGe9PLah3e4hyeVGVSGYd2udVtcGSWTwMlRgJdq6pROzK1cdoH3rhKX/MQF
	3SPiJWhhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBgjd-00076I-SF; Fri, 28 Aug 2020 15:56:13 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBgja-00070k-7m
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 15:56:10 +0000
Received: by mail-pl1-f169.google.com with SMTP id c15so690575plq.4
 for <linux-nvme@lists.infradead.org>; Fri, 28 Aug 2020 08:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qzfWzuMBNGhEvnQgxEL1n9TGRf+NI0mV2QRU1s6shzQ=;
 b=PRaObcKx+K0EM6ZgbHS5/8FXiqZvFYE45FwwdygsERwWjb8ru1Jkv4O/l5I9rDEDtG
 3u/ardDRBX9D/SKhwqxtxKW8uSFEvk/21oaf1OEjBvX19cRUtpJKVseUKletcTE8Ubne
 uoMLAOKQRYKfyDVaHpCsJHWFdLwdmXDmABrqW8xaZrgV9wIwTXZd0RM5WnkNmvSEG1SY
 +JHxu7oq4wqDQspxy1ajDMfaK1JNEPqW5esx3dE+VX7g+2bIZhJq2Yxq9kPQd+3IL84J
 GLlY9CkYK++MBco5rTOQMfrg9MtrpP1ewN+/8RF3YcG+TD+Zk/mZ7qPq4CmJQlOJlvMc
 HmAw==
X-Gm-Message-State: AOAM53016xUbEcB88CowZgnLUolA8xDOb1ikGGNZ3z3rabBB8tdEY71f
 qFxjauD/zpwz3f7NMRgeBd8=
X-Google-Smtp-Source: ABdhPJxNPX349VxWsdZHaGw8iWI7QPEGL9AK5pIOcajA0Di3u7k5Qw1ueCvpm3ra9Mljk1GyontA4Q==
X-Received: by 2002:a17:902:c402:: with SMTP id
 k2mr1949302plk.308.1598630169186; 
 Fri, 28 Aug 2020 08:56:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c4b8:3871:4bc4:154f?
 ([2601:647:4802:9070:c4b8:3871:4bc4:154f])
 by smtp.gmail.com with ESMTPSA id t20sm2270212pgj.27.2020.08.28.08.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 08:56:08 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-pci: cancel nvme device request before disabling
To: Tong Zhang <ztong0001@gmail.com>, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
 <20200828141707.4124-1-ztong0001@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <62d8d9fa-9615-4ad6-9eb7-9f26165d1455@grimberg.me>
Date: Fri, 28 Aug 2020 08:56:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828141707.4124-1-ztong0001@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_115610_292478_D4EC82B1 
X-CRM114-Status: UNSURE (   9.88  )
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

Added to nvme-5.9-rc

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
