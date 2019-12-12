Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD9DC43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 00:46:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CDD208C3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 00:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XzESqyVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CDD208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=XzESqyVZQdbLRed6Mwq7yOv2f
	ujOXE48MVAUTl7jAxw7t0A3sZdk8BGrpYz4jPMhk6x1iRcOcqU7tUJxfzjM40piJJU0y9pIBORSBe
	T8ifSV02k0Fl7ouoHswCuHT7RBG7qX5rpttmPcw87jxBOYfs6Cfy8+M/Atj0bbA43mUiHMl7OeQ3a
	bwdNjWF/61wNesCA0x6bngyS6Cojtpmmuvm2aAbvGHHEB36XjX0GZVKvXKJqTxlj31p7auIxrlpB4
	wATwkghnSpNefjHlIo4a3fYhExXO3eiI3NlZqUntjo9rU2g3Fy1Rxt3E28ZTi4iZPW7tArNgtxTsO
	FzVPyTe4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifCcd-0005Vg-1T; Thu, 12 Dec 2019 00:46:27 +0000
Received: from mail-ot1-f50.google.com ([209.85.210.50])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifCca-0005V3-F4
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 00:46:25 +0000
Received: by mail-ot1-f50.google.com with SMTP id h20so635360otn.5
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 16:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=DFrL2+SbzTWY44w5zxRcc3UEyTo3QU84Bdo65X6KzWI8p3mHLpVsiCSMqkog2Aik61
 XE2FeS7wU63+vm0BTM0mTDFNlS5OcjTLRmh2eUlh6ONyWAEtfUpbkzvsT0VsgvvBFMza
 MVAiDhZQ8nKy2YV4jRzD66C7y711PPQSm6mGJl2LqXleWhnAx74y8/VOH/YkGRzNadSk
 q25yxikvg/IoRBVEaTsaMRxuw79lkB/P3N+pdhbVxhKeoSrCEM44aWaDwIX4yRFwWxr5
 xwNdV2QyPrlX+oT6a2U9pIwFUqWzBJeZBvDdUY+uuI3eAOFYh2T6ijrRINRWZcI9KTr7
 cF9w==
X-Gm-Message-State: APjAAAVY98gqUwvB7uq6obo5UKp3YxTLs0dGV+5eIIyvX9qtXCt8ZG1a
 arGJWfH2T9Wg0pH5VAS93B4gBuGA
X-Google-Smtp-Source: APXvYqy7+YsN+oYCBNk1TbaNRonx+g+b/FnT3LFUtWoKIU9a9SE9ExiQNy0EI2h0zN3O8QyiKM5yvw==
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr5036697ots.250.1576111583599;
 Wed, 11 Dec 2019 16:46:23 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id t9sm1500186otm.76.2019.12.11.16.46.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 16:46:23 -0800 (PST)
Subject: Re: [PATCH V2 3/3] nvmet: check sscanf value for subsys serial attr
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
 <20191127094034.12334-4-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <59f0fa2b-5b0c-ae81-6458-345aca40ee73@grimberg.me>
Date: Wed, 11 Dec 2019 16:46:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127094034.12334-4-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_164624_501976_F876A76E 
X-CRM114-Status: UNSURE (   8.71  )
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
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
