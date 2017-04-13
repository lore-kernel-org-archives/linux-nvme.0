From: loberman@redhat.com (Laurence Oberman)
Date: Thu, 13 Apr 2017 12:59:32 -0400 (EDT)
Subject: [PATCH v2 0/4] arbitrary sg lists support
In-Reply-To: <9a8bc957-dcc0-2e54-d631-9f05f96e0f18@mellanox.com>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492101079.5176.9.camel@sandisk.com>
 <9a8bc957-dcc0-2e54-d631-9f05f96e0f18@mellanox.com>
Message-ID: <367807838.15062382.1492102772337.JavaMail.zimbra@redhat.com>



----- Original Message -----
> From: "Max Gurtovoy" <maxg at mellanox.com>
> To: "Bart Van Assche" <Bart.VanAssche at sandisk.com>, hch at lst.de, "keith busch" <keith.busch at intel.com>,
> linux-nvme at lists.infradead.org, linux-rdma at vger.kernel.org, leon at kernel.org
> Cc: vladimirk at mellanox.com, "Laurence Oberman" <loberman at redhat.com>
> Sent: Thursday, April 13, 2017 12:46:27 PM
> Subject: Re: [PATCH v2 0/4] arbitrary sg lists support
> 
> 
> 
> On 4/13/2017 7:31 PM, Bart Van Assche wrote:
> > On Thu, 2017-04-13@18:56 +0300, Max Gurtovoy wrote:
> >> This patch adds an arbitrary sg list support to NVMEoF host for
> >> capable devices (such as RDMA CX4/CX5 HCAs).
> >> During the review we decided to add an helper function to ib_core
> >> that will be used by ULPs in order to avoid code duplication.
> >
> > Hello Max,
> >
> > A question that is not related to the ULP drivers touched by this patch
> > series:
> > some time ago registration of sg-lists with gaps was disabled in the SRP
> > initiator because arbitrary sg-lists triggered CQE dumps in combination
> > with the
> > mlx5 driver. Does this mean that this issue has been resolved? If so, what
> > mlx5
> > driver and/or firmware version are needed to reenable arbitrary sg-list
> > support
> > in the SRP initiator?
> >
> 
> Hi Bart,
> IsraelR and I couldn't repro this issue even once on our labs. I suggest
> we take it with Laurence and try to figure it out.
> I can try installing the latest FW on CX4/5 cards in Laurence Lab and
> run the test suite again.
> 
> > Thanks,
> >
> > Bart.
> >
> 

Hello 
That's fine.

Lab is always ready for the SRP tests, I keep it that way.
The lab has mlx5 back-to-back iwth opensm and EDR100

Regards
Laurence
