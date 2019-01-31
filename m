From: keith.busch@intel.com (Keith Busch)
Date: Thu, 31 Jan 2019 12:05:11 -0700
Subject: Question about ioctl interface - IO passthru
In-Reply-To: <BYAPR04MB4502BAB173C20E8B499D633986910@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <CAPrnrPBpcuh2r40Bxzrq=PmDAaemnOvd4Or2nKFCannQ6oGkGg@mail.gmail.com>
 <20190131145539.GB19637@localhost.localdomain>
 <CAPrnrPCgxrucTYZeS3+7Ww7gAQmXA0JY0CB6gJXtSSAoT24D4w@mail.gmail.com>
 <BYAPR04MB4502BAB173C20E8B499D633986910@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <20190131190510.GA20974@localhost.localdomain>

On Thu, Jan 31, 2019@06:39:28PM +0000, Chaitanya Kulkarni wrote:
> So I think it is a good start that to use the nvme_passthru command and make it more generic.
> 
> Keith any comments on this ?
> 
> or should we extend the nvme_user_io command with
> the new addition such as result field (less likely in my?opinion, may break IOCTL)??

Yeah, we can't break the ioctl ABI. :(

The only reason I haven't moved nvme-cli from user_io to passthru is
that user_io works on every nvme capable kernel, and it also supported
metadata long before passthru did. I think it's overdue, though, I'll
just add a new param for ancient-kernel compatibility mode to fallback
to the legacy user_io.
