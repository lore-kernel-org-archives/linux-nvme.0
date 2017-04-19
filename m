From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 19 Apr 2017 11:13:15 +1000
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <20170418180020.GE7181@obsidianresearch.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <CAPcyv4izLa2vw12ysvVfd=ysaMKcASNFm+=CaqDKhnPY9B5OJg@mail.gmail.com>
 <20170418180020.GE7181@obsidianresearch.com>
Message-ID: <1492564395.25766.120.camel@kernel.crashing.org>

On Tue, 2017-04-18@12:00 -0600, Jason Gunthorpe wrote:
> - All platforms can succeed if the PCI devices are under the same
> ? 'segment', but where segments begin is somewhat platform specific
> ? knowledge. (this is 'same switch' idea Logan has talked about)

We also need to be careful whether P2P is enabled in the switch
or not.

Cheers,
Ben.
