Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17213C5AD49
	for <linux-nvme@archiver.kernel.org>; Thu, 29 May 2025 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T1mdLSm3nVxSoKm/jOhyZSowakO/MavTgz/9RPVrb9k=; b=mJIeP/r03kkFPkQakO4eS5MDzI
	MTcz/gPye9SJwQcFGRqBhwRdztWUMJ5RaBCrsOiezhQ5PbOZiCjMWTSrWuwjGWCqvAwNGrx2NIMMw
	zz0mpp1eA4U4XMYAGcVZLuU9VxtsMxuBrbsOhfP5UqGXbAhyUFjkohB2Jrv6yo7nWv9kY4kgV/F4D
	L8CVXoDwqQp9xGtbyeHFJvBA5fnE6Yu1bR7ytprKmhqZ3g/o3/lSolNRvJxBIQYS+me459shJCSeQ
	z/EZVb1GKwL4HOZjReaec7rq0JLaoLQkRZ+PGbWMwbiC4K4yMHaA5t+PQq+sltDyA2yzhAgSk/OTx
	13v9M56w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKhET-0000000GIir-3Yg0;
	Thu, 29 May 2025 17:39:57 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKhDF-0000000GIff-2Qr6
	for linux-nvme@lists.infradead.org;
	Thu, 29 May 2025 17:38:42 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso1190784a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748540321; x=1749145121; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1mdLSm3nVxSoKm/jOhyZSowakO/MavTgz/9RPVrb9k=;
        b=Z4ynNVH4YWk7LVbljwqgoO1Y6mT7seW/lVWoYpYjQNLdH7o2XxAh74HGWQgAL/+X17
         DUseWmkVuZEQu5da1SJC/d53wlDbLoS74yIut0KlaDdE88N8dTMUo+Bugbo32vBA4w3c
         wluEJh7lD858Wgd8SlS28WAVf4MjDCennrm/4A9PUSScAt8pS6gHkwDKNJ2pTRHCchpf
         4FOHEQPwklEXqdSaT+4dz8XkAz5wWwqSG4ZwKgfKlrStcJYZK1kWGOEBlEuKvVU1JjK/
         ZyGtfhOYAO2gSE0QVDeLmQErJFigQg7+updewCt671iUBFhG7biM2s8ntPnIVSncoVqf
         uL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748540321; x=1749145121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1mdLSm3nVxSoKm/jOhyZSowakO/MavTgz/9RPVrb9k=;
        b=gEkH9tc67QDzelyD1F910tJdirr+s2foHFzf9FZtiu94JmyjFkrxhT/CTZY3XhFKb3
         0/jbd6ng2zu74UDAvXOkeEUlfVAhdPhjtfUSqEL8+DJUyJxy6I8OkwTWVrQMNXyIlk5L
         3njxQ9HnPMCX/ZuYJQCS3SKFIlHZL0/fW83HdSPXHy6xQEX5n+GKTxcEMEypb1lY6SJA
         cF5OlaDZO/DCxzb4rNmC11qpGOeQVE7WvcqvzuAHEyHgJo2TBD5pdvuZ7Zm5OjJK6c0L
         uxDI52RZp3npuMK5JsfTt+Ox/5AP3Go/wYA6L+QC0/kVD9vLDHIs3ClnLm0ncowgnxB9
         7ncQ==
X-Gm-Message-State: AOJu0YxhjQizZX3n9iDRHhHaXzIwcakTbhJzc6VLY1fj5z0Hv/Ozp97i
	QHes3dS4OTTMAIivF05SeVaVgFVluSTMvZnMEQiyy10QOFK13FDldfDCOQSiTw==
X-Gm-Gg: ASbGncuzdTM7yLOoaxtmPKE/o3VWBDAOaw0xLsFsTbvGHaOstoBPkolSGeMITqUMk/2
	x1EkQpTtf5aMrdLFJXsnMG7nFGHKh2sQm5zBss0NwXn9Um7gVde8c+kpzSOkCrm12353uOYidVc
	WJY5Mmj+IVaSbAjbTWPCITuaSUHVva2AbJPyD465fOSd2dOhfjuKk4pfvEgMDZWmENNfdGOXgnt
	AV5IC1RcKRltJwvvTjZ2IkQ8p6m/nJqHhFnuVFZxgqJ/vbHC5g1bSYj2lRg8hmdyYCVRw4ruCEj
	Y261R0HoIpOx3vaWR67DHGwB/exHvcSxHqSHIH62v4WC109Rbziu9zegzoiVxSM9KwVjsdwfbdL
	cAqRpWb2SqO8EQbssX2c=
X-Google-Smtp-Source: AGHT+IHMjXMJK3GIMsOW/r5Bsv+ElaAuf9U2fcPfjytvATWZScxw5B72u3zPh85DGzAJ367lpoSnwg==
X-Received: by 2002:a05:6a20:258a:b0:215:cf53:c35 with SMTP id adf61e73a8af0-21ad9787094mr1059607637.31.1748540320633;
        Thu, 29 May 2025 10:38:40 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:31a7:446:9364:5b1f? ([240b:10:2720:5500:31a7:446:9364:5b1f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff73fbsm1591826b3a.162.2025.05.29.10.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 10:38:40 -0700 (PDT)
Message-ID: <9164e067-09f2-43e3-b57e-99fa2c9bd97f@gmail.com>
Date: Fri, 30 May 2025 02:38:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: add NVMe controller statistics
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20250528170350.5514-1-ikegami.t@gmail.com>
 <aDdze52GrviTSmFj@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <aDdze52GrviTSmFj@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_103841_635765_65676DF5 
X-CRM114-Status: GOOD (  12.18  )
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

On 2025/05/29 5:35, Keith Busch wrote:
> Specifically on sysfs attributes, the intended use was one file, one
> attribute, one value. That makes programatically parsing these much
> easier. So what you'd do instead is create 4 new files called
> "timeouts", "aborts", "resets", and "disables", and each just print out
> a sinlge number instead of this more complex output. If you're concerned
> with polluting the nvme device's sysfs directory, you can also make a
> sub-directory called "stats" to collect such things.
Just done as mentioned by the version patch.
> That principle hasn't always been strictly followed, but let's not
> introduce new deviants.
I see.
> As to what you're tracking and reporting here, I'm not convinced it's
> useful. It's just a snapshot of what's happened for the lifetime of that
> instance, which may not be very long.

Just changed the attributes as read-write device attribute then user can 
reset the counter value if needed and accumulate the counter value on 
user application.
By the way I think any unstable issue behavior caused on a drive the 
statistics counters can be used to check the warning behavior cause but 
it is okay as not be very long for the lifetime.
Thank you.



