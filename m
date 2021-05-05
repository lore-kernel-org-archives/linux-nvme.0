Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC04C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 14:38:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E8C61176
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 14:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E8C61176
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aofPb+ZdiwRP/klOX+VH3BVxvCCeTkDQXA9m7unENvI=; b=n449PiG+coggwWCi2CXVOrSGq
	lBwDO6GojahejSz/C/tNLtoa6f+ai5RGo92HxOZek1bv9aaFuZAOwr90+pMuCbWjXsJ8m4Q703679
	3oqasvBv+Yx/L+T45hbpZ8IKKDZ9BJHrm3nCacShBIKHtZqXUdxBwylx1vucxqHYQ9BxhCuEmZACq
	kf+YVElE4xVwVYxNhNCBJmym8JhFBSKt4tELZ1rbpTaMOYs6yUtEpvul0mNCqNbC2yOQzwMC2BWNw
	4uVvc1kSyv9iMrmuie9+N30krx03YqyDg8abDRBzAmV9nEhqfv4S5TFoORWDwhDlpQcHkR9r6eDSc
	qPjZJgl6A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leIes-001S7f-S5; Wed, 05 May 2021 14:37:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leIen-001S74-TS
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 14:37:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=8GZL1Nhot4rChtp0bdAG2qidnsxonWOJYVyqDDAfWCI=; b=23tPmc84b3XrKvRlmp+bGdwEGM
 sSIPhjAL4BDHh6Zg1jVT9uu9y+Tz2J5Vg2rT/5mZyyFrIhU4cgs9TiWLBW9EvisCv3ve+kOGl3Nq3
 plmoxLYJE4rcEVd6lthX5OtHa0XjmsvkGQSieVXPecRdnioVsBJLoJzRVOjhARALO7kUs3Ax/FHuL
 a4Dc891X8m8JS1Hr01WGFZ1hiIamIzLuxj4qo+ePiREHsc3eirSYqsyzKlRNMkAAEDMcha3SOBpQd
 9qKteijk+a0mDACym55IHYVI3Ro9gDFRIBeaeDniLlDjwy3mBQUj3KlyoHDhV++qYvLNvPSJpaMQX
 hmrGYX5g==;
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leIel-004peg-43
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 14:37:44 +0000
Received: by mail-pl1-x62e.google.com with SMTP id v13so1194238ple.9
 for <linux-nvme@lists.infradead.org>; Wed, 05 May 2021 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8GZL1Nhot4rChtp0bdAG2qidnsxonWOJYVyqDDAfWCI=;
 b=LmRJNcqbNIt02aXUGzGVJjqu67VWl3d2OMJcmUF2RVVgyeWBOBHrpStlkF9AmeWxus
 SykHCdKCMAVjZPZaREa/r/u99nBfhv6S7CcHUbpC3X/M3bgD3BFuNBnH73Fg3oj77iXW
 6DOgJ3uYOl0aOgPmU/HTBqRstRlTkb9yODkLvXfeT5Mh54kuK0bugItw7Vq//d9UYzxc
 On7q62BgZ+SV0epawDzbeda/ZtzgllXaciRR3PQSMFFU6gGXte7cV2Tr1hpnF+TDVpuH
 deI3WkDkiijH6isZbIO0W1XgXkcTtx5bjgB5+Gua7lJUQb+vt9L5S0Lakx9DVGMeGTgz
 sYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8GZL1Nhot4rChtp0bdAG2qidnsxonWOJYVyqDDAfWCI=;
 b=JacumN45VQRKjgiiZAFDXW7sYLKsYJ+sNSutAIQh5IBrWkUGuQZzHDW7hzmxb/bowi
 yBM/VyUXBdZhVU9PA/28Qlp052mJkRci8o+HhMMWOLUFOsMhgB+GUvvLmSPEeCizIvL6
 FRW9zO8UIAJA1c8hNKoPqnY5fPMTD0gUjtF3L8wV0OURbcWK/QQtqAF4EkiBbvvxdT8e
 mDpG8hxqKe1dITMzgu9tDSA2ZyY8YVPfs3IAzKNsgx0NKeahO5qJkZqHSapITJqgNQtK
 ehnSboSBi/OO8PKi+5Zd8iNTAKcn6kQiwzTYQ05o9s3og1QSZJWIMMf6TAH/hxaGbjhn
 fg0g==
X-Gm-Message-State: AOAM533A7hCqXq++6jkjBL77/9CsX1GsdY08g9Aj+lnqGrYI3vQdQB+A
 68jPxXa5hOyDvAFuVuzbKNz8X6BFRL1nvg==
X-Google-Smtp-Source: ABdhPJwNO3X8S6EzJWemGwOd0yldT99r9Edygtf5KgT6EEQFxlysERA3th37enrMzNdcXShp1520eg==
X-Received: by 2002:a17:90b:1e4e:: with SMTP id
 pi14mr11925670pjb.120.1620225460378; 
 Wed, 05 May 2021 07:37:40 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id s21sm7575378pjr.52.2021.05.05.07.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 May 2021 07:37:39 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.13
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YJKsCBgfk5vjsUiQ@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2d751229-8efc-cd3f-cee1-a13c46e0a593@kernel.dk>
Date: Wed, 5 May 2021 08:37:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJKsCBgfk5vjsUiQ@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_073743_333477_217E9E7B 
X-CRM114-Status: GOOD (  10.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/5/21 8:30 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-05

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
