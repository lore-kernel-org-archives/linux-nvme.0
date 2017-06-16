From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 16 Jun 2017 01:31:51 -0700
Subject: remove long broken SCSI to NVMe translations
In-Reply-To: <af9655ff-f5ae-0d86-7b84-dd48caa7c35f@suse.de>
References: <20170614063537.1044-1-hch@lst.de>
 <20170614150025.GD26073@localhost.localdomain>
 <20170614150138.GA9428@lst.de>
 <af9655ff-f5ae-0d86-7b84-dd48caa7c35f@suse.de>
Message-ID: <20170616083151.GB14698@infradead.org>

[you dropped all the people in the To and Cc list..]

> Someone should tell HPe, though; apparently they are using it for
> firmware download ...

Everything that could be done using the scsi emulation can be trivially
done using nvme-cli, as they should have done from day 0.

But adding the usual suspects to CC as they didn't seem to know it.
And adding Robert just for fun :)
