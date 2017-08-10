From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 10 Aug 2017 08:32:23 -0700
Subject: Naming Convention for NVMe CLI Plugin Commands
In-Reply-To: <20170807003025.GB842@localhost.localdomain>
References: <MWHPR04MB102593E65AA6F0D3C4377A29EAB60@MWHPR04MB1025.namprd04.prod.outlook.com>
 <20170807003025.GB842@localhost.localdomain>
Message-ID: <20170810153223.GA4944@infradead.org>

On Sun, Aug 06, 2017@08:30:26PM -0400, Keith Busch wrote:
> On Fri, Aug 04, 2017@07:51:45PM +0000, Jeffrey Lien wrote:
> > Is there any standard naming convention set for the nvme cli plugin
> > commands?  I've gotten a request from one customer to add the prefix
> > "vs-" (for vendor specific) to some of the cli plugin commands.  i.e.
> > nvme wdc smart-log-add would become nvme wdc vs-smart-log-add.  It's
> > not a big change to make but then it doesn't match the plugin commands
> > from other vendors.  
> 
> Hi Jeff,
> 
> The naming hasn't really been formalized, so I suppose you can call
> it whatever you want. Your specific example sounds a little redundant
> IMO since it's already a vendor specific command by virtue of it not
> being a top level sub-command; every command under a vendor plugin is
> vendor specific. But I won't push back if you want to call it that.

I think a vs- prefix makes sense in general, but:

 (1) we should do it for all plugins and all commands
 (2) we need to provide backwards compatibility for the existing
     commands to not break existing setups.
