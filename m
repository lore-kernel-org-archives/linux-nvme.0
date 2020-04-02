Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABC1C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:19:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9612072E
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yev72oAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9612072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aWcSx5w7j4rS4V9Mk3EtAZJTqKKUWFUsdnJdyw137ms=; b=Yev72oAqrk/J/Z
	uS+9R2cNUb/ynIBEbsceqZ2fbt21/FvB27HbrKQnLZxWBBBq6F78hv4nIItG5yQOD/3TehJzE0lKS
	y7k0ZavC+LPdOQyod7uwOUOaySAnZK7qNBEhTPb5lYdwERAzZDUN/GGbeujCU4DAUAOkWyxtR+bqF
	YjU/cDIdB3jbF+NGan0n1EUfwnDNFWrFg/cVhdTKjCzmlYOm4f7N3V4eZsraxVXsgsY/xyLiy76Dt
	s1wFd20QQoSr2Ii6VMxFjFssmbwyLz9f3i1ej3G5UY1GIX9Y2ZuVs909ZbgagGoDbnU5yCiZuCIdu
	RO0QfXmzgGjl7wOeMmWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK1cU-0005D3-3L; Thu, 02 Apr 2020 15:19:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK1cP-00054v-V3
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 15:18:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9D6B068B05; Thu,  2 Apr 2020 17:18:54 +0200 (CEST)
Date: Thu, 2 Apr 2020 17:18:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: nvme deadlock with ANA
Message-ID: <20200402151854.GA11784@lst.de>
References: <5e38c566-3f26-288d-1004-161d1084b468@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5e38c566-3f26-288d-1004-161d1084b468@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_081858_183976_2F49B314 
X-CRM114-Status: GOOD (  12.39  )
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 25, 2020 at 11:23:50PM -0700, Sagi Grimberg wrote:
> Hey,
>
> I want to consult with you guys on a deadlock condition I'm able to
> hit with a test that incorporate controller reconnect, ana updates
> and live I/O with timeouts.
>
> This is true for NVMe/TCP, but can also happen in rdma or pci drivers as
> well.
>
> The deadlock combines 4 flows in parallel:
> - ns scanning (triggered from reconnect)
> - request timeout
> - ANA update (triggered from reconnect)
> - FS I/O coming into the mpath device
>
> (1) ns scanning triggers disk revalidation -> update disk info ->
>     freeze queue -> but blocked, why?

What does -> but blocked mean?
>
>
>
> (2) timeout handler reference the g_usage_counter - > but blocks in
>     the timeout handler, why?

The timeout handler obviously needs to keep the queue alive while
running.  We could think of doing a try_get, though?


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
