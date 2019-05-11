From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Sat, 11 May 2019 12:48:48 -0600
Subject: [PATCH] nvme: add support for Verify command opcode
In-Reply-To: <20190511071822.GA14764@lst.de>
References: <20190511000406.5458-1-kenneth.heitke@intel.com>
 <20190511071822.GA14764@lst.de>
Message-ID: <fdd74c58-9bfa-ed43-9658-f7ee9d26a110@intel.com>



On 5/11/2019 1:18 AM, Christoph Hellwig wrote:
> On Fri, May 10, 2019@06:04:06PM -0600, Kenneth Heitke wrote:
>> This allows the Verify command to be sent using the
>> NVME_IOCTL_SUBMIT_IO ioctl.
>>
>> Signed-off-by: Kenneth Heitke <kenneth.heitke at intel.com>
> 
> I think we've decided that NVME_IOCTL_SUBMIT_IO is deprecated and
> everyone should be using NVME_IOCTL_IO_CMD instead.
> 
> Maybe we need to add an official deprecating warnings (probably
> just a printk_once, maybe per process name?)
> 

Thanks! I wasn't sure which was the preferred ioctl to use and didn't 
realize that SUMBIT_IO was considered deprecated.
