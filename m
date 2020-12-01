Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DC9C64E7B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 19:23:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140D321741
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 19:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CPIo76y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140D321741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lTXgRi7SHEw06lkNHBlHqp3VD2fwMBhmy3jWuYn7TPY=; b=CPIo76y4SPwK5PzWNPqiX58jt
	klDQe0aqwdwTq62BNTmLEuqQ1rAgAzREbIlZRxLXuM2EQBVEkDkCmD2zQG1wxgHVo+62F7NjXwFEt
	ZbKCo1KbVI07+vkKo1rJszWYjcpbn4Yh+2l5oV4oOZ8f6MvOUr60N7lVAFy7j0Z5/Vz5EAZvvcogU
	sSdS0Y8TkFej/vgKzfF9hT0MVCrnSd77FkZQo4fkuxfStLeAIFvqR7w2pHyIXNVBthJ0NznEjwEvn
	2xZUKgnAj8ouNrFhIyXV6D0Shl0GJgjJVnqg01tFCNvni/i59mZEEPEsuMbF5x7RekgJpar8DEtHY
	e3Ixt4qig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkBFP-0004DX-Kt; Tue, 01 Dec 2020 19:23:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkBFM-0004CM-23
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 19:23:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7104B67373; Tue,  1 Dec 2020 20:23:26 +0100 (CET)
Date: Tue, 1 Dec 2020 20:23:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] nvmet: Kconfig: Fix spelling mistake "incuding" ->
 "including"
Message-ID: <20201201192326.GA2149@lst.de>
References: <20201126224029.13527-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201126224029.13527-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_142332_225894_614B4666 
X-CRM114-Status: UNSURE (   6.73  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.11.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
