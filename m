From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Mon, 23 Jul 2018 13:59:36 +0000
Subject: [PATCH 2/2] scsi: set timed out out mq requests to complete
In-Reply-To: <20180723081231.GB19247@lst.de>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
 <1073d0d2902327970c4e28a4c7c97a21fd8885c8.camel@wdc.com>
 <20180720155646.GE4093@localhost.localdomain>
 <2b01f0a8d5864b2563573d46ce5b4ec5f593f538.camel@wdc.com>
 <20180720161240.GF4093@localhost.localdomain>
 <092dd4f2dae0cc533018c9fb829a50b4cbb6cb0b.camel@wdc.com>
 <20180720162321.GG4093@localhost.localdomain>
 <797120d19f5d15e7d98a3d2f90ce91ebf60690d7.camel@wdc.com>
 <20180720172444.GH4093@localhost.localdomain>
 <20180723081231.GB19247@lst.de>
Message-ID: <c62df9fa8002857f4145c8cef686d1711ed48dc7.camel@wdc.com>

On Mon, 2018-07-23@10:12 +0200, hch@lst.de wrote:
> Btw, one thing we should do in blk-mq and scsi is to make the time
> optional.  If the blk_mq driver doesn't even have a timeout structure
> there is no point in timing out requests and enter the timeout handler
> ever.

Are there any blk-mq drivers that do not define a timeout handler and that
use shared tags? I think such drivers need periodic calls to blk_mq_tag_idle().
Do you perhaps want to happen these calls from another context?

Thanks,

Bart.
