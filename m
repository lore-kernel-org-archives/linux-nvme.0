Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362F0C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 17:01:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB8A2242A
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 17:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB8A2242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EFyayUaNX6ZdTM0mDsfNhjZKaIqY9BRr0j9gcPQelBo=; b=2hHRUCMAJesBIy4GrcPUKTvY6
	8uxDKqlJFvbE/5r62pK7BzuMJQblncdInyRojrxIrhxgZ2EgiJ0CZLlvrxr6h1lmFsFF5dy/2cZLI
	+FdMyf+0VYWcqUdJ7UPsbMmZ8f/MhsOiDIwfh7vNqfjbe101JQla+7Odm04ghP1CZMHY5uXH17+Vo
	s84FA30Mllb84TEfF3/IAoK6CsGqnGQIK/5Tz32zt4OhHOpvth0hN/k/06FhPNIQeKlVw2/sGzGpG
	Huov7X1yx/i9rzZuFpvjFvG4F7In8F/TtlWSWoY+iMlFXIUYLrCb1neJqJ3Wor8FValy8gZA5fIQO
	6leabgMaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kz0ZB-00013p-IU; Mon, 11 Jan 2021 17:01:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kz0Z7-00012H-Q0
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 17:01:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA26E222B6;
 Mon, 11 Jan 2021 17:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610384473;
 bh=G1qXEBDT+3uLLjsU4LrKDhicL0RyPhvBjbQK9E+61VE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QWq7jAfMo2vNSDu2o8wIjoLmOKTYObgd393/uKgbosS6M4mLQ3R63qSAtAa1AE9Y2
 ysJy5HoUqLFGn0ibFnKsbV/gf3sFAb71cDBA694dD4l/7D/ZIa+aFN9luFu8oJFlAG
 7pqsElAWizASrdEO+AJJGaUvbUFenOGx2twTEmTPK+b/gKvakb+EazfXRJjKteN/Sw
 shMhgfCK0d4p0g8eSQVpEmBmzoSgjYVpOLt3xcz29SeY1eQn5nHZAQf4osCfzoarf/
 9JzVM0WL/WZnI2VO+f2nl2LbRyy0f7zGKVo9NuQMjmccifewj3/jU0DKqMkbu97gJy
 jfOoAPtk7ixOg==
Date: Mon, 11 Jan 2021 09:01:10 -0800
From: Keith Busch <kbusch@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] nvme: trace: parse format nvm command in detail
Message-ID: <20210111170110.GC1458209@dhcp-10-100-145-180.wdc.com>
References: <20210104155343.GA26034@michal-desk>
 <20210104160220.GB1024941@dhcp-10-100-145-180.wdc.com>
 <20210106090053.GA32643@lst.de>
 <20210108223431.GA1451691@dhcp-10-100-145-180.wdc.com>
 <CAPcyv4jLWOKDTyGzwar4C0H5euggvD_Ak6NESLd9=1THGC=ASg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jLWOKDTyGzwar4C0H5euggvD_Ak6NESLd9=1THGC=ASg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_120113_958069_72C68C31 
X-CRM114-Status: GOOD (  11.73  )
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
Cc: Michal Krakowiak <michal.krakowiak@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Michal Krakowiak <michal.krakowiak@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 08, 2021 at 04:12:31PM -0800, Dan Williams wrote:
> Is there a more centralized place to land such a helper? trace-cmd,
> perf? The nice thing about kernel parsing is I don't need to have a
> separate pile of disparate tools across subsystems.

Yes, I just placed it in a temporary location to see if the other nvme
stakeholders are okay with the idea. If so, I can make a real patch
series to remove the in-kernel decoding, and add the parsing script
somewhere in tools/.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
