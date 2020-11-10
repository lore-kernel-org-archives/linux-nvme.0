Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE2AC2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:52:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE26206ED
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V7/XYlFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE26206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hfELGdJ8Y52fBlhqIraljmXpUkMIB1HyQAl9IhNQd24=; b=V7/XYlFeSYffw2mVvRC+jSkJ9
	lrnsT3Y8+rc8x7p97EZN1eNIgxlwRdPIz2KDFFDiZytQzlAs27bNVVaSzCHbJsredGNXaa1cTl4V7
	29NCexzgNtze2NypwKfxCi9y5+wo+tmBOXCKPAARmE1q8aYVbd0pI4M/Ksj9tGC3SWcu6MsCkMwCW
	15wsXrIwNBKMUePgxRSJqOMrYIDCx4gL69EOdX+50lO0x6N5gaFC9Z7xw/wvirG2UKtmr5DMVRaC4
	Rz1lm/V0rMA1qLrr71j5ndRO4IBRvH4+hNJbV1OX0LeZAjxqhKDrtsOrwHrJv/PiiSFBdVJh2CGE7
	GCba/LUtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcJlF-0002ct-8S; Tue, 10 Nov 2020 02:51:57 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcJlC-0002cS-Pr
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 02:51:55 +0000
Received: by mail-pg1-f194.google.com with SMTP id z24so8893276pgk.3
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 18:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iz5goO/pEyyXLzp6Y5SVSSxugIri+sY+pte6YwKRUEc=;
 b=F43qtcrtEIoFTZsN1msyZhVx1VZqnVwLO8G5qwO6Z4L+Yjf9KIXkqvMEy9Vk7DQFBa
 X8ZxqjVPzsLXut/91mclhN/COhlWrmfna/6vS55f3TWc79jYEsrWzGVWbzHhQyiNfN10
 BclXivXOdFh7EkpUolXKZavaqpMzY2tnqGK2eDVvPPze60qIGMBneJC+Q7tURSKqJN/N
 YxZ9keqLH8JZNw45xU4+AmHjg5y8ExPUluW9FW3UaVhP757O7jgN6zcq/f0ACwwp6yzU
 x4r81Sl99aSzz0cGrMPQJ7Dp3ic2JvMptEt9hPmGtC1ZYv2gKATJBdOYZrvteKn7lKlY
 3hUA==
X-Gm-Message-State: AOAM5307AeyoVxXVjZ44Per+H8VegXCcO9iOHxpi13Aw0OO3f27bomF0
 c/Q/z91byXWuxExK2q17nj8=
X-Google-Smtp-Source: ABdhPJyiAVAqzdAvtQ0IcHoZNGbdMwqpgMqbKjpxcF3uAeWYHZpE/rE63uDqkKPuO75Ah1d7/ZxIcA==
X-Received: by 2002:a17:90b:300a:: with SMTP id
 hg10mr2585200pjb.30.1604976711401; 
 Mon, 09 Nov 2020 18:51:51 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id k5sm909720pjs.14.2020.11.09.18.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 18:51:50 -0800 (PST)
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
To: Keith Busch <kbusch@kernel.org>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <20201108082403.GB40741@kroah.com>
 <20201108223152.GA2219646@dhcp-10-100-145-180.wdc.com>
 <8ee7a7b0-5be4-99a3-7314-77d784e2ebb7@acm.org>
 <20201109023544.GB2219646@dhcp-10-100-145-180.wdc.com>
 <90da3071-0d73-f007-5892-d683de71d964@acm.org>
 <20201109150517.GB2221592@dhcp-10-100-145-180.wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <8c710753-a52f-1ddf-d5b6-dde3847b3749@acm.org>
Date: Mon, 9 Nov 2020 18:51:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109150517.GB2221592@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_215154_847117_68429B1A 
X-CRM114-Status: GOOD (  14.53  )
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/9/20 7:05 AM, Keith Busch wrote:
> Resets can happen at any time, so user space should always have been
> prepared for this. Is there actually a real case that is not working for
> you?

Hi Keith,

The use case of running nvme-cli from inside a udev rule is not
important to me personally. But reducing the boot time for systems with
multiple NVMe controllers matters to me. Do you want to recommend an
approach or do you perhaps expect me to explore the possible
alternatives further?

Thanks,

Bart.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
