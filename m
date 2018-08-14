From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 14 Aug 2018 15:21:21 +0000
Subject: [PATCH 3/5] aoe: use device_add_disk_with_groups()
In-Reply-To: <20180814073305.87255-4-hare@suse.de>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-4-hare@suse.de>
Message-ID: <047cdc676b8068aa8599f9646cf52bc578facade.camel@wdc.com>

On Tue, 2018-08-14@09:33 +0200, Hannes Reinecke wrote:
> Use device_add_disk_with_groups() to avoid a race condition with
> udev during startup.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Cc: Ed L. Cachin <ed.cashin at acm.org>

Reviewed-by: Bart Van Assche <bart.vanassche at wdc.com>
