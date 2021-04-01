Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FD4C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 08:25:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3AA61005
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 08:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3AA61005
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QmL5gyLrImSxsZdGdmt0OqFhRbLf/ER62StEpiDrK6s=; b=SY2TKrKjzrt7dn2VQLB1JPZnT
	E/1oUmyae4Ds7/2OFBhgmoMeb4hw8JPbIEFxsbSnyh+3aVTavJiQ4SVYijdysuIM+X7+vkdsMNBsA
	Bjw1+GkSiPZ+X6UyOeepj8+Sg7Vx8EOfAF8Cz0HD0mXe8ZU9VwFMXXhNtIT73jRauvchAxYymJWg4
	G92jc85i2NRbG0ObMT2DCHA3KWuWqm9csNzcUIUZ2RS8EhOcy/elsA3b7E5pHuhzsekIPhOKC6xyx
	0w1pD/IPqd8M2QZuMH8LlvQq6ArWSFhnYQSQJ5jAiCbcA4W/CKAPFMDlPCWikyiYZ2vUs+IB9pGoj
	vlRHLFqyg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRse9-008vLH-TT; Thu, 01 Apr 2021 08:25:46 +0000
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRse6-008vKf-8l
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 08:25:44 +0000
Received: by mail-pl1-f173.google.com with SMTP id o2so661552plg.1
 for <linux-nvme@lists.infradead.org>; Thu, 01 Apr 2021 01:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s9dXlyNB1wPFpzLt1/MDRCLJ2LvSrlsREvp75Ydv0AA=;
 b=d1W9RLu0TnnpdQpTIvilwHt3Ft8hWp7NE1KBSXG7nz7s6JJH6t5VX0oR9oFbKiN9sz
 PJ4s95ApQFmqyvQTxHG3a96C/kDpwr2jsCTRYmtCupMl4Qm3ZefmGqM3BAmE+R408S5w
 1BaDA157tGkXLAKE/UxREFdOI2ejLUgb0uUreI1SfXWVu2pIlmZjcyAzL4e71SF7yGBo
 ZgStBujo0cmxlls5K4q4U2vqXESuLq3VJqObCFAMT3es5hgG77onKehZYb74Mf/QUe0t
 VtDvE8MPYivfLzMhECeiX+WNju6mG8xgSrMLLgllM0NLdVIWpx21sscFk8T4rg9d3QM+
 5LkQ==
X-Gm-Message-State: AOAM531v8ygROsdf50ZRrUhtMUq5ggUDjNjqeodDvdbFNQM7gaI15Zwm
 rWkjENfSxpKRpmS7JX4DiZHA8zegCgs=
X-Google-Smtp-Source: ABdhPJypesiR74AXgEtnLv9M+Fk//zNWcoI9lcBE8fzwq+6i9t5CK2XBU+no/s/OGJe/2tdvkAUTDg==
X-Received: by 2002:a17:90a:d3d8:: with SMTP id
 d24mr7883059pjw.28.1617265540755; 
 Thu, 01 Apr 2021 01:25:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bf93:1a21:45ef:9cdc?
 ([2601:647:4802:9070:bf93:1a21:45ef:9cdc])
 by smtp.gmail.com with ESMTPSA id j21sm4070124pfc.114.2021.04.01.01.25.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Apr 2021 01:25:40 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To: Christoph Hellwig <hch@lst.de>
Cc: "Ewan D. Milne" <emilne@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de>
 <ad2fcbcd6707de4e219b39b012f6e42cb03dc92d.camel@redhat.com>
 <5715ef78-eaf1-dcb6-c2a2-f4725e1a01c4@grimberg.me>
 <20210401062031.GA25424@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8e93c5ce-aff7-ca0b-919c-a33eb0b9ceaf@grimberg.me>
Date: Thu, 1 Apr 2021 01:25:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210401062031.GA25424@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_092542_404006_2D4816A5 
X-CRM114-Status: GOOD (  10.99  )
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


>> request tag can't be zero? I forget...
> 
> Of course it can.  But the reserved tags are before the normal tags,
> so 0 would be a reserved tag for nvme.

Right.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
