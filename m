From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 11 Apr 2019 09:37:17 -0600
Subject: [GIT PULL] nvme fixes for 5.1
In-Reply-To: <20190411153134.GA16359@infradead.org>
References: <20190411153134.GA16359@infradead.org>
Message-ID: <581989af-bc97-f578-d676-fecf7d0b906c@kernel.dk>

On 4/11/19 9:31 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> two nvme fixes for 5.1 - fixing the initial CSN for nvme-fc, and handle
> log page offsets properly in the target.
> 
> The following changes since commit a3761c3c91209b58b6f33bf69dd8bb8ec0c9d925:
> 
>   block: do not leak memory in bio_copy_user_iov() (2019-04-10 16:14:40 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.1
> 
> for you to fetch changes up to d808b7f759b50acf0784ce6230ffa63e12ef465d:
> 
>   nvmet: fix discover log page when offsets are used (2019-04-11 17:28:30 +0200)
> 
> ----------------------------------------------------------------
> James Smart (1):
>       nvme-fc: correct csn initialization and increments on error
> 
> Keith Busch (1):
>       nvmet: fix discover log page when offsets are used
> 
>  drivers/nvme/host/fc.c          | 20 +++++++++---
>  drivers/nvme/target/admin-cmd.c |  5 +++
>  drivers/nvme/target/discovery.c | 68 +++++++++++++++++++++++++++--------------
>  drivers/nvme/target/nvmet.h     |  1 +
>  include/linux/nvme.h            |  9 ++++--
>  5 files changed, 73 insertions(+), 30 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
