From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 13 Aug 2019 09:35:59 -0700
Subject: [PATCH] nvme-tcp: Make nvme_tcp_mq_ops constant
In-Reply-To: <20190813090253.8813-1-nishkadg.linux@gmail.com>
References: <20190813090253.8813-1-nishkadg.linux@gmail.com>
Message-ID: <9e4598f0-dfc6-0fa6-8081-dbd568c39d9a@grimberg.me>

> Static structure nvme_tcp_mq_ops, of type blk_mq_ops, is not used except
> to be assigned to field ops of variable set. Variable set itself has
> type blk_mq_tag_set, whose field ops is declared as const. Hence
> nvme_tcp_mq_ops cannot be modified after being assigned to field ops of
> variable set. Therefore declare nvme_tcp_mq_ops const as well.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux at gmail.com>

Looks fine,

Can you please respin a patch that applies cleanly on nvme-5.4?

You can add my: Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
