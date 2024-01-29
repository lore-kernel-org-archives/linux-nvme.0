Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5CDC47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 15:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tCi1ypnQP8oKzBDFrlqwuAtNscKI0p1IdEPSqrD6gyk=; b=sawNve3C126YYeNHiv7FiIJWvy
	YCQ8BRYRAo7OTwmOX0egb1/APgQSZdVotC0I/fBW38lm83YhWgpOdYFbfRKmdI2AU3cNAUvgHtbzF
	+8Xdjpg8tfgGMEbI+WkNNG6ktd+6UA5R+516kG1CMaaD0EFs2VekhdKhC4SJWsXByFik21Y+n6mOK
	vyuWcDYwpz/6mBQ+qQA2COaCUNwaKf+u92jjymHhxfFXrYYjHqmuhB1NYS8BWXq6I6QcY4A+Q0JKn
	PI19HwjPuHAJgge5CS36OtBHlPmvkkcnElv0WA48y8yUUt0loGZpvzDn3Olchx0gTTfidT9KHOpl6
	/cXYyU4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUTIH-0000000DCwd-1QH1;
	Mon, 29 Jan 2024 15:11:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUTIE-0000000DCvz-2xEI
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 15:11:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7DBFD62173;
	Mon, 29 Jan 2024 15:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97922C433C7;
	Mon, 29 Jan 2024 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706541055;
	bh=MQT6JwU7D/NpSnFkKLZWSV4nV2rKlge/XLyAYDt3c6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBG1vxSzl9k4iIVlvseOUaalFUxL0efPG21aO4O/gq0wHuxBNaIHv9BJkMnAH/6z+
	 rWsdsc8ymGoJcl6BvwP59nQapDkKbcPH9CN3HZd6J9ZA2/IBbI/6MoFmxEr9pMk8xP
	 3d7qCM592Rlfoe3hhB+HwfMcJrEqB06gJToDfPwJJfqlqpu/tHW1p1VN9sCgdAHk3J
	 Efw5WjAHl04+KVRHOYNrN40g0QyZhllCyg6veSLWc0qywz+N7TsSa5Hkp/bkfRj3Ot
	 Y4n+bmXYFcz5NppxFf+f1+ebOVAOHqKWpunpNQUdktG5yoo/rNrP5lyETvg6wB5HIf
	 yTUAJNnw/SMAQ==
Date: Mon, 29 Jan 2024 08:10:52 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "Nitin U. Yewale" <nyewale@redhat.com>, chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	jmeneghi@redhat.com, loberman@redhat.com
Subject: Re: [PATCHv2 1/3] nvme-tcp: show hostnqn when connecting to tcp
 target
Message-ID: <Zbe__KROwAeKO6oO@kbusch-mbp>
References: <20240129110639.45542-1-nyewale@redhat.com>
 <501724df-de9a-4b74-bdee-eea7c3507f51@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <501724df-de9a-4b74-bdee-eea7c3507f51@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_071126_808808_A5E534B1 
X-CRM114-Status: GOOD (  10.63  )
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

On Mon, Jan 29, 2024 at 04:18:14PM +0200, Sagi Grimberg wrote:
> 
> > Log hostnqn when connecting to nvme target.
> > As hostnqn could be changed, logging this information
> > in syslog at appropriate time may help in troubleshooting.
> 
> hostnqn is available via sysfs, why do we need to log it?

I personally haven't encountered an issue where these patches would have
helped, but sometimes a dmesg is all you get with a bug report.

