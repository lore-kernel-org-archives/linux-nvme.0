From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Nov 2018 09:28:47 +0100
Subject: [PATCH] nvme: fixup ANA group descriptor offset
In-Reply-To: <20181105150036.17041-1-hare@suse.de>
References: <20181105150036.17041-1-hare@suse.de>
Message-ID: <20181107082847.GB25099@lst.de>

On Mon, Nov 05, 2018@04:00:36PM +0100, Hannes Reinecke wrote:
> The ANA group descriptor offset changed between the specification
> sent for ratification and the final ratified document, causing the
> ANA log page not to be displayed correctly.

Please fix the subject line, this is a nvme-cli patch.
