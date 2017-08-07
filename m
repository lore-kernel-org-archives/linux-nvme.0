From: keith.busch@intel.com (Keith Busch)
Date: Sun, 6 Aug 2017 20:30:26 -0400
Subject: Naming Convention for NVMe CLI Plugin Commands
In-Reply-To: <MWHPR04MB102593E65AA6F0D3C4377A29EAB60@MWHPR04MB1025.namprd04.prod.outlook.com>
References: <MWHPR04MB102593E65AA6F0D3C4377A29EAB60@MWHPR04MB1025.namprd04.prod.outlook.com>
Message-ID: <20170807003025.GB842@localhost.localdomain>

On Fri, Aug 04, 2017@07:51:45PM +0000, Jeffrey Lien wrote:
> Is there any standard naming convention set for the nvme cli plugin
> commands?  I've gotten a request from one customer to add the prefix
> "vs-" (for vendor specific) to some of the cli plugin commands.  i.e.
> nvme wdc smart-log-add would become nvme wdc vs-smart-log-add.  It's
> not a big change to make but then it doesn't match the plugin commands
> from other vendors.  

Hi Jeff,

The naming hasn't really been formalized, so I suppose you can call
it whatever you want. Your specific example sounds a little redundant
IMO since it's already a vendor specific command by virtue of it not
being a top level sub-command; every command under a vendor plugin is
vendor specific. But I won't push back if you want to call it that.
