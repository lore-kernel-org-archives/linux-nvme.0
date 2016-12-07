From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Dec 2016 18:05:16 -0500
Subject: [PATCH] nvme: use the correct msix vector for each queue
In-Reply-To: <CALZtONAyqjK4RG0PAJJczzHkZrhzpvT2v9eUu3yXs949-Q51dg@mail.gmail.com>
References: <20161207220348.8572-1-ddstreet@ieee.org>
 <20161207224414.GE22478@localhost.localdomain>
 <CALZtONAfYUXw2bgg=5XFEOZv39sKkRie_0wJRcbL+Lbihsok5Q@mail.gmail.com>
 <20161207224941.GA25959@localhost.localdomain>
 <CALZtONAyqjK4RG0PAJJczzHkZrhzpvT2v9eUu3yXs949-Q51dg@mail.gmail.com>
Message-ID: <20161207230516.GB25959@localhost.localdomain>

On Wed, Dec 07, 2016@05:46:34PM -0500, Dan Streetman wrote:
> 
> Is there a reason you want to share the interrupt between the queues?

The admin queue is hardly ever used (if at all) compared to an IO queue's
usage, so why waste the resource? I bet you can't measure a preformance
difference on queues that don't share, and it's reasonable to expect an
nvme controller's MSI-x count matches the IO queue count, which forces
us to share a vector.
