From: hch@lst.de (Christoph Hellwig)
Date: Wed, 22 Feb 2017 08:13:42 +0100
Subject: [PATCHv4 4/4] block/sed: Embed function data into the function
 sequence
In-Reply-To: <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
 <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20170222071342.GA17472@lst.de>

> +	if (!lock_held)
> +		mutex_lock(&dev->dev_lock);

No conditional locking, please.  I guess I causesd this by asking you
to remove __opal_lock_unlock, but it seems we'd either need to keep it
in the end.

Except for that the series looks fine to me.

Jens: given that 1-3 are the important fixes how about you pick those
up ASAP?  They all also had my Reviewed-by for previous postings.
