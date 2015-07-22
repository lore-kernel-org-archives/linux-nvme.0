From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 22 Jul 2015 14:37:08 +0300
Subject: [PATCH 4/5] block: Export integrity data interval size in sysfs
In-Reply-To: <1437458579-18706-5-git-send-email-martin.petersen@oracle.com>
References: <20150716091957.GA18310@infradead.org>
 <1437458579-18706-1-git-send-email-martin.petersen@oracle.com>
 <1437458579-18706-5-git-send-email-martin.petersen@oracle.com>
Message-ID: <55AF8064.4040409@dev.mellanox.co.il>

On 7/21/2015 9:02 AM, Martin K. Petersen wrote:
> The size of the data interval was not exported in the sysfs integrity
> directory. Export it so that userland apps can tell whether the interval
> is different from the device's logical block size.
>
> Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>
> ---
>   Documentation/ABI/testing/sysfs-block |  7 +++++++
>   block/blk-integrity.c                 | 14 ++++++++++++++
>   2 files changed, 21 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
> index 8df003963d99..a61f1e2165ee 100644
> --- a/Documentation/ABI/testing/sysfs-block
> +++ b/Documentation/ABI/testing/sysfs-block
> @@ -60,6 +60,13 @@ Description:
>   		Indicates whether a storage device is capable of storing
>   		integrity metadata. Set if the device is T10 PI-capable.
>
> +What:		/sys/block/<disk>/integrity/data_interval_bytes

I wander if pi_interval is not a more suitable name...

Otherwise,

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
