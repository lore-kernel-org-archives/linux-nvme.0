From: Austin.Bolen@dell.com (Austin.Bolen@dell.com)
Date: Wed, 13 Jun 2018 17:17:08 +0000
Subject: blktests block/019 lead system hang
References: <838678680.4693215.1527664726174.JavaMail.zimbra@redhat.com>
 <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
 <20180605161853.GB16899@localhost.localdomain>
 <5a3a2565a81543b5837672e01580a5b5@AUSX13MPC127.AMER.DELL.COM>
 <20180613154415.GC5574@localhost.localdomain>
Message-ID: <4d119d6db0174b39b4e7b0b11ea8d5d1@AUSX13MPC127.AMER.DELL.COM>

On 6/13/2018 10:41 AM, Keith Busch wrote:
> Thanks for the feedback!
> This test does indeed toggle the Link Control Link Disable bit to simulate
> the link failure. The PCIe specification specifically covers this case
> in Section 3.2.1, Data Link Control and Management State Machine Rules:
>
>   If the Link Disable bit has been Set by software, then the subsequent
>   transition to DL_Inactive must not be considered an error.
>
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

Yes, the R730 could mask the error if OS sets Data Link Layer State
Changed Enable = 1 and could let the OS handle the hot-plug event
similar to what is done for surprise removal.  Current platform policy
on R730 is to not do that and only suppress errors related to physical
surprise removal (PDS = 0).  We'll probably forgo the option of
suppressing any non-surprise remove link down errors even if OS sets
Data Link Layer State Changed Enable = 1 and go straight to the
containment error recovery model for DPC once the architecture is
finalized to handle these non-surprise remove related error.  In the
meantime, it is expected (though not ideal) that this family of servers
will crash for this particular test.  Ditto for the test that disables
Memory Space Enable bit in the command register.

-Austin
