From: jsmart2021@gmail.com (James Smart)
Date: Mon, 15 May 2017 14:48:53 -0700
Subject: [PATCH 04/15] lpfc: Fix nvmet RQ resource needs for large block
 writes.
In-Reply-To: <628697c5-6273-f87b-6f39-145bbeeb0741@suse.de>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-5-jsmart2021@gmail.com>
 <628697c5-6273-f87b-6f39-145bbeeb0741@suse.de>
Message-ID: <e822a05f-c59e-4f1b-c6a9-17580ebd98fb@gmail.com>

On 5/10/2017 11:18 PM, Hannes Reinecke wrote:
> On 05/10/2017 09:07 PM, James Smart wrote:
>> Large block writes to the nvme target were failing because
>> the default number of RQs posted was insufficient.
>>
>> Expand the NVMET RQs to 2048 RQEs and ensure a minimun of 2048
>                                                          512^^^^
> The minimum is actually 512, isn't it?

effectively. Reworked patch to set minimum at 512.

Will repost.

-- james
