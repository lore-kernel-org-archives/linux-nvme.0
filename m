From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 10 Dec 2018 22:47:25 +0000
Subject: [PATCH 03/12] nvmet: add error-log definitions
In-Reply-To: <b900a403-cda7-c150-630a-13ebf9c06ac2@grimberg.me>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
 <20181210055011.3146-4-chaitanya.kulkarni@wdc.com>,
 <b900a403-cda7-c150-630a-13ebf9c06ac2@grimberg.me>
Message-ID: <BYAPR04MB4502765504F81F35AA8CA0A886A50@BYAPR04MB4502.namprd04.prod.outlook.com>

Hi Sagi,

NVMET_ERROR_LOG_SLOTS is already defined in nvmet.h:-

# cat -n   drivers/nvme/target/nvmet.h  
     1	/*
     2	 * Copyright (c) 2015-2016 HGST, a Western Digital Company.
     3	 *
     4	 * This program is free software; you can redistribute it and/or modify it
     5	 * under the terms and conditions of the GNU General Public License,
     6	 * version 2, as published by the Free Software Foundation.
     7	 *
     8	 * This program is distributed in the hope it will be useful, but WITHOUT
     9	 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    10 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
    11 * more details.
    12 */
    13	
    14	#ifndef _NVMET_H
    15	#define _NVMET_H
    16	
    17	#include <linux/dma-mapping.h>
    18	#include <linux/types.h>
    19	#include <linux/device.h>
    20	#include <linux/kref.h>
    21	#include <linux/percpu-refcount.h>
    22	#include <linux/list.h>
    23	#include <linux/mutex.h>
    24	#include <linux/uuid.h>
    25	#include <linux/nvme.h>
    26	#include <linux/configfs.h>
    27	#include <linux/rcupdate.h>
    28	#include <linux/blkdev.h>
    29	#include <linux/radix-tree.h>
    30	
    31	#define NVMET_ASYNC_EVENTS		4
    32	#define NVMET_ERROR_LOG_SLOTS		128

We also use this in admin-cmd.c:-

309         id->frmw = (1 << 0) | (1 << 1);
310         id->lpa = (1 << 0) | (1 << 1) | (1 << 2);
311         id->elpe = NVMET_ERROR_LOG_SLOTS - 1;                                                                                                          
312         id->npss = 0;
313 



From: Sagi Grimberg <sagi@grimberg.me>
Sent: Monday, December 10, 2018 12:12 PM
To: Chaitanya Kulkarni; linux-nvme at lists.infradead.org
Cc: hch at lst.de; keith.busch at intel.com
Subject: Re: [PATCH 03/12] nvmet: add error-log definitions
? 


> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index dafee1af4829..5a19f64de891 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -202,6 +202,10 @@ struct nvmet_ctrl {
>?? 
>??????? struct device?????????? *p2p_client;
>??????? struct radix_tree_root? p2p_ns_map;
> +
> +???? spinlock_t????????????? error_lock;
> +???? u64???????????????????? counter;
> +???? struct nvme_error_slot? slots[NVMET_ERROR_LOG_SLOTS];
>?? };

NVMET_ERROR_LOG_SLOTS is undefined AFAICT.
    
