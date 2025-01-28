Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3E4C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 06:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DV6liNTLHsKnjK6JPOx8NIZ788MTKBUMbVm3nT3ypRQ=; b=nBqEIxT3j1JLmQ6Yx9VK07ehIF
	1vxb5KlT3/MwDc38HE61cwlnsyLAeKUrQhw9/tcaaipq0Sh1tSQtXZ8nqUeUCQrtPmyLeeIp3BOln
	CHc9JAxGCQqbERADF5rKJMH7GOBqJN2BpnXDIIXob3tX4vca5dnMtuaxwqTJso09+9ThkwGBWYImL
	PhD6nYtC2Qt/PE8KgBWiVblfFcEPQmsSOuate9j/micRCAQtOdHTRrZK2BkZ+xPn7mrAFR5vxuqc/
	wLvALamnWcHkNJEQzecuhCMea6T8wLOjP7iGSNcpxzdhvUzJXZKOHwheKmI2bfelxOJE6wrSjpe61
	ZlA8Jz4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcfNl-00000004FGF-0wca;
	Tue, 28 Jan 2025 06:47:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcfNk-00000004FFE-0rCq
	for linux-nvme@bombadil.infradead.org;
	Tue, 28 Jan 2025 06:47:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DV6liNTLHsKnjK6JPOx8NIZ788MTKBUMbVm3nT3ypRQ=; b=NcjWSeCztAFCx/chBBcqyKrf1E
	MXXK7f9E4wmJlHencmz5/6DnHKe9zJyjyIl1PtsQqja+nvL5e/2yEwO4d3kPpxSDOsR4t8DPDclv0
	d42UaWsJNaXAc4617w7g0Kn/lR4qZCzxyR5iE0wNyiWwUXG6wjezjzKVBj5+s9/m/TGYFvW4uXlbO
	axXxiLHU8lYCURPp560xjg57sScMTwSxeOB0/zvwe+sPAhzUW1/ijVr7/N0jWX8Rb016cIK8p08AY
	+kUkbpBOt+QtBbvh8ZbbDE0C1hyyRSy5OQl2P1VmQNsPg0i8xEL+oXRbX+6tnV/9TdWm+bNEgRziM
	6hurUH3Q==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcfNg-0000000ErK4-3o8w
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 06:47:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DAF5F68D05; Tue, 28 Jan 2025 07:47:20 +0100 (CET)
Date: Tue, 28 Jan 2025 07:47:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu,
	djwong@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v2 3/8] scsi: sd: set BLK_FEAT_WRITE_ZEROES_UNMAP
 if device supports unmap zeroing mode
Message-ID: <20250128064720.GC21401@lst.de>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com> <20250115114637.2705887-4-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115114637.2705887-4-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_064729_213281_839AF65C 
X-CRM114-Status: GOOD (  13.02  )
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

On Wed, Jan 15, 2025 at 07:46:32PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When the device supports the Write Zeroes command and the zeroing mode
> is set to SD_ZERO_WS16_UNMAP or SD_ZERO_WS10_UNMAP, this means that the
> device supports unmap Write Zeroes, so set the corresponding
> BLK_FEAT_WRITE_ZEROES_UNMAP feature to the device's queue limit.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


