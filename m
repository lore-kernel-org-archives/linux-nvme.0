From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 25 Jul 2018 14:47:17 +0300
Subject: [PATCH v3 2/3] block: move dif_prepare/dif_complete functions to
 block layer
In-Reply-To: <20180725112247.GA24190@lst.de>
References: <1532508421-2711-1-git-send-email-maxg@mellanox.com>
 <1532508421-2711-2-git-send-email-maxg@mellanox.com>
 <20180725112247.GA24190@lst.de>
Message-ID: <a1d9dc80-6fe9-78c7-2eed-9912ae01e456@mellanox.com>



On 7/25/2018 2:22 PM, Christoph Hellwig wrote:
>> +			pmap = kmap_atomic(iv.bv_page) + iv.bv_offset;
>> +			p = pmap;
> 
> Maybe:
> 
> 			pmap = p = kmap_atomic(iv.bv_page) + iv.bv_offset;
> 
>> +			for (j = 0; j < iv.bv_len; j += tuple_sz) {
>> +				pi = (struct t10_pi_tuple *)p;
> 
> No need for the cast, also the pi declaration can be moved into the
> inner scope:
> 
> 				struct t10_pi_tuple *pi = p;
> 
>> +			pmap = kmap_atomic(iv.bv_page) + iv.bv_offset;
>> +			p = pmap;
>> +			for (j = 0; j < iv.bv_len; j += tuple_sz) {
>> +				if (intervals == 0) {
>> +					kunmap_atomic(pmap);
>> +					return;
>> +				}
>> +				pi = (struct t10_pi_tuple *)p;
> 
> Same here.
> 
> Also the intervals check would make sense in the for loop I think, e.g.:
> 
> 			pmap = p = kmap_atomic(iv.bv_page) + iv.bv_offset;
> 			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
> 				struct t10_pi_tuple *pi = p;
> 


Yes it make sense, but we can do more iterations before we return but I 
guess it's rare and it's worth to have less lines of code.
I'll update it for the next version.
