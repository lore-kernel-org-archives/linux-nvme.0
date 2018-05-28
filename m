From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 28 May 2018 14:54:48 +0300
Subject: [PATCH 01/17] IB/isert: fix T10-pi check mask setting
In-Reply-To: <20180528072130.GB5618@lst.de>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-2-git-send-email-maxg@mellanox.com>
 <20180528072130.GB5618@lst.de>
Message-ID: <452bfcde-ee3c-a4e5-e2d0-43114099590a@mellanox.com>



On 5/28/2018 10:21 AM, Christoph Hellwig wrote:
> On Sun, May 27, 2018@06:50:06PM +0300, Max Gurtovoy wrote:
>> A copy/paste bug (probably) caused setting of an app_tag check mask
>> in case where a ref_tag check was needed.
>>
>> Fixes: 38a2d0d429f1 ("IB/isert: convert to the generic RDMA READ/WRITE API")
>> Fixes: 9e961ae73c2c ("IB/isert: Support T10-PI protected transactions")
>> Cc: stable at vger.kernel.org
>> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> 
> Looks good, and should probably got into the scsi tree ASAP.

Yes, there are few patches that can be pushed "as is".

Should it go through Nicholas PR ?

> 
> Btw, please don't cc stable@ for the whole series.
> 

The cc stable@ is only for this patch and not for the series.
