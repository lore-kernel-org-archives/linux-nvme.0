Return-Path: <SRS0=2QKc=EB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063C9C388F9
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2020 07:40:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F7722370
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2020 07:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VYHim1GG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F7722370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=VYHim1GGkM5o/5M4TS1foOJaL
	2b9lgGCJas3oH/HIb+5jhrY4uaRAwMG2rU3e+/1waWIyPXy3a6NKS/K1+B1IL98UwJUtzaZfWjxIk
	CWFNihYPkn/AKk/0kEXs2bjneLrntXQRHZ9uwW3sHCCothz7/bxPlI4H50oDwDWd0tRcjlsyLMjl6
	J7bKIRUDmtU+bIBpij+0jRdAWKpnlmLUEq4rg3WlXLKi3DSf7EeDS6k6Z7ykrJoc5V7CKQ1b+B9tG
	h2juVh6qrKAt+3Gsi0fJuaz8VINfS/0cq3G15D1lslX2CSsG0/I721ZzCLt4eAlNIUcvdjgGRSC4R
	rHAsGE5Ew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kWx6z-0000SL-U6; Mon, 26 Oct 2020 07:40:13 +0000
Received: from mail-pf1-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWx6x-0000R5-7f
 for linux-nvme@lists.infradead.org; Mon, 26 Oct 2020 07:40:12 +0000
Received: by mail-pf1-f177.google.com with SMTP id e7so5709349pfn.12
 for <linux-nvme@lists.infradead.org>; Mon, 26 Oct 2020 00:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=kkWxzKxz27Q1VeYMRWT2cf5c+ooBgzdYVKM+QMRV/KlJJ+Brn41s4zR98Aq4g1ONCO
 Ea4ToQL5uU53SJlwQh/PplfBYjPUnESWmQwpNWf1CvuCpemflTDUojsm5NyBAD2q+/kh
 C/EqIDsS4g7LwAAjqkRskdsyrr63vwsNYzUpzehkTL6H/zthb7gVPKTzG/WySPr4412A
 AN/PifLvXiO5/iAbJUmp3SzlQcGno25WglPrN9LY0ytQFTxLsR6BwpR2wQIvdj6VB9Py
 ty4UAi+18V2LzxASrPD2gc+JJpBd4WVUhTTYarUTzTIf+Pb6hNk0Q1gxl3eb49w/K7ZZ
 uqxQ==
X-Gm-Message-State: AOAM5314eukfJDkyvgE4oNz4Gbe9CV4/+OmyoRFQ1F0VBMGQu5eBdOip
 2baIhzSRNQh1zSIbZQXDB5I=
X-Google-Smtp-Source: ABdhPJxxhyjyZmhrcv3ON2RrqikdeJICOeooY+lzLU+0D0DGLkAtlFsXKuI3XCt9RBFiNyjoG2A2zg==
X-Received: by 2002:a62:7744:0:b029:152:4223:1b4e with SMTP id
 s65-20020a6277440000b029015242231b4emr10263525pfc.60.1603698008578; 
 Mon, 26 Oct 2020 00:40:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f815:47f7:1bca:3fe9?
 ([2601:647:4802:9070:f815:47f7:1bca:3fe9])
 by smtp.gmail.com with ESMTPSA id q24sm12352082pfn.72.2020.10.26.00.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 00:40:07 -0700 (PDT)
Subject: Re: [PATCH v3] nvme-rdma: handle nvme completion data length
To: zhenwei pi <pizhenwei@bytedance.com>, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de
References: <20201025115124.1430678-1-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <146e7680-264e-7b70-0a5c-a6e7dd520a2d@grimberg.me>
Date: Mon, 26 Oct 2020 00:40:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201025115124.1430678-1-pizhenwei@bytedance.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201026_034011_307452_FC3734F0 
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 lengchao@huawei.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
