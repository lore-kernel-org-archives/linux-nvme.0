Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4411FC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:21:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08CF611ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08CF611ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jmYE6nXtyJIOhmEZS8OfTb2+1gzMhzX7nqKF3TMdsa4=; b=hd9EFnLjT2WYMwXrpHTCduYpV
	2n3Z3a9tLqiRhCt9S+w8e/hLdeOZGkH/j+wZEp93TdQZ+fMGhKze/tAS1NrH+O3rCW6dIvHPBb7In
	ZaP3dpzky129Zc2pt5qRMzXUBGKMKix4NfwA+2Inq2UPCe6421N0JW5fHkTVQbBR+YiQcHLbfZMEn
	YOv6p7m568pmxagxxnwmuGdShcEvuoiaDSk6Mq892kW19K3HQsA9K/alSUo54Ei0qCMAsV8xCO6ul
	VSHGXslWusybjjtuEmb29IMnBWrqD3ZEJzu9xVEbCwLXLnfL7+OAxy3uyzp8x1xoSYMHQWZsnC8+4
	yvENyYReQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lihrB-00Fmws-Bq; Mon, 17 May 2021 18:20:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihr7-00FmwQ-9t
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 18:20:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=+JSpqLWHuOOEC6EwiiW4JLck2xDqgQH8l4WmVLzRvVc=; b=nGEAS4djj50DVJxq8bUZCCsOi1
 nrZe9bGdK6psdT9nxvcGHStLtMe3aPzMRrvyV2Qn0uY7Y67lCH/IMOwCSoY3dn96RoB1wLhWYBDBT
 /9fOfouIqYFBKzXZFoMtGDBVAj7nD4MOBWkQbyBn5WIqh49Xy/LSCxCXlieMAWjEiHA7QslGexG8m
 xee3VeiBJ6brETLMD6MWDvc7+A69t4Yya7qL7XqkQlNY/Zt1Y04BECHbwiZpQA6jrhKbRBeATi+tr
 kVUO0bkUaR3qH7pCshHP98KnYUnUPnPdif8RKHFa0PkSKzR7G65hbveP8GNC0tD7lVtQKjx1mMT1O
 u5qIZ/MQ==;
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihr4-00E3Po-Ky
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 18:20:40 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 lj11-20020a17090b344bb029015bc3073608so122051pjb.3
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 11:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+JSpqLWHuOOEC6EwiiW4JLck2xDqgQH8l4WmVLzRvVc=;
 b=FTzUSqe858tfMiVfh/GpPR3ypYIYr0iQq7gHtVZu0+T5W/1FQ/LDoZb3nggqV4KQkn
 xgmkO4YaNM1zl6zEQg5ls3DQBXayvJ+1WLIGXUAEXzwACSBM1QNoCA+OcvraI3k0SQXV
 MVihR3DHjbu7viyyIhwlsgZlQmFRSwN/iBnhvzwoFP7DkLHDTcsEjGKLoglYesZdyd2m
 uf2Fw562LcUwBU3BBOWISjpnNi1g5f1twUrPaMQlP+/pVHNQ9BRK93bjUN/MM5Q7gWrn
 By0eLWpkzAQTPMOdkLVq+wYfry+agRgO0NqvAtbiknsvdt4Lt8xm5Kc8qQ5hvJccEcD7
 B48g==
X-Gm-Message-State: AOAM531/qiG9epC9jp/gfaRwJus+kC1Uy59OlWJBh6jm058AGnNssYUC
 zYWlElK3tC3800/WuLm88Kw8Vgcyj4Y=
X-Google-Smtp-Source: ABdhPJxMxdFu7B0GMojh4bApguy4eKXwh7sjweZzFckIKspQCAxdMLswj1G20G6ycCs79bctugQglg==
X-Received: by 2002:a17:902:8687:b029:ee:e239:18bf with SMTP id
 g7-20020a1709028687b02900eee23918bfmr1214121plo.56.1621275637573; 
 Mon, 17 May 2021 11:20:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e600:1f8f:de79:17f9?
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id s14sm11546372pjp.16.2021.05.17.11.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 11:20:37 -0700 (PDT)
Subject: Re: [PATCHv4] nvme: allow to re-attach namespaces after all paths are
 down
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210517081809.104813-1-hare@suse.de>
 <20210517152601.GA2709350@dhcp-10-100-145-180.wdc.com>
 <688618fa-a079-6d84-adf2-01ee36f95d76@suse.de>
 <20210517154942.GA2709391@dhcp-10-100-145-180.wdc.com>
 <4b32451c-2426-c86f-ebc6-9de74e0bbde6@grimberg.me>
 <20210517180144.GC2709391@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <21fc1351-51e2-2d66-d988-b07763a7ae5d@grimberg.me>
Date: Mon, 17 May 2021 11:20:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517180144.GC2709391@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_112038_715324_9B0F7E0B 
X-CRM114-Status: GOOD (  16.17  )
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


>> That is because we keep the device node around even though it doesn't
>> have any bottom devices. Which is what I think Hannes tried to fix
>> in an earlier patch.
>>
>> Also, if an NVM subsystem happens to recycle nsids, it will trigger
>> pretty surely. So I'm not sure this is an obscure case...
> 
> I'm not very concerned because (1) deleting an in-use namespace is
> surely a user error, and (2) it currently doesn't work either, and no
> one's complained yet AFAIK.

You're not wrong. It's just that one error (on ns X) can manifest in
other potentially completely different namespaces created. I guess
this kind of thing can happen when ns administration is done by
adminX (or scriptX) and the ns mounting is done by userY where what each
is doing is unknown to each other.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
