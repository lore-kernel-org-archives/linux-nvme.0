Return-Path: <SRS0=9AXB=K6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD16C4743C
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jun 2021 20:01:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED98B613EC
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jun 2021 20:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED98B613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YDzacuDyf35vYPxvd/K96BB9NCkg5Q4o5rjwL8ZZ5/A=; b=j0f+brnpX9FlwjR8+YHXk8di48
	L4enJfB9j8Y59YpaQpe6FdpavqV8SeOSTTTNRXCaFyUEBJYkw04WecGrnh5LmfVA2nT9UMpDYCuly
	H8VbkIa2Liv2BOj4gd/TB2XaVS8MT5ES8JZIqGh7gSEQsYpbIVZjI/ApMkF6pCNo6xka2AEW9sfRm
	jgUnzSesEIn0L47SNzsnjC0iXAiQQtP3l4wD6H2eNdzxrdz1vQFUuYmcTplZtedkKed5GmKDe83Fu
	QtCoDpwuxwmz5m3K5OF6r85y3eTNIpxQfmJSl39NfIo8YE36PFeW5t3Jb6/cOwkRVF+FCAeksPeYV
	NH8kv1XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lpG07-00F3bi-LH; Fri, 04 Jun 2021 20:01:03 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lpG03-00F3ay-UQ
 for linux-nvme@lists.infradead.org; Fri, 04 Jun 2021 20:01:01 +0000
Received: by mail-ej1-f53.google.com with SMTP id jt22so16249190ejb.7
 for <linux-nvme@lists.infradead.org>; Fri, 04 Jun 2021 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PiCjHeklg/T0SzOA7e406SgYZUGIw154ONY/fprUGik=;
 b=C+nZuRFR0WmApv+45ZEEZGXAA2OAqW+Q8qyxaJMOx6rFUh5NdCU7EKjnL71zOA4wYj
 WmigbfF2wjHovMIt1ewGxsiu8R2sYW2kbhvgspGuuPyf8sM45aJs4nfOVJ+9XUocgp5z
 /OPreMZz9n8TGQgUDUUDBPyLqmyimvO+/fyPdhuRL4ilaBNU2rhvTzgBnE0Fiw4f1oSF
 7dzxY9u6O7Gmk3JCkLOdphN+cQqLsN6BukO5aQqW9trk0j7deEBIu7uK5XIH/ZGnulDr
 PumSnBuiU653BQXRZY7skFyQjlsyqWJcEDprZicRBrY44oFjilv4IAtP4n6YJC+9MYGN
 qKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PiCjHeklg/T0SzOA7e406SgYZUGIw154ONY/fprUGik=;
 b=BgDyU6n+/l2kcpoaSqSYvjfJD5zcngvunr/oqDMrRZ1Vu+L9T3hU80hfvVC3r1Q2nf
 3AzNQQw9Kiinlgh7IM7/+6w11JjqaEn9AwmYieNsxyGS73b+jP0eSJkZMjjFMJ+2K9gk
 oarpKISSmbeywdQZdt5x5ryfaOKsEV5tQ4V22/0/fjI4VdM/WdFcMoKtqiR/Ok4QO0u0
 QTBaVxz9qQRy/YRp3z25tW13fc1qQStAEJPKWIrxbbYgdCjw06AmqBgREgSSwDCtgv0M
 Pm4pQH53IXpkaAtLGKJ0i4I/kbp0jRRhhAo5qEVrlZmreCGbZ0NCC921Act1/tS2LHz/
 NFmQ==
X-Gm-Message-State: AOAM53205Ck64mwXiagSWbjdrvN0v2J2A3n3I8QZdvj+I4ESpkrOK3Bd
 8XMKYZYd5VFnMwApIw7N5Jc=
X-Google-Smtp-Source: ABdhPJzDtXQq60L7ImYbm1KjBldo4PtWRwDq+GCRsoZFbTvHHd/qVL5ibtUaPD4oHZui7/dynFlezA==
X-Received: by 2002:a17:906:274d:: with SMTP id
 a13mr5873040ejd.51.1622836796818; 
 Fri, 04 Jun 2021 12:59:56 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::ed5b? ([2a02:908:1984:a6c0::ed5b])
 by smtp.gmail.com with ESMTPSA id f18sm3180025ejz.119.2021.06.04.12.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 12:59:56 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
To: Mario Limonciello <mario.limonciello@amd.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Alexander.Deucher@amd.com, prike.liang@amd.com
References: <20210604165403.2317-1-mario.limonciello@amd.com>
 <20210604165403.2317-2-mario.limonciello@amd.com>
From: Julian Sikorski <belegdol@gmail.com>
Message-ID: <efa36cd9-c125-e660-048d-86b7178fbdbd@gmail.com>
Date: Fri, 4 Jun 2021 21:59:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604165403.2317-2-mario.limonciello@amd.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210604_130100_021221_D0C8C291 
X-CRM114-Status: GOOD (  23.75  )
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

Am 04.06.21 um 18:54 schrieb Mario Limonciello:
> AMD systems from Renoir and Lucienne require that the NVME controller
> is put into D3 over a Modern Standby / suspend-to-idle
> cycle.  This is "typically" accomplished using the `StorageD3Enable`
> property in the _DSD, but this property was introduced after many
> of these systems launched and most OEM systems don't have it in
> their BIOS.
> 
> On AMD Renoir without these drives going into D3 over suspend-to-idle
> the resume will fail with the NVME controller being reset and a trace
> like this in the kernel logs:
> ```
> [   83.556118] nvme nvme0: I/O 161 QID 2 timeout, aborting
> [   83.556178] nvme nvme0: I/O 162 QID 2 timeout, aborting
> [   83.556187] nvme nvme0: I/O 163 QID 2 timeout, aborting
> [   83.556196] nvme nvme0: I/O 164 QID 2 timeout, aborting
> [   95.332114] nvme nvme0: I/O 25 QID 0 timeout, reset controller
> [   95.332843] nvme nvme0: Abort status: 0x371
> [   95.332852] nvme nvme0: Abort status: 0x371
> [   95.332856] nvme nvme0: Abort status: 0x371
> [   95.332859] nvme nvme0: Abort status: 0x371
> [   95.332909] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -16
> [   95.332936] nvme 0000:03:00.0: PM: failed to resume async: error -16
> ```
> 
> The Microsoft documentation for StorageD3Enable mentioned that Windows has
> a hardcoded allowlist for D3 support, which was used for these platforms.
> Introduce quirks to hardcode them for Linux as well.
> 
> As this property is now "standardized", OEM systems using AMD Cezanne and
> newer APU's have adopted this property, and quirks like this should not be
> necessary.
> 
> CC: Julian Sikorski <belegdol@gmail.com>
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/device_pm.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> Changes from v4->v5:
>   * Add this patch back in as it's been made apparent that the
>     system needs to be hardcoded for these.
>     Changes:
>     - Drop Cezanne - it's now covered by StorageD3Enable
>     - Rebase ontop of acpi_storage_d3 outside of NVME

Tested-by: Julian Sikorski <belegdol@gmail.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
