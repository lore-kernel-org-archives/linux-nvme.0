From: hch@lst.de (Christoph Hellwig)
Date: Fri, 1 May 2015 18:02:45 +0200
Subject: [PATCH 6/8] nvme: handle invalid SCSI LBAs correctly
In-Reply-To: <alpine.LNX.2.00.1504271932250.19844@localhost.lm.intel.com>
References: <1429388864-29648-1-git-send-email-hch@lst.de>
 <1429388864-29648-7-git-send-email-hch@lst.de>
 <B58D82457FDA0744A320A2FC5AC253B93BABFA56@fmsmsx104.amr.corp.intel.com>
 <20150427192832.GA7802@lst.de>
 <alpine.LNX.2.00.1504271932250.19844@localhost.lm.intel.com>
Message-ID: <20150501160245.GA15451@lst.de>

On Mon, Apr 27, 2015@07:55:07PM +0000, Keith Busch wrote:
> Hm, the spec provides translations for status codes but doesn't say it
> should short circuit the process. This layer is responsible for accurate
> translations, so we'd fail complaince if we don't respect the controller's
> completion, even if it returns the wrong code.

Allright..  What's the status of merging the other patches?  As far as I can
see there's no nvme tree anymore and Jens pulls them in directly, right?
