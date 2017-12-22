From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 22 Dec 2017 08:23:36 +0100
Subject: [PATCH] nvmet_fc: correct broken add_port
In-Reply-To: <20171221164335.12400-1-jsmart2021@gmail.com>
References: <20171221164335.12400-1-jsmart2021@gmail.com>
Message-ID: <20171222072336.n6jr2ybr5gspxsrf@linux-x5ow.site>

On Thu, Dec 21, 2017@08:43:35AM -0800, James Smart wrote:
> prior patch to remove the add_port reference also removed the saving
> of the port pointer, which mean any io had no port pointer thus was
> rejected. Basically nothing works.
> 
> Restore the saving of the port pointer.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> this restores operation but if the targetport is removed, it will no
> longer be functional if it comes back. I will be submitting a more
> involved patch for this shortly

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

But a Fixes: and/or Cc: <stable at vger.kernel.org> might have been a
good Idea as well.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
