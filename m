From: axboe@fb.com (Jens Axboe)
Date: Tue, 9 May 2017 08:50:17 -0600
Subject: [PATCH] lightnvm: Remove an unused variable
In-Reply-To: <79988EFB-7909-4234-B4D9-435AAFAE2E07@lightnvm.io>
References: <20170509093450.dgj3qghdwefpg6li@mwanda>
 <79988EFB-7909-4234-B4D9-435AAFAE2E07@lightnvm.io>
Message-ID: <ff06f5a2-bff2-a366-34d4-53b993c13602@fb.com>

On 05/09/2017 04:19 AM, Javier Gonz?lez wrote:
>> On 9 May 2017,@11.34, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>
>> "rq" is never used in nvme_nvm_rqtocmd().  We also recently shifted some
>> code around so it's uninitialized and causes a static checker warning.
>> Let's just remove it.
>>
> 
> Looks good. I didn't see it when I refactored that part.
> Matias: If it is ok with you, can you pick it up?
> 
> Reviewed-by: Javier Gonz?lez <javier at cnexlabs.com>

Geert sent in a similar fix two days ago, it's already queued up:

commit 629b1b2e0e6c8285fdc21624af60e8190fa4417e
Author: Geert Uytterhoeven <geert at linux-m68k.org>
Date:   Sun May 7 16:14:44 2017 +0200

    lightnvm: remove unused rq parameter of nvme_nvm_rqtocmd() to kill warning

-- 
Jens Axboe
