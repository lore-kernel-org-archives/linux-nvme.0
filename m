Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566F5C5AD5A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 18:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pm7wIe1C2PI4FMXVf1XL9Kb99YTk38xyDebS5gIgCaU=; b=XsnQ8Igghsw/sbYoeMvaZ/AbRx
	j8ea07Mu0Z8cCfVDLHBwfniP1iznvDqxZsWSlk7PanbitSts/73+SMrUl2NJkDL40jj71rIzmSuPy
	TjYfcBt7GXiXJz7FhCtwtOIoPt1Ra4W2B9S2RHWzNUbV6GvITL0GFUxJqMDG+y8dSxf2g8T3YFE4S
	MZrf7PGjqDfZ0xO/mk4sFjcY5OPCbg4nj2LIJZWgnpLt1OR98SwSexfAF0u7Qwl34dlxLvOMICfOi
	2umiVlr4jEOTY0PN2l/ZL6o6P7xkEsr3sKQZmgOxztsxQUDIDQXahSElfJZCXzl3rf0ti2po//Ik1
	32skIqUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuE2A-0000000Gpa8-464b;
	Wed, 12 Aug 2026 18:50:38 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuE28-0000000GpZd-0EaI;
	Wed, 12 Aug 2026 18:50:36 +0000
Message-ID: <0028f4eb-1b97-46eb-b8f2-c674df118e10@infradead.org>
Date: Wed, 12 Aug 2026 11:50:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] docs: nvme-multipath: Add FC-NVMe marginal state
From: Randy Dunlap <rdunlap@infradead.org>
To: Jesse Taube <jtaubepe@redhat.com>, linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 Hannes Reinecke <hare@suse.de>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, John Meneghini <jmeneghi@redhat.com>,
 Bryan Gurney <bgurney@redhat.com>, Chris Leech <cleech@redhat.com>,
 "Ewan D . Milne" <emilne@redhat.com>, shinichiro.kawasaki@wdc.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20260812181300.3712426-1-jtaubepe@redhat.com>
 <20260812181300.3712426-14-jtaubepe@redhat.com>
 <52c3bed5-4c66-4baf-a772-6da2b5b7a815@infradead.org>
Content-Language: en-US
In-Reply-To: <52c3bed5-4c66-4baf-a772-6da2b5b7a815@infradead.org>
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



On 8/12/26 11:46 AM, Randy Dunlap wrote:
> 
> 
> On 8/12/26 11:13 AM, Jesse Taube wrote:
>> Adds documentation for the new marginal state for
>> NVMe over Fibre Channel. Documents how to check and reset the state,
>> as well as a description of how it affects multipath policies.
>>
>> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
>> ---
>>  Documentation/admin-guide/nvme-multipath.rst | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
> 
> 'make htmldocs' build warnings:
> 
> linux-next/Documentation/admin-guide/nvme-multipath.rst:35: WARNING: Title underline too short.
> 
> FC-NVMe
> ---- [docutils]
> linux-next/Documentation/admin-guide/nvme-multipath.rst:50: ERROR: Unexpected indentation. [docutils]

Some fixes below.

>> diff --git a/Documentation/admin-guide/nvme-multipath.rst b/Documentation/admin-guide/nvme-multipath.rst
>> index 97ca1ccef459..8df4235d4d10 100644
>> --- a/Documentation/admin-guide/nvme-multipath.rst
>> +++ b/Documentation/admin-guide/nvme-multipath.rst
>> @@ -31,6 +31,23 @@ To set the desired policy (e.g., round-robin), use one of the following methods:
>>     1. echo -n "round-robin" > /sys/module/nvme_core/parameters/iopolicy
>>     2. or add the "nvme_core.iopolicy=round-robin" to cmdline.
>>  
>> +FC-NVMe
>> +----

    -------

>> +On NVMe over Fibre Channel there is an additional state called `marginal`
>> +All policies will treat this path as offline and will not use it unless
>> +all other paths are marginal or unavailable. In that case, the policy will
>> +select the best path based on the policy.
>> +
>> +To see the current path state, use one of the following methods:
>> +   1. cat /sys/class/fc_host/host*/device/rport-*/fc_remote_ports/rport-*/port_state
>> +   2. cat /sys/devices/virtual/nvme-subsystem/nvme-subsys*/nvme*/state
>> +To reset a path to online use:
>> +   1. echo "Online" > /sys/class/fc_host/host*/device/rport-*/fc_remote_ports/rport-*/port_state
>> +
>> +The marginal state is caused by a
>> +FPIN-LI (Fabric Performance Impact Notification - Link Impact) event.
>> +FPIN-LI event counters can be seen with:
>> +   1. cat /sys/class/fc_host/host*/statistics/fpin_li*

The marginal state is caused by a
FPIN-LI (Fabric Performance Impact Notification - Link Impact) event.
FPIN-LI event counters can be seen with::

  cat /sys/class/fc_host/host*/statistics/fpin_li*


>>  NUMA
>>  ----
> 

-- 
~Randy


