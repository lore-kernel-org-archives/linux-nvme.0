From: keith.busch@intel.com (Keith Busch)
Date: Tue, 3 Oct 2017 09:06:49 -0600
Subject: [PATCH] nvme-pci: Use PCI bus address for data/queues in CMB
In-Reply-To: <CAKUFe6YHJ+jBgxtEy+YTTDQtphtOEz6+xfBXdowsFKy7ZMqW3w@mail.gmail.com>
References: <1506662966-10865-1-git-send-email-abhishek.shah@broadcom.com>
 <20170929144242.GN8463@localhost.localdomain>
 <CAKUFe6YHJ+jBgxtEy+YTTDQtphtOEz6+xfBXdowsFKy7ZMqW3w@mail.gmail.com>
Message-ID: <20171003150649.GA2195@localhost.localdomain>

On Sat, Sep 30, 2017@02:30:16PM +0530, Abhishek Shah wrote:
> > On a similar note, we also break CMB usage in virutalization with direct
> > assigned devices: the guest doesn't know the host physical bus address,
> > so it sets the CMB queue address incorrectly there, too. I don't know of
> > a way to fix that other than disabling CMB.
> 
> I don't have much idea on CMB usage in virtualization... will let
> someone else comment on this.

It's okay, I think it's a gap in the NVMe specification that would allow
such usage.
