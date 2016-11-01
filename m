From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 1 Nov 2016 06:43:52 -0700
Subject: [PATCH] nvmet: Fix possible infinite loop triggered on hot
 namespace removal
In-Reply-To: <1477819337-31190-1-git-send-email-sagi@grimberg.me>
References: <1477819337-31190-1-git-send-email-sagi@grimberg.me>
Message-ID: <20161101134352.GA5096@infradead.org>

>  void nvmet_ns_disable(struct nvmet_ns *ns)
> @@ -324,13 +324,10 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>  	struct nvmet_subsys *subsys = ns->subsys;
>  	struct nvmet_ctrl *ctrl;
>  
> -	mutex_lock(&subsys->lock);
> -	if (list_empty(&ns->dev_link)) {
> -		mutex_unlock(&subsys->lock);
> +	if (!test_and_clear_bit(NVMET_NS_ENABLED, &ns->flags))
>  		return;
> -	}
> -	list_del_init(&ns->dev_link);
> -	mutex_unlock(&subsys->lock);
> +
> +	list_del_rcu(&ns->dev_link);

We'll still need the lock here, don't we?
