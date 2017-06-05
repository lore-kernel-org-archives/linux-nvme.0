From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Jun 2017 11:14:43 +0300
Subject: NVMeoF: multipath stuck after bringing one ethernet port down
In-Reply-To: <0d0bb86a-7def-d04b-f4a4-362bc5bb1e4b@gmail.com>
References: <CAK0KL7DPLw+0AB8cGop7jowfE1HV9wyXBmJhE90trpor-PcSYw@mail.gmail.com>
 <ebb7ffb8-4dec-5540-5cef-ffd36bef3e25@grimberg.me>
 <fa6277fa-948f-103e-1322-f8b2362467c3@gmail.com>
 <656fd267-1e01-b561-fc74-e36c1892d1f9@gmail.com>
 <5b5b0a61-41cc-8018-19db-f683a604d7e4@grimberg.me>
 <48b14a96-e419-f6d1-090e-cbe774139e11@mellanox.com>
 <459af627-3918-768e-c35f-3f99768b82cb@grimberg.me>
 <0d0bb86a-7def-d04b-f4a4-362bc5bb1e4b@gmail.com>
Message-ID: <c4e61783-bf7d-02dc-8172-6d5feb85c5c4@grimberg.me>

> I tested the patch, works great.
> 
> Both IO (dd), "multipath -ll", and "nvme list" return instantaneously 
> with IO error, multipath is reinstated as soon as the path is reconnected.

Thanks Shahar,

Alex, does the patch work for you as well?

Christoph, any feedback on this patch? if not, I'll submit a formal
patch soon for 4.12-rc.
