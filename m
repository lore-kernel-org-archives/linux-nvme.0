From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 30 Nov 2016 11:09:42 -0700
Subject: [PATCH v2 2/4] block: Add Sed-opal library
In-Reply-To: <20161130181357.GD21081@localhost.localdomain>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
 <20161130181357.GD21081@localhost.localdomain>
Message-ID: <20161130180941.GA23789@sbauer-Z170X-UD5>

es1;4205;0cOn Wed, Nov 30, 2016@01:13:57PM -0500, Keith Busch wrote:
> On Tue, Nov 29, 2016@02:52:00PM -0700, Scott Bauer wrote:
> > +	dev = get_or_create_opal_dev(bdev, key->opal_act.key.lr, true);
> > +	if (!dev)
> > +		return -ENOMEM;
> 
> The alloc_opal_dev from this call returns ERR_PTR values on error, so
> the check should be:
> 
> 	if (IS_ERR_OR_NULL(dev))
> 		return PTR_ERR(dev);

Nice catch, I'll go double check the rest of the return values for this
scenario.
