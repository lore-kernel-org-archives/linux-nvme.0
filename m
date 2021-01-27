Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E708C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 16:36:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F3560187
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 16:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F3560187
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AXxvWOKfDSniRMJWkTUWTHpRNlQa0+7DhztPg4evwwM=; b=NDbzpkTh4hqhfutTT47cO9wmp
	YYlOMSTBcwTLk09+0Iv3jB1aaXBZKbOGGWbsScYRMZBH5QSQmLKyMpgx7pjvNcMzCtH4rqgfaKlww
	DkZUtRjhoxWztOCmP393jgFgCltxeyw6nQGHCnOkZroWEVvqWZM44IHTLZzvPrN8GC3H1NTQeOxXY
	jyKeY7S6DzZbi9M14LD1KxAeWccclz9W4yug9ky/lCJ5UsoPA4LcKz7CTtxHsaxwtpq3xuh/59B2A
	2pOXX3OdbIj5peWa1eZhHl5iMfkocsMbaUMp0Hnrbi2a2/uuZprO6oXVTnVuTvZklnDDreDGsxuhw
	z6CaXEKfw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4nnX-0004i5-Cc; Wed, 27 Jan 2021 16:36:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4nnU-0004ds-J0
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 16:36:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8C0B868AFE; Wed, 27 Jan 2021 17:35:55 +0100 (CET)
Date: Wed, 27 Jan 2021 17:35:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCHv2] nvme/hwmon: rework to avoid devm allocation
Message-ID: <20210127163555.GA22717@lst.de>
References: <20210119064318.124415-1-hare@suse.de>
 <20210119145632.GD54031@roeck-us.net>
 <1093bedb-9b6d-b365-85d0-de8ef7eceb95@suse.de>
 <efddf566-a5a1-cda0-5fec-5e8a1d6bffb3@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <efddf566-a5a1-cda0-5fec-5e8a1d6bffb3@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_113600_770472_6B3A8E7F 
X-CRM114-Status: UNSURE (   7.97  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 19, 2021 at 09:54:30PM -0800, Guenter Roeck wrote:
> It needs lm-sensors version 3.5.0 or later. Older versions
> don't support a device hierarchy.

Hannes, did you get a chance to test this with lm-sensors?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
