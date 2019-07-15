From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 15 Jul 2019 09:40:39 -0600
Subject: [PATCH blktests 07/12] nvme/018: Ignore error message generated
 by nvme read]
In-Reply-To: <20190715071522.GB4495@x250>
References: <20190712235742.22646-1-logang@deltatee.com>
 <20190712235742.22646-8-logang@deltatee.com> <20190715071522.GB4495@x250>
Message-ID: <e1008f94-1cb7-8619-bbdd-802968e9402d@deltatee.com>



On 2019-07-15 1:15 a.m., Johannes Thumshirn wrote:
> On Fri, Jul 12, 2019@05:57:37PM -0600, Logan Gunthorpe wrote:
>> nvme-cli at some point started printing the error message:
>>
>>   NVMe status: CAP_EXCEEDED: The execution of the command has caused the
>> 	capacity of the namespace to be exceeded(0x6081)
>>
>> This was not accounted for by test 018 and caused it to fail.
>>
>> This test does not need to test the error message content, it's
>> only important that a read past the end of the file fails. Therefore,
>> pipe stderr of nvme-cli to /dev/null.
> 
> How about redirecting all of the output to $FULL?

Sure, I'll update it and send a v2.

Logan
