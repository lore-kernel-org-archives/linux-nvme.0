From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Jun 2017 13:43:21 -0400
Subject: [PATCH 1/4] nvme-cli : add support for sanitize command.
In-Reply-To: <20170629164443.GF3110@localhost.localdomain>
References: <20170629021928.19389-1-chaitanya.kulkarni@hgst.com>
 <20170629021928.19389-2-chaitanya.kulkarni@hgst.com>
 <20170629164443.GF3110@localhost.localdomain>
Message-ID: <20170629174321.GG3110@localhost.localdomain>

On Thu, Jun 29, 2017@12:44:43PM -0400, Keith Busch wrote:
> On Wed, Jun 28, 2017@07:19:25PM -0700, Chaitanya Kulkarni wrote:
> > +	const struct argconfig_commandline_options command_line_options[] = {
> > +		{"no_dealloc", 'd', "", CFG_NONE, &cfg.no_dealloc, no_argument, no_dealloc_desc},
> 
> Just a minor request, this tool uses '-' instead of '_' for compound
> word long options, and I think keeping that consistency is a good thing.

Ah, it was just this one that used '_'. The documentation used '-'
already. I made the fix in this patch and applied all of them.

Thanks!
