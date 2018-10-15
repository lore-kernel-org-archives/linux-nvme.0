From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 15 Oct 2018 14:19:01 -0700
Subject: Help needed: nvmet configuration
In-Reply-To: <CABnqofwo5xQGnuNTOzC+jsWqUmB-awS6nGWGK4SPPTDp=cFfeA@mail.gmail.com>
References: <CABnqofxasv=-xbQQ+XZH8jad4Oa0gnvKusk5sF_a-kdSLvK1Ww@mail.gmail.com>
 <75a10e13-29fd-df82-0289-b4f6948365c0@grimberg.me>
 <CABnqofwo5xQGnuNTOzC+jsWqUmB-awS6nGWGK4SPPTDp=cFfeA@mail.gmail.com>
Message-ID: <061df6c2-f1af-41b6-0bcd-5d936b4b41e5@grimberg.me>


> Thanks Sagi for your reply.
> 
> I do have 2 100 Gig mellanox NICs (with 12.12.12.38 and 12.12.14.38).
> 
> I copy pasted the incorrect interface.

Still looks like there is an address resolution listening to this IP.
Are you able to run any rdma_cm application over this device? Would
be good to run rdma_server/client on the same setup.
