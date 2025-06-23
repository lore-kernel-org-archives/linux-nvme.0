Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FCAC7EE33
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ga66k71n0w2vGA9z4DH8+0qqeWCf9Q2vDualzrEXD4g=; b=v4L+BopGgGHpktj8ItzD7giIXP
	77fo2lnCUOiQ4N4iyw5igpJRCKgDyFaWjLmE4u3KUVMc85YS1lc5EFuXiaW4zlhoenJSuq9NlPv/Y
	m6Fta+Ynd72HEq9ErlJCgzICbMqwFYCTrh/TfEz5eDVuJeuq/3ctOJOPq1pVtAn7Lbgt2sg3UJ3Cv
	nZkxbwAJhU2U0vp0DBImCBRJfKRMJ6eSMSkOvQwTIn1wtjuAqTUlzBJRvoczmLNQPEME2H/l+17YT
	P5TGH1didb5F91cWgNYqTotscxVDOJdJn/QPpDdn+dNo0Dn6WNFdp1/12qqJZVGxVADK3bwyA9h0v
	P1HC6mkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTrax-00000004HKZ-482I;
	Tue, 24 Jun 2025 00:33:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTo1h-00000003wmN-3dNH
	for linux-nvme@bombadil.infradead.org;
	Mon, 23 Jun 2025 20:44:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=Ga66k71n0w2vGA9z4DH8+0qqeWCf9Q2vDualzrEXD4g=; b=L6MBjskYOdhIWMykF6aQAWDR7J
	F5FA62THmEEazZNSZJlog9O8O7uhD1uSn2Me+3cmY+FHE8mXLNMfhjJSb+h6vwAeW/6OWtOinwNJD
	QIcDD/V73ACO1Z0Q/3W1UMDCtlM+DqoiXj4lTSzYPI2cgDPeFFV/f8CimU0s8uMw+VNGLIq0opQ+5
	ruCWjN1vXETWMdayFXXaozEyOQeAwOLRcom8uNONEjiI+/kW9cMH3ty4V9bMQRrbJHyMW7EDBUbMt
	dCDTHc9MZsVV89HzABQvpgPP9qkwk/akE2MoGkb0AMmHpvNqnIq7NVrU2IyYfyHrNFuIA0wjGXl6C
	gmHbWoOg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTo1d-00000004Yi0-0XuT;
	Mon, 23 Jun 2025 20:44:21 +0000
Message-ID: <44434e4e-cd03-49d2-bd0c-94c29f54c88b@infradead.org>
Date: Mon, 23 Jun 2025 13:44:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] nvme: Fix multiple spelling and grammar issues in
 host drivers
To: Alok Tiwari <alok.a.tiwari@oracle.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, nilay@linux.ibm.com, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/22/25 11:40 PM, Alok Tiwari wrote:
> This commit fixes several typos and grammatical issues across
> various nvme host driver files:
> - Corrected "glace" to "glance" in a comment in apple.c
> - Fixed "Idependent" to "Independent" in core.c
> - Changed "unsucceesful" to "unsuccessful", "they blk-mq" to "the
> blk-mq", Fixed "terminaed" to "terminated" and other grammar in fc.c
> - Updated "O's" to "0's" to clarify meaning in nvme.h
> - function name comment *_transter_len() -> *_transfer_len() in zns.c
> 
> Fixed sysfs_emit() output format in pci.c (replaced x%08x with 0x%08x)
> 
> These changes improve the code readability and documentation
> consistency across the NVMe driver.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/nvme/host/apple.c      |  4 ++--
>  drivers/nvme/host/core.c       |  2 +-
>  drivers/nvme/host/fc.c         | 10 +++++-----
>  drivers/nvme/host/nvme.h       |  2 +-
>  drivers/nvme/host/pci.c        |  2 +-
>  drivers/nvme/host/rdma.c       |  2 +-
>  drivers/nvme/target/passthru.c |  4 ++--
>  drivers/nvme/target/zns.c      |  2 +-
>  8 files changed, 14 insertions(+), 14 deletions(-)


-- 
~Randy

