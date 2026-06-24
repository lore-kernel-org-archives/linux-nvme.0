Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5EDCDB47F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lUVIjfr7QvKDdCu8mD0Vi81wv3j541RzsL12GLO3F2M=; b=w3fzBkvxE6KuNrGYv7jEuRT1ng
	0y+x6KETAAOy37GeHZmAVMOzs998ZHYCJUJkF6QLqYbd0pv3bMKjqfvhF5ejPGGcWjfmc/6ienq8d
	Yvzp2iUlF+/SI7afQEgQZJ22QeAfTuye6udmWpZwG2rED1eNlJQOSmf9mG8yYq1nEp++RAHaBv/Vc
	nbWcWK3s0JxRUR+7qsI05HrTXJk47ilCjnF3QCGW8DXZWMXLqSQDfkA8KvDWy4gonS6JPDc77t84/
	dz+100f6YAFLQ3xhHPDUIqUwbhrACOnitjTuXY2WRDhxiNFPNHSl5+7+VhW4b43EYPW4oUTGWGKmv
	WoQNbNQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcMAA-00000007iUF-1H7V;
	Wed, 24 Jun 2026 11:53:02 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcMA5-00000007iTf-2cSD
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 11:53:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782301973; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lUVIjfr7QvKDdCu8mD0Vi81wv3j541RzsL12GLO3F2M=;
	b=Ldidkpj+SvKVvI0m32K7BkhLdeSyIyyizG/I1SCS9uNTCWzXD3+mVbdMtXXq6Mjpf/us4XNkF2GCbiOq65SGuxj8YNuavDOJFyO+CDtV4LdfMXSfIWtJ+P813jttZkJgA07rY0t4mCeEmSrFddz6o8Lra4S7B0k5xUb/ql4cVLU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X5Y-N95_1782301968;
Received: from 30.178.83.21(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5Y-N95_1782301968 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 19:52:49 +0800
Message-ID: <315b3fcf-a4ba-4f81-aa16-0d2f61a47b5f@linux.alibaba.com>
Date: Wed, 24 Jun 2026 19:52:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-multipath: expose path_state via sysfs
To: Daniel Wagner <dwagner@suse.de>, John Garry <john.g.garry@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
References: <20260624054843.1132083-1-kanie@linux.alibaba.com>
 <01e1bdfa-2917-401e-9ffb-a2229798e542@oracle.com>
 <c9b1d8fd-7012-44a0-a975-947fc0e16fac@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <c9b1d8fd-7012-44a0-a975-947fc0e16fac@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_045258_364780_7AEA5DC2 
X-CRM114-Status: GOOD (  13.88  )
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



在 2026/6/24 17:55, Daniel Wagner 写道:
> On Wed, Jun 24, 2026 at 08:36:44AM +0100, John Garry wrote:
>> On 24/06/2026 06:48, Guixin Liu wrote:
>>> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
>>> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes the
>>> current path state, including whether the path is enabled or disabled
>>> with a specific reason.
>>>
>>> Factor the path disable checks from nvme_path_is_disabled() into a new
>>> nvme_path_get_state() helper that returns an enum nvme_path_state. This
>>> keeps the path selection logic and sysfs reporting in sync, so any future
>>> updates to the path disable criteria are automatically reflected in the
>>> sysfs output.
>>>
>>> Possible values:
>>>     - "enabled (optimized)"     : ANA state is optimized
>>>     - "enabled (non-optimized)" : ANA state is not optimized
>>>     - "disabled (ctrl_down)"    : controller is not live
>>>     - "disabled (ana_pending)"  : ANA state change pending
>>>     - "disabled (ns_not_ready)" : namespace is not ready
> I'd prefer to have a single string here instead of something we might need
> to parse again. The sysfs docs says
>
>    Mixing types, expressing multiple lines of data, and doing fancy
>    formatting of data is heavily frowned upon. Doing these things may get
>    you publicly humiliated and your code rewritten without notice.
>
> Something like
>
>    - optimized
>    - non-optimized
>    - ctrl-down
>    - ana-pending
>    - ns-no-ready
Would this be redundant with ana_state?

Is this OK?
     - enabled
     - ctrl-down
     - ana-pending
     - ns-not-ready


CC Keith, John, Nilay, what do you think?
>
> BTW, the docs on sysfs say, these interfaces should be documented also
> in Documentation/ABI. So far we haven't done this for the nvme
> subsystem. Should we start with it?
Sure, just like the nvme-multipath.rst file I worked on earlier,
I can do this later with the help of AI.

Best Regards,
Guixin Liu


