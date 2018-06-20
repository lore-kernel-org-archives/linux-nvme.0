From: hch@lst.de (Christoph Hellwig)
Date: Wed, 20 Jun 2018 14:28:32 +0200
Subject: [PATCH v2 1/2] nvmet: reset keep alive timer in controller enable
In-Reply-To: <f94d4506-6985-e7bc-8f0e-aa23bb2bcf89@grimberg.me>
References: <20180619124534.26736-1-sagi@grimberg.me>
 <20180620090611.GA4188@lst.de>
 <3941d283-0d98-b69c-3d5b-c544cc52aa50@mellanox.com>
 <f94d4506-6985-e7bc-8f0e-aa23bb2bcf89@grimberg.me>
Message-ID: <20180620122832.GA13858@lst.de>

On Wed, Jun 20, 2018@01:41:08PM +0300, Sagi Grimberg wrote:
>
>>> I've applied both patches to nvme-4.18.
>>
>>
>> the second one is not complete for error flows (I've mentioned it 
>> yesterday).
>
> Yea - lets hold off on patch 2

Ok. I've dropped patch 2 for now.
