From: Austin.Bolen@dell.com (Austin.Bolen@dell.com)
Date: Wed, 13 Jun 2018 18:24:14 +0000
Subject: blktests block/019 lead system hang
References: <838678680.4693215.1527664726174.JavaMail.zimbra@redhat.com>
 <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
 <20180605161853.GB16899@localhost.localdomain>
 <5a3a2565a81543b5837672e01580a5b5@AUSX13MPC127.AMER.DELL.COM>
 <20180613154415.GC5574@localhost.localdomain>
Message-ID: <2bbfd07208a84856a2d4dcb833671a82@AUSX13MPC127.AMER.DELL.COM>

On 6/13/2018 10:41 AM, Keith Busch wrote:
> Thanks for the feedback!
>
> This test does indeed toggle the Link Control Link Disable bit to simulate
> the link failure. The PCIe specification specifically covers this case
> in Section 3.2.1, Data Link Control and Management State Machine Rules:
>
>   If the Link Disable bit has been Set by software, then the subsequent
>   transition to DL_Inactive must not be considered an error.
Forgot to mention... this PCIe requirement to not treat Link Disable = 1
as an error is a requirement on PCIe hardware and not from platform
side.  So if you want to test this PCIe spec requirement then you need a
way to ascertain whether PCIe hardware or platform is causing the
error.  Additionally, setting Link Disable is not what is causing the
error in this specific case.  The error is coming from a subsequent MMIO
that is causing UR since link is down.

-Austin


> So this test should suppress any Suprise Down Error events, but handling
> that particular event wasn't the intent of the test (and as you mentioned,
> it ought not occur anyway since the slot is HP Surprise capable).
>
> The test should not suppress reporting the Data Link Layer State Changed
> slot status. And while this doesn't trigger a Slot PDC status, triggering
> a DLLSC should occur since the Link Status DLLLA should go to 0 when
> state machine goes from DL_Active to DL_Down, regardless of if a Suprise
> Down Error was detected.
>
> The Linux PCIEHP driver handles a DLLSC link-down event the same as
> a presence detect remove event, and that's part of what this test was
> trying to cover.
>
