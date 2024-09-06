Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAC6E6FE49
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZ9WAlBZ1PEjDEyRMGR/ekZdz1Et2+X5XDRqbTWMA84=; b=JXcaEOOoMwxWcm92PWAusT7717
	xt9zsSpRsHljk+oQanKd9BaDNyDUwgdLtzxHpIjkqy0fy65M/JMRwICy+yAWcENX82G/hyN6uZ1wW
	yVlSGfMzQMtx8zeu7X+VrkXcm9rHRJ+zI+AZWsoBdEPo+zCosope84n6WGJKkXg1yF0Ds0nJr7Svf
	X0zQoC3gT4hTYsjCGOq6dkbBGAgmKoPDDVmAtrAGl7TClceL/RJZhi+mF8Aq9DYue0ZdE+3Lg90S0
	XkHESSjiaT0i+4oJYabAiweI3AKmyp+oAAa3dfs6l3K6QmE7kSzYm+AG9LqQo+e25/RreejNw8qXe
	SbUjpFvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smgN2-0000000DduD-2a0c;
	Fri, 06 Sep 2024 21:19:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smgN0-0000000Ddtq-0HlS
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 21:19:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7E71E5C5707;
	Fri,  6 Sep 2024 21:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037B9C4CEC4;
	Fri,  6 Sep 2024 21:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725657592;
	bh=Lcx41B8B4l4eNdmA18BhfW14Tq62l0Q/qKMcsUVVrts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNyASmjmzn0riERTRRQIHBnwSJNbHwmYeGT2H8qSjkrTs9DVlZ7+xxpMyHxpUTnTG
	 2RGdHyTu++MTu24b7+d5rbgCl/6/XVz8Ix2Jsn1KA/NsUh1d4ZLfBNHPX4Fvh4Bxzk
	 1QoyFaigWvbTBV4yn2QTig/MzwdTgOCNZAN4cMWNM8j0wqhXmymxaxgfP+CJ9i9v3E
	 Q34VroXXoJMlmrZ8oWR29wpADFb36wRazXWfmnW5JXCSw9T4st8+kdP4rk1YLKKFM7
	 LzMu2V2jqWUc5rZV4qMiYWrZRmwFT3K1H7nEbAisA4N5JH+dbi1jqNb59Tq1fRfzlQ
	 5dtNLJtYfpTSQ==
Date: Fri, 6 Sep 2024 15:19:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] nvme: Convert comma to semicolon
Message-ID: <Zttx9v6H2E1L8hBe@kbusch-mbp.mynextlight.net>
References: <20240906065815.40300-1-shenlichuan@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906065815.40300-1-shenlichuan@vivo.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_141954_170476_6E626856 
X-CRM114-Status: UNSURE (   7.47  )
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

On Fri, Sep 06, 2024 at 02:58:15PM +0800, Shen Lichuan wrote:
> To ensure code clarity and prevent potential errors, it's advisable 
> to employ the ';' as a statement separator, except when ',' are 
> intentionally used for specific purposes.

Thanks, applied to nvme-6.12

