Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865FDC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jan 2022 09:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=kpB5lOVlCMTarD4g/bWpBOdEMC
	y2YBnZ34nvbWsEbNmrI/apcU4rOLw3x2sH6952nqjix+wM1vburChcpVb+4+vaUnZBUIyaxZV22mE
	CGG1GYdTOmo8HKtvD7zvsiGYr+Ya9wytqlDSS86vmIBm85cl4AvqpU6I9DfoZ4zgSKyGecQ1rK+09
	d1IGyFcXEuaE3V+9BD11WCPlqSmujJq1pH9XOsTDCf8XFSuchTJmP5AYuUsxZ6+fzvk8YJXCfM2E1
	F3R0Nsl7BWTnTuyV7f6RgURW/8gbIOFUsIth1yjE8ERTxLDrhh6YQth0aUmtm9jwRF3/49qgfSbCb
	E10hxUOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBYz8-000VVi-Af; Sun, 23 Jan 2022 09:16:30 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBYyt-000VUz-Kr
 for linux-nvme@lists.infradead.org; Sun, 23 Jan 2022 09:16:16 +0000
Received: by mail-ed1-f44.google.com with SMTP id b13so51054881edn.0
 for <linux-nvme@lists.infradead.org>; Sun, 23 Jan 2022 01:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=RcSH/viTRQBIe3NRXisA+eI/1eqKQDBcmuHSBMO5tAWcJXQznjoRjWvAZ8k1Z3cx4g
 YdniHtMNhxcP3TjAYUXaWOQ5cLFYTkIk7thbrhAHNys79mVo33dl5uyAwe/slM4EgVTa
 Qnmk8nO7X+/EHzr7mJ/W2mxgloQzr0o8/UgwdtEu9F9IkWH6QJMqtPO+cQDGVaoEPSv+
 Yj1ahfbpXkViQjGq5rR2grEwZKmIxoOT771TEO8IFmFcjTaCBiv968Y7P9e2STVuC6Oh
 ZwKlZtFWqW+/AX6X4UGGkSyCAK5cxoVNHvmw8Cbkrkzuxz9WMSlUZQko8ssLFGDYdRy2
 GoSQ==
X-Gm-Message-State: AOAM5306p2/AGGNlrCEjBX4G6n6ILYYmFepNZFYtm/ouDnGVLJEeyeFm
 4+e4G9Lxtu/nfxfHQoGn5Rwj+vw6USM=
X-Google-Smtp-Source: ABdhPJzzsqPdenfU06WfEC0zKY1jdZ+no/zSE4ctDKikaTnrM/XGYcVKMnlcdjHoVFQGEuWnXFp8zA==
X-Received: by 2002:a05:6402:2994:: with SMTP id
 eq20mr11061122edb.281.1642929373230; 
 Sun, 23 Jan 2022 01:16:13 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id gh14sm3581094ejb.38.2022.01.23.01.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jan 2022 01:16:12 -0800 (PST)
Subject: Re: [PATCH v4] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <1642870664-3401-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <23ddf451-2540-86c2-c403-2614477c130f@grimberg.me>
Date: Sun, 23 Jan 2022 11:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642870664-3401-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220123_011615_721130_1B6CCBE9 
X-CRM114-Status: UNSURE (   7.54  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

