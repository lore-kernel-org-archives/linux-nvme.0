From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Mar 2019 15:12:39 +0100
Subject: [PATCH v2] nvmet-file: clamp-down file namespace lba_shift
In-Reply-To: <20190309021340.13313-1-sagi@grimberg.me>
References: <20190309021340.13313-1-sagi@grimberg.me>
Message-ID: <20190311141239.GB7788@lst.de>

On Fri, Mar 08, 2019@06:13:40PM -0800, Sagi Grimberg wrote:
> When the backing file is a tempfile for example, the inode i_blkbits
> can be 1M in size which causes problems for hosts to support as the
> disk block size.

Can you please look into the other review comments as well?

Also this will need a code comment describing why we do this clamping.
