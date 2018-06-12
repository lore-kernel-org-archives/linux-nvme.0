From: Austin.Bolen@dell.com (Austin.Bolen@dell.com)
Date: Tue, 12 Jun 2018 23:41:54 +0000
Subject: blktests block/019 lead system hang
References: <838678680.4693215.1527664726174.JavaMail.zimbra@redhat.com>
 <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
 <20180605161853.GB16899@localhost.localdomain>
Message-ID: <5a3a2565a81543b5837672e01580a5b5@AUSX13MPC127.AMER.DELL.COM>

On 6/5/2018 11:16 AM, Keith Busch wrote:
> On Wed, May 30, 2018@03:26:54AM -0400, Yi Zhang wrote:
>> Hi Keith
>> I found blktest block/019 also can lead my NVMe server hang with 4.17.0-rc7, let me know if you need more info, thanks. 
>>
>> Server: Dell R730xd
>> NVMe SSD: 85:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller 172X (rev 01)
>>
>> Console log:
>> Kernel 4.17.0-rc7 on an x86_64
>>
>> storageqe-62 login: [ 6043.121834] run blktests block/019 at 2018-05-30 03:16:34
>> [ 6049.108476] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 3
>> [ 6049.108478] {1}[Hardware Error]: event severity: fatal
>> [ 6049.108479] {1}[Hardware Error]:  Error 0, type: fatal
>> [ 6049.108481] {1}[Hardware Error]:   section_type: PCIe error
>> [ 6049.108482] {1}[Hardware Error]:   port_type: 6, downstream switch port
>> [ 6049.108483] {1}[Hardware Error]:   version: 1.16
>> [ 6049.108484] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
>> [ 6049.108485] {1}[Hardware Error]:   device_id: 0000:83:05.0
>> [ 6049.108486] {1}[Hardware Error]:   slot: 0
>> [ 6049.108487] {1}[Hardware Error]:   secondary_bus: 0x85
>> [ 6049.108488] {1}[Hardware Error]:   vendor_id: 0x10b5, device_id: 0x8734
>> [ 6049.108489] {1}[Hardware Error]:   class_code: 000406
>> [ 6049.108489] {1}[Hardware Error]:   bridge: secondary_status: 0x0000, control: 0x0003
>> [ 6049.108491] Kernel panic - not syncing: Fatal hardware error!
>> [ 6049.108514] Kernel Offset: 0x25800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> Sounds like your platform fundamentally doesn't support surprise link
> down if it considers the event a fatal error. That's sort of what this
> test was supposed to help catch so we know what platforms can do this
> vs ones that can't.
>
> The test does check that the slot is hotplug capable before running,
> so it's supposed to only run the test on slots that claim to be capable
> of handling the event. I just don't know of a good way to query platform
> firmware to know what it will do in response to such an event.
It looks like the test is setting the Link Disable bit.  But this is not
a good simulation for hot-plug surprise removal testing or surprise link
down (SLD) testing, if that is the intent.  One reason is that Link
Disable does not invoke SLD semantics per PCIe spec.  This is somewhat
of a moot point in this case since the switch has Hot-Plug Surprise bit
set which also masks the SLD semantics in PCIe.

Also, the Hot-Plug Capable + Surprise Hot-Plug bits set means the
platform can tolerate the case where "an adapter present in this slot
might be removed from the system without any prior notification".  It
does not mean that a system can survive link down under any other
circumstances such as setting Link Disable or generating a Secondary Bus
Reset or a true surprise link down event.  To the earlier point, I also
do not know of any way the OS can know a priori if the platform can
handle surprise link down outside of surprise remove case.  We can look
at standardizing a way to do that if OSes find it useful to know.

Relative to this particular error, Link Disable doesn't clear Presence
Detect State which would happen on a real Surprise Hot-Plug removal
event and this is probably why the system crashes.  What will happen is
that after the link goes to disabled state, the ongoing I/O will cause
MMIO accesses on the drive and that will cause a UR which is an
uncorrectable PCIe error (ERR_FATAL on R730).  The BIOS on the R730 is
surprise remove aware (Surprise Hot-Plug = 1) and so it will check if
the device is still present by checking Presence Detect State.  If the
device is not present it will mask the error and let the OS handle the
device removal due to hot-plug interrupt(s).  If the device is present,
as in this case, then the BIOS will escalate to OS as a fatal NMI
(current R730 platform policy is to only mask errors due to removal).

For future, these servers may report these sort of errors as recoverable
via the GHES structures in APEI which will allow the OS to recover from
this non-surprise remove class of error as well.  In the (hopefully
near) future, the industry will move to DPC as the framework for this
sort of generic PCIe error handling/recovery but there are architectural
changes needed that are currently being defined in the relevant
standards bodies.  Once the architecture is defined it can be
implemented and tested to verify these sort of test cases pass.

-Austin


>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
