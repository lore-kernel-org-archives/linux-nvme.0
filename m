Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD2CC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 16:50:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E817B6113D
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 16:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E817B6113D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=Lwu8zbSK2HuMMLgg4ux/h9U6k
	faz8Yas+knljmsP46w7tnuzeIbR8UrlEF5hD7+ZyYd3W2FBOG5u900r1Wm2W/yj/YhwdJtXlpZXqS
	14JoWQF1W6wiyTKR5FiCWbUy4iE83KLbexDaK6cQAhvXy5KzrZjo50oEix8sfGZzTvM/p4s720BCf
	lxmIxhLDJddzg2nmequvzYvV79P1iEydmCIB4EP2rZFjrfQAnp1SCtsH/TY8AUFO3muX5pJ3vbONr
	YvxbAJYhdjqLEyXSVZZDoFSUin++ayPcuhNRf9bC5PH2OEI6aZR+TQkA3n+hQj70XDlGaMldTl7/M
	zLxE7sc+g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSN03-00DR71-7U; Fri, 02 Apr 2021 16:50:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSMzz-00DR5I-HZ
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 16:50:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4A4A968C65; Fri,  2 Apr 2021 18:50:18 +0200 (CEST)
Date: Fri, 2 Apr 2021 18:50:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v2 0/3] Export fast_io_fail_tmo to sysfs
Message-ID: <20210402165018.GF22030@lst.de>
References: <20210401095412.84254-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210401095412.84254-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_175019_811427_B4182E97 
X-CRM114-Status: UNSURE (   9.41  )
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

Thanks,

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
