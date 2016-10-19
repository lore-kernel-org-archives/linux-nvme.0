From: axboe@fb.com (Jens Axboe)
Date: Wed, 19 Oct 2016 09:51:45 -0600
Subject: [PATCH RESEND] nvme: Add tertiary number to NVME_VS
In-Reply-To: <1476848934-25256-1-git-send-email-krisman@linux.vnet.ibm.com>
References: <1476848934-25256-1-git-send-email-krisman@linux.vnet.ibm.com>
Message-ID: <3682edaa-0632-ed38-54e1-71459d5b0503@fb.com>

On 10/18/2016 09:48 PM, Gabriel Krisman Bertazi wrote:
> NVMe 1.2.1 specification adds a tertiary element to the version number.
> This updates the macro and its callers to include the final number and
> fixup a single place in nvmet where the version was generated manually.

Added, thanks.

-- 
Jens Axboe
