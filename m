Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7D5C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:38:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DE5613BE
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DE5613BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MRi6dWRX4UHitGPnPLC18YfrwgJ0mI5cRTXEibmZqVw=; b=Zeo3CSBNHTlGUdcpG9XWGyGi/
	8VVsRI+CJH5UujeCx9aW7H60LrTWsAivHh6RB6PG7oNcaDBhPxb1kmvOriedEly0gDfdxykfdIhEf
	4woCHqkZTl4OJ6A+J+UTVRvgw4LqcgxM0MQ/hYvCS3JW7j3vys92ZakCLcjcXBqijmze8rjeQOOB3
	X6lPFonFZBUvvnf/+oHC0BHv5TI4/uZMsKJfIyXN0beyFi+8U0JkCdy9OEklWKBDmhsL1zUQJc3AU
	0yj3QMYBU7Ja8w60S/3Dm3sy95vNIUpMEZQiG4khryNSeAK8wERxKvv+179DP47nW8ETXrvSj0oH3
	7YDmXcO2g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgVOF-000lxB-Fg; Tue, 11 May 2021 16:37:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgV6N-000hyM-FB
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 16:19:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1LHfxgMDGjQZPG7jap4nWGdht3Mj6ep2eEqdlh5B7uo=; b=NUM6XeRPZmCsc5piKh4gpfcKVZ
 oeYEHhQcixEgrixwDeB1qN0Ybb62bSgTRz2oB9iuEevEeE4or7ZFk9JODzuscNIllZmrk1WOqP6k2
 h8Q78EXcqVqOEAaG1d0khb8iMguWBj8tIYJxl4VDTU6sYQHZMcSoUHqChkMRnQFBpok8AVXKtMOVN
 ta2503+FZalpQHxrWPK6thdt3dTpwmdtWEnpMYrpZLSrkLeBTbxjR1/X7GpObWK7RxyUmIOwQyfgT
 x0yyqL5ihb20m8v+rl6GuD1nQhR4y3II10mBKJrVzLLvxmdLT9elI3w1YfQ7zvIBXrprDB47OZE45
 YAmuPbEQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgV6K-009kuB-Al
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 16:19:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 01EF867373; Tue, 11 May 2021 18:19:07 +0200 (CEST)
Date: Tue, 11 May 2021 18:19:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2] nvme: generate uevent once a multipath namespace is
 operational again
Message-ID: <20210511161907.GA17525@lst.de>
References: <20210511080308.6734-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210511080308.6734-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_091916_539306_6BAB5498 
X-CRM114-Status: GOOD (  11.60  )
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

On Tue, May 11, 2021 at 10:03:08AM +0200, Hannes Reinecke wrote:
> In an all paths down scenario I/O will be requeued or aborted, so no
> further I/O will be ongoing on this namespace.
> This leaves upper layers like MD unable to determine if the namespace
> becomes operational again after a successful controller reset.
> This patch will send an uevent per multipathed namespace once the
> underlying controller is LIVE, allowing MD to start resync.

Can you please also add a comment why we are sending the event?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
