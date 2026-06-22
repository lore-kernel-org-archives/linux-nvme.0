Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E35CD98F0
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 02:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S+hICL1h5dC4ykvmiE/JrhHjQZWnawwGq/li0Mm4uFg=; b=Qk94wvL/QQQfeQ5tgdUVtrwzjX
	hDv3jHdjIVr8pCahz9TPrJd/Yjs8uF5L9fws0E1ru31rJoFH5McE3nUyXK7HAQmYjo1K8bBXYreoH
	l635y3i/8Edl1IvqJpkQPCc5+BdL7sYPpFhe74RKw6BG4ruxidB4Toq0ey1Uo17WmVpL6/I1VovwT
	kO/CvcUt7DjYidyKRSTqsrChlDeFu7EF65qb/lEXl1Z8lq7dD5qmvCN7RdBbSuoBpSRi9bIfgClpm
	aw0yoKpB3kNPuQBLgU7nPCs8z6ZI/7VbkP8MCNGDD5qzJkcZFFzadyIVPe125SJEjgfLPxeZ+vWOr
	h/R7gqag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbU08-00000004IDo-0owf;
	Mon, 22 Jun 2026 02:03:04 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbU05-00000004ICn-1QXs
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 02:03:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782093773; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=S+hICL1h5dC4ykvmiE/JrhHjQZWnawwGq/li0Mm4uFg=;
	b=Ly0twbXLI8o6SWkvdb3OjDEfT9vALLqtJSNBtI6Yn/FlPn+0laNVRSsl7zXBB1ecfEoQipYNAeGe83Gf5/ZZSbVMMHueDqftp16WMoICRahe3xu+4+4+uZCfzFuPTaOIVY2tKc67zWMOtwmOU28XaSAC/TYNC5B6K71p8xDJwG4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X5GTt5l_1782093770;
Received: from 30.178.82.96(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5GTt5l_1782093770 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 10:02:51 +0800
Message-ID: <f4488a80-2e8c-4782-af48-40e5806929d9@linux.alibaba.com>
Date: Mon, 22 Jun 2026 10:02:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: expose path_state via sysfs
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20260617121543.2291455-1-kanie@linux.alibaba.com>
 <498d2a2f-8545-470e-b42a-dd47e26a948a@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <498d2a2f-8545-470e-b42a-dd47e26a948a@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260621_190301_721624_BD373491 
X-CRM114-Status: GOOD (  12.54  )
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



在 2026/6/18 21:02, Daniel Wagner 写道:
> On Wed, Jun 17, 2026 at 08:15:43PM +0800, Guixin Liu wrote:
>> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
>> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes whether
>> the path is currently enabled or disabled.
>>
>> The attribute reflects the result of nvme_path_is_disabled(), showing
>> "disabled" when the controller is not live/deleting, the namespace has
>> an ANA state change pending, or the namespace is not ready. Otherwise
>> it shows "enabled".
>>
>> This gives userspace visibility into the multipath path selection state
>> without requiring users to piece together controller state and namespace
>> flags manually.
> The ctrl state is already exposed to the sysfs. What's the use case for
> this sysfs entry?
1. A controller being live only indicates that the transport connection 
is healthy.
However, due to ANA, a path through that controller may be inaccessible 
or non-optimized.
The ctrl state simply cannot express this.

2. Different namespaces on the same controller can belong to different 
ANA groups
with different access states. For example, ns1 may be optimized while ns2 is
inaccessible on the same controller. A single ctrl state value cannot 
represent this granularity.

3. The multipath iopolicy (numa, round-robin, queue-depth, service-time) 
makes
routing decisions based on path state. Without visibility into path 
state, users
cannot understand or predict why I/O is routed to a particular path,
making performance debugging a black box.

4. For monitoring and diagnosis, When I/O latency spikes in production, 
operators need
to determine within seconds: Did an ANA failover occur? Which path 
became inaccessible? Is a non-optimized
path now carrying traffic? The ctrl state just shows live and cannot 
answer any of these questions.

Best Regards,
Guixin Liu


