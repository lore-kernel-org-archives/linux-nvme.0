From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 26 Jul 2018 08:29:00 -0600
Subject: [PATCH 1/2] nvme-cli: add minimal ana-log page support
In-Reply-To: <20180726092431.GD24335@lst.de>
References: <20180725001316.2714-1-chaitanya.kulkarni@wdc.com>
 <20180725045352.GA10905@lst.de>
 <20180725144848.GC14596@localhost.localdomain>
 <20180726092431.GD24335@lst.de>
Message-ID: <20180726142900.GA18221@localhost.localdomain>

On Thu, Jul 26, 2018@11:24:31AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 25, 2018@08:48:48AM -0600, Keith Busch wrote:
> > Adding the RAE option for user space tooling is a good idea. Defaulting to
> > on should be safe too (will confirm on older drives),
> 
> Is it?  Strictly speaking the bit is reserved for drivers < 1.3, so they
> could reject it, even if I doubt anyone does.

Oh, duh ... the definition of "reserved":

  Receipt of reserved coded values in defined fields in commands shall
  be reported as an error.

You're right.
