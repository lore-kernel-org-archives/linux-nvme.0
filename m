Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6A0C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uje3LCySfaQlUQjhZYuiWJYvV7rBiSMPGA/U2mclzvI=; b=PqsbRjPC17E2TuNv3QxnBjIun7
	JKNNO8z6Q9txGSGC3sZq3YmlBgX7Wq4Zk1JH44Mgkm4q8RRuhQNk/pwNJ7LsDHSJihnVNsWgzYILD
	dalmV3OUm3iSy4xp7t6tzDtUZAuGbkURpTIqGtG8nZ/KoJ7xvq+FHSDSfKjrGq54nyobO8AQ9gxYc
	UcaFQd1U6yaBVNuDZlQPjVLGst3KPhE2ljBPtKFKioVDxYRaTGgehgqdXH0WAieLEFpOmEJFUDc2z
	IlwLsPEUR/VabODmc1nTDmHY4J6LYDNEBmNEYv5jh9cAahIvIMsAdisHJJHmrER104+GNBH5ox6Ex
	7Nz6TT3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pebnQ-00CTSC-2w;
	Tue, 21 Mar 2023 13:13:00 +0000
Received: from mail-ed1-f49.google.com ([209.85.208.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pebnN-00CTR4-0g
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 13:12:58 +0000
Received: by mail-ed1-f49.google.com with SMTP id eh3so59417612edb.11
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 06:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uje3LCySfaQlUQjhZYuiWJYvV7rBiSMPGA/U2mclzvI=;
        b=LORYzjfdZOXnX1waUU9MlkDkZKpOQ9KbSqCJWKuTpOlaMaZAquxcAXw8nkvKLf8S4o
         zYDj9O7ud3Nv/NACXYKMxIurL83aA1sTi6yS3u3KVzp1TASmz1zEtYSudtHo9dWTnsHr
         W/q4ACwTgYOSInLdpTVxWyEptlKXEpGx6UsWULnQGIrmXWCOrqbacFF9BSe+QWT8HKh3
         QMZOJUgQHxVVKlbVxR8QoOZjnDKClAmSFROyQwdE5b1CBWsdgXBtZwBfeHrLvHxszjF6
         aEFipa9cWASCZ6GP7VPLZpQSSvYZw/FHj7ZpVc2ZiMwknu0B7DhvunghuBMy1R3GqifB
         ZhDQ==
X-Gm-Message-State: AO0yUKUnejV3J5HAPzbnMYx7clQf3T0EWZpjaInS3ATR9bWWaCejv9Ow
	Xp1gKg0u17dlN80YrkeYAdA=
X-Google-Smtp-Source: AK7set8t2cDe6tzSHXZ3HbzW8I77f3FAVLiW1Tlu7OQxrCGjAKsft2jxUSmevWStyWgdBID0qaAA6Q==
X-Received: by 2002:a17:906:2252:b0:92f:38a6:d087 with SMTP id 18-20020a170906225200b0092f38a6d087mr2367546ejr.4.1679404372264;
        Tue, 21 Mar 2023 06:12:52 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id ml23-20020a170906cc1700b0092ce8344078sm5821362ejb.33.2023.03.21.06.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 06:12:52 -0700 (PDT)
Message-ID: <98884644-99f3-7b3c-387a-66fbdd98d4ed@grimberg.me>
Date: Tue, 21 Mar 2023 15:12:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 00/18] nvme: In-kernel TLS support for TCP
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_061257_272419_47E03112 
X-CRM114-Status: GOOD (  11.56  )
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


> Hi all,
> 
> finally I've managed to put all things together and enable in-kernel
> TLS support for NVMe-over-TCP.

Hannes (and Chuck) this is great, I'm very happy to see this!

I'll start a detailed review soon enough.

Thank you for doing this.

> The patchset is based on the TLS upcall mechanism from Chuck Lever
> (cf '[PATCH v7 0/2] Another crack at a handshake upcall mechanism'
> posted to the linux netdev list), and requires the 'tlshd' userspace
> daemon (https://github.com/oracle/ktls-utils) for the actual TLS handshake.

Do you have an actual link to follow for this patch set?

