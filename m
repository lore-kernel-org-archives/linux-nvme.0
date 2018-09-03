From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Sep 2018 03:42:46 -0700
Subject: [PATCH] nvmet-rdma: fix possible bogus dereference under heavy
 load
In-Reply-To: <4d094f13-bcc1-0cea-2c2b-efdf232e51a9@mellanox.com>
References: <20180901011447.32287-1-sagi@grimberg.me>
 <20180901074414.GA32538@lst.de>
 <003801d441f0$fdc37a70$f94a6f50$@opengridcomputing.com>
 <4d094f13-bcc1-0cea-2c2b-efdf232e51a9@mellanox.com>
Message-ID: <776599cb-b2f9-abef-ab24-e4c351335243@grimberg.me>


> we also can't check during send completion:
>  ?if (rsp->req.sg != &rsp->cmd->inline_sg)
>  ??????????????? sgl_free(rsp->req.sg);
> 
> since the cmd was post_recv'ed (Sagi can you handle this in V2 ? can 
> simply add pointer in rsp to this.) We need to make sure we don't count 
> on rsp-cmd assosiacion after post_recv call (maybe remove it ??).

Right, will add this as an incremental patch.
