Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC7C433E6
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:00:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE77E64FF0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE77E64FF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=RM6TOJiMDHWfQTtMdfkbMqfGR
	rRr7zw2GJ8xUr8mPAvM9FOnDF+jhvdebRtyHnICccUH5tDkZ/lIU6Ao4tZ1DjX/Vt9KuWNfTIBIqH
	UPxETTqdieFAyHBXX7OhAHD5brGufEIkIm+GB2NXpGYf5vE/UsxTw0ZA9mleiqpEJuooDIkt/H6IC
	JP/iJYuDzyZgykrE9NmBH9OutYOjHuFcULnSlZ4RucLjyfj+0SMO1leXUFgxhm262Wjq1q+5cEvBX
	QLFaHDqIiX/xjoz/PfNXUhUQ81nvyKwmbac3RIWS3ddWZR/E4RT38z8577N/njdJuPCN28+7ZNbdz
	Y6Hs2qo5A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIIU5-00GiG0-Ke; Fri, 05 Mar 2021 21:59:45 +0000
Received: from mail-ot1-f43.google.com ([209.85.210.43])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIITv-00GiD3-Tc
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 21:59:37 +0000
Received: by mail-ot1-f43.google.com with SMTP id 75so7469otn.4
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 13:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=sREheu3J9p0aS3GP9Q+EqTV1CYROG30LTBV0X26zQcEMCyek1W266lwKaPuaDbJGdj
 KDN2jGZbGhKeTivrXS5UKLF0jq6KU1T+mOcKpY9hwi6fK0498LVnkk5dULqVl1Zy8x9u
 4XiFmHtyN2BK5y7U8SP4Xn7LTv4NJfSx1WyYC5GrWgB7YGytu6sO8Zc/UGO82XTBrgSx
 qLbntseZbJUAmAjwezq5yfjYiC9w9+Q8iWN94DI15tUpB61kLJBvr7sNpt6TMmKoy6S4
 d4gftmk4Owz/dcJME5a/icTxgr8H4/kPSIHTWqU2KRZ8Vz96kzU+YWwpo0zSVDAm5vV1
 Wvrg==
X-Gm-Message-State: AOAM531a0FUESnOVyfxD8sdR0J800gUao5QuPWM0FrrJgH267DVYg5RT
 ehBsMWcQRE7e7Wd1DwYIGQg=
X-Google-Smtp-Source: ABdhPJxhc2ZsE9HiRgnpLVeC5jZPVBIXnLvnH1crQZ1p6NnUD8z891P/wqQ45E6YV+WCszz87O+S2w==
X-Received: by 2002:a9d:881:: with SMTP id 1mr7320097otf.329.1614981574989;
 Fri, 05 Mar 2021 13:59:34 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id l2sm866409otf.44.2021.03.05.13.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 13:59:34 -0800 (PST)
Subject: Re: [PATCH 2/4] nvme: add NVME_REQ_CANCELLED flag in
 nvme_cancel_request()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
 Chao Leng <lengchao@huawei.com>
References: <20210226071728.106923-1-hare@suse.de>
 <20210226071728.106923-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8fcba373-22cd-52a1-5b22-b7b4a04b59da@grimberg.me>
Date: Fri, 5 Mar 2021 13:59:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226071728.106923-3-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_215936_196094_445EA63F 
X-CRM114-Status: UNSURE (   9.42  )
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
