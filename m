From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Nov 2018 17:23:43 +0100
Subject: nvme: allow ANA support to be independent of native multipathing
In-Reply-To: <20181120133719.GB18991@redhat.com>
References: <20181116091458.GA17267@lst.de>
 <37098edd-4dea-b58f-bca6-3be9af8ec4ee@suse.de>
 <20181116094947.GA19296@lst.de>
 <bbaf4637-209c-5cfe-2749-3fcc54f7a35f@suse.de>
 <20181116101752.GA21531@lst.de> <20181116192802.GA30057@redhat.com>
 <20181119093938.GA11757@lst.de> <20181119145650.GB13470@redhat.com>
 <20181120094201.GB7742@lst.de> <20181120133719.GB18991@redhat.com>
Message-ID: <20181120162343.GB2774@lst.de>

On Tue, Nov 20, 2018@08:37:19AM -0500, Mike Snitzer wrote:
> This isn't how a Linux maintainer engages in technical discussion.

And this isn't a technical discussion.   As told before the only
reason to not build the multipath code is to save space, and
the only reason to disable multipath at runtime is for potential
pre-existing setups, which obviously are not ANA capable.

The right fix is to warn users if they use a driver without
CONFIG_NVME_MULTIPATH on a multi-port device and to phase out the
multipath=0 option in the long run, again with a warning.  Any new
additions to "improve" these cases simply don't make sense.
