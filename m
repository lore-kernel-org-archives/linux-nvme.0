From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 2 Dec 2016 14:47:53 -0800
Subject: [PATCH v3] nvme/pci: Log PCI_STATUS when the controller dies
In-Reply-To: <20161202224805.GA8698@localhost.localdomain>
References: <c28126550f46f20aec1f069a4a8d10d802332dda.1480697884.git.luto@kernel.org>
 <20161202224805.GA8698@localhost.localdomain>
Message-ID: <CALCETrWo1sE=KvzcUiXsYO6796V5DDnpk5A+vLykAVwZyVtgEg@mail.gmail.com>

On Fri, Dec 2, 2016@2:48 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Fri, Dec 02, 2016@08:58:57AM -0800, Andy Lutomirski wrote:
>> When debugging nvme controller crashes, it's nice to know whether
>> the controller died cleanly so that the failure is just reflected in
>> CSTS, it died and put an error in PCI_STATUS, or whether it died so
>> badly that it stopped responding to PCI configuration space reads.
>>
>> I've seen a failure that gives 0xffff in PCI_STATUS on a Samsung
>> "SM951 NVMe SAMSUNG 256GB" with firmware "BXW75D0Q".
>>
>> Reviewed-by: Christoph Hellwig <hch at lst.de>
>> Signed-off-by: Andy Lutomirski <luto at kernel.org>
>
> Totally fine with this, but just want to mention that even the MMIO read
> has caused problems when racing a pciehp hot plug event. A config read in
> this case is another opprotunity for a completion timeout, unless I can
> get Bjorn to apply the patch series disabling config access on surprise
> removed devices. Or maybe our nvme health check polling implementation
> is misguided.
>

I've been meaning to complain about the keepalive polling kicking my
laptop out of idle every now and then :)  But yes, I think this
particular issue should be solved in the PCI layer.  Also, the PCI
layer should have a nice way to reset devices that go completely out
to lunch, too, IMO.
