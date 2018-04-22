From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 22 Apr 2018 17:26:42 +0300
Subject: [PATCH 1/2] nvmet: reset keep alive timer in controller enable
In-Reply-To: <20180417152452.GC25823@lst.de>
References: <20180415084741.4235-1-sagi@grimberg.me>
 <20180417152452.GC25823@lst.de>
Message-ID: <dce8390b-c433-e740-3c90-9575c329680b@mellanox.com>

hi Sagi,

On 4/17/2018 6:24 PM, Christoph Hellwig wrote:
> On Sun, Apr 15, 2018@11:47:40AM +0300, Sagi Grimberg wrote:
>> From: Max Gurtuvoy <maxg at mellanox.com>

please copy-paste my signature for both patches (small typo):
Max Gurtovoy <maxg at mellanox.com>


>>
>> Controllers that are not yet enabled should not really
>> enforce keep alive timeout, but we still want to track
>> a timeout and cleanup in case a host died before it enabled
>> us. Hence, simply reset the keep alive timer when the controller
>> is enabled.
> 
> Please move a comment like this into the code (and use all 80 chars
> you have available in source files :)).

are you sending V2 or I will ?


> 
> Otherwise this looks good.
> 
