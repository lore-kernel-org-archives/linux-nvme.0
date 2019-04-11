From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 12 Apr 2019 00:34:15 +0900
Subject: [PATCH 0/2] nvme: Check size of command structures
In-Reply-To: <20190411152732.GA7312@localhost.localdomain>
References: <20190411151832.26481-1-minwoo.im.dev@gmail.com>
 <20190411152732.GA7312@localhost.localdomain>
Message-ID: <cc4a3f58-ba74-6ee8-93ba-fc4223aba004@gmail.com>

On 4/12/19 12:27 AM, Keith Busch wrote:
> On Fri, Apr 12, 2019@12:18:30AM +0900, Minwoo Im wrote:
>> Many command structures have been added in linux/nvme.h wihtout
>> BUILD_BUG_ON() check.  It also needs to be assured to avoid unintended
>> growth of structures.
> 
> We're already protected from accidentally increasing a command size since
> 'struct nvme_command' unionizes them all. Its size would be the largest
> command in the union and we do check it's 64 bytes. Unintended shrinkage,
> though, that would require individual command type checks, so okay.
> 

Agreed. struct nvme_command is a largest one in that union. By the way,
remaining structures also need to be checked for the unintended shrinkage.

Thanks,
