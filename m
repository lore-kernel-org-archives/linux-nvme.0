From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Sep 2016 10:45:09 +0200
Subject: blk-mq: allow passing in an external queue mapping V2
In-Reply-To: <20160830232824.GA2807@localhost.localdomain>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
 <20160830232824.GA2807@localhost.localdomain>
Message-ID: <20160901084509.GB4115@lst.de>

On Tue, Aug 30, 2016@07:28:24PM -0400, Keith Busch wrote:
> Before, each mq hardware queue would have 2 CPUs, now it's terribly
> unbalanced.

Hmm.  This wasn't supposed to change the cpu mapping, an indeed I saw
results like that horrible one before as well.  Let me dig into this
with my fake lower queue count device.
