From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 5 Feb 2018 10:22:17 +0800
Subject: [PATCH 4/6] nvme-pci: break up nvme_timeout and nvme_dev_disable
In-Reply-To: <20180202183103.GI24417@localhost.localdomain>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-5-git-send-email-jianchao.w.wang@oracle.com>
 <20180202183103.GI24417@localhost.localdomain>
Message-ID: <584a703f-98e9-a07b-ad44-6fa51b119c02@oracle.com>

Hi Keith

Thanks for you kindly response and comment.
That's really appreciated.

On 02/03/2018 02:31 AM, Keith Busch wrote:
> On Fri, Feb 02, 2018@03:00:47PM +0800, Jianchao Wang wrote:
>> Currently, the complicated relationship between nvme_dev_disable
>> and nvme_timeout has become a devil that will introduce many
>> circular pattern which may trigger deadlock or IO hang. Let's
>> enumerate the tangles between them:
>>  - nvme_timeout has to invoke nvme_dev_disable to stop the
>>    controller doing DMA access before free the request.
>>  - nvme_dev_disable has to depend on nvme_timeout to complete
>>    adminq requests to set HMB or delete sq/cq when the controller
>>    has no response.
>>  - nvme_dev_disable will race with nvme_timeout when cancels the
>>    outstanding requests.
> 
> Your patch is releasing a command back to the OS with the
> PCI controller bus master still enabled. This could lead to data or
> memory corruption.
> 

There are two cases nvme_timeout will return.
BLK_EH_HANDLED
BLK_EH_NOT_HANDLED

For the 1st case, the patch will disable the controller.
Then the controller will stop processing any outstanding command and delete the sq/cq queues as the protocol.
Looks like it is still not enough, I will to disable the _pci_in nvme_pci_disable_dev_directly next version. 
Really thanks for your directive here.

For the 2nd case, it will return BLK_EH_NOT_HANDLED.
blk_mq_rq_timed_out will do nothing for this case.
All the command will be handled after all the things are disabled.

> In any case, it's not as complicated as you're making it out to
> be. It'd be easier to just enforce the exisiting rule that commands
> issued in the disabling path not depend on completions or timeout
> handling. All of commands issued in this path already do this except
> for HMB disabling. Let'sjust fix that command, right?
> 
We will still met nvme_timeout will invoke nvme_dev_disable and cannot synchronize on the outstanding
requests. This is really a devil and will be a block to do other improvements.
This patch just do two things:
1. grab all the previous outstanding requests with blk_abort_request. Then release them after the controller is totally disabled/shutdown.
   consequently, during the disable/shutdown and initializing procedure, nvme_timeout path only need to serve them. And this also could
   ensure there will be _no_ any outstanding requests after nvme_dev_disable.
2. fail the adminq command issued during disable/shutdown and initializing procedure when the controller no response. we need to do two 
   steps for this, disable the controller/pci and complete the command. Then nvme_timeout will not need to invoke nvme_dev_disable and nvme_dev_disable
   will be independent.
 
Please consider this.

Many thanks
Jianchao
