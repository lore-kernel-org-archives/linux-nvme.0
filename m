Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D77C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 15:46:51 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF6C61492
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 15:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF6C61492
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OFxAvQxqbeDKxuhHBviTP3EWzsJV3IKkpTbs4ob6ahw=; b=YHc7YXvReIglpf
	KU6K+BjxWoS5m8q0ynkTBTOoucYGIMO3KKfZxCK0If3hPzqGAyzMaiT7y72pmKJPtl7Mor9vZYn7g
	sjb9uP8z78fKKnLFdLsscf1hiQDNgYOTGHqP5bJs5TCFyLT59pHRwK9tG9g5z3/8CYcaFaq7PFPDD
	rydEIaMiAXz8Z9QHuDN/15yXZ7Og999X4yREcYFPfJAL3jqXcs6t1gGbebAL5M+mjoUG2uFawmmQw
	VUP9o8zaRiFXbWPRi11gnzuC/C4BRgMyllMAK9Y6IE5EDC3cWpVxP5nyEY+fmzj8a96I7t4vjghyO
	4vrsl0jhNn623BLeZkhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltBGY-0014rk-R0; Tue, 15 Jun 2021 15:46:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9MB-000E8e-Pf
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nQY7irb99BB91xpsETIvasgskmUW6b1znlET0GEeHGg=; b=eE8epEJRwIMkNyWMww3DG814Ek
 Mtpkw/7Jc6knJJOOCJ5DjHB+iJdCXwQl1knfsQgYiqQUDSZ/ZyLGUUkJ9HzUDdMNB1tiUEqD6ZDe3
 XbPsX6xVHx2+MeH6kXo7JcBvlL/gJnUOKpLKcpzXsk6qe7Ott7Buk95DmIMHTpcyNlNBg2NlNq0k2
 h3l/zeDbfy6+s3+i5JvXAqcyaga/Fx8i3SnKhwdYPQ5WbkUqb1X5RC2tBv+kYoXPFA1rwjA1q/YIU
 pr/GUCaagL9XtK1TV09BOImonABzxSU7cQkfHRqL1CgPZH6uljGhcYT3VoB4+ZyaoZpehH2ClStGy
 SvllJxAw==;
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt22l-007O7Q-MT
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 05:55:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C9DEA67373; Tue, 15 Jun 2021 07:55:24 +0200 (CEST)
Date: Tue, 15 Jun 2021 07:55:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
 prike.liang@amd.com, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Julian Sikorski <belegdol@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
Message-ID: <20210615055524.GA21218@lst.de>
References: <20210609184018.26017-1-mario.limonciello@amd.com>
 <20210609184018.26017-2-mario.limonciello@amd.com>
 <831df669-b38e-9f4b-dd67-b613aaab6c28@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <831df669-b38e-9f4b-dd67-b613aaab6c28@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_065530_642732_B50453D6 
X-CRM114-Status: GOOD (  11.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 14, 2021 at 09:02:36PM -0500, Limonciello, Mario wrote:
> Christoph, Keith ping on this series.  Any other thoughts?
> If it's good can you take this in for nvme-5.14 since Rafael mentioned
> the conflict from the other StorageD3Enable commit in nvme-5.14?

I'll queue it up for nvme-5.14.  I was planning to do a run today.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
