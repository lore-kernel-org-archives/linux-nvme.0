Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F112BC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 19:12:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FC5206F4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 19:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pKbHrZFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FC5206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=79sM8UjFJKHJjFNHYyrbCtBFwgpkIPf5EgWjsjXpHPo=; b=pKbHrZFbGznijVowGCgppQQW4
	84bVyPYCw/jVObrJNdmcwJJcQKJhDidgFv5e333A9mP3RDzIKurB2uK0oQkWDAvuwK6bFVUbzu6YZ
	97KbDCKMwpsKLvLX3NY6pcV4dAsZ6kevlU6G8vuy2QrOBTqGtG4yxVXYf06x0JvhSA2GwdUXc3Rxb
	zn7c2iW8OFvIHGwyr63nYkDG++78ShEjaVzwOzG6x48QJFev3pLIL2t+48kIcKzThPRY1Ew4S0mZE
	JETSP1RRbIEsqmRy1AWnfE/xPh40s3JJ3qsZ9TYc4FyQ8gZTTKppdJfVtoQ331z12i3IknHZT7VVn
	EC3FcIVBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jygeD-0004NM-3a; Thu, 23 Jul 2020 19:12:53 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyge7-0004Mt-O5
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 19:12:49 +0000
Received: by mail-pf1-f195.google.com with SMTP id u185so3519261pfu.1
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2020 12:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6/no1MLwpAndBDsGxTIRKPHFHs1y4Kp3QpTntHsgXjw=;
 b=BeM5/JIAbMjCy2Tm0Rn/yRLUrdZj+26LP1W7qYq2IC8YorWRlOcQ4aGMUYmiadw85b
 6elxeMuujDEjvFmMfgRlpMXZfJi7WqlyCyPxmI2Lb0CGlquwtTWSoUUipLAulshQaoHO
 vf99HMzBpz2fudtM9iiYOdu+yTxdmD2hmriUZOFFr6YQeE4m6Fm0C6YqF+KbwC4rkMrv
 pbe6Yogok6poyyDU7E1jIyK2b9FCZ5nvHjfkDC0Ae1A0uhAaxS+QKdcrmdibVW6oFbNS
 xaJAXuAOo3W8sFviNE1mPZdENHqyg96qEMUOHd2CzpVgJtEu3NF9aJgfM2j5Gb8YJ6LF
 czvA==
X-Gm-Message-State: AOAM531x8mpawqOgHljw1CE3FF3l3o/xphVxzJHC/YvKRTLOAmzaz9+T
 oUNqMNgCiwRTitzTzLW0iNY=
X-Google-Smtp-Source: ABdhPJyMRzesNVpPleX0q5jKozRyeE3+7UdKTYVrnSBqyQXrlgHzU7lSol0ZW5LWEpEF/WBFbnqcag==
X-Received: by 2002:a63:b18:: with SMTP id 24mr5664823pgl.406.1595531566617;
 Thu, 23 Jul 2020 12:12:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a07e:34d2:a5fa:d770?
 ([2601:647:4802:9070:a07e:34d2:a5fa:d770])
 by smtp.gmail.com with ESMTPSA id 17sm3571515pjl.30.2020.07.23.12.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 12:12:45 -0700 (PDT)
Subject: Re: [PATCH] nvme-core: reduce io pause time when fail over
To: Keith Busch <kbusch@kernel.org>
References: <20200722093633.31347-1-lengchao@huawei.com>
 <20200722160054.GA1363519@dhcp-10-100-145-180.wdl.wdc.com>
 <973d6470-05e8-8be4-2c8b-3162f37a971e@grimberg.me>
 <fffa2b82-f933-6531-7f98-2f6269fd0d11@huawei.com>
 <d6c07da9-e553-19c9-78e8-f52519730b3c@grimberg.me>
 <20200723164212.GA2366615@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <18b10b97-d26b-91c8-1abe-6d36714a3429@grimberg.me>
Date: Thu, 23 Jul 2020 12:12:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723164212.GA2366615@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_151247_960133_5C722427 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: axboe@fb.com, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +       /* all namespaces share hctxs, so sync just once */
>> +       blk_mq_quiesce_queue_sync(ns->queue);
> 
> They don't share hctx's. An hctx is a property of a specific
> request_queue, and each namespace has their own.

ugh, right...

But I still think that we should wait for all the srcus together...

Perhaps we should do call_srcu on all and wait for all in one pass.
But I don't want the driver to do this without a proper blk-mq
interface..


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
