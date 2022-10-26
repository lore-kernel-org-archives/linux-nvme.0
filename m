Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C32CC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CHOZvPiQyJrYIwJpVXjaISAt9cvh1UXpPpZ1J0WtUzM=; b=hog6f+q4Gt5rq12vps2J5OZdPB
	fbu34UnyywfvKltvkO/VOpEIoBCtBgvDHqDK3GBu+yl6CK1NXyNNsrqIRxDyINrDN+ZSgzz4H1Hvx
	lLG10Xcv/uKiNg0EGUu3187NJCYTUWN2YK2hCdgMJVQTkI/iDJQIUCDmUN6roZ8WT1tq56Yz0UTBI
	nKn0C2pHVNwFhewjlZkr5DRlxWBkfB2Mx0pplqiG2SFA9ZL/PSPXVjugWeZZUyFCNK+n8D9FBfZOl
	PrqcW94rOVJ6V0WHIZc42BoKFk0trwaFBPuOfVbjWQzJ9zY+ceLGjOIFLcG62XZOwXzaVs7+IZYTN
	U6kQJI+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfnW-009Fny-Nk; Wed, 26 Oct 2022 12:46:18 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfnT-009Fl1-4u
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:46:16 +0000
Received: by mail-wr1-f54.google.com with SMTP id w14so1853784wru.8
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHOZvPiQyJrYIwJpVXjaISAt9cvh1UXpPpZ1J0WtUzM=;
        b=xZLbFdRbnTwTI8lDN6xiF8Kq9OQmPar8ruZ5IXJlQwDoVccZ161mdIJd0SRDuHopTz
         OZxES4nVyArLuhYgCEx1/lsOxnCK39BOsXe2ASLtkwLZ3QJgzxDONG7hBb4sd+XOmQXy
         IrL4Tf0t3f1ScDAJ+2l690XN5J6fEMBhnVsd4EzRLSMhtEwb8sObjInHkwr38eZD/Ht7
         hFpKdzwX3OFjdo0eRTmw+rjzn3IIIrbpnN0dujEmMAhEJI58Cc2i+BRC216OjCdXSTLJ
         V/iv9X18b1ok9T5pyf/XeF+dwBXZn3QPtCXeFFeK80Qctpdz5k8Hxt7LcQnbgQk1VsY3
         gGQw==
X-Gm-Message-State: ACrzQf2hPFMQJ3u90qBriIQpo46L3gRT9N8Arto9d7BBw68v0eHLK7J9
	8ASNMpTKtfVx/66NCWxS1es=
X-Google-Smtp-Source: AMsMyM7G7ZltULJQfexGzwYocPJXRgyYUw7xlKQFhXYAxd9Bd3zLdgEwUgiMEkslhk6CJpfljDTrMQ==
X-Received: by 2002:adf:e583:0:b0:236:6280:57c9 with SMTP id l3-20020adfe583000000b00236628057c9mr14344980wrm.262.1666788371201;
        Wed, 26 Oct 2022 05:46:11 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b00228cd9f6349sm4967595wrv.106.2022.10.26.05.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:46:10 -0700 (PDT)
Message-ID: <cafdc008-9d07-758a-bb66-1ca62b0baa50@grimberg.me>
Date: Wed, 26 Oct 2022 15:46:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/17] nvme-pci: refactor the tagset handling in
 nvme_reset_work
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_054615_239804_0233EF17 
X-CRM114-Status: GOOD (  10.49  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> The code to create, update or delete a tagset and namespaces in
> nvme_reset_work is a bit convoluted.  Refactor it with a two high-level
> conditionals for first probe vs reset and I/O queues vs no I/O queues
> to make the code flow more clear.

This is clearer, but what I think would be even cleaner, is if we simply
move the whole first time to a different probe_work and treat it like it
is instead of relying on resources existence as a state indicators
(tagset/admin_q). The shared portion can move to helpers.

