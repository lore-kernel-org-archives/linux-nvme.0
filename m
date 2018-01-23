From: thomas.tai@oracle.com (Thomas Tai)
Date: Tue, 23 Jan 2018 09:59:21 -0500
Subject: [PATCH] nvme: Add fault injection feature
In-Reply-To: <20180123002341.GU12043@localhost.localdomain>
References: <1516666161-3716-1-git-send-email-thomas.tai@oracle.com>
 <20180123002341.GU12043@localhost.localdomain>
Message-ID: <e884f956-3fe5-20b0-931f-0f94df39052f@oracle.com>



On 2018-01-22 07:23 PM, Keith Busch wrote:
> On Mon, Jan 22, 2018@07:09:21PM -0500, Thomas Tai wrote:
>>
>> Once the error injection is enabled, BLK_STS_IOERR will be
>> injected into the nvme_setup_cmd. Following example shows
>> how to inject an error.
> 
> That doesn't seem like a very interesting place to inject an
> error. Woudln't nvme_end_request be more interesting?
> 

Hi Keith,
Thanks for your suggestion. Will move the error injection to 
nvme_end_request in next version of the patch.

Thanks,
Thomas
