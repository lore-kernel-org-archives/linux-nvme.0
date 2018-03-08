From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 8 Mar 2018 22:32:55 +0800
Subject: [PATCH V4 1/5] nvme: do atomically bit operations on
 nvme_request.flags
In-Reply-To: <20180308075736.GB16084@lst.de>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <1520489971-31174-2-git-send-email-jianchao.w.wang@oracle.com>
 <20180308075736.GB16084@lst.de>
Message-ID: <d9d37fd4-2632-c46b-2ec1-291c4dc1d26d@oracle.com>

Hi Christoph

Thanks for your precious time for reviewing this.

On 03/08/2018 03:57 PM, Christoph Hellwig wrote:
>> -	u8			flags;
>>  	u16			status;
>> +	unsigned long flags;
> Please align the field name like the others, though

Yes, I will change this next version.

Thanks
Jianchao
