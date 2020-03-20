Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A6CC4332B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 22:55:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010EA20714
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 22:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hNlSEBNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010EA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3jDQJcdnUL8dh06DVO+T7Z1m9D/CJsXv7n1EWhgEnMU=; b=hNlSEBNPr3BKyydXUe/RGbjAH
	47KKe0DbS2Gv7UVmXekdLNwqJPjVWsAUWQaHzxtuEoF9rz+N9Tfo8FErbT1K/7AK/zByl+Y/7WsE2
	49jQO1LfYYz1DUceXT6UWa1PvyHEG+EkP+wJPBavpv4mD6pdsCQgdSHoBMbIBcudKNqHN5Jui2OcK
	zADMu4mmB5z8SDm2okpYP3IH6krS0+GOCqfogCaNXQa3hbPibMUmQE54Ei1PxtP0oOtyrWiuVdBHk
	9RBRvG/Zs9Hyv6wJZ3MavNYrkdyH+SJEJTuVlQOUEKpiHtkVkOQM85oFSMZLxAOKwr5GgevUF+cb7
	wkxVUgMiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFQXh-0004Pn-75; Fri, 20 Mar 2020 22:55:05 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFQXe-0003ug-0X
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 22:55:03 +0000
Received: by mail-wr1-f47.google.com with SMTP id h9so9391274wrc.8
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 15:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KqdJKSI2WgesJy581+hlBXWtqeHA8ciDvqvbjYA8ICo=;
 b=XGkSAOjLNE8DN5EwjHblp2bONaDLT7nJ8qRQOumjhqd8ZQEkv7fFIkUJ6xSmQSqQeh
 kWnX371ctGH3AsUw0YIB65QmAeTGdidiY6J6rlJBcjW46u/uzzKZcgY9SkRI3zLqi1P1
 8U1TrszEmThp1kqPGouviHsKaSo1uE8BdPMxlQ7QvmXF3+B1dqprVB/PbgvRYEDqdGLW
 URyi/pe0T4lAC3hvcNAWSHQaOj/cQzE89rk1s2JttyWpWsriESPZ+dnVYxG3l9nZD8Pa
 wbR7F+LnWwXL8baN/iFRcUxDGdG9E86XjQKVcJYos5yuzfI76vfmvkkQ2ZjfRTTTVWiw
 xJQA==
X-Gm-Message-State: ANhLgQ0fGPj0lRSJgIiSQUUOlrFFsc5zSdvZ4WI88Vf6oO0tJnB6Zc6K
 GLTZ7jVqLlZFJbD2WsTK9o3+rY/r
X-Google-Smtp-Source: ADFU+vvp3TW5FSropj19O4p4L5Y8mKoYsdOD9Snx9VZUSr8dA1g26LTZ+0VNXEXv8tTs5qUps2FjBA==
X-Received: by 2002:adf:f688:: with SMTP id v8mr13759302wrp.344.1584744899565; 
 Fri, 20 Mar 2020 15:54:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b9e4:7d48:9c27:2b02?
 ([2601:647:4802:9070:b9e4:7d48:9c27:2b02])
 by smtp.gmail.com with ESMTPSA id c4sm9704367wml.7.2020.03.20.15.54.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Mar 2020 15:54:58 -0700 (PDT)
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
To: tasleson@redhat.com, linux-nvme@lists.infradead.org
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
Date: Fri, 20 Mar 2020 15:54:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_155502_084459_635F2E60 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks Toni for reporting,

> # mkfs.ext4 /dev/nvme0n1
> 
> [  125.031254] nvme-fabrics ctl: Failed to read smart log (error -5)
> [  125.031509] nvme nvme0: new ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery", addr 192.168.2.80:8009
> [  125.034133] nvme nvme0: Removing ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery"
> [  125.246827] nvme nvme0: creating 1 I/O queues.
> [  125.249356] nvme nvme0: mapped 1/0/0 default/read/poll queues.
> [  125.250788] nvme nvme0: new ctrl: NQN
> "nqn.2014-08.org.nvmexpress:NVMf:uuid:23d9d3e0-a83e-45d7-a902-3e80679385f8",
> addr 192.168.2.80:8009
> [  125.257115] nvme0n1: detected capacity change from 0 to 34359738368
> [  153.188620] blk_update_request: I/O error, dev nvme0c0n1, sector
> 67108736 op 0x9:(WRITE_ZEROES) flags 0x5000800 phys_seg 0 prio class 0
> [  153.191395] BUG: kernel NULL pointer dereference, address:
> 0000000000000008
> [  153.191440] #PF: supervisor read access in kernel mode
> [  153.191468] #PF: error_code(0x0000) - not-present page
> [  153.191495] PGD 0 P4D 0
> [  153.191513] Oops: 0000 [#1] SMP PTI
> [  153.191534] CPU: 0 PID: 237 Comm: kworker/0:1H Not tainted
> 5.5.9-200.fc31.x86_64 #1
> [  153.191574] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> [  153.191619] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
> [  153.191660] RIP: 0010:nvme_tcp_io_work+0x303/0x790 [nvme_tcp]

Can you share which line *(nvme_tcp_io_work+0x303) map to?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
