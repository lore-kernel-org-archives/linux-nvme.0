Return-Path: <SRS0=JSVl=OK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D757FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 07:56:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924F560F58
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 07:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 924F560F58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m8wcxltNG8wgNC/oJSEkvTq/j848DdQOY0CquHuvhSY=; b=fvqLilawTfdOptG4K3SPNFQ0ia
	Q9ZOITKJ/anXqm/dE3adOUdMTn7gy4XgmHMRzS0bBgBQt3EZp9y3OnFvbnVKpokSR19z3P4BAWuAg
	buS7X6pPUH785QhUwhxX8654aiihGoJCDwddo0l2ZKacyOHeTSEBtnEdwcmTDiX7YV4fQaEY6oJc3
	yIl9OQ+MgTLxEVCVadHRFKFz1VRcmyRBjBe7Aej6SqVDoywVuhTGTnhfigkkdpo87HQ8mgYVNxAHW
	fATQZa7Lp43cc7qQSdGuUgqweVnUNVkk69DiEOzr4+JBsdyhdOomHjLMTCAxIAflAySCPoLxt7kM3
	IQOrd/Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSE9m-000rDB-Uk; Mon, 20 Sep 2021 07:56:06 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSE9c-000rCV-OP
 for linux-nvme@lists.infradead.org; Mon, 20 Sep 2021 07:55:57 +0000
Received: by mail-wr1-f49.google.com with SMTP id q26so27221079wrc.7
 for <linux-nvme@lists.infradead.org>; Mon, 20 Sep 2021 00:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hZL7WnQgBs7BANvee41Cj+D1C9Cx4LXTNy/SJFX0tmo=;
 b=x6/jXmqAzlPPtsYt/09O4rLYQSLmpVKXZvX6KN0vcvnp1FYpcLd35Z/MK3iyXPGZEz
 PrFBLjNCPGaCDuG4qrk8PH8rGtmakkXOd4Teb1en85Rqzfu4ezHRFQdiGST7Octv4mDk
 XmQrM3Ktd/hKZUJVSApfF91FnCfoX4cIf7GRkfvJlyj5mVQu/FChOdJDJMFthzW89+wy
 QOisbq464H+e162yPnYX5+YQeWeoLN+CLVf+BZsCnMBky7efg+gruhRYWJVrQAuono5Z
 grGd7rVFBjCalF/ewa/NqGpCWvWvNew7GixIJCBJqfs/ptqejiG832MgbuZ1JDU5gnFw
 eFhA==
X-Gm-Message-State: AOAM531AdtAGfI2Q2vcyTU02zC7a7YHqLZBuCDWxEysn2prbrtbDTrl9
 TlDUrNYOlx+CoySDrgcDDG4=
X-Google-Smtp-Source: ABdhPJxcT5u6qVpH3T+MIHbDNfxKFVL7lqF7UTxzJy9n8c+9xi836730uvc366BcSQ7nbaNrkUM29w==
X-Received: by 2002:a05:6000:2af:: with SMTP id
 l15mr649998wry.17.1632124554097; 
 Mon, 20 Sep 2021 00:55:54 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id f18sm18072965wrw.63.2021.09.20.00.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Sep 2021 00:55:53 -0700 (PDT)
Subject: Re: [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
To: Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com
References: <20210918215729.388968-1-anton@lightbitslabs.com>
 <b6dd0d15-041e-209e-953c-1b991c0738c9@grimberg.me>
 <20210919230524.GA451482@anton-latitude>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c2732f09-17a2-029f-5904-147659cf301b@grimberg.me>
Date: Mon, 20 Sep 2021 10:55:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210919230524.GA451482@anton-latitude>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210920_005556_871517_983E6856 
X-CRM114-Status: GOOD (  11.45  )
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


> Well, this works for me (passes a test that gets into
> the described scenario deteministically),
> probably because we nvme_start_queues() earlier
> in nvme_tcp_configure_io_queues().
> Same is correct for rdma transport.

OK, looks good to me:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
