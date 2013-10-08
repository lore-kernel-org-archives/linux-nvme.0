From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 8 Oct 2013 09:33:02 +0200
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <20131008043330.GF31666@concordia>
References: <cover.1380703262.git.agordeev@redhat.com>
 <20131008043330.GF31666@concordia>
Message-ID: <20131008073301.GC10669@dhcp-26-207.brq.redhat.com>

On Tue, Oct 08, 2013@03:33:30PM +1100, Michael Ellerman wrote:
> On Wed, Oct 02, 2013@12:29:04PM +0200, Alexander Gordeev wrote:
> > This technique proved to be confusing and error-prone. Vast share
> > of device drivers simply fail to follow the described guidelines.
> 
> To clarify "Vast share of device drivers":
> 
>  - 58 drivers call pci_enable_msix()
>  - 24 try a single allocation and then fallback to MSI/LSI
>  - 19 use the loop style allocation as above
>  - 14 try an allocation, and if it fails retry once
>  - 1  incorrectly continues when pci_enable_msix() returns > 0
> 
> So 33 drivers (> 50%) successfully make use of the "confusing and
> error-prone" return value.

Ok, you caught me - 'vast share' is incorrect and is a subject to
rewording. But out of 19/58 how many drivers tested fallbacks on the
real hardware? IOW, which drivers are affected by the pSeries quota?

> And yes, one is buggy, so obviously the interface is too complex. Thanks
> drivers/ntb/ntb_hw.c

vmxnet3 would be the best example.

> cheers

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
