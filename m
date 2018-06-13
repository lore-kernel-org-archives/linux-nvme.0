From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 13 Jun 2018 04:28:54 -0700
Subject: [PATCH v3 1/4] nvme_fc: remove reinit_request routine
In-Reply-To: <20180612235028.17969-2-jsmart2021@gmail.com>
References: <20180612235028.17969-1-jsmart2021@gmail.com>
 <20180612235028.17969-2-jsmart2021@gmail.com>
Message-ID: <20180613112854.GA18531@infradead.org>

On Tue, Jun 12, 2018@04:50:25PM -0700, James Smart wrote:
> The reinit_request routine is not necessary. Remove support for the
> op callback.
> 
> As all that nvme_reinit_tagset() does is itterate and call the
> reinit routine, it too has no purpose. Remove the call.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Looks good, thanks.
