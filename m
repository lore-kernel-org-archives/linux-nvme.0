From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 15 Aug 2018 18:19:46 -0700
Subject: [PATCH] nvmet: free workqueue object if module init fails
In-Reply-To: <20180814213430.4096-1-chaitanya.kulkarni@wdc.com>
References: <20180814213430.4096-1-chaitanya.kulkarni@wdc.com>
Message-ID: <2681cb3c-cd47-c3ad-5f65-af13a1cce620@grimberg.me>


>   out:
> +	if (buffered_io_wq)
> +		destroy_workqueue(buffered_io_wq);
>   	return error;
>   }

I think it will be better to give it a dedicated goto target
and fixup subsequent goto statements.
