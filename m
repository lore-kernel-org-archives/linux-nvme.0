Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEE9C678D4
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lt62TOtCNBeda51sSbb0IHk12ewkEpu/Cta9b7TEHrY=; b=lwbv76vc2IFwOyLXtmQdC2KiFH
	EhRauEfNWsT4tyFBpN6RuuAuq1WgaN+F4F9tiqt2rn0Yz+YB+K5lPkeoXunTt/Vwlp0V1Nunlr0lr
	59LGQj+tHU5ghiKxe8aVnIq1xIODj4FetbxO+TisQrBsKWMVzuhPT8OacAbqpcTXzRlge1XlGuNVv
	uSK2nORz2y9+1bUXx68bt703kjF4p+26jAg4TwLz0/oyvuaGz3NoKprgmwJcNT+xXuynXuw4GmRvy
	f6yvhRlm69FlVAbATuP2yYmdZDlFtB2HyCq2ScZTxWcun8Ty0ay5jAvb7cNEp+U7mCpA6s5IlAfnm
	zxbLdPuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZTaS-00Gt2U-ST; Tue, 07 Mar 2023 09:26:24 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZTaM-00Gszu-8A
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 09:26:19 +0000
Received: by mail-wr1-f45.google.com with SMTP id e13so11393952wro.10
        for <linux-nvme@lists.infradead.org>; Tue, 07 Mar 2023 01:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678181174;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt62TOtCNBeda51sSbb0IHk12ewkEpu/Cta9b7TEHrY=;
        b=RNZA3PIcENfobB6Gby1BsiE79bHXyyCV3Zdj9dOa3iGNa0r7Zz/xHXJMPGIuDDSanw
         Rdp0h+kUqkneC8PvX1obDvmyc649ZNm4Rju+HjOgCbAXcLZfgQmYvhvxUjdBb0uJkH0H
         qbiQKu4vGkuNfwnrUXb55h7JYCzxJdnvBKCxpCAi/lg+lsB5sKxQ9DG2Gb7aup+cheME
         jOLXfpYoQBe+8heP/1xdJ6w7SfI5hsfnpfarGkGCZDWHnZW2bdH0vAx6pu8yFHpGI2iQ
         sj2XLF40ljAsanwx/Faeu5/3Sn8+n77KR3yN1VAVFWGPskESK9b69Zwi0lvYk27ApMtO
         a67A==
X-Gm-Message-State: AO0yUKWCwIJiLeBcvcRpSCEyZqzfHc5uS9Sftvh4/WFPjrJtJEjMON+M
	G5LfZPSDXr75RjGsori8ZaA6eF1Y2JQ=
X-Google-Smtp-Source: AK7set8teHN6Qexu6RtzM3iFzlM8sR1yQqI+JY22xTx4XrHOKzdttx2cc57uheNs2pZ8OQvgwPOa4A==
X-Received: by 2002:a05:6000:11c7:b0:2c7:b49:97f6 with SMTP id i7-20020a05600011c700b002c70b4997f6mr7310292wrx.2.1678181174446;
        Tue, 07 Mar 2023 01:26:14 -0800 (PST)
Received: from [10.100.102.14] (46-116-231-83.bb.netvision.net.il. [46.116.231.83])
        by smtp.gmail.com with ESMTPSA id s4-20020adff804000000b002c705058773sm12577620wrp.74.2023.03.07.01.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:26:14 -0800 (PST)
Message-ID: <a73ea22a-9871-d152-080e-49c0904dbe94@grimberg.me>
Date: Tue, 7 Mar 2023 11:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20230301082737.10021-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230301082737.10021-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_012618_344618_736BA860 
X-CRM114-Status: GOOD (  11.81  )
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


> The two fabrics rdma and tcp share a lot of common code. This here is my attempt
> to consolidate the common code.
> 
> I've picked just one function (setup admin queue) for this RFC to get a feeling
> and feedback if this is a valid approach or if people hate it. I've left out fc
> for the time being because it differs too much two the other two drivers.
> 
> I've tested quickly tcp, rdma is only compile tested.

I think we should make all transports to unify setup/teardown sequences 
(i.e. including pcie and fc). Otherwise we are not gaining much.

It will help if we make the ops higher level like

ops.setup_transport(ctrl)
ops.alloc_admin_queue(ctrl)
ops.start_admin_queue(ctrl)
ops.stop_admin_queue(ctrl)
ops.free_admin_queue(ctrl)
ops.alloc_io_queues(ctrl)
ops.start_io_queues(ctrl)
ops.stop_io_queues(ctrl)
ops.free_io_queues(ctrl)

The init/deinit can be folded to alloc/free I think.

This is indeed a much larger effort, but I don't know what
this unification of rdma/tcp buys us really...

