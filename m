From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 5 Sep 2018 18:20:06 -0600
Subject: [PATCH nvme-cli 0/4] Some useful fabrics patches
In-Reply-To: <20180901013605.10658-1-sagi@grimberg.me>
References: <20180901013605.10658-1-sagi@grimberg.me>
Message-ID: <20180906002006.GA22449@localhost.localdomain>

On Fri, Aug 31, 2018@06:36:01PM -0700, Sagi Grimberg wrote:
> patch #1 is cleanup
> patch #2 is a bug fix
> patch #3,#4 are are adding a useful fabrics command to disconnect
> all the existing controllers.
> 
> Sagi Grimberg (4):
>   fabrics: make some arguments integers
>   fabrics: don't fail empty discovery log page
>   nvme: commonize subsystems info in a helper
>   fabrics: add disconnect-all command
> 
>  Documentation/nvme-disconnect-all.txt | 34 ++++++++++
>  fabrics.c                             | 92 ++++++++++++++++++++-------
>  fabrics.h                             |  1 +
>  nvme-builtin.h                        |  1 +
>  nvme.c                                | 83 ++++++++++++++----------
>  nvme.h                                |  2 +
>  6 files changed, 155 insertions(+), 58 deletions(-)
>  create mode 100644 Documentation/nvme-disconnect-all.txt

Looks good, applied with Chaitanya's reviews and regenerated
documentation.
