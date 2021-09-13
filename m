Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58E4C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 09:29:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA6E60D42
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 09:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8FA6E60D42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QmkavwfuuqRIDS2ZbMZph85gTavGfdyustnLurtJkWk=; b=R8CYE5Eltt6joLHaLB7EI01BDQ
	X0iXcMKs7U73oevvkFLp73m0YIJmQtoFnPHXDL5XUUawlzRDQAglSFbDtojWamJJ0rP/UaPZK/jYb
	MwrDgnYB/o3pF6Kx0JrYKIDU3K/LaWAbCWkgL/VU9g/z09B3uQnZrTHq6WQF5D/1r/WHnVJycsw/z
	Ouxy41/KEx85soRtuSgrFqMAigSudIa5h9RZVUQJkUmms+2qtohlkAH5iOVWgH6bnO9JGebWFRIdd
	StdRnnqivy5V9OaMYhfHsf6SAKdlwQnSYg9tGqRiOweeb2RHlyfGF5wJpU2RKVhcsGBLGkmtQHRhU
	uTZF9mnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPiH1-0013wd-8I; Mon, 13 Sep 2021 09:29:11 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPi4y-0010bC-5O
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 09:16:45 +0000
Received: by mail-wr1-f50.google.com with SMTP id g16so13558348wrb.3
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 02:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=53Qc5YClTYXWxlVsiiASo+dHFTy1pnxCstYhtalBnNc=;
 b=2NzERfjtUzOaxHA/0paRdVPLyMyz7IODOMcxK9CTeS5/1Y0T6B8dQmbkPpRwyepFp/
 znXRqfWNjf2I7Hq5jpMddO1/14vErxa631krhWqmK45ddHJgW6NAiK9UHIyL1MP2KT17
 fuoCUry8fijWgR+Gd0sAUBO0C2okzQc0r9oakOGpG5hr1JZuNfbTMOI1pMRe7a++5gbj
 gKFoEcYglc79Hj6WEfySqy07yADtteikRZ+Qapy0pCyrBx3kCHYx3tAlE9t3N3ZDrY04
 7ZmQd6zANc+CFF5+0464n7gsFcYfrqnHls5SXjHT74hPu8ZXJNGzPlOJl0OdF8wxEy1m
 HRHw==
X-Gm-Message-State: AOAM533EREoKDq612o9Ij1pKf8i1VDAL0G3ZdwGLaD+X/ptvMVtkpuyH
 IoYCtjFuScBJ1YkL3aGq+IQ=
X-Google-Smtp-Source: ABdhPJwxwh9kmVm1kcDKUzLWezEd1fEQHTf8VCOSb1FF4Kmn6PbkQgxbMW/DkCeEF6Dewpqt/mPDtg==
X-Received: by 2002:adf:e507:: with SMTP id j7mr11325806wrm.103.1631524602107; 
 Mon, 13 Sep 2021 02:16:42 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id y4sm6289174wmi.22.2021.09.13.02.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 02:16:41 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Fix io_work priority inversion
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, Samuel Jones <sjones@kalrayinc.com>
References: <20210909155452.2601605-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6a053328-4e55-66e1-d73e-879d21ea452d@grimberg.me>
Date: Mon, 13 Sep 2021 12:16:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210909155452.2601605-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_021644_256181_CF2FE97A 
X-CRM114-Status: UNSURE (   9.12  )
X-CRM114-Notice: Please train this message.
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

Thanks Keith,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Lets monitor that this goes to stable.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
