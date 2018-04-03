From: mst@redhat.com (Michael S. Tsirkin)
Date: Tue, 3 Apr 2018 16:12:39 +0300
Subject: [virtio-dev] [pci PATCH v7 2/5] virtio_pci: Add support for
 unmanaged SR-IOV on virtio_pci devices
In-Reply-To: <CAKgT0UfgZ2gAdiAbCe4MTOr3o9cqq1q-mykCQsw68p2F-QEC8g@mail.gmail.com>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
 <20180315184132.3102.90947.stgit@localhost.localdomain>
 <20180316183042-mutt-send-email-mst@kernel.org>
 <CAKgT0UfgZ2gAdiAbCe4MTOr3o9cqq1q-mykCQsw68p2F-QEC8g@mail.gmail.com>
Message-ID: <20180403161151-mutt-send-email-mst@kernel.org>

On Fri, Mar 16, 2018@09:40:34AM -0700, Alexander Duyck wrote:
> On Fri, Mar 16, 2018@9:34 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Mar 15, 2018@11:42:41AM -0700, Alexander Duyck wrote:
> >> From: Alexander Duyck <alexander.h.duyck at intel.com>
> >>
> >> Hardware-realized virtio_pci devices can implement SR-IOV, so this
> >> patch enables its use. The device in question is an upcoming Intel
> >> NIC that implements both a virtio_net PF and virtio_net VFs. These
> >> are hardware realizations of what has been up to now been a software
> >> interface.
> >>
> >> The device in question has the following 4-part PCI IDs:
> >>
> >> PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
> >> VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe
> >>
> >> The patch currently needs no check for device ID, because the callback
> >> will never be made for devices that do not assert the capability or
> >> when run on a platform incapable of SR-IOV.
> >>
> >> One reason for this patch is because the hardware requires the
> >> vendor ID of a VF to be the same as the vendor ID of the PF that
> >> created it. So it seemed logical to simply have a fully-functioning
> >> virtio_net PF create the VFs. This patch makes that possible.
> >>
> >> Reviewed-by: Christoph Hellwig <hch at lst.de>
> >> Signed-off-by: Mark Rustad <mark.d.rustad at intel.com>
> >> Signed-off-by: Alexander Duyck <alexander.h.duyck at intel.com>
> >
> > So if and when virtio PFs can manage the VFs, then we can
> > add a feature bit for that?
> > Seems reasonable.
> 
> Yes. If nothing else you may not even need a feature bit depending on
> how things go.

OTOH if the interface is changed in an incompatible way,
and old Linux will attempt to drive the new device
since there is no check.

I think we should add a feature bit right away.


> One of the reasons why Mark called out the
> subvendor/subdevice was because that might be able to be used to
> identify the specific hardware that is providing the SR-IOV feature so
> in the future if it is added to virtio itself then you could exclude
> devices like this by just limiting things based on subvendor/subdevice
> IDs.
> 
> > Also, I am guessing that hardware implementations will want
> > to add things like stong memory barriers - I guess we
> > will add new feature bits for that too down the road?
> 
> That piece I don't have visibility into at this time. Perhaps Dan
> might have more visibility into future plans on what this might need.
> 
> Thanks.
> 
> - Alex
