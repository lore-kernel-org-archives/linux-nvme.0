From: keith.busch@intel.com (Keith Busch)
Date: Tue, 21 Feb 2017 17:42:23 -0500
Subject: [PATCH] nvme-cli: fabrics: Fix to pass "host_traddr" to the
 kernel driver.
In-Reply-To: <39a0312c-9994-f52c-c714-1d94c4501f8c@grimberg.me>
References: <n> <1486579584-5660-1-git-send-email-duane.grigsby@qlogic.com>
 <23f1e7ba-7085-2692-cc95-ef63a535a31c@grimberg.me>
 <A4F3AC48-4E31-49F4-9498-6A65C3659EF1@cavium.com>
 <fec0b817-0ebd-0e49-b04d-9601ce516fe6@grimberg.me>
 <07574210-2E0C-4455-9FF3-6D7D5B7DE3DA@cavium.com>
 <39a0312c-9994-f52c-c714-1d94c4501f8c@grimberg.me>
Message-ID: <20170221224222.GA1362@localhost.localdomain>

On Tue, Feb 21, 2017@11:08:14PM +0200, Sagi Grimberg wrote:
> 
> > I have not tried the fc target loopback.
> 
> 
> After looking at the code again I now recall that the
> connection string construction is not shared by transports. My
> concern was that other transports (rdma) won't blow up...
> 
> So this looks good,
> 
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

Thanks, applied the patch with the review.
