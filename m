From: james.smart@broadcom.com (James Smart)
Date: Mon, 14 May 2018 08:21:37 -0700
Subject: [PATCH v2] nvme: continue keep alive on error
In-Reply-To: <20180512133315.GA14317@infradead.org>
References: <20180511232229.18929-1-jsmart2021@gmail.com>
 <20180512133315.GA14317@infradead.org>
Message-ID: <3573acc7-f40d-0567-10ea-aa9cbb29bb99@broadcom.com>



On 5/12/2018 6:33 AM, Christoph Hellwig wrote:
> On Fri, May 11, 2018@04:22:29PM -0700, James Smart wrote:
>> Currently, if the keep_alive command failed, an error message is
>> generated and keep alive is stopped. This guarantees the target will
>> eventually not see a keep_alive in a KATO window and fail.
>>
>> The keep_alive command may complete in error in cases where the
>> transport or lldd are temporarily out of resources. As such, the
>> command should be retried rather than letting the controller die.
>>
>> If the command completes in error, retry another one after a short
>> delay. Track whether keep alive has had an error to reduce printing
>> the error message to the first failure only.
> This seems pretty much counter the definition of the keep alive.
> What kinds of errors do you see when you'd want to retry?  How we
> can we figute out we hit exactly that case instead of just wasting
> our time retrying?

The error is a temporary adapter resource error that wants the upper 
layer to retry the command, whatever command it was, after a short delay.

Taking another look at the code and the history of this issue:? the 
transport should be returning BLK_STS_RESOURCE and the blk-mq layer will 
take care of the retry. But the transport only does so if the LLDD 
returned a -EBUSY response. And lpfc until the recent patches, didn't 
always return -EBUSY.? So it was a driver error.

Ok - I'll drop this one too.

-- james
