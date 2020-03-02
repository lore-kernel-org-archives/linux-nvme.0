Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4FAC3F2CD
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 17:44:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87483214DB
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 17:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OEPeU0w4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87483214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4m0hBKHkKj9eBBuz9F8MGqi9h/X8sTdfuAuzLyAbzLs=; b=OEPeU0w40+p3mlWDtWGZ6eDZK
	UJNzPJfjTcmffT8yU8VS4wUyH+7uFHA98Ve0K9HugWlKs8cH8nSCd0JdKA14JfxYQWQ1tK+wfCLIs
	qHWcwwrroZxKC84EeJZoxzV+hpIEf2PfpTZ9PsX6o6JUEtC8qpOy6iDGUJC9xUTBTzwE9Yse+gkXZ
	Dfg6BH551VTLdBBkcKKB97uVzkzBwapmdmw+y3skFcDbAKZ5YZBTVRSRAlmuLy+hfCrZJJM0/3drz
	o21aU4PhTHONzcPp1G7iCOTr3UPP23fX6Ix3JVpxo/RT5I5j8x9AbfK4U0YxWKDadGG94n2RHROl3
	OVphWNjyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8p6o-0000Nq-CP; Mon, 02 Mar 2020 17:44:02 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8p6m-0000NR-BW
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 17:44:01 +0000
Received: by mail-oi1-f196.google.com with SMTP id i1so36711oie.8
 for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2020 09:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dNYh745W5kmdbqIPKnH/LXvfdVacdCVejfx31yl0yhs=;
 b=RWv0RIjyUX0Vf2OiDBVQjo/dHt0UfCf/VGa72yEbm6U6UM9rZ0BOx+YlI7HYY4Byyz
 neGkGK7LakhAIMY605DuJhwtQZeptCI+HxU3IkpCjgP7Bn/DThlUrX9/MHNnJrssbIZW
 V0gD/ahqXAIolc9NwWUKup4QXBZB/pbJVvIE71dF3+sbaerIItvatbwRQjhzp+asD1HZ
 bWnrB3odQutjOzONrPDVqGr3pNVzjxPXiRKFr6tHNLMxUXzOORmOd5Q34QGm8ozQyUal
 X9ZZKUyKfVHCzXJqwaV/gbo262cI1STIeejr4dY7w2xUtm8U8vHGGYZXxaN1GXPHfkaN
 Ixmw==
X-Gm-Message-State: ANhLgQ2Qo1Sxm3cX3JsNNcd0aNasD3jrxu7CFQsQGZwpGWMkTkkGzLYN
 hCGa22xSkY3B6ZC9ro59+/U=
X-Google-Smtp-Source: ADFU+vvWMYBvKZRzMQujbzfZfC/OHszWtExDqb2WiOAsxYeSMC7rYVgWKnjM1NyMGzgl8mjMAXGQ6g==
X-Received: by 2002:a54:4487:: with SMTP id v7mr177416oiv.106.1583171038809;
 Mon, 02 Mar 2020 09:43:58 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id r26sm1198295otk.65.2020.03.02.09.43.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2020 09:43:57 -0800 (PST)
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
To: Krishnamraju Eraparaju <krishna2@chelsio.com>,
 Max Gurtovoy <maxg@mellanox.com>
References: <20200226141318.28519-1-krishna2@chelsio.com>
 <b7a7abdc-574a-4ce9-ccf0-a51532f1ac58@grimberg.me>
 <20200227154220.GA3153@chelsio.com>
 <aeff528c-13ed-2d6a-d843-697035e75d6c@grimberg.me>
 <7a8670c0-64bc-7d7b-1c7a-feb807ed926a@mellanox.com>
 <20200302073240.GA14097@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c8e3f76b-a255-ba03-dcb5-32d8042fc8a0@grimberg.me>
Date: Mon, 2 Mar 2020 09:43:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200302073240.GA14097@chelsio.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200302_094400_397465_14531C21 
X-CRM114-Status: GOOD (  12.87  )
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
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com, nirranjan@chelsio.com,
 linux-nvme@lists.infradead.org, jgg@ziepe.ca, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi & Max Gurtovoy,
> 
> Thanks for your pointers regarding mdts.
> 
> Looks like fixing this issue through mdts is more natural than fixing
> through RDMA private data.
> 
> Issue is not occuring after appling the below patch(inspired by Max's
> patch "nvmet-rdma: Implement set_mdts controller op").
> 
> So any consensus about merging the fix upstream, to fix this specific
> issue?

I think we can do this asap.

Max, please send a patch for this.

Thanks,

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
