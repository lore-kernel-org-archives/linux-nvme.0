From: dave.b.minturn@intel.com (Minturn, Dave B)
Date: Tue, 7 Jun 2016 21:52:11 +0000
Subject: [PATCH nvme-cli] print friendly name for trtype and adrfam
In-Reply-To: <20160607215050.GA30120@localhost.localdomain>
References: <1465335200-32354-1-git-send-email-mlin@kernel.org>
 <20160607215050.GA30120@localhost.localdomain>
Message-ID: <9A947B1F6D0FF74CB5D6ACFF43B473F3A39DD4FA@ORSMSX112.amr.corp.intel.com>

It looks like you have the trtype (transport type) and adrfam (address family) swapped in the switch statements.
..Dave


>>-----Original Message-----
>>From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
>>Behalf Of Keith Busch
>>Sent: Tuesday, June 07, 2016 2:51 PM
>>To: Ming Lin <mlin at kernel.org>
>>Cc: Christoph Hellwig <hch at lst.de>; linux-nvme at lists.infradead.org
>>Subject: Re: [PATCH nvme-cli] print friendly name for trtype and adrfam
>>
>>On Tue, Jun 07, 2016@02:33:20PM -0700, Ming Lin wrote:
>>> From: Ming Lin <ming.l at samsung.com>
>>>
>>> Without this patch:
>>> =====Discovery Log Entry 0======
>>> trtype:  1
>>> adrfam:  1
>>>
>>> With this patch:
>>> =====Discovery Log Entry 0======
>>> trtype:  ipv4
>>> adrfam:  rdma
>>>
>>> Signed-off-by: Ming Lin <ming.l at samsung.com>
>>
>>Applied.
>>
>>_______________________________________________
>>Linux-nvme mailing list
>>Linux-nvme at lists.infradead.org
>>http://lists.infradead.org/mailman/listinfo/linux-nvme
