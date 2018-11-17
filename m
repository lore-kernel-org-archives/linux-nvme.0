From: davem@davemloft.net (David Miller)
Date: Sat, 17 Nov 2018 12:15:10 -0800 (PST)
Subject: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <20181115171626.9306-11-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-11-sagi@lightbitslabs.com>
Message-ID: <20181117.121510.1754018619653365187.davem@davemloft.net>

From: Sagi Grimberg <sagi@lightbitslabs.com>
Date: Thu, 15 Nov 2018 09:16:22 -0800

> +static unsigned nvmet_tcp_recv_budget = 8;
> +module_param_named(recv_budget, nvmet_tcp_recv_budget, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(recv_budget, "recvs budget");
> +
> +static unsigned nvmet_tcp_send_budget = 8;
> +module_param_named(send_budget, nvmet_tcp_send_budget, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(send_budget, "sends budget");
> +
> +static unsigned nvmet_tcp_io_work_budget = 64;
> +module_param_named(io_work_budget, nvmet_tcp_io_work_budget, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(io_work_budget, "io work budget");

I strongly suggest moving away from module parameters for this stuff.

Create a genetlink socket family and allow run time configuration of these knobs
by the user.

Thanks.
