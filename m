From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 12 Jun 2018 04:40:12 +0000
Subject: [PATCH V2 06/14] blktests: add fio data verification routine
In-Reply-To: <20180611210928.GA25795@vader>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
 <20180611091554.19639-7-chaitanya.kulkarni@wdc.com>,
 <20180611210928.GA25795@vader>
Message-ID: <BN6PR04MB1203E98E3ADACD3FF4B4FBBB867F0@BN6PR04MB1203.namprd04.prod.outlook.com>



[CK] Fine with me.


From: Omar Sandoval <osandov@osandov.com>
Sent: Monday, June 11, 2018 2:09 PM
To: Chaitanya Kulkarni
Cc: linux-nvme at lists.infradead.org; jthumshirn at suse.de
Subject: Re: [PATCH V2 06/14] blktests: add fio data verification routine
? 
 
On Mon, Jun 11, 2018@05:15:46AM -0400, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>? common/fio | 12 ++++++++++++
>? 1 file changed, 12 insertions(+)
> 
> diff --git a/common/fio b/common/fio
> index e83258d..abe5ee2 100644
> --- a/common/fio
> +++ b/common/fio
> @@ -162,10 +162,17 @@ _fio_perf() {
>? # tests that should run for a specific amount of time.
>? _run_fio() {
>??????? local args=("--output=$TMPDIR/fio_perf" "--output-format=terse" "--terse-version=4" "--group_reporting=1")
> +
>??????? if [[ -v TIMEOUT ]]; then
>??????????????? args+=("--runtime=$TIMEOUT")
>??????? fi
> +
>??????? fio "${args[@]}" "$@"
> +
> +???? if [ $? -ne 0 ]; then
> +???????????? echo "error fio failed"
> +???????????? cat "$TMPDIR"/fio_perf
> +???? fi

I simplified this to

if ! fio "${args[@]}" "$@"; then
??????? ...
fi
    
