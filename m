From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 14:06:39 +0300
Subject: [PATCH 3/5] nvme_fcloop: split job struct from transport for
 req_release
In-Reply-To: <20170324034321.8719-4-jsmart2021@gmail.com>
References: <20170324034321.8719-1-jsmart2021@gmail.com>
 <20170324034321.8719-4-jsmart2021@gmail.com>
Message-ID: <77336c0d-5c20-b36e-da62-bbab5e96b36f@grimberg.me>



On 24/03/17 06:43, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
>
> Current design has the fcloop job struct, used for both initiator and
> target processing, allocated as part of the initiator request structure.
> On aborts, the initiator side (based on the request) may terminate, yet
> the target side wants to continue processing. the target side can't do
> that if the initiator side goes away.

Isn't refcount an easier way to go?

otherwise looks fine,

Reviewed-by: Sagi Grimberg <sagi at grimbeg.me>
