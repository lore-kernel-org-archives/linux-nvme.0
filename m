Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A10C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 20:26:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AB0617E4
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 20:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12AB0617E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=onVrN1VHye+unhSbwaSy1GcHrb2EKAtCPIS6EAWExoA=; b=KQyQ2MJhGe1MG8POvqURb+43eL
	uYpIBbRPWEbak7DhviuIcYDZhWKnmxt1SWED/4e5ykUXXVyi4tiAHLc3tjuwBD0bvUKIhUGStXiaW
	3uF98gpLJrhvEQLFBMrwhSKPjiM9mmGojV57ZHNKFj/A/rKJDwMabuX+HT9sd7KybTLMB3PSQpsRP
	aATejuqCAS1ZclwLVqLjQsnPzFRcGhmmZ1WDPtOFb/EpZpthjEf69uwsZ//KdOPzi7H6y7uZXfpKW
	7jxcQEgcBtWctaKKEQAnYYrdsj88v3iqI2N6dzxm9AhyLb3PVe0SEgGK8TY6YEHB7ufCZIK1JoCRn
	y+LhwpWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mn52V-002imL-2Y; Tue, 16 Nov 2021 20:26:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mn52S-002im2-4M
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 20:26:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3704D61AED;
 Tue, 16 Nov 2021 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637094403;
 bh=ZWgPynjA8Hs+cAN6pwCVvquYVndvzqvDISK0DCNc9IQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a5hP0nRecNER9g6wSgAhoFbhM5kTMOdsegYDVB0oVWuo/IJvjIRXPAn5iNBbhYTwy
 vM8hAHi7MXX+2Dp9xw4aVkZknyqPssDDY1NOILD4zwMyQ2VfWYrtUWeRq6DUdT9uUt
 2TIbPKHgYGZ44VVteAOIh6Db7Ll4s3iX8O6wIjnriQ+vxMJjgTq+JPyvKBxil70EYr
 W4515KVL8prbq9GGYZZGk4+avBH7C2M+VPyDDqyJ+bNxtFUUWMKr1E09/0Bc7cYkaE
 UXudn4HRoUCQlRZqj1RGMBzgsCGzG4obcGXpAsK6RbagqRgv5FWl93xH/MGLK3tPDB
 8whrl8qpuy9oQ==
Date: Tue, 16 Nov 2021 12:26:41 -0800
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com
Subject: Re: [PATCH V3 0/3] Fix a race condition when performing a controller
 reset
Message-ID: <20211116202641.GB2984697@dhcp-10-100-145-180.wdc.com>
References: <20211116154920.87279-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116154920.87279-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_122644_207647_1A823F1A 
X-CRM114-Status: UNSURE (   9.10  )
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

On Tue, Nov 16, 2021 at 04:49:17PM +0100, Maurizio Lombardi wrote:
> Memory leaks and kernel panics involving the nvmet driver
> have been observed when an initiator executes a reset_controller
> operation while doing I/O.
> 
> The problem is due to a race condition between io_work
> and release_queue, the latter may end up destroying the
> commands while io_work is still running, causing use-after-free
> and memory leaks.

Series looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

