Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05CEFA373D
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mTejb0AwfehQYdudLc2ElFAEubnJK8SPY4tBcgRtmmQ=; b=Fx7KuyuO1Zj8BLXEBA3561Xhmp
	c5/ltXs0ZCtuI/+Uz3JASPUwwoqKpp+Rtpn/DoPpJEatFPMItBNqo9qbW/juovJh0LttfoV2aeIpo
	fWRaWRT31wn7ndPLyj6z6wdFTJ2/Zc45suFJQRLhDE0fVT233zTRg9on/PqP/kKtWH+0CN0qQ28ur
	kpr3hUZxqM+gdmKtvTDBLHq4ZiXUZcF19ZC+c5AR04hfM9Df3Ke6HmJPAHaVroFzcDzaLBPwHa0KE
	eGEAiK5ygUbAL5M2PPwVPH17G+khX4pdx9lYyP6XRNgrgszkHsjIGl7AJktvOWAULOEMBwKWEhK8Y
	ha86hNng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olwPk-009NiT-Bx; Fri, 21 Oct 2022 18:06:36 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olwPh-009Nhz-P5
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 18:06:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 93B86B82B9A;
	Fri, 21 Oct 2022 18:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D81C433D6;
	Fri, 21 Oct 2022 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666375590;
	bh=mTejb0AwfehQYdudLc2ElFAEubnJK8SPY4tBcgRtmmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqxxihuIAzrZOl9DgmRlGtgdG+hYQ6X4WvVzfgLCEzWUi3um+0rS4AmHPAj/lFBe4
	 4GJNYaamOUW5G85tjRj2qLuuuK6AoRksi7wI5Yk7Fl/xB03DVWZ3QhOcN4Z2ovEVdP
	 C1dkUrgzHWl1q1ZONR+ZQZX6jC0fOJJogwkLKiETjGBNg/GG3I+cqSS8eMa7KJl3ox
	 b0yoGvXhK8Qg5FdkCq3RmzaWo8DEu+vN6Pm13SqSNPQUxTJsFPtyCD0rdqsCpZOnn+
	 EHjATHTDUebRoct2ijhkl+1jG5meAB/LiFhA+OF4+KZtTTynSSXXqDjGHVyTwxesnj
	 hhk05kSclCLRQ==
Date: Fri, 21 Oct 2022 12:06:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: per-tagset SRCU struct and quiesce
Message-ID: <Y1Lfoj5Hgz8FwJzu@kbusch-mbp.dhcp.thefacebook.com>
References: <20221020105608.1581940-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_110633_996612_C1AC1AC8 
X-CRM114-Status: UNSURE (   7.85  )
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

Looks good; for the series:

Reviewed-by: Keith Busch <kbusch@kernel.org>

