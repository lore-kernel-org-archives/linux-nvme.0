Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58087C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 06:31:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248EF2067C
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 06:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tD3rz2Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248EF2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zH5DtqKCa+L2beV7lVXxzIrbA3tW3IAY/l7V6XT3X4A=; b=tD3rz2UnOowpgmzityqz4K3He
	0pIMIffg+1Ur1zbbIawz3dFxB+nhrMlPgE5KAtEfyAHcXmM0uMWDblu1dOSPsmA7V5XlUwDHM/Jn8
	LJSxtvT0rLqGlzE0fSb5ADfexmSdcmLJR5YT/u/JaH9AwGqLn023ZFxVvGgFSSqIIbznZoYsEKpCW
	UE/r5Hj3aKpYmZrGfZ9UsbrkHXVgdVODQ08+eoFNxipvSHM99voslZ5Xdj1LBDxV9zOJRPZyDGIM2
	rCEMQE7Sx/f4iHLmVXw0EPgrVqkNMf5LoeY7Huds9HRyQJTzLuLHwjUKNOvDwSCgc+DgnU6tL0cRK
	pqUuCtoEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7v9b-0003c7-29; Tue, 18 Aug 2020 06:31:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7v9Z-0003bc-Ro
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 06:31:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3717068AFE; Tue, 18 Aug 2020 08:31:23 +0200 (CEST)
Date: Tue, 18 Aug 2020 08:31:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] nvme: just check the status code type in
 nvme_is_path_error
Message-ID: <20200818063122.GB1754@lst.de>
References: <20200817081544.837699-1-hch@lst.de>
 <20200817081544.837699-4-hch@lst.de>
 <37dab7d8-fae2-0890-f2f0-e68008c1966d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <37dab7d8-fae2-0890-f2f0-e68008c1966d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_023126_040258_441D401C 
X-CRM114-Status: UNSURE (   9.26  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17, 2020 at 12:31:24PM -0700, Sagi Grimberg wrote:
>> +	return (status & 0x700) == 0x300;
>
> Nit - A little comment may help future readers of this.

Ok, I've added one.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
