From: linda.knippers@hpe.com (Linda Knippers)
Date: Fri, 16 Jun 2017 09:57:16 -0400
Subject: remove long broken SCSI to NVMe translations
In-Reply-To: <20170616083151.GB14698@infradead.org>
References: <20170614063537.1044-1-hch@lst.de>
 <20170614150025.GD26073@localhost.localdomain> <20170614150138.GA9428@lst.de>
 <af9655ff-f5ae-0d86-7b84-dd48caa7c35f@suse.de>
 <20170616083151.GB14698@infradead.org>
Message-ID: <5943E3BC.6050807@hpe.com>

On 06/16/2017 04:31 AM, Christoph Hellwig wrote:
> [you dropped all the people in the To and Cc list..]
> 
>> Someone should tell HPe, though; apparently they are using it for
>> firmware download ...

Yes, that's how we discovered it was broken.

> Everything that could be done using the scsi emulation can be trivially
> done using nvme-cli, as they should have done from day 0.

I don't quite know the history of our use of the scsi translation but I
suspect it's because we adapted some existing utility to also support nvme.

David Milburn's patch is very simple.  Can we please fix the bug for now
so we have a little time to fix our tools?

Thanks,

-- ljk
> 
> But adding the usual suspects to CC as they didn't seem to know it.
> And adding Robert just for fun :)
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
