From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Dec 2016 05:28:15 -0800
Subject: Linux-nvme Digest, Vol 56, Issue 64
In-Reply-To: <20161128163600.GD2609@localhost.localdomain>
References: <mailman.3.1480276802.9433.linux-nvme@lists.infradead.org>
 <CAEhOZrdzuwda+QZnE3D7rhGmY4S8Tk1VYmP4eFCZJtotY6p+Og@mail.gmail.com>
 <20161128163600.GD2609@localhost.localdomain>
Message-ID: <20161202132815.GA14982@infradead.org>

On Mon, Nov 28, 2016@11:36:00AM -0500, Keith Busch wrote:
> If I understand correctly what you're using, you'll want to use the
> BIOS's AHCI mode for Linux so that the NVMe device is not remapped into
> the "RAID" device.

Yes, what a great terminology choice by the Chipset and BIOS people.

I think we'll need a patch to the ahci driver at leat to warn about
remapped device.
