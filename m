From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 20 Oct 2016 16:35:43 -0500
Subject: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
 informative
In-Reply-To: <018701d22b16$b4927e20$1db77a60$@opengridcomputing.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
 <00bf01d22adf$43370ac0$c9a52040$@opengridcomputing.com>
 <0b3c125a-cdb8-7a28-deca-0ccad3d1ca22@sandisk.com>
 <010801d22af9$c202c370$46084a50$@opengridcomputing.com>
 <31822981-0032-98aa-6570-450351020463@sandisk.com>
 <012601d22afd$5a310460$0e930d20$@opengridcomputing.com>
 <015201d22b0b$4f526440$edf72cc0$@opengridcomputing.com>
 <015c01d22b12$5e9f4e70$1bddeb50$@opengridcomputing.com>
 <2ce6e308-0a64-8d68-dbf0-8c58c78e1af0@sandisk.com>
 <018701d22b16$b4927e20$1db77a60$@opengridcomputing.com>
Message-ID: <019501d22b19$e9907160$bcb15420$@opengridcomputing.com>

> > Hello Steve,
> >
> > Had you already realized that the description of my patch 6/6 shows that
> > it is not guaranteed on an IB setup that ev->param.conn.private_data_len
> > == 0 for other cases than IB_CM_REJ_CONSUMER_DEFINED?
> 
> Sorry, I missed that. :(
> 

Perhaps another helper in addition to rdma_reject_msg():  rdma_reject_has_user_data()?
