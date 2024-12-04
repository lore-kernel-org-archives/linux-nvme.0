Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0C4E77170
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 17:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YfUu3jt6ybl7LPhAU9Ujv97uWfI8FA4IfLFmygglC3U=; b=KgCCC5O8XdqOBs3bxojNqpF0tJ
	E7/E4t5ukyKuy9DcAQExX0yfuflOZ40yhSf88Ev9sszlwF74kICbcrEwVfdwMYBwPxgy55GiIUKly
	UK7CLgWw465mNXUVVqzna3bmWW14CYCRIQGZQpIl3GDIH3qU84VHja2nGfGpswGCqw1eEeHQ4F0fk
	49TpOqbmlCMmI2OczCjJBN+cBg8qv7kOF3iKcUDuCBWLD1BV6GHjJZk4iL3pnKZU0ooYgfPN0p72q
	F+vlncOtf2XIght1klAFQ5iGNn9Hdny4KmXJh/dLQ1DNZRWqsW+U+3944MjpnzPNGdlxJROVm8P4k
	ChV7r1tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIt3j-0000000DLHv-0aHI;
	Wed, 04 Dec 2024 17:21:07 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIt3H-0000000DLCT-1jxO
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 17:20:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8D0E3A41852;
	Wed,  4 Dec 2024 17:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0396C4CECD;
	Wed,  4 Dec 2024 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332838;
	bh=bau6gjEqDQidbOep3Qh1WMApV6jHZixFqVetwye+cNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPltwK+5R5njHd0raY4WDaotLEp+3N0RKd8chG8rqaGz/y+9CXJpLMU8CXtfMgvkw
	 xwWg+xbat2BBZIoWeQrH6peLjP5SO2zVPsvvc3OIB6L/kTCbqMx0XnUi475aKR/9cH
	 zoEiES/3b3rJ4B5SqxKQOsMV3CJ8bmILbNU4rQmG2SrPHdsTI6vmN3cHRRdTpAe6v6
	 O/gUMaOO+q57LqT1K9oouDQq60MebBoKRRqVXqpTpeguiU3ivNB21klwVck1i1mbIb
	 bBcdV5OTNC87eEBFsbOoNPmB8J1VZq8oT33pWPccjE3VhRKeRhYy58mLOu0vZPRi8P
	 9wfSMVNLzShcQ==
Date: Wed, 4 Dec 2024 09:20:36 -0800
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kanie@linux.alibaba.com,
	kch@nvidia.com, loberman@redhat.com, emilne@redhat.com,
	jmeneghi@redhat.com
Subject: Re: [PATCH V2] nvme-fabrics: handle zero MAXCMD without closing the
 connection
Message-ID: <Z1CPZBhMfBNk3ifl@kbusch-mbp>
References: <20241203125732.393992-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203125732.393992-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_092039_515265_F2FDC693 
X-CRM114-Status: GOOD (  11.78  )
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

On Tue, Dec 03, 2024 at 01:57:32PM +0100, Maurizio Lombardi wrote:
> The NVMe specification states that MAXCMD is mandatory
> for NVMe-over-Fabrics implementations. However, some NVMe/TCP
> and NVMe/FC arrays from major vendors have buggy firmware
> that reports MAXCMD as zero in the Identify Controller data structure.
> 
> Currently, the host implementation returns an error in such cases,
> completely preventing the host from connecting to the target.
> 
> Fix the issue by printing a clear warning message about the firmware bug
> and allowing the connection to proceed. It assumes that the
> target supports a MAXCMD value of SQSIZE + 1. If any issues arise,
> the user can manually adjust SQSIZE to mitigate them.

Thanks, applied to nvme-6.13.

