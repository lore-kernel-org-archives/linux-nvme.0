From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 15:14:05 +0300
Subject: NVMeoF: multipath stuck after bringing one ethernet port down
In-Reply-To: <cc73ebe9-ab1c-18cf-5c5c-240358d82f3c@kaminario.com>
References: <CAK0KL7DPLw+0AB8cGop7jowfE1HV9wyXBmJhE90trpor-PcSYw@mail.gmail.com>
 <ebb7ffb8-4dec-5540-5cef-ffd36bef3e25@grimberg.me>
 <fa6277fa-948f-103e-1322-f8b2362467c3@gmail.com>
 <656fd267-1e01-b561-fc74-e36c1892d1f9@gmail.com>
 <e685401a-25c4-deb4-3eb2-b5182ccbd64c@gmail.com>
 <cc73ebe9-ab1c-18cf-5c5c-240358d82f3c@kaminario.com>
Message-ID: <0d4f7dca-3b5c-5cca-f077-58d1f8ab40a8@grimberg.me>


> I played with the keep alive thread so that it didn't exit if it got an
> error, and that was resolved as well.

Why is that needed? there is no reason scheduling keep-alives if they
fail.
