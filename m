From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 12 Mar 2018 21:55:27 -0400
Subject: [PATCH v3 08/11] nvme-pci: Use PCI p2pmem subsystem to manage the
 CMB
In-Reply-To: <20180312193525.2855-9-logang@deltatee.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-9-logang@deltatee.com>
Message-ID: <4b08ec0b-76f4-4b67-a38b-5a1940c4c40d@codeaurora.org>

On 3/12/2018 3:35 PM, Logan Gunthorpe wrote:
> -	if (nvmeq->sq_cmds_io)

I think you should keep the code as it is for the case where
(!nvmeq->sq_cmds_is_io && nvmeq->sq_cmds_io)

You are changing the behavior for NVMe drives with CMB buffers.
You can change the if statement here with the statement above.

> -		memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
> -	else
> -		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
> +	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
>  


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
