From: keith.busch@intel.com (Keith Busch)
Date: Mon, 24 Jul 2017 18:45:26 -0400
Subject: Test Unit Ready translation seems wrong in latest driver
In-Reply-To: <99d24253f526a6f8f6ca4c9883dde14a@mail.gmail.com>
References: <706a68b8482154bdf77efe7fb195fe24@mail.gmail.com>
 <20170724220153.GB11979@localhost.localdomain>
 <99d24253f526a6f8f6ca4c9883dde14a@mail.gmail.com>
Message-ID: <20170724224525.GC11979@localhost.localdomain>

On Mon, Jul 24, 2017@04:21:36PM -0600, Sathya Prakash Veerichetty wrote:
> My bad, I was referring to 4.12.  So there will not be any support to SCSI
> translation at all or is there a different interface?

Correct, no support for SCSI when using NVMe. The NVMe interface is the
one to use for managing NVMe devices.
