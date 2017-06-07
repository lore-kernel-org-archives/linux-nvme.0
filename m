From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 7 Jun 2017 12:56:12 +0300
Subject: [PATCH v4 for-4.13 2/6] mlx5: move affinity hints assignments to
 generic code
In-Reply-To: <20170607082200.GB24774@lst.de>
References: <1496814868-22070-1-git-send-email-sagi@grimberg.me>
 <1496814868-22070-3-git-send-email-sagi@grimberg.me>
 <20170607082200.GB24774@lst.de>
Message-ID: <1f762580-f958-5bf5-b0aa-7b67b9c98990@grimberg.me>


>>   
>> @@ -1730,7 +1725,8 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>>   	c->mdev     = priv->mdev;
>>   	c->tstamp   = &priv->tstamp;
>>   	c->ix       = ix;
>> -	c->cpu      = cpu;
>> +	c->cpu      = cpumask_first(pci_irq_get_affinity(priv->mdev->pdev,
>> +			MLX5_EQ_VEC_COMP_BASE + ix));
> 
> ->cpu is only used to call cpu_to_node on it.  So remove it and switch
> the users to
> 
> 	pci_irq_get_node(priv->mdev->pdev)
> 
> instead.

I started with this, but its not exactly correct, channel cpu is used to
construct the xps cpumask, see: mlx5e_activate_channel()
