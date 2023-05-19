Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7538C7EE26
	for <linux-nvme@archiver.kernel.org>; Fri, 19 May 2023 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02qmR9tpruDPFuKvpp+qybqz0k7yoaU3QB8ymglivPI=; b=16WOKwyTcueKPeIXKmuMrCBc68
	aMfOP/vdr+xj+SjQld8znTybhWCQK23+p28Cd5ZMVfqn7zJb0iyP7dIUZvqgrcDUbGbHMLA/XzWg4
	8vYEdnHlIs+C03NYWSvRUg2UrD2rBrQxYFEyDXjub3xtq629Th1n5w90q55hH9XlykFoVeu8Ghsmb
	0YQ3KKk2N58+C0Nlt92ojRJy9Pj6s0x/mE1NrNuMZaVwEc+yRLwHj9wOYgzxVZsPCPXla+b7xWc+m
	lZWhpJMR4Z5C2U8EP33Ss8YsCHguR/bcYj4GQeWXXqtfhHKLb8kvzWjOIU22YoHZ9vLnuoM80+OQZ
	HKrZ8ZEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q047b-00GtPN-36;
	Fri, 19 May 2023 17:42:31 +0000
Received: from mail-io1-xd64.google.com ([2607:f8b0:4864:20::d64])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q047W-00GtNL-1K
	for linux-nvme@lists.infradead.org;
	Fri, 19 May 2023 17:42:29 +0000
Received: by mail-io1-xd64.google.com with SMTP id ca18e2360f4ac-76c5c50ce9cso93248839f.2
        for <linux-nvme@lists.infradead.org>; Fri, 19 May 2023 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684518145; x=1687110145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=02qmR9tpruDPFuKvpp+qybqz0k7yoaU3QB8ymglivPI=;
        b=EtGoHLX6vetV5YM5qVRsx/Jksuqqs7qTOLVWDkOLb79NYTK+kRINXcytCy8rZzn+Hw
         +Z4fVoj1/hcAPceKEBuDGlJBiAOlcbx0EBLUnlcepqavYiR+GQmlLbX+pBMlV+n/I561
         Qe04Nhzwe0v1oIbdPWnlHtA8ByP4l2HJ2qRY2DZ+GZEWgYSJqwGkL2F+ZLRkb4K6IN2C
         PvvlZZ97E1LM7SsbJ+qU5PUDcdK8FQ9UZRzfRDloZWkgxBCotLz86rhtoK6dqDygEK5n
         pF6v3+UdcgVBC5yuHdJ06LEFxz4CezgG3cA6+mnIFw58ybIbqxIuajOgNAK/uzhofV2W
         SygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518145; x=1687110145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02qmR9tpruDPFuKvpp+qybqz0k7yoaU3QB8ymglivPI=;
        b=K9uBHzAoDkuc5RVhHalz5bslcHi45ZznQfTgInDtWkzkxHvrgUkH8TZDL3lOfUv32w
         REFafZsB8YswV4JAXh57g0n0NsRcWn4yJ31WlKisghsEIENGcwVsgCn3vYyI4MCYLtk+
         2CLMeIvGmxqEoccNYbM4NDa4s4qNmPgcAqTT+Q4mfmmLde7wIsWBCgC3SS6vMddPT6uu
         jfATq/QqwutdYDMaIgXFW/iMMHSN6+umhnXoRj4p2eYs0UUGWUfpDFBQpD8Tb2e4zA2D
         ku7QGlJ0weplfsSuEiITiHrqzXQy37zZpSw4fAbUkYs5EWAVKOM5i8Z9VsuiKkp5vVnP
         twGA==
X-Gm-Message-State: AC+VfDwT3Fge/njg5tOu/a4sd0nx0x2QPP7hmwQfoatY3IzMoBQjlEfM
	zLQpfEMW0UiLRegXONoWaLYZzO4q2KsHifHDUbzqfHZis/Nf/w==
X-Google-Smtp-Source: ACHHUZ63a73OWTQJLy3pg0iUflEVV6fUwOdgw286yjEwSpV+fSor6eTb0vLN/Lxa18Roefts0ZESsy0JPr+r
X-Received: by 2002:a5d:9287:0:b0:762:f8d4:6f4 with SMTP id s7-20020a5d9287000000b00762f8d406f4mr1817129iom.8.1684518144902;
        Fri, 19 May 2023 10:42:24 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e21-20020a6b6915000000b0076fe9edea70sm201054ioc.35.2023.05.19.10.42.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 May 2023 10:42:24 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 4D36A20D28;
	Fri, 19 May 2023 11:42:24 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 48FFAE40643; Fri, 19 May 2023 11:42:24 -0600 (MDT)
Date: Fri, 19 May 2023 11:42:24 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] nvme: improve handling of long keep alives
Message-ID: <20230519174224.GA3577629@dev-ushankar.dev.purestorage.com>
References: <20230424232225.1975793-1-ushankar@purestorage.com>
 <20230424232225.1975793-4-ushankar@purestorage.com>
 <4fcc801e-b680-a60b-f7e1-99a59edc5109@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fcc801e-b680-a60b-f7e1-99a59edc5109@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_104226_641704_583A286B 
X-CRM114-Status: GOOD (  14.99  )
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

On Thu, May 18, 2023 at 12:01:33PM +0300, Sagi Grimberg wrote:
> > +	/* Subtract off the keepalive RTT so nvme_keep_alive_work runs
> > +	 * at the desired frequency. */
> > +	if (rtt <= delay)
> > +		delay -= rtt;
> > +	else
> > +		delay = 0;
> This should probably log a warning or something... The controller has
> such a slow response time to keep-alive that it exceeds the delay...

Good idea. Added it in v3.

