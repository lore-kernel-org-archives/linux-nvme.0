Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C61C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 18:03:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B4D23C8E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 18:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B4D23C8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BDYRo9Kuhn5SpPJt3KiajDnD8igbfLxncyQH0vI1E/I=; b=Tq+8YpHaBR6Dd4hfwsuaQkL+v
	UlDUnJofxg5TPRPQnNx3AjJl6ZCJe+KoYKhSzLtHUznoi4K+5kDJyi8/ingM8srezslV5Gt9dogko
	H6W8b/byltbdh9yq2ajIuQAw6Mek6aT3Czd4P7OUXhOTMB1otgG9Fpo+UwpSEVuaedP6snb8fjwrv
	IA1PDwce2qZcshKIGHjT/BN3jhmxkcPdmqA747H8FnmxBTgT11ko7D84stfcBqp4H7JkHYdMBReMF
	RUZg87+5IdgLR0B/ZhxFkXznielc7WobQuYVO+7HqruvfYndCtLGrTEiXTw6kSmVleoor+/zA+oaQ
	2XcUhkXqg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn3nw-0003hc-5Q; Wed, 09 Dec 2020 18:03:08 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn3ns-0003h7-Qd
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 18:03:05 +0000
Received: by mail-pl1-f180.google.com with SMTP id p6so1348790plr.7
 for <linux-nvme@lists.infradead.org>; Wed, 09 Dec 2020 10:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SRipnXMOWpolgZIuv58+RBTLGyKag1tXg8K4EtlKxn0=;
 b=iJl0meDREBHiaR4PpYKKZeH/fwSLaj5dezooRh9SFLDrtWMdqQ/1bQzPrZ8ongsFVL
 52hV+auYI/ZmfMnvcyCtvcePHBvVd0+VKjCAhHoPqbLXfTYRPucV2+P65PBNYiGfVr5m
 3u8JvV+h6ZFn3PQZfcKvppV7uAEi8LC3QuckxmJUd1f9DvpytiXgSipj2eodr2dBrCi/
 EvRqlBqKinr1WuWUnHd4FGkzteGhH7Xqk1SgBbKa7QqLxiTlEpCy+WCZJNXgKDmeEY1l
 9c5KNgnB3T9nh54sfjT8o5Wgpe2n3d7X+4DJC6/gXVFQ0YKSpy8cHl/nxMlP/8JSoydY
 8SHg==
X-Gm-Message-State: AOAM531EkcrTjlkGezAYXqwafTSlOsgipc3XoeluxQzSALuL6z7JwuEI
 nbU2GnBAkMKViHSFnBaWXjE2K9MZam0=
X-Google-Smtp-Source: ABdhPJzxU5v36EzaEKuAjGW4b4itZJcKjA6IUMxzDr5cV5I6/V/495K1tVU5h6g6rqLpn+2eUQteWw==
X-Received: by 2002:a17:902:a388:b029:da:bad:ed3 with SMTP id
 x8-20020a170902a388b02900da0bad0ed3mr3284843pla.76.1607536980462; 
 Wed, 09 Dec 2020 10:03:00 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:d824:ffd8:a843:5dd9?
 ([2601:647:4802:9070:d824:ffd8:a843:5dd9])
 by smtp.gmail.com with ESMTPSA id u15sm2849306pju.7.2020.12.09.10.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Dec 2020 10:02:59 -0800 (PST)
Subject: Re: Request timeout seen with NVMEoF TCP
To: Potnuri Bharat Teja <bharat@chelsio.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
Date: Wed, 9 Dec 2020 10:02:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9EHFnhujZo175Kw@chelsio.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_130304_896569_990C54BF 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi All,
> I am seeing the following timeouts and reconnects on NVMF TCP initiator with latest v5.10-rc5
> kernel.
> I see the same behavior with nvme tree too (branch:nvme-5.11)
> I last ran this with 5.8, where it was running fine.
> 
> Target configuration is, 1 target with 1gb ramdisk namespace. On intiator,
> discover, connect and run fio or Iozone. Traces are seen within couple of minutes
> after starting the test.

Hey Potnuri,

Can you also attach the target side logs? it seems like an I/O times out
for no apparent reason..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
