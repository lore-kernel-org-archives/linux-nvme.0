Return-Path: <SRS0=+tAy=ON=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4624C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 20:07:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E1E61029
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 20:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2E1E61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XkpHVm+AOOj76D8nhPVGcfPa+ygh10FQTONwBPJgz4I=; b=TOmkwSvvvxGkcO
	2jFHPrJjjZDEz3/pF7u5TaHEJDI5KvKehUBVKgA3YBNoF1H94LXoNaz67p6u/a1qZlQcoSlzpYKP1
	32oJGe0W3zGxu3G57oxJ2yCvW/iqGuUogg9m1jwktr9qUHmuqI+CefOERDu9sjvLd6aU3eRfZAGlt
	T/GtUu0QqpBe+iXmtuhy++ew5XxKL3hFfb/NXG/8GYWP6r2OmFKnW+Fw7QcxCCWkBbY8RnQYTQqv0
	LuXm09u2oidWlbGQOGv43LbEmEWPb46wTt0prTTKiAKIO67UhwGuVEzgLGZBkV1h6uXVxVWdmSYBb
	F65/Fp047Wxi6g5nAmAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTUzX-00CXeO-8y; Thu, 23 Sep 2021 20:06:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTUzU-00CXe6-E2
 for linux-nvme@lists.infradead.org; Thu, 23 Sep 2021 20:06:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CC6060FC1;
 Thu, 23 Sep 2021 20:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632427604;
 bh=xwiv9NPhe4vPA867hgrAN56w+cVjkt+W0dmsxDZyjtA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e7euUYSiqxfknqUwpeuTRfbi5lI+A1Hbi30Fn4Tk74K+0C3EhRDGuA6C5JFuwSiD2
 XIxQCcFkFTMFEfn0WVrb0g5HUBAPQksRz6vQInJH8M585MJK4uT3iP8CBjuUdg7ojO
 rDdoUIUL/fXXZ96c8i9WQjvwRfayCw/DcEYiHJM0HbW73TJlOXBnzfyF5NOvATo6ob
 rhcrW2ZI2TpKRMqsEhn0qash7kzKgZ9zKUnYkGathDkuafC7fLnnRIU0GuDrRLhwZ+
 KgCFPEnWo2TlCRCvKtEG4yWjNLqdXHsa9OaYdH6gJva8La8VRh4Tnch5MaEIu8oz5i
 h6ONWCnQ/bdiA==
Date: Thu, 23 Sep 2021 13:06:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 chaitanyak@nvidia.com
Subject: Re: [PATCH 1/2] nvmet: use macro definition for setting nmic value
Message-ID: <20210923200641.GB114816@dhcp-10-100-145-180.wdc.com>
References: <20210923101744.4204-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210923101744.4204-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210923_130644_532627_4EEF08AE 
X-CRM114-Status: UNSURE (   4.80  )
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

Patches look good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
