From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Mar 2019 08:55:47 -0700
Subject: [PATCH] nvme: schedule requeue whenever a LIVE state is entered
In-Reply-To: <e03e9ab7-8973-097e-6ffb-60eec0ab47e5@suse.de>
References: <20190321141033.131308-1-hare@suse.de>
 <da58a1e4-14cd-2587-6350-dccabb6632f1@grimberg.me>
 <0ccee425-93bb-ad04-5b20-f8a792f1aafa@suse.com>
 <8fa7e09f-3621-f37b-9830-64377ce8cfd6@grimberg.me>
 <e03e9ab7-8973-097e-6ffb-60eec0ab47e5@suse.de>
Message-ID: <ec71c2a4-d3e1-36ad-b7bc-0e8e6e394a5d@grimberg.me>


> That's what we tried initially (cf thread "[PATCH] nvme-multipath: relax 
> ANA state check"), but got rejected by Christoph.

IIRC Christoph was asking why was requests being requeued when moving
from live -> live, and I think you answered that in your patch
description..
