From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 May 2019 09:14:56 +0200
Subject: [PATCH] nvme-pci: Fix queue_count to consider nr_possible_cpu
In-Reply-To: <20190504113923.32316-1-minwoo.im.dev@gmail.com>
References: <20190504113923.32316-1-minwoo.im.dev@gmail.com>
Message-ID: <20190508071456.GA21604@lst.de>

On Sat, May 04, 2019@08:39:23PM +0900, Minwoo Im wrote:
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -147,6 +147,7 @@ static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
>  static int queue_count_set(const char *val, const struct kernel_param *kp)
>  {
>  	int n, ret;
> +	char cnt[6];
>  
>  	ret = kstrtoint(val, 10, &n);
>  	if (ret)
> @@ -154,7 +155,8 @@ static int queue_count_set(const char *val, const struct kernel_param *kp)
>  	if (n > num_possible_cpus())
>  		n = num_possible_cpus();
>  
> -	return param_set_int(val, kp);
> +	sprintf(cnt, "%d", n);
> +	return param_set_int(cnt, kp);

This just looks weird.  If we ant to limit the number why not
get rid of all these param_ops stuff and just verify the
number in nvme_calc_irq_sets without all that boilerplate code?
