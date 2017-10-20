From: jsmart2021@gmail.com (James Smart)
Date: Fri, 20 Oct 2017 07:50:45 -0700
Subject: [PATCH v3 3/5] nvme_fc: add a dev_loss_tmo field to the remoteport
In-Reply-To: <ee0d6875-843f-103e-fa1e-825bf18acf48@suse.de>
References: <20171017233248.6769-1-jsmart2021@gmail.com>
 <20171017233248.6769-4-jsmart2021@gmail.com>
 <ee0d6875-843f-103e-fa1e-825bf18acf48@suse.de>
Message-ID: <390ba07b-bdd5-ec3c-ded2-dd1286404025@gmail.com>

On 10/19/2017 11:04 PM, Hannes Reinecke wrote:
> Is this exported to sysfs somewhere? If not, can we have it in sysfs?
> It surely made live _so_ much easier when configuring the odd device...
> 
> Other than that:
> 
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> 
> Cheers,
> 
> Hannes
> 

Currently, the scsi transpoirt fc_rport sysfs entry has the dev_loss_tmo 
attribute, and when set, the driver will call the 
nvme_fc_set_remoteport_devloss() routine to set it on the nvme-fc 
remoteport.

When we genericize the fc transport, it will be on the generic fc_rport, 
and the set will call both the SCSI transport/lldd and the NVME remoteport.

-- james
