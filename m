From: keith.busch@intel.com (Keith Busch)
Date: Tue, 7 Nov 2017 17:04:24 -0700
Subject: [PATCHv3 2/5] nvme/fc: remove unused "queue_size" field
In-Reply-To: <45c5bfad-4854-2e01-905e-bcd8cbf42314@broadcom.com>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-3-keith.busch@intel.com>
 <45c5bfad-4854-2e01-905e-bcd8cbf42314@broadcom.com>
Message-ID: <20171108000423.GA25017@localhost.localdomain>

On Tue, Nov 07, 2017@03:56:52PM -0800, James Smart wrote:
>    On 11/7/2017 2:13 PM, Keith Busch wrote:
> 
>  This was being saved in a structure, but never used anywhere. The queue
>  size is obtained through other means, so there's no reason to duplicate
>  this without a user for it.
> 
>  Reviewed-by: Sagi Grimberg [1]<sagi at grimberg.me>
>  Signed-off-by: Keith Busch [2]<keith.busch at intel.com>
>  ---
>   drivers/nvme/host/fc.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> 
>    I had reviewed the v2.
> 
>    Reviewed-by: James Smart [3]<james.smart at broadcom.com>

Indeed, sorry about that, and thank you for the review.
