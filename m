From: guanjx09@163.com (Guan Junxiong)
Date: Wed, 11 Oct 2017 22:32:40 +0800
Subject: [PATCH 2/6] nvme: use 'nvmsXnZ' instead of 'nvm-subXnZ'
In-Reply-To: <20171002162038.GS8463@localhost.localdomain>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-3-git-send-email-hare@suse.de>
 <20171002161621.GB11048@lst.de> <20171002162038.GS8463@localhost.localdomain>
Message-ID: <d9796b73-5309-a5e5-679b-dd0c67437e2b@163.com>



On Tuesday, October 03, 2017 12:20 AM, Keith Busch wrote:
> On Mon, Oct 02, 2017@06:16:21PM +0200, Christoph Hellwig wrote:
>> On Mon, Oct 02, 2017@03:55:55PM +0200, Hannes Reinecke wrote:
>>> Align with overall nvme device naming scheme.
>>
>> It is very close to the normal /dev/nvme* devices, so I feat it will
>> create a lot of confusion.
>>
>> But given that all device name suggestions so far suck I'd be happy
>> to take a stawpoll of linux-nvme subscribers :)
> 
> Of the options availble, +1 to Hannes' nvmsXnY.
> 

+1 for Hanne's nvmsXnY

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
