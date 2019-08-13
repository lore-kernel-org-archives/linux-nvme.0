From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 12 Aug 2019 23:33:14 -0700
Subject: [PATCH 1/2] nvmet-tcp: fix possible NULL deref
In-Reply-To: <5bff9385-b853-4868-6f78-2b9611fc479d@mellanox.com>
References: <20190808205522.24638-1-sagi@grimberg.me>
 <5bff9385-b853-4868-6f78-2b9611fc479d@mellanox.com>
Message-ID: <541549b3-657d-7007-fddb-9df0ce26d95e@grimberg.me>


> what about zeroing the sg_cnt during nvmet_tcp_get_cmd ?
> 
> and NULLify the cmd->req.sg as well in nvmet_tcp_get_cmd ?

Its set in nvmet_req_init()
