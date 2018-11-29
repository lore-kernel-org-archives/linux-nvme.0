From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 29 Nov 2018 10:05:45 -0700
Subject: [PATCH 7/7] blk-mq: use plug for devices that implement
 ->commits_rqs()
In-Reply-To: <20181129154959.GF7234@infradead.org>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-8-axboe@kernel.dk>
 <20181129154959.GF7234@infradead.org>
Message-ID: <6b3b1c19-4c74-2a8c-849d-1bccee8663d4@kernel.dk>

On 11/29/18 8:49 AM, Christoph Hellwig wrote:
>> +		/*
>> +		 * Use plugging if we have a ->commit_rqs() hook as well,
>> +		 * as we know the driver uses bd->last in a smart
>> +		 * fashion.
>> +		 */
> 
> Nipick: this could flow on just two lines:
> 
> 		/*
> 		 * Use plugging if we have a ->commit_rqs() hook as well, as we
> 		 * know the driver uses bd->last in a smart fashion.
> 		 */

Fixed up.

-- 
Jens Axboe
