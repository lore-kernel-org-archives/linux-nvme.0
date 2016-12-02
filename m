From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 2 Dec 2016 08:57:46 -0800
Subject: [PATCH v2] nvme/pci: Log PCI_STATUS when the controller dies
In-Reply-To: <20161202132600.GA2827@infradead.org>
References: <f028ad4073488a571f2e19e19ccff0f6daa4af33.1480639321.git.luto@kernel.org>
 <20161202132600.GA2827@infradead.org>
Message-ID: <CALCETrU=7fw+afkCELDna6TaWxmym3oEHmnv6mKWq420d2aKhQ@mail.gmail.com>

On Fri, Dec 2, 2016@5:26 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Dec 01, 2016@04:42:41PM -0800, Andy Lutomirski wrote:
>> When debugging nvme controller crashes, it's nice to know whether
>> the controller died cleanly so that the failure is just reflected in
>> CSTS, it died and put an error in PCI_STATUS, or whether it died so
>> badly that it stopped responding to PCI configuration space reads.
>
> Just curious:  what controller did this happen with?

I've seen a failure that gives 0xffff in PCI_STATUS on a Samsung
"SM951 NVMe SAMSUNG 256GB" with firmware "BXW75D0Q".

I'll add that to the v3 changelog.

>
>> +                     /* Read a config register to help see what died. */
>> +                     u16 pci_status;
>> +                     int result;
>> +
>> +                     result = pci_read_config_word(to_pci_dev(dev->dev),
>> +                                                   PCI_STATUS, &pci_status);
>> +                     if (result == PCIBIOS_SUCCESSFUL)
>> +                             dev_warn(dev->dev,
>> +                                      "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
>> +                                      csts, pci_status);
>> +                     else
>> +                             dev_warn(dev->dev,
>> +                                      "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
>> +                                      csts, result);
>> +             }
>
> Can you factor all this debug code into a separate function to keep
> the main flow easier to read?
>
> Except for that this patch looks fine to me:
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Done.  v3 coming.

-- 
Andy Lutomirski
AMA Capital Management, LLC
