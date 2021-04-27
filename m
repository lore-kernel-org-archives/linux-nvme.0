Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF98BC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 09:17:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6D2613A9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 09:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6D2613A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WkrbamfaJnMgNPVyZzV5qU56gWG3jrV4UCMNPXAZgEA=; b=eSTBd7o0bhfdoX10TEE8RmXk3
	tAoifDmIfqsuDqTfwazHmHfpm8WLRF/SyohAnN7h1rRrv8zRsKcbS6MCJ/URtNr4zD4veRY+BHlkb
	natgZzzKPtO4BcThS/EbXNJoddYQ9x1XvmOQ4cLWUFID31mr841A4At3N/82tpJwhjYVGnon7tw2C
	ARP4ephMYTP52BT2yFuaOnAWV8UKDNH3VIVkP5FasmZ3tHUJ8PlIingAtJVtvUJ2VN7yj5+IuEqp8
	MdzZA6/Wl5vHlsfQ8LWGRKGeXi/Hd/0D9r8e3YrxRFdK6FCxlVtV+L/jFKlPXRgfSTbUBkkVBLdT9
	abReQFacg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbJpu-001Cjo-SL; Tue, 27 Apr 2021 09:16:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbJpr-001CjJ-6N
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 09:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=X/gh548JLTulglC1Dvp3QLE6tjarX4vFLFGJETcVQlU=; b=znPH6jw57ji8+l2NJ+0psHFyca
 HcLKtEMSF/qNrZw895oUPltUqOSZsBcujbK2gvJ82JQh7S7P2Y8H2QgHibhzSdOkUgKv8tLil/eTc
 reGQBahwzJS3hD5flP4C28j14CN1WAEKxNzbpr0x6fmyCqUF2Cf1HwrCnK6si3EXA4tENh755biZD
 VOht+oyuRQ6RNpdxvZ7NlBhKa1s6N4yhyto8RVwQhkm+EINK4NSzteoZGu1ZDvhT7kFNMohwlseRt
 hIf2e1mYquR9t1UdW1+8hYgCZhGnycvgkBcITh+5q1IsnCL4jlBQvPEnTWyN/RSjSAI3P0UcZzyW9
 JseMEPBw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbJpo-00GZeb-Ik
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 09:16:49 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8AF8CB034;
 Tue, 27 Apr 2021 09:16:43 +0000 (UTC)
Date: Tue, 27 Apr 2021 11:16:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: mwilck@suse.com
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] nvme: rdma/tcp: fix list corruption with anatt timer
Message-ID: <20210427091643.sk3uaasam5jm4rlh@beryllium.lan>
References: <20210427085246.13728-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210427085246.13728-1-mwilck@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_021648_805065_E04C77CB 
X-CRM114-Status: UNSURE (   7.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 27, 2021 at 10:52:46AM +0200, mwilck@suse.com wrote:
> If anyone has better ideas, please advise. The issue occurs very
> sporadically; verifying this by testing will be difficult.

Maybe you could update the commit message with Chao's analysis?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
