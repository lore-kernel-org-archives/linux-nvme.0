From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 8 Jun 2017 09:46:05 +0200
Subject: [PATCH v6 01/10] scatterlist: add sg_zeroout_area() helper
In-Reply-To: <20170608074124.GA13953@lst.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170607094536.32419-2-jthumshirn@suse.de> <20170608074124.GA13953@lst.de>
Message-ID: <a4e7a0a6-3ba8-c205-c0bb-d50778accc80@suse.de>

On 06/08/2017 09:41 AM, Christoph Hellwig wrote:
>>  size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
>>  			  void *buf, size_t buflen, off_t skip);
>>  
>> +size_t sg_zeroout_area(struct scatterlist *sgl, unsigned int nents,
>> +		       size_t buflen, off_t skip);
> 
> Maybe sg_zero_buffer to fit with the other functions in the family?
> 
> (I'd be happy to fix this up if you're ok and we don't need another
> respin otherwise).

Sounds good.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
