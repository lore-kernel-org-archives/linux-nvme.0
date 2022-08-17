Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF794C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 14:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R+mRpIZ7Zgu21uwMA0nvMtTfDGIisuZ8eNPyxKRxmQE=; b=AKKxZGKsZzm3O1L7Q0k2WoEcYv
	191DkfTz4fFkMnbNU2HLU7OzGsnF2/wVphkFgWQqTBEi9KOVREDu5X+TkOOy0wMH5/OeVPcERd6Ez
	dRZhu+lhCuPrJIqh8nY3WIMK95TThjJc7qkS8GjHgOovj39fVV4nxUBsJeAgQAghQtDeYxQdSeuyb
	sSxQg1Q90Of4OMq9MFHsBvDU4yGDp4q3cuaCJxBIlEaaroqkmgMXW46zXjlqMNYaFlFPfaEAg+m+p
	OSK+ggUPipPVAtyeRlXDXF/Id5yal8swKivDKIAiWJCV0C95rjbqGVaKduC2Mr+cDu1fDIjPD2JPP
	6q220LbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOJzJ-002ogo-PI; Wed, 17 Aug 2022 14:25:41 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOJzH-002ofB-Oy
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 14:25:40 +0000
Received: by mail-wm1-f46.google.com with SMTP id d5so4472572wms.5
        for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 07:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=R+mRpIZ7Zgu21uwMA0nvMtTfDGIisuZ8eNPyxKRxmQE=;
        b=8Aaump1kbNbVVztXwH5FWUkjCHrnwGPpCyHSZsd/9BeFHp8v/yDMDYrb4eG5x6MQy5
         2+mmJCswiVchMP/5GbIVlJAb5TcE/wPAsoI1TmxNlqfU4rav/wAD8NIywyyHMnZNMDEb
         s16TqdHYdN22viyGZGAusErAIPRD20TOaQ9/RJv0wGR721XRS97HySvNAt3CwJv+qL+L
         bo35p5gE+qEfkFFU7rxlOOIyEhiQlWjsKLWN9FaZTIej2/nJGzIGmLRccb/B0odkzvPN
         bPa5SB8msobD2mzcJ/I26ynd7Z3pc7dqjh2Z/UwmSA6CgaTbyewx3UfaRmXE/IlPYHq1
         w1nw==
X-Gm-Message-State: ACgBeo2Q52pNYnjC8KypiXJ/mPvkor0Vx3qU1+UxGDnQTvBtoTF4ywGb
	vTc6vPeCn9gatIZs4yAMlYE=
X-Google-Smtp-Source: AA6agR5icZEtlkcXFsc6tMcsi67HXqUlEdQRuDlo+geBQqnwvBpJndjqm2NQJr58kaf3KQFquFDANw==
X-Received: by 2002:a05:600c:3502:b0:3a6:edc:39f8 with SMTP id h2-20020a05600c350200b003a60edc39f8mr2392754wmq.200.1660746336588;
        Wed, 17 Aug 2022 07:25:36 -0700 (PDT)
Received: from [10.100.102.14] (85-250-24-41.bb.netvision.net.il. [85.250.24.41])
        by smtp.gmail.com with ESMTPSA id l20-20020adfa394000000b002250c35826dsm7449729wrb.104.2022.08.17.07.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:25:35 -0700 (PDT)
Message-ID: <7c5c3e39-650e-c0ae-c9ce-8b23c8c15493@grimberg.me>
Date: Wed, 17 Aug 2022 17:25:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com>
 <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com>
 <c11e62ae-3439-e3e3-adba-d7f5f951791c@grimberg.me>
 <Yvz4zquwplVKwwXK@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Yvz4zquwplVKwwXK@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_072539_853208_5E4ED329 
X-CRM114-Status: GOOD (  10.41  )
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


>>> You should also remove the cmd's 'nr_mapped' field while you're at it,
>>> otherwise you'll hit the WARN in nvmet_tcp_free_cmd_buffers().
>>
>> Not remove nr_mapped because we use it to know the iovec entries, but
>> we can just remove the WARN statement.
> 
> It's only used locally within nvmet_tcp_map_pdu_iovec() after this change, so
> no need to carry it in struct nvmet_tcp_cmd anymore.

You are right, we can kill it.


