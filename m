From: kai.heng.feng@canonical.com (Kai Heng Feng)
Date: Thu, 15 Nov 2018 15:16:29 +0800
Subject: [PATCH v2 1/2] pci: prevent sk hynix nvme from entering D3
In-Reply-To: <20181109002157.GK41183@google.com>
References: <20181106071214.12745-1-acelan.kao@canonical.com>
 <20181109002157.GK41183@google.com>
Message-ID: <B21C5A96-AB21-4405-BBF1-9AD343425CA9@canonical.com>

Hi,

> On Nov 9, 2018,@08:21, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Tue, Nov 06, 2018@03:12:13PM +0800, AceLan Kao wrote:
>> It leads to the power consumption raises to 2.2W during s2idle, while
>> it consumes less than 1W during long idle if put SK hynix nvme to D3
>> and then enter s2idle.
>> From SK hynix FE, MS Windows doesn't put nvme to D3, and uses its own
>> APST feature to do the power management.
>> To leverage its APST feature during s2idle, we can't disable nvme
>> device while suspending, too.

We have a new Intel NVMe [8086:f1a6] that has this ?new? behavior.

> 
> I don't know how APST works, but it sounds like you want to disable D3
> if you're using APST.  But that's not what this patch does; this
> disables it always.

Ok, will work on a new patch that only disables D3 when APST is enabled.

> 
> I'm not sure we want a quirk for this at all, since as Christoph
> points out, it doesn't fix a functional issue as the other uses of
> quirk_no_ata_d3() do.
> 
> From your emails with Christoph, it sounds like this quirk is a
> workaround for a firmware defect.  If we *do* end up wanting a quirk,
> the changelog should at least mention the firmware defect and maybe
> check whether it has been fixed.

According to SK Hynix folks and new evidence on the new Intel NVMe
we have, this is something we are going to see more often.

Kai-Heng

> 
>> BTW, prevent it from entering D3 will increase the power consumtion around
>> 0.13W ~ 0.15W during short/long idle, and the power consumption during
>> s2idle becomes 0.77W.
>> 
>> Signed-off-by: AceLan Kao <acelan.kao at canonical.com>
>> ---
>> drivers/pci/quirks.c    | 1 +
>> include/linux/pci_ids.h | 2 ++
>> 2 files changed, 3 insertions(+)
>> 
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 4700d24e5d55..b7e6492e8311 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -1332,6 +1332,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
>>    occur when mode detecting */
>> DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
>> 				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SK_HYNIX, 0x1527, quirk_no_ata_d3);
>> 
>> /*
>>  * This was originally an Alpha-specific thing, but it really fits here.
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 69f0abe1ba1a..5f5adda07de0 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -3090,4 +3090,6 @@
>> 
>> #define PCI_VENDOR_ID_NCUBE		0x10ff
>> 
>> +#define PCI_VENDOR_ID_SK_HYNIX		0x1c5c
>> +
>> #endif /* _LINUX_PCI_IDS_H */
>> -- 
>> 2.17.1
>> 
>> 
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
