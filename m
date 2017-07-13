From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Jul 2017 19:17:55 +0200
Subject: [PATCH] nvmet: preserve controller serial number between reboots
In-Reply-To: <5b7b436c-eed1-d731-50be-0733f9ac7155@grimberg.me>
References: <20170713104806.12353-1-jthumshirn@suse.de>
 <d32c32f6-3f8f-c63a-f961-ee16407c2fd6@grimberg.me>
 <20170713130652.GA24376@lst.de>
 <5b7b436c-eed1-d731-50be-0733f9ac7155@grimberg.me>
Message-ID: <20170713171755.GB5107@lst.de>

On Thu, Jul 13, 2017@07:38:27PM +0300, Sagi Grimberg wrote:
>
>>> It seems weird that a subsystem has a serial.
>>
>> But that's actually how NVMe defines them.
>
> Where is that wording?

Right there in the SN field description:

"Serial Number (SN): Contains the serial number for the NVM subsystem
 that is assigned by the vendor as an ASCII string. Refer to section
 7.10 for unique identifier requirements. Refer to section 1.5 for
 ASCII string requirements"
