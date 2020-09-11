Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3407DC2D0E1
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 17:30:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A2C221E5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 17:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IZD/TGJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A2C221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kyy6WQo5++zcp8DrKxzj/fKp1Vgo2JerriK0SxBm8Ts=; b=IZD/TGJoHSpl3Z/4QE+amkeaz
	s3m4jBBXfoRWG5j26cyRboChQNHOh1PjN6ZxQUV18org30vuE3Kku3Sg9JQBeGOLVAeMJMcsbjIMO
	rxigZYTVKyNogAF8nCGMjJu2waocK/+8JtkpkvLbBJDAnWeImrDrHMBJy9HH5U22O+9DLNHvhGKgE
	4Zx4uTL6zcU0sh6gWHV2UWiyBNvjhgTUQmp1ce4595q58keKUjHjMXNGUJEp8JzJSZ1cQLnytaI+b
	qSPgfKIqrAhk4wtI52QENhJy0BmDcYDDs+I2H7cKl7jP452J6/y/xH0DBMUmlRnQ20NXfEkYJhIoT
	nRyO18tgA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGms0-0002Kk-62; Fri, 11 Sep 2020 17:29:56 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGmry-0002J9-5o
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 17:29:54 +0000
Received: by mail-pj1-f67.google.com with SMTP id o16so2046307pjr.2
 for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2020 10:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aVIVVhDyL7377dgQv2tmJZmOuhn7zWUqlZOPCZ0N11E=;
 b=b466LaMB3aV6cwzNisPph6VvrlG5MQXDWNza/TtkzJqSnIM/dGxbuf/twFM/xTSoUQ
 h4FBewVtA1YGxWkW2yfteFP1GY8l0GzTo7oe/pLryNrkG7oSIyvaytJvF9lEpjy1zt3m
 dD/SEd/jZ6R0i3yERJTduq8IEoYqOIJusWhSc1Hs0ncizIxqdJuYuH1Dg4IZNZ6ZgESQ
 zsMZqIQAm3JaZDc00LhBV6JPjj13/NK+c4l2sctX/LXz3ORGeIQFjN7xUUaCqqb88CF0
 4cbMRP7kEIAc2vTtoJvAne/+1DFPRt4A4jN4ubWQ3WzdFe+lgMH6YRVvm/b46hvNyj4S
 w2ZA==
X-Gm-Message-State: AOAM532dDQ1Wjm4CuXa975xtYLVWGH1D7lzYqmLD1Xgq5sa4IWlXrxPf
 cZRqGe8tpPmabfI5k2AQBa4=
X-Google-Smtp-Source: ABdhPJwWN/oRHNqzQ0rgktkhGO08Iw+dD3PrZwS1Pd5SiSZWRW3eZo0ECqvuX1mm8NGMcsiUbugesQ==
X-Received: by 2002:a17:90a:7481:: with SMTP id
 p1mr3114935pjk.33.1599845391149; 
 Fri, 11 Sep 2020 10:29:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4428:73d8:a159:7fcc?
 ([2601:647:4802:9070:4428:73d8:a159:7fcc])
 by smtp.gmail.com with ESMTPSA id gj16sm2408568pjb.13.2020.09.11.10.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 10:29:50 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200911024117.62480-1-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4fb604fd-c081-5eb1-cb3a-860746b6952a@grimberg.me>
Date: Fri, 11 Sep 2020 10:29:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911024117.62480-1-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_132954_226289_2A68DF05 
X-CRM114-Status: GOOD (  13.13  )
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
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Jens,
> 
> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> and prepares for replacing srcu with percpu_ref.
> 
> The 2nd patch replaces srcu with percpu_ref.
> 
> The 3rd patch adds tagset quiesce interface.
> 
> The 4th patch applies tagset quiesce interface for NVMe subsystem.

Tested some reset storms and target restarts during traffic with
nvme-tcp.

Seems that no apparent breakage.

So:

Tested-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
