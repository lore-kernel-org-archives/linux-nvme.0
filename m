Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F30C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:47:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872BE64F21
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872BE64F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=k1dxVoB0N65pnVTFyOCTtW0NW
	QXPLUTn7DQ2LLKZSFxOqnfaaRfKPSIfsYYNXNDx1qvISiz2BaWK0tYQn6KUETwP5v9M/uY625F6o9
	8d2ry2QJQCg/O+FAy7Gbf9v15p1yZdWOhRp1wH+EPivzDD+67U+TgV/2QEwrTFSO4WkpyhA4MXl9t
	/o2kn1yzK1j62FjbiPuw99kY+HiprV4lnM/ZZCapeoGuzB5NF3FX5TdEnb4wdqkE+nwIjTf7TMtSg
	bCxHQcb2dRvQ3rIEjpaVGS6r4+DnOczKYlwpwyaH/aGw+HC6gRhW7mdkl8Q/bMbdIwYGb3Ahf9rJ/
	yic4+Lyyg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLrJb-00GaSs-AA; Mon, 15 Mar 2021 17:47:39 +0000
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLrIJ-00GaDV-Dn
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:46:30 +0000
Received: by mail-pj1-f44.google.com with SMTP id t18so9198776pjs.3
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=G85Vsf1w9YeOIiloYO4uWLCOjnscGg0zESpjwRuFgOAHH0IFfll+P6CNFMEsP/6oMA
 R4nFc3J+ooTy8C2WFUr+x15hBq2PtJnFNZZEiyNzIA/lxqpoJFDgXR/ZJ7SMlAJn4Dl7
 MqrcpVmodak8kdtl0+/X9sZzfrFuOzQJdMFvMri0aCjXYkUr7zH5IPEC6Fe5W1ReEW+o
 aEB0B8TCL+j4AkyRsblw2eLyAg3Unp0Tfy/lr2xHFJ8tqH38x82cB0M75Thzsev5mNym
 Nu1MnFysIoMvNDoTvMGu3+CwinfG13aTUgfJ+DVQjaUN6SLyL8n2kj4tQjOE7QVpdmC6
 sOyQ==
X-Gm-Message-State: AOAM53157cVv0NScxdpoZXDHjaFgqecBZM7Qsa5TMH54JUd0se68/oAW
 SfofF1l6jte1iV5pCTTGKgE=
X-Google-Smtp-Source: ABdhPJzMIT0dQb4J45Wpyk/cyxfdvX8wTuzIfG+OzfdOhByEyl8VVt2GNQ8+V+OIlHoZe48tlHHmBw==
X-Received: by 2002:a17:902:e2d4:b029:e4:be01:1d9a with SMTP id
 l20-20020a170902e2d4b02900e4be011d9amr12702785plc.43.1615830377225; 
 Mon, 15 Mar 2021 10:46:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id 10sm13763830pfp.4.2021.03.15.10.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:46:16 -0700 (PDT)
Subject: Re: [PATCH 08/10] fabrics: use "const char *" in struct config
To: mwilck@suse.com, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-9-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <50b28fd2-3f8f-8cb1-43a9-3764b2670f4b@grimberg.me>
Date: Mon, 15 Mar 2021 10:46:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210306003624.21102-9-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_174619_769993_4D5AD864 
X-CRM114-Status: UNSURE (   8.41  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
