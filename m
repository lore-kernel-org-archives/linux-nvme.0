From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 20 May 2019 02:56:03 +0900
Subject: [PATCH V2 2/4] nvme-status: Introduce nvme status module to map
 errno
In-Reply-To: <BYAPR04MB5749007DAA9F804D6385FF8F86050@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190513170342.9497-1-minwoo.im.dev@gmail.com>
 <20190513170342.9497-3-minwoo.im.dev@gmail.com>
 <BYAPR04MB5749007DAA9F804D6385FF8F86050@BYAPR04MB5749.namprd04.prod.outlook.com>
Message-ID: <20190519175602.GB10876@minwooim-desktop>

On 19-05-19 17:42:19, Chaitanya Kulkarni wrote:
> On 05/13/2019 10:04 AM, Minwoo Im wrote:
> > Background:
> >    It's not enough to return the nvme status value in main() because it's
> > allowed to be in 8bits, but nvme status is indicated in 16bits.  So we
> > has not been able to figure out what kind of nvme status has been
> > returned by return value.
> >
> >    This patch introduces nvme-status module that manages mapping between
> > nvme status and errno.  It's not possible to make 1:1 mapping relations,
> > but we can map it as a groups.
> >
> > All the internal errors which has been returned in a negative value will
> > be returned with ECOMM that indicates communication errors.  In this
> > case, we can see what happened via stderr.
> 
> I didn't understand this as I don't see ECOMM in this patch, also when 
> you mentioned internal errors are you referring to the  NVME_SC_INTERNAL 
> ? in that case in this patch NVME_SC_INTERNAL is mapped to the EIO. Can 
> you please explain ?

Nice catch, Thanks, really.  I didn't make ECOMM errno included to this
patchset.  NVME_SC_INTERNAL will be mapped to EIO to make it
distinguished from ECOMM which indicates the internal linux errno.  All
the error status from nvme except cases defined in the following
switch-case will be mapped to EIO.

Will make this patch return ECOMM in case of internal linux error which
will be given in a negative value with the previos commit.

Thanks,
