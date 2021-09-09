Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7EAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 16:49:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD81461104
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 16:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD81461104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=43ROSZ2vp4OgSzweEie0hviluDj/ahrxjfpWjFBIzMA=; b=dbPKI1jSLyuM9C
	oNure4PHUNNOfyhA2M/gjijJmadpXgrKZ74OWrKMzTKX8iRsK2sZcN4Srm769DPzy4O74oIE6/Nhf
	3NIfelAz5aNQcmLJYR0b536oDZG1fxuDTLMT6ZzMOh40PzxW3LBcc/0OosbUfEBmV7R2GbwyFzgz3
	gUaT1MDUtvZVwMTjOSdy/5qVTPDcnSJYzwdc5yGKArUCr7I39OoKEUZI41wf2eCw53kZnFtgFuC0a
	L0FX/T1BF2EmVix2/0+iHjBBCLL+rtuyaPRTdOlXoU1sXAGSF+aKwn3LZsu0POOH0sV05uA6wIpd1
	hgBDb8ouCqHytRmVslwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mONEM-00AOmO-RB; Thu, 09 Sep 2021 16:48:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mONEK-00AOlW-4X
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 16:48:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46BD661104;
 Thu,  9 Sep 2021 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631206131;
 bh=+0TpyqjVbWupM0BzhnSGN89hvBjRymqCiYh0MlckTbI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=azjHheVFOLCKBPDIrfwQ1OpUm61bO1kHObbhpV227dQSExeVpXomg+U+W84l8gVxb
 Mpyk+pqagZVG2BUnlPusG+Z0c3Kp4tT/xjKxZgvE9j6V8T+clICsaD9PnKbp6QVa9t
 GvnlWVyrVn5sFR7x3rlmZbLWdAQi8qPYOsMAwUsKe00qQv1M2vA2v5sdaTmPSJmUX9
 IwTQ/GJ4XDUDPhk0bsqnihl6gDd2EiKxFZ9jfXQKiTg42WbxwxQgAkR2J18db3q8Cp
 y9MGrAHoP/l65fZwAjMnlTVwkeECmdmYAA7vAcfiGZiLgxJM5uMt7NYSf4sIe+kI5z
 akNw8oVbG6qUg==
Date: Thu, 9 Sep 2021 09:48:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: chengjike <chengjike.cheng@huawei.com>
Cc: linux-nvme@lists.infradead.org, sunao.sun@huawei.com, jiangtao62@huawei.com
Subject: Re: [PATCH nvme-cli] fix path->nentry bugs
Message-ID: <20210909164849.GB2601661@dhcp-10-100-145-180.wdc.com>
References: <20210909145709.2079-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210909145709.2079-1-chengjike.cheng@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_094852_245028_5933C955 
X-CRM114-Status: UNSURE (   4.18  )
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

Applied to libnvme.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
