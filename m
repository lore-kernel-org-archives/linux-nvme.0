Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293ACC43458
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2026 02:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DKzfhK+lMLnMeRABy0YIREnmGZYiNNQzYECZnShdCVM=; b=uDOxFtzI9/K7yKG86tdqJ/9eGR
	CQK0y0xpv3BLCDFW0iLsU0zCgzSrWHcEaDQLIlrvTJuNG4+7UFYGbLKPhSwK77WWvKnA9kkf+vv4S
	DUBPADxOXR+/CEa5+gIEWorJ9OYYSsXxfTnz0V52Py5rHTSca6qYT31jbXyZQSpdR1wlO9N8bnNPV
	gVze08evCrsBYLPhvwj5H67KpL6m6ReNAjljUbdA97RsaHpLRBLrwpgTPtw37MqUsQh5ctO+623lp
	7ldX5gXt7paZSeZ+Q56fWDNSI3WnAK75KILblsfZPiY+9NPstw7E+ZApGBVgGnHOBXMehLZuMVpKz
	zHz4fO5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTLH-00000005ry1-2mMC;
	Fri, 03 Jul 2026 02:09:23 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfTLE-00000005rwn-3rTP
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jul 2026 02:09:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783044558; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DKzfhK+lMLnMeRABy0YIREnmGZYiNNQzYECZnShdCVM=;
	b=ZArptw3RB65lyIziaRXSznFwKnriBQc1GQLNceVXFcRGoyFQ0CemtLATcCq1GAwLKRRfFApua7efCOdeh/yNX+/cigfXzBb+5OFtNyoWUHzfWGyPBaNI+AFXaTjb3WW6XLHHDH35Ztnsuthatdu9b3J+WizzBzT3m+UbUmk55WA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6HGsM2_1783044554;
Received: from 30.178.82.218(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6HGsM2_1783044554 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jul 2026 10:09:15 +0800
Message-ID: <87d3a982-3208-40b3-beed-d31b7ea9aa58@linux.alibaba.com>
Date: Fri, 3 Jul 2026 10:09:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nvme: add ABI documentation for host sysfs
 interfaces
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260702095541.1145128-1-kanie@linux.alibaba.com>
 <20260702095541.1145128-2-kanie@linux.alibaba.com>
 <7d312569-a32d-4e08-bdfa-febb1389b83c@linux.ibm.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <7d312569-a32d-4e08-bdfa-febb1389b83c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_190921_261077_028294D3 
X-CRM114-Status: GOOD (  18.24  )
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



在 2026/7/2 21:49, Nilay Shroff 写道:
> On 7/2/26 3:25 PM, Guixin Liu wrote:
>> +What: /sys/block/nvmeXnY/diag/command_retries_count
>> +What:        /sys/block/nvmeXnY/diag/command_error_count
>> +What:        /sys/block/nvmeXnY/diag/multipath_failover_count
>> +What: /sys/block/nvmeXnY/diag/io_requeue_no_usable_path_count
>> +What: /sys/block/nvmeXnY/diag/io_fail_no_available_path_count
>> +Date:        May 2026
>> +KernelVersion:    7.2
>> +Contact:    Nilay Shroff<nilay@linux.ibm.com>
>> +Description:
>> +        Namespace diagnostic counters.
>> +
>> +        command_retries_count: I/O command retry counter. Only
>> +        visible on per-path devices.
>> +
>> +        command_error_count: I/O command error counter. Only
>> +        visible on per-path devices.
>> +
>> +        multipath_failover_count: Multipath failover counter.
>> +        Only visible on per-path devices. Requires
>> +        CONFIG_NVME_MULTIPATH.
>> +
>> +        io_requeue_no_usable_path_count: Counter of I/Os requeued
>> +        because no usable path was available. Only visible on
>> +        multipath head devices. Requires CONFIG_NVME_MULTIPATH.
>> +
>> +        io_fail_no_available_path_count: Counter of I/Os failed
>> +        because no available path existed. Only visible on
>> +        multipath head devices. Requires CONFIG_NVME_MULTIPATH.
>> +
>> +        All counters can be reset by writing a value.
>> +
>
> How about splitting the above diagnostic counters into two sections 
> instead? Since the sysfs
> layout differs depending on whether multipath is enabled, I think 
> documenting them separately
> may make the interface clearer.
>
> For instance, how about documenting it as follows:
>
> One block covering non-multipath configurations:
>
> What:           /sys/block/nvmeXnY/diag/command_retries_count
> What:           /sys/block/nvmeXnY/diag/command_error_count
>
> Description:
>         Namespace diagnostic counters for non-multipath
>         configurations (when CONFIG_NVME_MULTIPATH is
>         not configured).
>
>         command_retries_count: I/O command retry counter.
>
>         command_error_count: I/O command error counter.
>
>         All counters can be reset by writing any value.
>
> For multipath configurations:
>
> What:           /sys/block/nvmeXcYnZ/diag/command_retries_count
> What:           /sys/block/nvmeXcYnZ/diag/command_error_count
> What: /sys/block/nvmeXcYnZ/diag/multipath_failover_count
> What: /sys/block/nvmeXnY/diag/io_requeue_no_usable_path_count
> What: /sys/block/nvmeXnY/diag/io_fail_no_available_path_count
>
> Description:
>         Namespace diagnostic counters for multipath
>         configurations (when CONFIG_NVME_MULTIPATH is
>         configured).
>
>         command_retries_count: I/O command retry counter.
>
>         command_error_count: I/O command error counter.
>
>         multipath_failover_count: Multipath failover counter.
>
>         io_requeue_no_usable_path_count: Counter of I/Os
>         requeued because no usable path was available.
>
>         io_fail_no_available_path_count: Counter of I/Os
>         failed because no available path existed.
>
>         All counters can be reset by writing any value.
>
> I think this better reflects the actual sysfs interface and makes it 
> immediately obvious where each
> attribute is exposed, without having to describe the differences 
> between per-path and multipath head
> devices in the individual attribute descriptions.
>
Sure, changed in v3 thanks.
> One other suggestion: could we keep all of the diagnostic counters 
> grouped together in the ABI
> documentation? I noticed that in your first revision they were all 
> documented together, but in
> this revision they're separated. I'm referring to the controller 
> diagnostic counters under:
> /sys/class/nvme/nvmeX/diag/*
>
> IMO, keeping all of the diagnostic counters adjacent would make the 
> documentation easier to
> browse.
My bad, changed in v3 thanks.

Best Regards,
Guixin Liu
>
> And yes thanks for documenting all this!
>
> --Nilay


