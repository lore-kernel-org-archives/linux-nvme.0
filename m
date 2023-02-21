Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D478C636D7
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oLPwNsH1kzbIduAeXPFkZrP52COW7jFDZtOfTDZi3h8=; b=GHkPVbEr9NT8ATIdfaJDJTMhu8
	bDi8aYHLrTXs9Iu1ukKe3QqiH3uaFkiM/QiNE8YhSE90SDGjD1LiLs3B9sOiUpnrkUHWUpuUGMGon
	L05b/rf+9au4QaHIQL4PcPGofnuquQCEC/HwyThc6odaQ2veALCFCYGw8ma6TuiGySYoxOdQSB80a
	R00m/i0CwVxxzE7MH5uvDy+KoI/veFiVGa4TD9ztGgCmmldQ4O5DmWvwOCiLlsRKFr+UGWh61QnXC
	ozVYt6yuVFMLhBn1Pp7BUjgDXX+YiEluE5+KkGaSny4W74vbuMBbh0Messkkp3OsQ56uDZPhw8b6F
	34m91EGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUW2V-0093fu-1z; Tue, 21 Feb 2023 17:02:51 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUW2S-0093df-Te
	for linux-nvme@lists.infradead.org; Tue, 21 Feb 2023 17:02:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E6047B80E97;
	Tue, 21 Feb 2023 17:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBCDC433EF;
	Tue, 21 Feb 2023 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676998963;
	bh=oLPwNsH1kzbIduAeXPFkZrP52COW7jFDZtOfTDZi3h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U3HiRF8pCUCycONsklo4cGqNJnCXZxsZDeUaHOwGWcV7e98cHmfU82qtJuBf1y1z7
	 UdKqq44l3OK4b8BbzuM6rSu1FTz8XQQXgw070fpepnzhdcLKJrlNKMkIkwfp6QSPd/
	 oZXwst6bFsiyRmXpXCjsZ3ZCfyp/L8ZS/GXu6WGZvs6Q5BVL44xPScpMVGyBI9T8di
	 ph9LD+HQn4dorMuN5GhFmhpa+D5IokEGyrYBs75Clu/+wvZ2c/vRfzVz3MO2YsQfvy
	 u82yqLw7xDlsxCX3E0ENQm4YISpm/JFmGXCZ/J+PufYxMH/0mWo5PthJx57a1OjqQh
	 0Qzrnjn+LTzCQ==
Date: Tue, 21 Feb 2023 10:02:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Michal Berger <michallinuxstuff@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] Bug 217037 - cmb attributes missing from the nvme
 class under sysfs
Message-ID: <Y/T5L1ZIssWY5wQZ@kbusch-mbp>
References: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
 <Y+5JdR02tlzD/TFS@kbusch-mbp>
 <151a00d9-0ea2-eadb-72b4-fa8a2dd41bfc@kernel.dk>
 <CACosJgyjgh+cz6nTrKWVQ9P8Z9_wJGWGQBOjae2MoJrZQ3RmTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACosJgyjgh+cz6nTrKWVQ9P8Z9_wJGWGQBOjae2MoJrZQ3RmTQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_090249_146411_25B97995 
X-CRM114-Status: GOOD (  13.70  )
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

On Sun, Feb 19, 2023 at 11:54:37PM +0100, Michal Berger wrote:
> Have there been any patches submitted for testing? I don't see any as
> part of this thread nor at the bugzilla where the issue was initially
> reported. :)

I'm sorry, I didn't see your email in the bugzilla. With time running out, I
just posted the patch for upstream with a link to your original report, but I
apologize for not getting you CC'ed on it. The fix is included in the 6.2
release.

