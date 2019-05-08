From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 May 2019 09:54:47 +0200
Subject: [PATCHv3 2/2] nvme: validate cntlid during controller
 initialisation
In-Reply-To: <20190503133736.111201-3-hare@suse.de>
References: <20190503133736.111201-1-hare@suse.de>
 <20190503133736.111201-3-hare@suse.de>
Message-ID: <20190508075447.GB22414@lst.de>

This does two a little pointless iterations over the cntl list.

I'll send out a quick untested series to show how this might be
done better.
