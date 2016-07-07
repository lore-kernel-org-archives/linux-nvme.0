From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 7 Jul 2016 08:37:58 -0600
Subject: [patch] nvmet: fix an error code
In-Reply-To: <20160707081526.GA16742@mwanda>
References: <20160707081526.GA16742@mwanda>
Message-ID: <577E6946.9010207@kernel.dk>

On 07/07/2016 02:15 AM, Dan Carpenter wrote:
> We accidentally return zero here when ERR_PTR(-ENOMEM) is intended.
>
> Fixes: a07b4970f464 ('nvmet: add a generic NVMe target')
> Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

Thanks Dan, added.

-- 
Jens Axboe
