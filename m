From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Dec 2016 16:31:32 +0100
Subject: [PATCH 2/3] ahci-remap.h: add ahci remapping definitions
In-Reply-To: <aa6cba2c-6cf7-0222-b871-d98d1c8e4fe8@cogentembedded.com>
References: <1480703463-17489-1-git-send-email-hch@lst.de>
 <1480703463-17489-3-git-send-email-hch@lst.de>
 <aa6cba2c-6cf7-0222-b871-d98d1c8e4fe8@cogentembedded.com>
Message-ID: <20161205153132.GC6340@lst.de>

On Sat, Dec 03, 2016@01:57:01PM +0300, Sergei Shtylyov wrote:
>> +#ifndef _LINUX_AHCI_REMAP_H
>> +#define _LINUX_AHCI_REMAP_H
>> +
>> +#include <linux/sizes.h>
>> +
>> +#define AHCI_VSCAP		0xa4
>> +#define AHCI_REMAP_CAP		0x800
>> +#define AHCI_VSCAP		0xa4
>
>    Why do it twice?

No good reason, probably just me messing up the move..
