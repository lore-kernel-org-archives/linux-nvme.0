Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279C8C61DD3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2026 08:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j6a387rOggT8tFKeuUjy61TBV3RFR1/nixb35DGursM=; b=W8H1C9e7Xt538Y8ugojJQlEhPL
	LwvCnaDAKHKeHMj/L1toiHXTD0IvgZ7nAylQ3DZmNJG0OmKWW9oimmkruP0ASgDUZ3ZZLddpqCbew
	0saiT/Vg353Ys6v4c5Nqb8BszorNoIJs5EyvQPlDtxPFkulL+0JkHAwysjEiKGUkmGQx5hJvVFD9T
	vGssT6UDgafO2nhzlYfUYDx4PzKks+QJPqsgxvYGStTdVg7L0/BFjRIaFscLQU3pA0bGNAhRvZDTI
	XhvFs+Zp3I6dJB2l/q5S2/RPSgxymnWDgBFLTY002c7A2sOTjNalL0L450OGHmwGCYUqp5Y2A6nXs
	ulhyfAgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1Jdc-0000000BEvH-3m2q;
	Tue, 01 Sep 2026 08:14:36 +0000
Received: from out-160.mta1.migadu.com ([2001:41d0:203:375::a0] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1JdZ-0000000BEuK-22ju
	for linux-nvme@lists.infradead.org;
	Tue, 01 Sep 2026 08:14:35 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=8mD/fmqwrqdy3kZXJEip9Ki/qWx6X9LJmxOCqZ6vmvI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788250469; v=1; x=1788855269;
 b=S5gbaI/Iylx/wHM1b/u8Q5ssz5bt7WfEWjkHZY72ck0mPkE+uwaEZT0v6sYfYtd98yXCIAZ1
 IKrY18bSN5SNzI1cBUr+2d+7FvGsFED1GR8BfOkZSZDuNV7wIW4qT7X9EyvG8EmhliwdSQtm440
 lAEIdFMAJv7GdqVpDzp5Y76Q=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id ef85270989d16c58;
	Tue, 01 Sep 2026 08:14:29 +0000
X-Mizu-Trace-ID: ef85270989d16c58
X-Migadu-Flow: FLOW_OUT
Message-ID: <eb76f8b4-3730-410c-bdcd-3a36c46686ab@linux.dev>
Date: Tue, 1 Sep 2026 09:14:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: add reference counting for transport modules
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 john.g.garry@oracle.com, wenxiong@linux.ibm.com, gjoyce@linux.ibm.com
References: <20260831152006.819471-1-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260831152006.819471-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_011434_086775_B3F04909 
X-CRM114-Status: GOOD (  18.51  )
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

On 8/31/26 16:19, Nilay Shroff wrote:
> Hi,
> 
> This patchset adds reference counting for NVMe transport modules while
> the corresponding multipath head node is open. This prevents the
> underlying transport module from being unloaded while it is still in
> use by the multipath head node. Unloading a transport module while it
> is still in use can result in undefined behavior.
> 

What is the undefined behaviour specifically?

When the ctrl ops module ref counting was originally introduced, the 
commit message mentioned a crash which it solves.

So far for this problem we have seen a report that if we remove the 
module, the mounted FS will have IOs fail. The same can be experienced 
if the admin unbinds the device from the driver. However, I have not 
seen a mention of a crash, kernel data corruption, a hang, etc.


> The second patch adds a Clang context annotation for the shared field
> used to track the number of active head node openers, allowing the
> Clang context analyzer to validate accesses to the field.
> 
> As usual, feedback and suggestions are welcome.
> 
> Thanks!
> 
> Nilay Shroff (2):
>    nvme: keep transport module referenced while head node is open
>    nvme: add context annotation for nvme_ns_head::nr_openers
> 
>   drivers/nvme/host/core.c      | 11 +++++++++--
>   drivers/nvme/host/multipath.c | 37 +++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h      | 33 +++++++++++++++++++++++++++++++
>   3 files changed, 77 insertions(+), 4 deletions(-)
> 


