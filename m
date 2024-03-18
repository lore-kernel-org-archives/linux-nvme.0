Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3501C54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 20:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i8zyFMvCnYgGOTIy4IrS6KUCSjwtDMvOAJkGI6lyBMI=; b=LyZT6qQ4+GL+OC9D1Cm/Z2ti8K
	XBhrkTt89YmlcXzvU5eMdbQaPZ/yeg1NnAnTZ4+k+WhuV0JOEZTir6tH7foyJoG9u63FI+ePBcXCJ
	i2XLq4IfDnp2Ej86VuvA0PtMZNB6frmzc7rfI6MX60ZD7SAJkMwGEXXnygmqDRldWY7aLHmyVRvwg
	4txI6OcQBBMpmBUmHkKHJEZOXpouJBvQVrA0aMaEG0L2/rh+apoyIDOYAE5GVUHYLZrzDcUzLGnsE
	eTnFt8lDGkVHxcqHkZ9SedB3jX6qwddoIcq+oZ/2tD5vBZI2Are8R4ZDN6Jmm+6GDW+ZiPfYfW6QU
	V3ldND+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmJo1-0000000A3sd-0aE9;
	Mon, 18 Mar 2024 20:42:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmJny-0000000A3s3-0GN4
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 20:41:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 82A0C60B59;
	Mon, 18 Mar 2024 20:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5425C433C7;
	Mon, 18 Mar 2024 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710794517;
	bh=i8zyFMvCnYgGOTIy4IrS6KUCSjwtDMvOAJkGI6lyBMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9PjmDhnioupQKC+rvXxiTc4XhjHet6SqaNDiFrRo+tqu0LfV3X8wdlAc8Nq6RixM
	 ZMFctKRYfgSDJeAYdiQ7PAt/CeIN19BydQAMH3GPt70WpQ+NX9+t5I9M6kK9qAuM77
	 4pxMyATUavAzE3Kpay9VF15E8Gj2O9NbaONzagGhjofsBa6kn6SUTQtQJrjbSDBDLm
	 69NOgMNeRlMPMjrtp7tFq0eIePU9SdBEtdbxNy7MD4abOQmwpvOqWmBuTL3Ifd1+hF
	 pIti83zeXaM1OoKRkyy9R2shr4WUZArR/2YAlTcj1wMJ2p5Tl7bjjzP9LySINGEn9s
	 8OTSxSRVAGlZQ==
Date: Mon, 18 Mar 2024 14:41:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, Anton.Gavriliuk@hpe.ua
Subject: Re: [PATCH v2 1/2] nvme-tcp: Export the nvme_tcp_wq to sysfs
Message-ID: <ZfinEuOTyMPaAX5B@kbusch-mbp.dhcp.thefacebook.com>
References: <20240313123816.625115-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313123816.625115-1-fengli@smartx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_134158_174220_E014E430 
X-CRM114-Status: UNSURE (   8.45  )
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

On Wed, Mar 13, 2024 at 08:38:09PM +0800, Li Feng wrote:
> Make the workqueue userspace visible for easy viewing and configuration.

Thanks, applied to nvme-6.9.

