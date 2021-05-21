Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD5C4707A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:18:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1354613EA
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1354613EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=qEwTRAX4C4oTwsZNvmf/6AOQHC
	5txzJ+X09baS9aY0fDOGSPLV8hjLUOyHnsVD/gMzZyIJhAGYkA8+khdI1reudKkKW/Sy2tCr/863m
	jmFUNsCo4NZ02mvXERd0nXf9PUsuqX6+YUzUEPucUFfJIm4zWuA42innoxCT6QLFMP2ERaY+3Ut+k
	8+OUGavYyPFIJ8kYjaA5bOj95B9YiS0ZHfJz/qFKFa+jxuTQuEdlGTZchW18lrcpKHadaa5SJ6bVl
	2EZcxcNkFH69TgGDvtS6MXaEYKm5f0l+LehcvxDTzcK2KlJ3BJTyTU8BwMHeHGFawniGXhcSc9t0H
	XbC6Zxow==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkBb4-0010Q1-QO; Fri, 21 May 2021 20:18:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkBb1-0010PN-C2
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 20:18:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=sf0EyM7k3OTGQ1BWYszCgeuXIG
 6hhpeS9BS760SL7fEdPNuIusiS1t8p4hR4keKJVsMF91mgwnX0wU39HWdzZ+sut9eqZBx/JoDcIJk
 K02kN0wShVJwxj5QIA6cyT+pHGiUVr9QywwdLIbShwPgidfY7FKTFQ+KSSgc1ADnrn19vmfciSuTp
 +qFN2IIUKBa/VD4mrgpgsgmdQRE1x3jP/F5Rgmcm6D4zy1pz36Yg/wL1hqcybfa13Xhr0jgbjjZOV
 lDZRmdC7X1/oAg0FU2VZRa5NwN6lFXvnyAZzDI2mujo1B7l2JZ5gSF3GUhNpirlG4jsYuj7mu7dj3
 2BY9cueg==;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkBaz-00HP45-18
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 20:18:10 +0000
Received: by mail-wm1-f47.google.com with SMTP id o127so11738961wmo.4
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 13:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=RT7qIm9O8MTTW/upQzwgZasJ1O6YsMnLTyUJ6XMk1ndgXrcWHtqO7i2VeC50oYhBZk
 NYxEhUT7iRifthW6KiR/bPtYU26X2uupyUhYrbhw5ZuY1+crWyTEVplyGb9q4jclv/MD
 dn3Ml0WV99MMmetnqT6VAAFiw+BUtS/W6ErSgVWfOfuiq+eKEMQR0ex7q97Qebsq1MKw
 4ZexVPPbu8jE6Aj5mMHVQF9dMqMSjs9gf5V61rSb4bhaAegGBlNTlnh97+R6ze7w/KVC
 YVRsy/fsjfyZp/+aeHr8+JJz74RZLmEU3SZDcpLzT0/SjOyR2/GGxL+qtlKcdUe1pYX0
 18dg==
X-Gm-Message-State: AOAM532lbGSTNiz294ytqtAy67uqANsxi8ggS7Mj+ST3EBkkmo8EfDXV
 dyiEdErDk0kWFAGxGR+CAN7YDa+5HK8=
X-Google-Smtp-Source: ABdhPJwKMTypZpwn0WnZtJRxQ2P0pGO80508JjRmFRBBcCyCz1EH4ZaMP/jBlteDyJ8CxUgkgDNjaw==
X-Received: by 2002:a05:600c:4fd0:: with SMTP id
 o16mr10751924wmq.137.1621628286969; 
 Fri, 21 May 2021 13:18:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id b10sm3284882wrt.24.2021.05.21.13.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 13:18:06 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: decode host pathing error for connect
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210521082346.146966-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e23bee63-7d19-85c5-7854-c69c15b54a4a@grimberg.me>
Date: Fri, 21 May 2021 13:18:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521082346.146966-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_131809_098372_C018F5B4 
X-CRM114-Status: UNSURE (   8.89  )
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
