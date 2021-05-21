Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CD0C47076
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 18:01:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D9F61004
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 18:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D9F61004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BqxR/rwJNNibFMAyMj5I/RRYsISkZ6mpyu0s7sunDYY=; b=ZmvNWRUH01X2NCjNYUIKFPQOBC
	1AdwxeZcrnhwUtvVjS2zr1QYja+p/7qfv+pB7SwGx6HK2UHy6XYaKB63fl42h8YXLwiaHhAVFiHBb
	VTPxkGhbwQvbScN/l3L2e/0yBvrTtcQbtcIsuutQ+6elikmYqbJzZwT3arGpE94UDHSTqhpRb8v60
	jACKsL2S4ltnFilGht3hV63eXFsCKxSTFxqHKBbNo6vzLoGLiflkrpUlQzc7j+3N3c/Gkdfeki3uC
	4qRORSluGgHYou8YfXLwECQYc7iot3ZgYrtvln4KuG4Pytd+D1AmU0yojiCUs6oFQAjB9Amy/ZV2H
	kX80rewQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lk9SD-000eOC-KB; Fri, 21 May 2021 18:00:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk9SA-000eNv-QA
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 18:00:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=K2OMHwJrFA1wNd3dbbnfZzfa7bj0/B6q6MDz93o2gys=; b=BFrqwJtp6qDfCwQT+fUptCy6Zi
 06+0WNJYJZfaZ/ZWyo+C2iB81NRxl5PLHd+N5ei3Cv/VPWoQLAUJNAC4OsnFYHA0w7yVaKPbVQjX/
 CISdFAl5VTvWGtWFcG0Ollt4KokG4P31KKBRS8U2ExN8gLXHTh+hQHQ4ZZfL6M46IKwOG0+WQLxSx
 WYzUjaOiwNR5t94qpXxvDAeoXzGt4Tgx1Og1ePV0lRpp3vVQXYe1Ze/GFuPSy1ptsl7PwFvtfncOh
 EoN86QrDGsEGUkHKhhZGRGCf0mBvB94WV58WCqhC62jBiqJUfqPeXTpS80R9y3N588WBh6C7wwEnP
 PmQKqadw==;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk9S7-00HL3V-T8
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 18:00:53 +0000
Received: by mail-wr1-f52.google.com with SMTP id p7so18165054wru.10
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 11:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K2OMHwJrFA1wNd3dbbnfZzfa7bj0/B6q6MDz93o2gys=;
 b=gl9HyPDmC+nZmcN9/AnnmKv6qg6FNLzH5g7JhnajN8y4+DoXzFcPq0nM2BlKTBptpR
 la/IVARKsG6Zl+6FTrIhRCggmxMkr6VaPAchV1JGXDT4PLPvU11S/E//QVWVVjfM1G6U
 wyOnIPsyH70wGGomTsOxzujxowPV/RiBWI+dYCY/WhXF/Z/A3U1J2WelXK68BlJQxGsU
 /4gJTIb7MywOqHvSnC7eMfxJXFs4lQGhjdeldBj0P47rQbOPu0eq06PW1+unDpJ0F0tz
 uvwkQ5gb4VNyJ3HukiSk2XRplKa/eodQkZ2w2MsF11L7unzNzaSMPP4LzlQwPML3/Oj9
 lgDA==
X-Gm-Message-State: AOAM533heX8mh4Wzprf0WDloDgxxC21q8RGibRLmBp6mPypFjW7knfTX
 BZtncYU7KnDm/i7Hf3oH/vs=
X-Google-Smtp-Source: ABdhPJwSsgONsBUKuWTQWzH+H/MLK3jNvF2rYJSDp1OM5I/f4uKleXyGGzvfG+qvaGKFxNu6PVlOzw==
X-Received: by 2002:a5d:5404:: with SMTP id g4mr11078217wrv.286.1621620049533; 
 Fri, 21 May 2021 11:00:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id u14sm238914wmc.41.2021.05.21.11.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 11:00:49 -0700 (PDT)
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org
Cc: maxg@mellanox.com
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
Date: Fri, 21 May 2021 11:00:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_110051_972265_0EFAC363 
X-CRM114-Status: GOOD (  12.33  )
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


> Hi
> I found this issue on 5.13-rc2 with NVMe/IB environment, could anyone
> help check it?
> Thanks.
> 
> $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> real 0m10.678s
> user 0m0.000s
> sys 0m0.000s
> $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> real 1m11.530s
> user 0m0.000s
> sys 0m0.000s
> 
> target:
> $ dmesg | grep nvme
> [  276.891454] nvmet: creating controller 1 for subsystem testnqn for
> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> [  287.374412] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> [  287.399317] nvmet: ctrl 1 fatal error occurred!
> [  348.412672] nvmet: creating controller 1 for subsystem testnqn for
> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> 
> client:
> $ dmesg | grep nvme
> [  281.704475] nvme nvme0: creating 40 I/O queues.
> [  285.557759] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> [  353.187809] nvme nvme0: I/O 8 QID 0 timeout
> [  353.193100] nvme nvme0: Property Set error: 881, offset 0x14
> [  353.226082] nvme nvme0: creating 40 I/O queues.
> [  357.088266] nvme nvme0: mapped 40/0/0 default/read/poll queues.

It appears that there is an admin timeout that is either triggered
by the reset or unrelated.

Can you run nvme reset /dev/nvme0 instead so we can see the "resetting
controller" print?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
