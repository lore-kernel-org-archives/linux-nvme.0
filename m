Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B01FC02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1gHhFQoAATtseknrD/eHDw3a7Fd+vr21xju6PhOoMdc=; b=egGuIDT9bWnKBSBsMTazTOxqsH
	7DYkQwkDEEVPDeXmM9hodTTrstpzOhWRdMtrO1ZF6vf2YsHIBwVeHS9gfTwnF9BtepnJRWOX2+JSe
	v8AKOmqCYBxPN7OoPtqb2HufSnJiXfPSRT5lKgWvGdb33LZZep38GfeGHRRiC5+a/XPbrjcO2dBrT
	A3iiOLEC+jjrGxGkQZv5+p6sfiSM2gWiV/AywSXISNzezkV23pm7qMLqsPNMowpywXLmE5E4owaZi
	ZlCOvUt4A4pV0P7FU3y8/AE0nnLpoHWVRVRr1bwkUkZJVjFGwwxZug8ST7I4CP5rYYymduoVVqPwZ
	+e1DZwkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPnR-00000008onv-0VvH;
	Tue, 18 Feb 2025 15:46:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPnP-00000008on8-2upl
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 15:46:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E667A5C5ECA;
	Tue, 18 Feb 2025 15:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE53C4CEE2;
	Tue, 18 Feb 2025 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893562;
	bh=1gHhFQoAATtseknrD/eHDw3a7Fd+vr21xju6PhOoMdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhFr+BO87kwK+jpe/Up9foGnMN+gxtagwcY7emlV4beMzZX2u9fWjw/2SWLVPD9yU
	 1JlSdezBEtOHLbR2F2GGmcBTjdZ07U/2HkB+9BDjcVqY/Kf8CWgmpfdPox8fU4GseZ
	 2K/L8Qv4rq2SxskgK1hGPnBhdlnV4cLQN151DW9RAJIjqCP+MrCvrimBqRY4qHDo1c
	 Y5voWO0rQ/k0DagQcMdLyM65oN+yGWUC5DYLxMI1vLw9FgJR9I57kBZlI396XSMDve
	 1gjXbn1u2kO0pVeq9R+DwhmF4A1HeBNxJK3ZAQBNX5TC/HS4HKV13/E3l1UmN//SHQ
	 Q/0rg7rmdNfrw==
Date: Tue, 18 Feb 2025 08:46:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme/ioctl: add missing space in err message
Message-ID: <Z7SrOM65-lgtLC9T@kbusch-mbp>
References: <20250213170515.4027908-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213170515.4027908-1-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_074603_777857_97B22473 
X-CRM114-Status: GOOD (  10.74  )
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

On Thu, Feb 13, 2025 at 10:05:14AM -0700, Caleb Sander Mateos wrote:
> nvme_validate_passthru_nsid() logs an err message whose format string is
> split over 2 lines. There is a missing space between the two pieces,
> resulting in log lines like "... does not match nsid (1)of namespace".
> Add the missing space between ")" and "of". Also combine the format
> string pieces onto a single line to make the err message easier to grep.

Thanks, applied to nvme-6.14.

