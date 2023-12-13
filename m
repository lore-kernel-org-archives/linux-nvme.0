Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C984EC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4C7lxDybtEbHFpCOIX1tviJcEv9i9MKUadPfgPvrd2A=; b=XW4u73/U5lg39iP6FZVMl4ksMy
	BrozhsEWb0yH0XTe54rK+4TqTRcj5Uz5BpfkzkHlDb5bhk9dMrJKXHkuSUzGml4qoJ2pG5Qp/lhJ7
	kCMH/z1q+/sjGL/tc5NUhqLdjm3HCbQUNm2r6AmlQ1UOYBh4s0+1P8vvaKbIUwPfvQ4mExB7cWTn7
	I4zqCO8N+zc8esMmalO+W2stPRQT91L9T9irck6yGOdR5c4XqEwx/VbyFMsPn41MjN/Z9R/72gZ47
	fg9ZwzGf+8iZbnNo3yxcI2v34ceJ1wUJa6akU+Ce7t+Z+tfuwqjEEAWZ8s+04qBiFjw0sLVJxIA3Y
	gqWbjGeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDYIV-00GCoQ-1S;
	Wed, 13 Dec 2023 23:05:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDYIT-00GCnw-0j
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 23:05:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C324C61F47;
	Wed, 13 Dec 2023 23:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40449C433C7;
	Wed, 13 Dec 2023 23:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702508739;
	bh=4C7lxDybtEbHFpCOIX1tviJcEv9i9MKUadPfgPvrd2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLPGZVrIMjhmTQjTxcJfLbTsxIenqedaE/F7ekXqv+3XXR1W/X6Qsgw3Iz3VQPz6+
	 95/m/KPDWfmNx4OU8JkLZI6p4VRtpMt/uYGczG15goCbkLpNgt+Hrv0OtEgnEalOEN
	 vcDYWmnRADQAy7BBmABIqAcLw2k08OrY1oiATLnoj3h5DdrTPBuWmS8Fo53Cohw+Nw
	 FmIKMuvtfaNJtwzAYgdcfGDP4hxszCAY8Ogw+xTbvjd/jShV1DeAB4IqCqJbsWpW34
	 GzkjPTyeZXKAYQ2a4MM/b1SdCSbzW+BsK7GDmVCwvCWywsbd01qp+fRnERVroxV2cE
	 j4Z4Q7AYBqhKA==
Date: Wed, 13 Dec 2023 15:05:37 -0800
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/5] *** bugfixes and code refactoring for nvme target ***
Message-ID: <ZXo4wSw7LutFA43a@kbusch-mbp>
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_150545_331520_FC8166E2 
X-CRM114-Status: UNSURE (   5.03  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed patches 2 and 3 applied to nvme-6.8. Thanks!

