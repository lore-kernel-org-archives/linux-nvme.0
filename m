From: jsmart2021@gmail.com (James Smart)
Date: Tue, 28 May 2019 17:13:25 -0700
Subject: [PATCH] nvme-fc: Add message when creating new controller
In-Reply-To: <alpine.LRH.2.21.9999.1905281624470.9636@mvluser05.qlc.com>
References: <20190528182404.3463-1-jsmart2021@gmail.com>
 <alpine.LRH.2.21.9999.1905281624470.9636@mvluser05.qlc.com>
Message-ID: <06bf2ef9-253e-3292-5cd5-11cae0c40afa@gmail.com>

On 5/28/2019 4:37 PM, Arun Easi wrote:
> On Tue, 28 May 2019, 11:24am, James Smart wrote:
> 
>> When looking at console messages to troubleshoot, there are one
>> maybe two messages before creation of the controller is complete.
>> However, a lot of io takes place to reach that point. It's unclear
>> when things have started.
>>
>> Add a message when the controller is first attempting to be
>> connecting to. Thus we know what controller and its NQN is being
>> put into place for any subsequent success or failure messages.
>>
>> Signed-off-by: James Smart <jsmart2021 at gmail.com>
>> ---
>>   drivers/nvme/host/fc.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>

>> +	dev_info(ctrl->ctrl.device,
>> +		"NVME-FC{%d}: creating new ctrl: NQN \"%s\"\n",
>> +		ctrl->cnum, ctrl->ctrl.opts->subsysnqn);
>> +
> 
> Adding rport+lport information would be helpful. It would be good to have
> for all messages, but at least one message establishing the relationship
> would make it easier when looking at logs.
> 
> Just wondering if there is any reason why no FC rport/lport info
> was logged with any of the messages in fc.c?

I actually asked myself the same question after sending the patch: 
whether having host_traddr and traddr fields in that message made sense. 
I opted to stay as is only because it is much shorter (those WWN's are 
long).

The other question I had is whether I should print this only on initial 
creation or whenever a new association is started so it picks up the 
cases of when a reconnect start.  Only disadvantage is - more long 
messages in the log.

I can easily be convinced to do something different if you prefer.

-- james
