From: james.smart@broadcom.com (James Smart)
Date: Wed, 11 Oct 2017 07:35:08 -0700
Subject: [PATCH v2 3/7] nvme_fc: add a dev_loss_tmo field to the remoteport
In-Reply-To: <984d8db1-c518-b515-05b5-46ba61c58c84@grimberg.me>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-4-jsmart2021@gmail.com>
 <984d8db1-c518-b515-05b5-46ba61c58c84@grimberg.me>
Message-ID: <d79a9eca-5fbc-1933-986e-bb16467e34cc@broadcom.com>

On 10/11/2017 3:11 AM, Sagi Grimberg wrote:
>
>> +#define NVME_FC_DEFAULT_DEV_LOSS_TMO 60??? /* seconds */
>
> Why not reusing NVMF_DEF_CTRL_LOSS_TMO ? and isn't 60 seconds
> a little to aggressive to give up?

Because there is an existing FC port timeout which is currently over on 
the SCSI side of the house.? The FC port will support both SCSI and 
FC-NVME simultaneously on the FC port - so it spans/affects both.? When 
the "common fc class" is created and moved out from under scsi, it will 
be the one with the value.


>
> What do you do with the ctrl_loss_tmo user parameter?

Well - this patch munged the dev_loss_tmo value into the 
ctrl_loss_tmo-based values. That is an issue - so in a prior comment I 
stated I'm reposting with the controller loss timeout kept separate from 
the fc port dev_loss_tmo. Thus NVMF_DEF_CTRL_LOSS_TMO and ctrl_loss_tmo 
will be used normally - like it is with RDMA. Dev_loss_tmo will be 
tracked at the fc port level and if fires, will trump wherever the 
controller is in its ctrl_loss_tmo

-- james
