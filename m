From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 19 Jan 2018 16:14:02 +0800
Subject: [PATCH V5 0/2] nvme-pci: fix the timeout case when reset is
 ongoing
In-Reply-To: <20180119080130.GE12043@localhost.localdomain>
References: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180119080130.GE12043@localhost.localdomain>
Message-ID: <0639aa2f-d153-5aac-ce08-df0d4b45f9a0@oracle.com>

Hi Keith

Thanks for your time to look into this.

On 01/19/2018 04:01 PM, Keith Busch wrote:
> On Thu, Jan 18, 2018@06:10:00PM +0800, Jianchao Wang wrote:
>> Hello
>>
>> Please consider the following scenario.
>> nvme_reset_ctrl
>>   -> set state to RESETTING
>>   -> queue reset_work       
>>     (scheduling)
>> nvme_reset_work
>>   -> nvme_dev_disable
>>     -> quiesce queues
>>     -> nvme_cancel_request 
>>        on outstanding requests
>> -------------------------------_boundary_
>>   -> nvme initializing (issue request on adminq)
>>
>> Before the _boundary_, not only quiesce the queues, but only cancel
>> all the outstanding requests.
>>
>> A request could expire when the ctrl state is RESETTING.
>>  - If the timeout occur before the _boundary_, the expired requests
>>    are from the previous work.
>>  - Otherwise, the expired requests are from the controller initializing
>>    procedure, such as sending cq/sq create commands to adminq to setup
>>    io queues.
>> In current implementation, nvme_timeout cannot identify the _boundary_ 
>> so only handles second case above.
> 
> Bare with me a moment, as I'm only just now getting a real chance to look
> at this, and I'm not quite sure I follow what problem this is solving.
> 
> The nvme_dev_disable routine makes forward progress without depending on
> timeout handling to complete expired commands. Once controller disabling
> completes, there can't possibly be any started requests that can expire.
> So we don't need nvme_timeout to do anything for requests above the
> boundary.
> 
Yes, once controller disabling completes, any started requests will be handled and cannot expire.
But before the _boundary_, there could be a nvme_timeout context runs with nvme_dev_disable in parallel.
If a timeout path grabs a request, then nvme_dev_disable cannot get and cancel it.
So even though the nvme_dev_disable completes, there still could be a request in nvme_timeout context.

The worst case is :
nvme_timeout                              nvme_reset_work
if (ctrl->state == RESETTING )              nvme_dev_disable
    nvme_dev_disable                        initializing procedure

the nvme_dev_disable run with reinit procedure in nvme_reset_work in parallel.


Thanks
Jianchao
