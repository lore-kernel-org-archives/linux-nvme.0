Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C72C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 23:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ktrLRS3EgqqJUjUtw7+Pojudy6iobInKbsZzH1zKINk=; b=3WjhL9JrbmSfuCIsCu6f9jJira
	pmWPa1WNcdAToKxbadsNsqsqMEfqs6Im0hEPyytrvPOezBzQXVkXXo3C2F8WcNauTzi1XumUCFNC3
	1uilsKSPNp5LA9ZYealnnz0Hl8RFQwL44J9wdAs/3ZtpHdY44rHIPZ2aY7s7VdDLkXeifMChxoOgV
	mZEEK+7MTbCApVjfbGmhhjQUivfnw2IWqHP56oCh4Hu8YiPEZutWCDytNtEI/3A4+YyKKExSqA6Ii
	x9Uxtn38N/YBE6hWTEdk/x0RCjhPz1S0nd5W3Uk6O2mZ2KNt1cXDwHj1EUANX7kIFLL3ndAzFgVPN
	Wzp+z5IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osYDm-009BvR-Qh; Tue, 08 Nov 2022 23:41:34 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osYDe-009Bur-4S
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 23:41:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8C6E6B81BAB;
	Tue,  8 Nov 2022 23:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB811C433C1;
	Tue,  8 Nov 2022 23:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667950883;
	bh=ktrLRS3EgqqJUjUtw7+Pojudy6iobInKbsZzH1zKINk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4KlmyjvX/ROCp9ybS+2ZlpuP2Z9vWUUxnG3qc+wA1Q9sItWKwdO2lZ+jiIqDg9az
	 aLuaS1BkxrtuTKvAU+rBKwIMpnKUset9B4bpWXoYdlpAk0ylBacRVWv8oFSsr7+neF
	 KaUEuCQhAQJbRTFs9z0NhF3qCIIa0G3rjVD7B6cr6wmj76W43oyIqh8rIwqJfd1qSS
	 TYJVVOyficn4TZrLf7l0gEQQBPQ02nySySEx93AsGW7Gv/OkYeQKyEZXCFInPa9e7I
	 jPgXsbSOfd1Idi9IU/j/7Mk4ok3zDMZ45Ev0ryNk5Dr4bB4xDvUsx60UN5KT9Ovdca
	 McZKykq8fmRvQ==
Date: Tue, 8 Nov 2022 16:41:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v2] nvme: scan sequentially only when list scan
 unsupported
Message-ID: <Y2rpIJ9lSJYnb+GG@kbusch-mbp.dhcp.thefacebook.com>
References: <20221107195443.2176099-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107195443.2176099-1-ushankar@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_154126_333402_D9D2E997 
X-CRM114-Status: GOOD (  12.17  )
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

On Mon, Nov 07, 2022 at 12:54:44PM -0700, Uday Shankar wrote:
> Currently, if nvme_scan_ns_list fails, nvme_scan_work will fall back to
> a sequential scan. nvme_scan_ns_list can fail for a variety of reasons,
> e.g. transient transport issue. And the resulting sequential scan can be
> extremely expensive on controllers reporting an NN value close to the
> maximum allowed (>4 billion). Avoid sequential scans wherever possible
> by only falling back to them if nvme_scan_ns_list fails due to
> controller non-support of Identify NS List. This breaks (noncompliant)
> devices that claim to support version NVME_VS(1, 1, 0) or later, but
> don't support Identify NS List. Such devices can be made to work again
> using the existing NVME_QUIRK_IDENTIFY_CNS.

Looks fine, but I really don't look forward to finding out how many
devices, if any, were secretly relying on this fallback.

