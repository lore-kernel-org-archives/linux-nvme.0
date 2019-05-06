From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 6 May 2019 16:26:10 +0000
Subject: [PATCH 2/3] nvme: 016: fix nvmet pass data with loop
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-3-minwoo.im.dev@gmail.com>
Message-ID: <SN6PR04MB452726B60D050C3A88A7456C86300@SN6PR04MB4527.namprd04.prod.outlook.com>

We need to get rid of the string comparison here.
On 05/05/2019 08:06 AM, Minwoo Im wrote:
> The following commit has affected the result of genctr and treq field
> printed:
>
> genctr would increment two times per a subsystem due to
>    Commit b662a078 ("nvmet: enable Discovery Controller AENs")
>
> treq field would be printed out to support TP 8005:
>    nvmet driver:
>      Commit 9b95d2fb ("nvmet: expose support for fabrics SQ flow control
>                        disable in treq")
>    nvme-cli:
>      Commit 2cf370c3 ("fabrics: support fabrics sq flow control disable")
>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   tests/nvme/016.out | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/nvme/016.out b/tests/nvme/016.out
> index 59bd293..8599066 100644
> --- a/tests/nvme/016.out
> +++ b/tests/nvme/016.out
> @@ -1,11 +1,11 @@
>   Running nvme/016
>
> -Discovery Log Number of Records 1, Generation counter 1
> +Discovery Log Number of Records 1, Generation counter 2
>   =====Discovery Log Entry 0======
>   trtype:  loop
>   adrfam:  pci
>   subtype: nvme subsystem
> -treq:    not specified
> +treq:    not specified, sq flow control disable supported
>   portid:  X
>   trsvcid:
>   subnqn:  blktests-subsystem-1
>
