Return-Path: <SRS0=imtT=XI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0660DC4CEC9
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 18:45:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C0A20830
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 18:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dvQMrCLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C0A20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WpIHTW4DMpXh4wpEVMeHufR8G5jL9Fry6upY3zlVU2w=; b=dvQMrCLKl0J4z/NSzc2tCGSmj
	2jqg16BQQE8H86DuNVlkHOhz2EnQnh7FVfrLF6oKQt0YKehpGeqFblfXqBLYiHw3iheHRqfmXtZVF
	RTLXNGBmXeVaEsOL2Gh5zsuMKEMYQvLrgT49joSp9APpim/WijZJTUcrLyIGXZh+yVjHWe2FypqW7
	iApLXEL11MUzhkPnaQFvmfdBoETvtyw4BY6W3n9dP1h6mnF7Q+THzrqkkx7niJWAP/F977jlRjfRd
	B0s1c3wiW5rt4PKc57RwZpULTjHKu5SYmq4WEjOWDsU/9slCMakUK9ovHpssCnJzLRztt3Jz0r48x
	4XI8M7OZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8qZ5-0006eA-Lv; Fri, 13 Sep 2019 18:45:03 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8qZ1-0006H7-Qe
 for linux-nvme@lists.infradead.org; Fri, 13 Sep 2019 18:45:01 +0000
Received: by mail-oi1-f196.google.com with SMTP id z6so3464088oix.9
 for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2019 11:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0v+0MQG4N399eZMBIAYAZbDzpvrbD+9gpyUjDxcT1bg=;
 b=itQZ5YNJ4qdDJ4pGHg3lyInQ6Jv7xnLO+g8O6rc0eKYrT4spTH/sLbtYISONxdciLf
 Ioml5M7tm/37W+xddGgiywYOfd74qgcKX5FpnQpyC2qhc70RXBUGJD4Put37SH//6eJl
 A8DXc6ZvTgqfqnz7+hmFsIBLHXlKT6v0hyp6yvGWseUTVJqW5O4hXjmwX/ws5MWnu0GO
 wRKrHyoWU6dKLZbzBF+jn6b1/McQhUOJu9ZALvCGFUeWtMLFby+9VcOarhkT+flhZ3dY
 hO0R9HRGDaDmMt2V1GVN5t5jUdlUyZqUoaDfXarxAeBWNQYyP0jZ8220aGDmV0xo+lPQ
 1b7Q==
X-Gm-Message-State: APjAAAX58sne0qWd1/t8SwAR125wJvfsUfrmX7kca+Ya480SZ5hfF5eT
 D6B83BBfCXxDU2+yjqV0ypw=
X-Google-Smtp-Source: APXvYqzInVRUZttVHfceoWFeSWbEikpd27vywRG28Zgx0GIhkzejbuTsyd+r048vmINq7WpYc9mgzw==
X-Received: by 2002:aca:e046:: with SMTP id x67mr4797861oig.156.1568400298834; 
 Fri, 13 Sep 2019 11:44:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id n23sm479942oie.24.2019.09.13.11.44.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Sep 2019 11:44:57 -0700 (PDT)
Subject: Re: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
From: Sagi Grimberg <sagi@grimberg.me>
To: Alex Lyakas <alex@zadara.com>, Max Gurtovoy <maxg@mellanox.com>,
 linux-nvme@lists.infradead.org, Shlomi Nimrodi <shlomin@mellanox.com>,
 Israel Rukshin <israelr@mellanox.com>, tomwu@mellanox.com
References: <F7E28AA1609E4FC495B5E8D4250E7DEF@alyakaslap>
 <90599926-b7ec-8431-a7aa-c44fde08b5c4@grimberg.me>
 <ec4fb8df-98c4-fffc-7581-5245c397d16c@mellanox.com>
 <66ACE500178B47D6B39F23FE98D22363@alyakaslap>
 <b6443a7c-4be6-3dbc-0535-a8ded3261c50@mellanox.com>
 <8ab1fa5e-2d67-5128-93b5-2f32704869e4@grimberg.me>
 <28046c97-c271-dff4-5252-4b5668c7bfb7@grimberg.me>
 <B3E9005C4E4645628157970AE2A385C4@alyakaslap>
 <fbcd59ef-9c48-4e1a-4802-1cae33c5f671@grimberg.me>
 <d7caa73f-b939-41f5-793a-c9b74880f246@grimberg.me>
Message-ID: <5fee46b0-0516-766a-5b1a-7114a164c9ae@grimberg.me>
Date: Fri, 13 Sep 2019 11:44:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d7caa73f-b939-41f5-793a-c9b74880f246@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190913_114459_867159_CDFFF2F5 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Hi Sagi,
>>>
>>> Which kernel this patch applies to?
>>
>> its based on the nvme tree, but it should apply cleanly on upstream
>> 5.2...
> 
> Alex, Max? did you retest this?

Raising this from the ashes...

Alex, did you test this patch?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
