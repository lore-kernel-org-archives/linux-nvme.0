From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 26 Jun 2018 14:12:46 +0300
Subject: [PATCH v6 2/2] nvmet-rdma: support max(16KB, PAGE_SIZE) inline
 data
In-Reply-To: <e822e13637192a88f67d6be8cc01d4ff7720c937.1529938266.git.swise@opengridcomputing.com>
References: <cover.1529938266.git.swise@opengridcomputing.com>
 <e822e13637192a88f67d6be8cc01d4ff7720c937.1529938266.git.swise@opengridcomputing.com>
Message-ID: <ee7f57ae-7813-8d39-291d-49e2562b9526@grimberg.me>


> -	pr_info("enabling port %d (%pISpcs)\n",
> -		le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr);
> +	pr_info("enabling port %d (%pISpcs) inline_data_size %d\n",
> +		le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr,
> +		port->inline_data_size);

We can lose the info here, its should be visible via configfs.

otherwise looks fine,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
