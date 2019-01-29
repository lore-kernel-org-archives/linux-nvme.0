From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 29 Jan 2019 06:50:56 -0800
Subject: [PATCH] nvme-cli: minor cleanup for sibmit_io()
In-Reply-To: <20190129071202.174535-1-chaitanya.kulkarni@wdc.com>
References: <20190129071202.174535-1-chaitanya.kulkarni@wdc.com>
Message-ID: <a9136048-6118-ab5b-72da-9f702ea0c5a4@acm.org>

On 1/28/19 11:12 PM, Chaitanya Kulkarni wrote:
> -	} else {
> +	} else
>   		buffer_size = cfg.data_size;
> -	}

Does nvme-cli follow the kernel coding style? The kernel coding style 
guide explicitly mentions that braces should be balanced. So this patch 
changes codes that conforms to that style guide into code that does not 
conform.

Bart.
