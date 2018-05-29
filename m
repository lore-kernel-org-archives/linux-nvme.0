From: jgg@mellanox.com (Jason Gunthorpe)
Date: Tue, 29 May 2018 13:23:29 -0600
Subject: [PATCH 01/17] IB/isert: fix T10-pi check mask setting
In-Reply-To: <6c7335c1-1d59-f764-be46-9aab46eb8458@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-2-git-send-email-maxg@mellanox.com>
 <20180528072130.GB5618@lst.de>
 <452bfcde-ee3c-a4e5-e2d0-43114099590a@mellanox.com>
 <20180528120359.GA13368@lst.de>
 <99191c8c-b03e-f40d-ffd9-a73e01d0ae2a@mellanox.com>
 <20180528163324.GF17491@mellanox.com> <yq1o9gz2mi1.fsf@oracle.com>
 <6c7335c1-1d59-f764-be46-9aab46eb8458@mellanox.com>
Message-ID: <20180529192329.GJ18442@mellanox.com>

On Tue, May 29, 2018@03:08:21PM +0300, Max Gurtovoy wrote:
> 
> 
> On 5/29/2018 6:01 AM, Martin K. Petersen wrote:
> >
> >Jason,
> >
> >>I see no problem for you to take it. Let me know if you prefer we do
> >>it through RDMA.
> >
> >Applied to 4.17/scsi-fixes. Thanks!
> >
> 
> Thanks Martin.
> 
> Jason,
> how do you suggest to proceed with patches 2/3/4 that were reviewed by
> Christoph ?

If you want RDMA to take any patches send them to
linux-rdma at vger.kernel.org, updated to include the tags that Christoph
included.. Otherwise they are not in the RDMA patchworks.

> we must wait until Martin PR for sure...

Hmm, maybe we should have sent this patch through rdma in that
case.. The merge window is soon anyhow so it doesn't really matter
this time - but you need to think about what tree patches need to go
to when building your patch plan, don't just send a large unstructured
series like this and expect the maintainers to figure out all the
dependencies!

So, send the patches you want to the rdma list around rc1

Thanks,
Jason
