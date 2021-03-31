Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACFDC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 18:54:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296C461006
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 18:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296C461006
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dCSi/SN41BEF1C/H7m2yI90mjQB1GIeYBA5BX3qmjBI=; b=DI4T6sCSxsvmkX4Eys10KCivt
	oD4MCMACAtIDBH7r0M7YQZGDDS6GSk2djxOfQTKQuraJGHmuua6Ao81OCXWqtxdxn70vc3Sepse5A
	3WiccVMO7h1YvMObCc7YbavYQicCfMnM6LCLzAmrH6DYuUxKw9JQLwufjC5qOir4w6OiB6q5hSx0D
	cP/jWB57xN/9rzHOAfUZRPtzkBkwqUalazwHcCZUOmqVRIXND+7i5nt/LH/wO9lmr+e9g8jvBIWSh
	bNCVkpHHdeBpyAgzczKXPUGWQHr1c2CfsAj4u/H7CSUVQigZtJzBkF/gLj0L7axb2GYMnHBDhzSPF
	OG3pDbPMg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRfys-007JtW-PZ; Wed, 31 Mar 2021 18:54:18 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRfyg-007JsN-E8
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 18:54:08 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D9A3AAFCE
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 18:54:05 +0000 (UTC)
Date: Wed, 31 Mar 2021 20:54:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
Message-ID: <20210331185405.2c2a5p6qzb2uvzw6@beryllium.lan>
References: <20210331131228.131118-1-dwagner@suse.de>
 <1d7843a8-2a6e-ac2f-03d4-96785108b06e@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d7843a8-2a6e-ac2f-03d4-96785108b06e@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_195406_628109_1B14E101 
X-CRM114-Status: GOOD (  11.97  )
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

On Wed, Mar 31, 2021 at 04:04:55PM +0200, Hannes Reinecke wrote:
> On 3/31/21 3:12 PM, Daniel Wagner wrote:
> > Commit 8c4dfea97f15 ("nvme-fabrics: reject I/O to offline device")
> > introduced fast_io_fail_tmo but didn't export the value to sysfs. That
> > means the value is hard coded during compile time. Export the timeout
> > value to user space via sysfs to allow runtime configuration.
[...]
> It's actually _not_ hardcoded during compilation time, but rather
> settable via options to 'nvme connect'. But we still should be able to
> change it after connection has been established.

Ah, yes, I didn't realize it. Best to drop the sentence I suppose. Shall
I send v2?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
