Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F874C07E95
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 19:58:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2295610FB
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 19:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2295610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kluUslbhB6atRxOEXdsdzCDNhtAVqV9HXVAz0Io0p2s=; b=ybQpnfB1ZVtkas3wBCx9pfL03o
	XQSacGefFkt0bJV5l3FSAYsmQFR5BhZbnE6K09h/lkKBAdoCbuSTwwWGjI1imQ5l2xMZi1bYnYJxw
	YnCeWiaSYJtXFF9YThX/vHHJO2VPi3/4FY9OBL4Y+XQGDlk3MoSbZ0o+i93Ji0GD+IAL51BS8LnMc
	PSheMEabdKAcoWbHTBonqAUX0uJgEJ/awPzeIZFFhq7cfn09J+/LlPKLINmLEgX+9+LwFp0vIhKNO
	1NFOSm0hjdKxbTcM/bg70i/EBzutxazGFrH9aC/jJTzUY7F/FfBSiacIiPqSAXYRkM2pfkn3T+Jsa
	s8fWzVDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5ZPC-00BCxi-3a; Mon, 19 Jul 2021 19:58:22 +0000
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5ZP8-00BCxC-QY
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 19:58:20 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 g4-20020a17090ace84b029017554809f35so379235pju.5
 for <linux-nvme@lists.infradead.org>; Mon, 19 Jul 2021 12:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DFndhK6vUmjyzrZCjWxDtbJP6rBi0wo5LlNnb61gvCc=;
 b=dIP7wdPnQ8jWty6Wo/M1hcG0AcqCJBRGV1Vz5OhJfAYhh2nX6zGAtoqyptszlrFFNH
 pLspO6JpH/PvTFCOw4ju2mpvbvGWSnaTJztKlzzkVOIiE/yAyfLuI1TaLKC/enXxvpwv
 hQELAEXKrnUCnTQU9kutx48Qy8eBeeZOsa9cpkurRi45NPGedWHiLlLVZecWFj92i8D2
 ZyEl40ITjDLsGz1cw5z6oe2w/7xqsaWl4Qb1+MkK8Z37/SwrbMGN26o893bu3RojsEZN
 /629HnjPUNp39uO0Wfyu+uytdx4Oe3noAPfc+lwbh0tR1ytfz9fdEDJkxl/QcvW8nuPy
 koSw==
X-Gm-Message-State: AOAM530lIXdgWhAx2xV+TkLBis1j4d6wsvb3ZB1YJ23TziTRoeBg0EiR
 1Ga3CP0MeyH8ZwvkWPzKKCs=
X-Google-Smtp-Source: ABdhPJz7dzGqqGmLNjdWiwM8io6JWCl4l9pfx+/i264L/TaSSvyD8xnHTUhlC2yPT5a9zzD0I/5pgw==
X-Received: by 2002:a17:90b:1097:: with SMTP id
 gj23mr26738044pjb.65.1626724697244; 
 Mon, 19 Jul 2021 12:58:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:eaf8:322c:314f:2eb7?
 ([2601:647:4802:9070:eaf8:322c:314f:2eb7])
 by smtp.gmail.com with ESMTPSA id 11sm20932465pfl.41.2021.07.19.12.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 12:58:16 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvme: introduce nvme_transport_sgl_desc structure
To: Christoph Hellwig <hch@lst.de>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 james.smart@broadcom.com, oren@nvidia.com
References: <20210719095309.7777-1-mgurtovoy@nvidia.com>
 <20210719095703.GA1880@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <51a5f3c5-9360-f241-8fe4-6a5d53df99b2@grimberg.me>
Date: Mon, 19 Jul 2021 12:58:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719095703.GA1880@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_125818_911960_DBECCF4E 
X-CRM114-Status: GOOD (  13.09  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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


>> Currently the tcp and fc transports use nvme_sgl_desc structure to
>> describe transport data blocks. Replace it with a new structure that
>> describes the Transport SGL Data Block according to the NVMe
>> specification.
> 
> What is the point?

I think its ok to be more aligned to the spec, and have the transport
sgl represented in the code. Don't see any harm in that.

> Note that we should probably still clear the reserved space anyway.

Definitely we should clear it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
