From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Nov 2016 13:13:57 -0500
Subject: [PATCH v2 2/4] block: Add Sed-opal library
In-Reply-To: <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
Message-ID: <20161130181357.GD21081@localhost.localdomain>

On Tue, Nov 29, 2016@02:52:00PM -0700, Scott Bauer wrote:
> +	dev = get_or_create_opal_dev(bdev, key->opal_act.key.lr, true);
> +	if (!dev)
> +		return -ENOMEM;

The alloc_opal_dev from this call returns ERR_PTR values on error, so
the check should be:

	if (IS_ERR_OR_NULL(dev))
		return PTR_ERR(dev);
