Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D66CD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=I1eW1th4Z5McVIanLJ169KFCZO
	BwNG/jJ02251zYwlNvi+Skp6jk/Z4l8QWGV2pHeumxTefFT+Zv8rubTGzRUUq0eFUXZuja7eudvrb
	4pnLALUq1QpEB4XpO/8A+El+KLG+b9gsr4OvkjbRH8Y7ZEQQ1wQke3AM0djsN7eALMJfBukfnP9eX
	MQjRUlkgPPZp0GnQ6n3THSWV3e5UEGwrWGajx1jEXM8D3QMzOCGiZwWZ1if1gM9lqOUcXB0NXp7Uh
	6NO/lugIhUaLUnuN02YKrHlg73S5wX6SL5UyYThA/3oJe+e+AS49W/4yetTChsYO1K5t+pQachHDY
	/T2u3gBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCRX-0000000BjuH-3pWA;
	Sun, 10 May 2026 22:16:11 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCRV-0000000Bjtk-0rXi
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:16:10 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso20757995e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451367; x=1779056167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ee/eSbtAiiRvQ94+LyxMZ5mWM4pO0gcndMfsnsNVSk6szRK5j5fCOVBuVtRCT7DA+z
         6rnoVw2EhT5/cM8eXSmB3RnobgCVSJEWGmVz1am4K4gMjVnI/F8Vo5ZjJgD/uXa06qa3
         DW3LupoJg/2uyaDGryfYWU1HYi1V9pqwhmnIDCxN5vnOuzeQp5pxB66IEX6v0HLUhAp0
         WXxuCOKkH8ahUPLo9WkUlk+X02r9FL/Gx8vaBsLq7kmt0eZPtYtKABiK4fnOXIZdNT2S
         JcUBSM0IIZfknm7t1lBhGOpfpRdMBhKvQH1KL8gU5GIRBFZgbG+9odNgSW9VbipWLy6z
         Q0Hw==
X-Forwarded-Encrypted: i=1; AFNElJ8dNd6z9BSUkor6ruJdIexlMybX4gEIuIH34eCC9ZMvyFh6MHfB9qhlKQpC0WnKnGHT5zwvvz4SZbwY@lists.infradead.org
X-Gm-Message-State: AOJu0YwHGoWa6al1etx1caBUvjUymHXE2OqPvjoF4Fmg1ZIgj4hLp3rM
	5RWZlaIICi2rw7DHMZ1YOHx0i+mrew52hzqBPwIS6zc6RP9KgEezw5Fx
X-Gm-Gg: Acq92OFbk5hhA28Jjdz4Jq2G3Q7e3YO9gCUXK96bKlfBHFaplhQJu/n+6R2bnUHM/qw
	1Zd8Dd1aPMEDADGi9MSKG44WDY0DFTorf76RoLrXAAmobkHXc8os3aTKK79HxNN9xxZXB2CF13y
	yEpjDrOgJiC+oGL06RtpE7g/dMl8Zs/wgHxKfu6JtiMGxBpnhqvLbHnQO3JKN1auQvuRV5IgTm+
	5NypXZ8PyapxBKJ8FVSowdoD8O9ZOy61s+6zyV92GfFOXepjo1Tp+8jDj4qOzifvYvf0BUPe0uE
	zro4//Ey/sr7wkDkaPnUhBqRQc7hZThNsD/r0b9ZYXeKyCV6cjpNTp9ldpf6LctruP4E3CubjIX
	EVtfSjDtehiIanQkcjWpF78VQzjqGMyp0Qmwc6jC9at6sNzU92HXPnLsGj+LmvyXq6GoY3QzMdA
	89SwDF8B++DxkcDH8Gis1JffeC23sgfA==
X-Received: by 2002:a05:600c:c111:b0:48e:8499:4bd7 with SMTP id 5b1f17b1804b1-48e84994c39mr1790015e9.17.1778451367215;
        Sun, 10 May 2026 15:16:07 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fffba5fsm136481555e9.2.2026.05.10.15.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:16:06 -0700 (PDT)
Message-ID: <003dab5c-bac6-49a0-816d-617fac42d8e3@grimberg.me>
Date: Mon, 11 May 2026 01:16:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 8/9] nvmet-loop: do not alloc admin tag set during
 reset
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-9-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260508133335.98612-9-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_151609_243542_90ED8D37 
X-CRM114-Status: UNSURE (   3.60  )
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

