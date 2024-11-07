Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13517D5AE6C
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 07:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9gyDtqFpMqqX3UIYtIZEx+faPMVvVGG/jXDeyIQhGRI=; b=s3VwDZYCnEjG77euHXr6tzHSqB
	xV128Pvks6wqrsbiKKX1upcXOXiSQnW10sa4bQMzn4OwoqMmtfVaE834ZStZ6qzoqzeWF75md5kTv
	A//23we9B4i92EWohYCtVTm/XEj2A3pdM8ZFp9CTQaK0KkisH9vDPwcwoW4XoYv/VndqAySQnv4aE
	asWJ2Nka17GOmwx398PH/Jvt+B0x5Sc8Lfhlt/UBs2XixArHeKqd4nZU4GiGgCIUj+FsY7Et9U6SJ
	MnYnqjBBrJnxa5XB2ixh0R1XjemW/uAwB3BGnk+2H07RHaKs+ycPdd5Ve2oSoj0Xy1/vI6jMn3n8i
	lPaYAtuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8weI-00000005w0z-0VsH;
	Thu, 07 Nov 2024 07:09:46 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8weD-00000005w0I-47Iz
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 07:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730963378; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9gyDtqFpMqqX3UIYtIZEx+faPMVvVGG/jXDeyIQhGRI=;
	b=nF+JdVo1aoG8nz/i2YI+p7q5yOdD8HFjJEdB3pGj8JhYJq4LJUf5i+K8rrmrRXrVpgpcmlrrkg3MILUux8Xc2z5B1VEEREyX7msLbqgSunZnzVoqQMr54zP5GqaZKb32ddvjfcona2K+X4SkI5Ndht7mK8+2MBVq8Myy5lSIbTM=
Received: from 30.178.82.60(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIug2Yf_1730963373 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 15:09:34 +0800
Message-ID: <19cf3e11-83d4-4057-a643-e052bab7680a@linux.alibaba.com>
Date: Thu, 7 Nov 2024 15:09:33 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v2] nvme-multipath: introduce service-time iopolicy
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20241107063249.101179-1-kanie@linux.alibaba.com>
 <20241107063907.GA3353@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241107063907.GA3353@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_230942_491431_22F9896F 
X-CRM114-Status: UNSURE (   7.98  )
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


在 2024/11/7 14:39, Christoph Hellwig 写道:
> On Thu, Nov 07, 2024 at 02:32:49PM +0800, Guixin Liu wrote:
>> The service-time policy can dispatch I/O to the path with the lowest
>> total amount of currently processed I/O, ensuring that new I/O can be
>> sent to less-loaded paths when some paths are overloaded, thereby
>> achieving lower latency.
> What is the exact use case for this?  The commit log is unfortunately
> very sparse.

In scenarios with varying random I/O sizes, the different I/O sizes 
being processed on

each path can lead to slower processing and higher latency on paths 
under heavy load. By

distributing the I/O to other paths with lighter loads, the I/O can be 
processed more

quickly.

Sorry for the sparse commit log, I will send a v3 to expain detaily.

>   All these little policies add up, and we have absolutely
> no documentation on them :(

I'm glad to add a document to introduce all these nvme-multipath polices 
within v3 patchset.

Best Regards,

Guixin Liu



