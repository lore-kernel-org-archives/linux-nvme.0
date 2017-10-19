From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 19 Oct 2017 10:17:01 +0300
Subject: [PATCH 10/17] nvme: switch controller refcounting to use struct
 device
In-Reply-To: <20171018165258.23212-11-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-11-hch@lst.de>
Message-ID: <b4e85bf7-f0ae-4ea9-2caa-3ba3645f88ea@grimberg.me>



> -	if (!kref_get_unless_zero(&ctrl->ctrl.kref))
> -		return -EBUSY;
> +	nvme_get_ctrl(&ctrl->ctrl);

Given that we take this reference before we are protected with
the state change I think this should still be get_unless_zero.

Maybe we can introduce get_device_unless_zero() for this?
