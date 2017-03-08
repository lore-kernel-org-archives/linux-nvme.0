From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Mar 2017 23:20:14 +0100
Subject: [RFC PATCH] nvmet: Back namespace with files
In-Reply-To: <20170308221527.GA1885@localhost.localdomain>
References: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
 <20170308213519.GA32009@lst.de> <20170308221527.GA1885@localhost.localdomain>
Message-ID: <20170308222014.GA635@lst.de>

On Wed, Mar 08, 2017@05:15:28PM -0500, Keith Busch wrote:
> This is a step toward getting namespace management. It's easy to create
> namespaces if they're files.

Given that namespace management is tied to controller IDs it's a fairly
bad fit for fabrics, especially so with our dynamic controller model.
