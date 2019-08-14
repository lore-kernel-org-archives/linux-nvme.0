From: gpiccoli@canonical.com (Guilherme G. Piccoli)
Date: Wed, 14 Aug 2019 13:18:22 -0300
Subject: [PATCH] nvme: Use first ctrl->instance id as subsystem id
In-Reply-To: <20190814160640.GA3256@localhost.localdomain>
References: <20190814142836.2322-1-gpiccoli@canonical.com>
 <20190814160640.GA3256@localhost.localdomain>
Message-ID: <abfc4bd0-f4f0-5655-81ee-ec32d3516f35@canonical.com>

On 14/08/2019 13:06, Keith Busch wrote:
> On Wed, Aug 14, 2019@07:28:36AM -0700, Guilherme G. Piccoli wrote:
>>[...]
> 
> The subsystem lifetime is not tied to a single controller's. Disconnect
> the "first" controller in a multipathed subsystem with this patch, then
> connect another controller from a different subsystem, and now you will
> create naming collisions.
> 

Hi Keith, thanks for your clarification. Isn't the controller id unique?
Could the new connected controller from a different subsystem have the
same id? If you can give a rough example I appreciate.

But given the above statement is a fact, what do you think of trying the
ctrl->instance first and in case we have duplicity, fallback to
subsystem ID allocator?

Since the creation of subsystems is not a critical path, adding this
small burden shouldn't be a huge penalty, and it'll help a lot with the
huge amount of reports of "confusion" after the introduction of nvme
multipathing, also it helps for the case I mentioned in the description,
some multipath'ed controllers, some single ones.

Cheers,


Guilherme
