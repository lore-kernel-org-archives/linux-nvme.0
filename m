From: thenzl@redhat.com (Tomas Henzl)
Date: Wed, 14 Feb 2018 18:07:47 +0100
Subject: [V1] mpt3sas: Do not use 32-bit atomic request descriptor for
 Ventura controllers.
In-Reply-To: <1518603397-3941-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1518603397-3941-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <fcff8324-229c-7c24-432e-c303128be77e@redhat.com>

On 02/14/2018 11:16 AM, Suganath Prabu S wrote:
> Problem Statement: Sending I/O through 32 bit descriptors to
>  Ventura series of controller results in IO timeout on certain conditions.
>
> This error only occurs on systems with high I/O activity on
> Ventura series controllers.
>
> Changes in this patch will prevent driver from using 32 bit descriptor
> and use 64 bit Descriptors
>
> V1 Change set:
> 1) In this patch removed callbacks as suggested by Hannes.
>
> Note:
>  This patch Should be applied on top of
> https://www.spinics.net/lists/linux-scsi/msg117405.html
> "Adding MPI Endpoint device support" patches.
>
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>

Reviewed-by: Tomas Henzl <thenzl at redhat.com>

Tomas
