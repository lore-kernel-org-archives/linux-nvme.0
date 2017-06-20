From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 19 Jun 2017 23:48:00 -0700
Subject: remove long broken SCSI to NVMe translations
In-Reply-To: <5943E3BC.6050807@hpe.com>
References: <20170614063537.1044-1-hch@lst.de>
 <20170614150025.GD26073@localhost.localdomain>
 <20170614150138.GA9428@lst.de>
 <af9655ff-f5ae-0d86-7b84-dd48caa7c35f@suse.de>
 <20170616083151.GB14698@infradead.org> <5943E3BC.6050807@hpe.com>
Message-ID: <20170620064800.GA11019@infradead.org>

On Fri, Jun 16, 2017@09:57:16AM -0400, Linda Knippers wrote:
> > Everything that could be done using the scsi emulation can be trivially
> > done using nvme-cli, as they should have done from day 0.
> 
> I don't quite know the history of our use of the scsi translation but I
> suspect it's because we adapted some existing utility to also support nvme.
> 
> David Milburn's patch is very simple.  Can we please fix the bug for now
> so we have a little time to fix our tools?

I don't think I want to expand usage of it.  The code only "worked"
for about two years, during which not too many NVMe products even
existed.  And I say "worked" because I found countless of sever bugs
(use after free, memory overruns, etc) issues when I first ran a SCS
I testsuite over it, which obviously didn't even cover the commands
you care about.

You might have a slightly better leaverage with distros already
shipping this code, but enabling it upstream does not seem in any
way helpful.
