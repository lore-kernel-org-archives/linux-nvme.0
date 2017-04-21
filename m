From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 21 Apr 2017 11:15:11 -0600
Subject: [GIT PULL] nvme updates for 4.12
In-Reply-To: <20170421170229.awfwczwwe3vetii6@infradead.org>
References: <20170421170229.awfwczwwe3vetii6@infradead.org>
Message-ID: <55ff9f20-13d2-de63-db00-4f4a5446a2b9@kernel.dk>

On 04/21/2017 11:02 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this is the current NVMe pile: virtualization extensions, lots of FC
> updates and various misc bits.  There are a few more FC bits that didn't
> make the cut, but we'd like to get this request out before the merge
> window for sure.
> 
> 
> The following changes since commit 99c749a4c4f4ea2c9eee01f81f79bdbf26c3914e:
> 
>   blk-stat: kill blk_stat_rq_ddir() (2017-04-21 07:56:23 -0600)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.12
> 
> for you to fetch changes up to e02ab0230489461fd9fdd8028841dae6f03a4874:
> 
>   nvme: let dm-mpath distinguish nvme error codes (2017-04-21 16:41:56 +0200)
> 
> ----------------------------------------------------------------
> Helen Koike (1):
>       nvme: improve performance for virtual NVMe devices
> 
> James Smart (8):
>       nvmet_fc: add target feature flags for upcall isr contexts
>       nvmet_fc: add req_release to lldd api
>       nvme_fcloop: split job struct from transport for req_release
>       nvmet_fc: Rework target side abort handling
>       nvmet_fc: add missing reference in add_port
>       nvme_fc: Move LS's to rport
>       nvme_fc: Add ls aborts on remote port teardown
>       nvmet_fc: Change traddr field separator to a colon
> 
> Junxiong Guan (1):
>       nvme: let dm-mpath distinguish nvme error codes
> 
> Keith Busch (2):
>       nvme/pci: Don't set reserved SQ create flags
>       nvme/pci: Poll CQ on timeout
> 
> Logan Gunthorpe (1):
>       nvmet: convert from kmap to nvmet_copy_from_sgl

Pulled, thanks.

-- 
Jens Axboe
