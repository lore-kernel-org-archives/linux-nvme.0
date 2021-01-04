Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A00C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 16:02:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA1A22509
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 16:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA1A22509
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ekH48k1yQI3qTchMGyO+IRrJ/P7Zj9Vb+FFEewQfupU=; b=SUn8W/T8Nz7WQzTvuzzf0Q1mF
	sfUBb8XwyFlj/P4yvGmtCA+AZtAkUhgX2HjANW9yW0T1TKMTEkYn+5NUYDZKXImdRa5l1EkIsrZt7
	Xm68AL+laTUGoC8C+1IspGpFPnqsdezai3kT8TDOi79FLqOQmAYS9Gc/huuP6AtSNQD+6kXp4/kdb
	pqPNcLmcper+YfpLMYJ3AtjM8sPe8s6KGkWYJHWSBV9gTvv2EnolSFDSapJdgf9L4teSt0FjsxeaM
	wkx9M4xKKfbPV0YpxjXLa2caen/uHDFUGqKZkXpKBlufGOMzTle+Gq9ychGWCbeB+9UCCoUh5XgX7
	XU8NafLzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwSJP-00047V-34; Mon, 04 Jan 2021 16:02:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwSJM-00046s-AG
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 16:02:25 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4ECD0224D4;
 Mon,  4 Jan 2021 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609776142;
 bh=8bg6poNvzNnhiSbJ3dzsubSGc4mfPdd3R5Iba1rQWQs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GcSFhO9YBRL7vubBJexyh2sW9vItsVKwXpjTtDOdkSAtZ0b3odpVvhOttjNyyQvdW
 iUs2IY8XZBIlrGvy4woe7YFOMQj/waA92SgCqNZzlP3m5OOrobKGJOZrbDovxJLC6s
 GU0+wSZjXUWTAu7vYbtsOgZcUjKMkIfB/jHWlEHC0DqmfGHR1Zv1yfn4iWw/uBv8Jh
 FDDa6FoMaId7Lia3f4jW0bkc7m2nMhI/x3oo15NMFrkct43S/7edZM9AMOQUl6MI11
 5Ta7iNuCfdCZr1ajVYJ93dYyxnVxPP6KLdtyzc1+IKGNtvFNo9hEfAwUZ9wHJsvqnO
 tirQ9Z9aQSxgA==
Date: Mon, 4 Jan 2021 08:02:20 -0800
From: Keith Busch <kbusch@kernel.org>
To: Michal Krakowiak <michal.krakowiak@linux.intel.com>
Subject: Re: [PATCH] nvme: trace: parse format nvm command in detail
Message-ID: <20210104160220.GB1024941@dhcp-10-100-145-180.wdc.com>
References: <20210104155343.GA26034@michal-desk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210104155343.GA26034@michal-desk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_110224_426091_B1C4BB19 
X-CRM114-Status: GOOD (  12.71  )
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
 Jens Axboe <axboe@fb.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 04, 2021 at 04:53:43PM +0100, Michal Krakowiak wrote:
> FTrace does not parse NVMe commands consistently. There are commands
> that are being parsed in detail and commands for which the trace log
> contains only raw bytes of command dwords. Add detailed parsing of
> format nvm admin command to make the trace log more consistent and
> human-readable.

Perhaps it's too late since we've already gone done this path in the
driver, but IMO, we should have only traced raw dwords without any
additional decoding. This would have allowed consistent output for all
kernel versions and resilient to future spec changes. Then that could
have made possible for a user space utility to do the decoding to a
human friendly format, kind of like what blkparse does for block layer
trace events.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
