From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Mar 2019 15:36:27 +0100
Subject: [PATCH] nvmet: protect discovery change log event
In-Reply-To: <20190311221157.25266-1-sagi@grimberg.me>
References: <20190311221157.25266-1-sagi@grimberg.me>
Message-ID: <20190312143627.GC1149@lst.de>

>  	struct nvmet_ctrl *ctrl;
>  
> +	mutex_lock(&nvmet_disc_subsys->lock);
>  	nvmet_genctr++;
> -

But there should be no need to takes this over the nvmet_genctr
increment, that is supposed to be protected using nvmet_config_sem.
That being said a lockdep_assert_held for that would be nice.

Also I think the subject line could use a tweak - we are not really
protecting the event, but the list iteration (as explained in the
commit log)
