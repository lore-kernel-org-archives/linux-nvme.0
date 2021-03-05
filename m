Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84602C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 21:11:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204ED6507A
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 21:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204ED6507A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=hB1BU+vS47OlkSU3pH+GaInRO
	TMahNCdNUrh4LIe2YF2IszoAfRWqehsqTEdLFD9VfrOD0u1yz+3Hsng7cBKeMYaXgFGymvjvT7Hu5
	M8kNgK3rjUfcASetXouQAZ890ljSfYEoYqsVe9wVGc3X/RUOtm/+qaHs24TpBZx2ixo5IVXuiinYV
	N4kK78IE5HmvcnBkFonNfurmdIkUHJXFdjztt5Lse2JZDSJ/yo1ITrnctw8WoWadg1uFngkbI9EZS
	Kqsj39Aj0VBhudkGlxWe6oEIVV1xLqQElQx09v+4Z4G3k91W4J5Gl+k1PpSv21priJJ7QMJR2K0M1
	IQgbb7lIA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIHjB-00GWb6-OQ; Fri, 05 Mar 2021 21:11:17 +0000
Received: from mail-oi1-f178.google.com ([209.85.167.178])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIHiw-00GWXI-Rz
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 21:11:06 +0000
Received: by mail-oi1-f178.google.com with SMTP id x78so4051445oix.1
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 13:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=h361yMCuDm7mG757M8GvV7Ns2STMXXoqgDzfjuJJWfXLohQm0zGQyxcQJyuZAhp+Gu
 xy7xFNal0W0bIxTXP254e5/ilO9BG77styn34tOTUZfzabzWx0xMDYxQmgXe+slwMhzm
 FFMvQlW2um3/VadZ4pWHsw5u4OeC5PhU3Y0PPjUFLxIeTqm63As+xqZSYfLwgBf8XWNL
 2p6IH0J807r+Xdg8RT/neKMZ1oJXUF5MWwFsb+0Wt8wAJwRlD6Fm29nxABU23/+dM13k
 suDqHgqXMOt/S/TcYjhrKn8BEwLxiOvFRlsd2PgYdULPjg2BqHKTw1KFCC7ccz8JVIJq
 mw5Q==
X-Gm-Message-State: AOAM530fXfAt1iO+tpQKGJWoYDCKrfESyymWTgSptS4S1LQeko9lqdIu
 XVAv3uoENV7yHKI84+HepnvSDl8xnOE=
X-Google-Smtp-Source: ABdhPJwvwPbdgP4kP+T1R5S5HUa7orPif34+fyAjbnItLIsWre6VQmFgnDMpzMXSUVfgv54IzlWG3Q==
X-Received: by 2002:aca:530c:: with SMTP id h12mr1302636oib.172.1614978661484; 
 Fri, 05 Mar 2021 13:11:01 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id p19sm868496otk.63.2021.03.05.13.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 13:11:01 -0800 (PST)
Subject: Re: [PATCH 1/2] nvme: add 'fast_io_fail_tmo' controller sysfs
 attribute
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210225110534.75710-1-hare@suse.de>
 <20210225110534.75710-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5747d377-fc4d-f5e9-9428-e331be93b44d@grimberg.me>
Date: Fri, 5 Mar 2021 13:10:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225110534.75710-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_211103_101353_2D925AA4 
X-CRM114-Status: UNSURE (   9.45  )
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
