From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 19 Jun 2019 17:05:55 +0000
Subject: [PATCH V7 0/7] nvme-cli: Introduce nvme-status mapping with errno
References: <20190618131216.3661-1-minwoo.im.dev@gmail.com>
Message-ID: <DM6PR04MB575484ED690BAF70A81089AA86E50@DM6PR04MB5754.namprd04.prod.outlook.com>

In case if missing any of my reviews, this is for the series.

Reviewed-by: Chaitanya Kulkarni <chaianya.kulkarni at wdc.com>

On 06/18/2019 06:12 AM, Minwoo Im wrote:
> Hi Keith,
>
> Now it's v7 patchset for the nvme-status mapping with errno.  Chaitanya
> has reviewed for the first five patches, and Sagi has suggested to
> return an error for a case that numrec is different.  The 6th and 7th
> patch will make what Sagi's said.
>
> This patchset introduces nvme-status module to manage mapping
> relationships between nvme error status and errno.  It cannot be
> directly mapped in 1:1, but we can figure out what kind of errors
> happended by the return value of nvme-cli.
>
> NVMe status fields are 16bits to indicate, but UNIX return value from
> main() will be parsed in 8bits so that we need to do something about
> return value to indicate nvme error status.
>
> This patch series has been tested with:
>    - nvme pcie device controller/namespaces
>    - nvme loop target with nvme-fabrics
>
> The branch on github can be found at:
>    https://github.com/minwooim/nvme-cli.git for-1.9/return-negative-errno-v7
>
> Please pick this series.
> Thanks,
>
> Changes to previous V6:
>    - Added Reviewed-by: tags of Chaitanya for the first and second
>      commmits.
>    - Added a new command(6th) which makes it return an error when the
>      fabrics discovery retry(10 times) exhausted.
>    - Sagi has suggested that when numrec is different from the expected
>      value, then it should return an error.  The 7th patch will do it.
>
> Changes to previous V5:
>    - The first patch has been updated being without an whitespace in
>      front of new label("ret") in a function.  The other lables added
>      followed the existing style in where it belongs to.
>      The default style would be great to follow the kernel style which
>      is non-space label, as suggested by Chaitanya.
>    - The second patch has been updated to have "out" named label just
>      like the others in that file(fabrics).
>    - No functional changed in this version 6.  Only style change has been
>      applied.
>
> Changes to previous V4:
>    - Add the first three patches before introducing errno mapping module.
>
> Changes to previous V3:
>    - Fix to return 0 when given error is 0 which means success.
>      (Chaitanya)
>
> Changes to previous V2:
>    - do not overwrite the err local variable, instead returning the
>      converted errno mapped directly.
>    - return ECOMM in case of linux internal err which indicates the
>      negative values from in the middle of the subcommand.
>
> Changes to previous V1:
>    - make switch-case inline in nvme-status (Chaitanya)
>
> Minwoo Im (7):
>    nvme: Do not return in the middle of the subcommand
>    fabrics: Do not return in the middle of the subcommand
>    nvme: Return negative error value for internal errors
>    nvme-status: Introduce nvme status module to map errno
>    nvme: Return errno mapped for nvme error status
>    fabrics: return error when discovery retry exhausted
>    fabrics: Return errno mapped for fabrics error status
>
>   Makefile      |   3 +-
>   fabrics.c     |  67 +++--
>   linux/nvme.h  |   6 +
>   nvme-status.c | 155 +++++++++++
>   nvme-status.h |  14 +
>   nvme.c        | 701 ++++++++++++++++++++++++++++++--------------------
>   6 files changed, 641 insertions(+), 305 deletions(-)
>   create mode 100644 nvme-status.c
>   create mode 100644 nvme-status.h
>
