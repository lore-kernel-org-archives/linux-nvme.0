From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 30 Nov 2016 10:28:03 -0800
Subject: [PATCH] nvme/pci: Log PCI_STATUS when the controller dies
In-Reply-To: <c1a8c6d2-2dfc-b9af-5134-b3aca2402957@fb.com>
References: <0e60b11aa18049f2643b62400c3fcbd959791c51.1480468668.git.luto@kernel.org>
 <c1a8c6d2-2dfc-b9af-5134-b3aca2402957@fb.com>
Message-ID: <CALCETrUt+JtDE1W97xjK+8U=oQFSV-4o4hqRFV_f9tsXUp=qRQ@mail.gmail.com>

On Wed, Nov 30, 2016@7:25 AM, Jens Axboe <axboe@fb.com> wrote:
> On 11/29/2016 06:18 PM, Andy Lutomirski wrote:
>> Signed-off-by: Andy Lutomirski <luto at kernel.org>
>> ---
>>  drivers/nvme/host/pci.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 0248d0e21fee..b4527e5b1364 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1292,10 +1292,16 @@ static void nvme_watchdog_timer(unsigned long data)
>>
>>       /* Skip controllers under certain specific conditions. */
>>       if (nvme_should_reset(dev, csts)) {
>> -             if (!nvme_reset(dev))
>> +             if (!nvme_reset(dev)) {
>> +                     /* Read a config register to help see what died. */
>> +                     u16 pci_status = 0xffff;
>> +
>> +                     pci_read_config_word(to_pci_dev(dev->dev),
>> +                                          PCI_STATUS, &pci_status);
>>                       dev_warn(dev->dev,
>> -                             "Failed status: 0x%x, reset controller.\n",
>> -                             csts);
>> +                             "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
>> +                              csts, pci_status);
>> +             }
>>               return;
>>       }
>
> Looks fine to me, but why the pci_status init to 0xffff?

In theory, although not (AFAIK) on x86, config space reads can fail
outright.  Normally a failure looks like returning 0xffff, so I
figured I'd make it consistent.  I could alternatively check the
return value and print a different message if pci_read_config_word
fails.

--Andy
