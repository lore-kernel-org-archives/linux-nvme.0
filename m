From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Fri, 5 Jan 2018 16:30:26 +0100 (CET)
Subject: [PATCH 09/12] nvme-pci: Use PCI p2pmem subsystem to manage the CMB
In-Reply-To: <20180104190137.7654-10-logang@deltatee.com>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-10-logang@deltatee.com>
Message-ID: <281272464.115248600.1515166226009.JavaMail.zimbra@kalray.eu>

> @@ -429,10 +429,7 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
> {
> 	u16 tail = nvmeq->sq_tail;
> 
> -	if (nvmeq->sq_cmds_io)
> -		memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
> -	else
> -		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
> +	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
> 

Why is it always memcpy() and not memcpy_toio()? I'd expect something like
if (nvmeq->sq_cmds_is_io)
	memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
else
	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));

Marta
