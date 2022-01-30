Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C970DC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 08:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gwjXkd8SP9whgU/XfZ3Wy3o95L/x8ZmhCCX+9uPwOZE=; b=XzHh2dBKRgDzgYt5Jkp7VUwL97
	OILP0ddcVjyzeke8oWAmkWWxZcP3TpDAYGBbMJ4zzi4ayiEj8pBvtBD5MviVXonubyy4l6aEcFhIA
	1hbE+juZHaDLOLOGtah0cGueOOxtGlJd/p4Xh9u9BvvJj+SFTfAwTCquHMyAK/Nrz6HTZgcpJ4QgM
	KpEfTV52t/bEY10Ewl2F9qmKo+jp29s4IVl/E2GN0uxSs54tkxfUCbXRfbXZnVbblQZaiMSuv2qkN
	8ry7E6Kk2PxD1f/gQvY6I8Fc973Y6gAoywVPeXHivpL4vrWWKovxQ5GcQp288li/dXZdHc4Tv8Mk+
	K285f1Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE5s1-006Anv-Ir; Sun, 30 Jan 2022 08:47:37 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE5ry-006AnL-Em
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 08:47:35 +0000
Received: by mail-wr1-f47.google.com with SMTP id f17so19512498wrx.1
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 00:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=gwjXkd8SP9whgU/XfZ3Wy3o95L/x8ZmhCCX+9uPwOZE=;
 b=6bRkPV35+kkLVpvQvpfGOqb+p47DQbiZ/hXcHm0/Pj1xU/9JU0/Si6VJSB1ZssNh9x
 JTf0r+AhPP/oVQxDZ50Z/L+YlzlDFqmrfuGXUvF953VP6xI/0BT60sWtlPcmsHFzhP5r
 f6udr/ZStV/f8HuXbs+4NPxCAyTFOkq+aocO6msjTzLtWuH4ANEtm1vRcKOs9X6PiuRK
 4jKDhRmlDZDCy/4HzwOMfjFtJcnD/RSDdNi06HJG2HdAfAUyIizvdOACr8JcofXkW7pk
 ChzB5w9ypRdH8Yr0feYBMtfj6nDAD52gvsnm1n6kllJNsWoKBEAkF3kz7HjFGw8NYDG5
 PyLQ==
X-Gm-Message-State: AOAM531YpsUujkE9VpAMYvLIxtwmRa/Cl+6VkSSiA2pq0xExA1oaxJXK
 9pM0uxKfOCme9o2PEQI7FNj0RdOXkwU=
X-Google-Smtp-Source: ABdhPJzLR9dX+u6vRaEnQ/eCY5aiX+C3S1X7sQFjUmSztlDCWKw7jwh8YnOR1kP5qyhYIATqWfFZcA==
X-Received: by 2002:a05:6000:178d:: with SMTP id
 e13mr12785296wrg.183.1643532452896; 
 Sun, 30 Jan 2022 00:47:32 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id p2sm6035746wmc.33.2022.01.30.00.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jan 2022 00:47:32 -0800 (PST)
Message-ID: <47898a48-ee1c-ac28-62f8-85b205a16a5f@grimberg.me>
Date: Sun, 30 Jan 2022 10:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: ncme-tcp: io_work NULL pointer when racing with queue stop
Content-Language: en-US
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org
References: <CAPnfmXLsLwUKU_OdELsxy9gkR+21yTHFst0KUqb-c6Zd7OyB_A@mail.gmail.com>
 <0617b76f-6335-5dbf-9f9e-ba5151651e5b@grimberg.me>
 <CAPnfmXKEeTrQ2KH-UwM1V-vkAqk6KVxu9iZ5n2EpisJmY5eVkw@mail.gmail.com>
 <0ff519b9-9248-1f88-7117-ace764e18f64@grimberg.me>
 <d33f5615-0e40-2e6e-76a1-b9450fa9ec6c@grimberg.me>
 <CAPnfmXJceXFDAUXND--8UiUJeyzL-8NUAdgYcws=CodEEOF6Zg@mail.gmail.com>
 <CAPnfmXJjaueZeHb0eANu_78n9dby82crquuxVWwiOD_P5gEY5w@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAPnfmXJjaueZeHb0eANu_78n9dby82crquuxVWwiOD_P5gEY5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_004734_533464_9B63695F 
X-CRM114-Status: UNSURE (   6.84  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> This completed a day of automated testing without any failures.
> 
> Tested-by: Chris Leech <cleech@redhat.com>

Nice, I take it that the driver did not survive this test
before?

btw, nvme-rdma needs the exact same fix. Will send a
small patchset for it.

