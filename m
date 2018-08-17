From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 17 Aug 2018 15:55:07 -0600
Subject: [PATCH 1/6] nvme-ana-log: fixup compiler warning in show_ana_log()
In-Reply-To: <BYAPR04MB4502A06AE5FE20A06720D95F863D0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180817072908.56784-1-hare@suse.de>
 <20180817072908.56784-2-hare@suse.de>
 <20180817080924.GA13230@lst.de>
 <BYAPR04MB4502A06AE5FE20A06720D95F863D0@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <20180817215507.GA9931@localhost.localdomain>

On Fri, Aug 17, 2018@09:44:34PM +0000, Chaitanya Kulkarni wrote:
> 
> Not sure if this is relevant but le64_to_cpu() we are fixing warnings by the cast,
> maybe follow the same pattern everywhere?
> 
> http://lists.infradead.org/pipermail/linux-nvme/2018-June/018585.html

Yeah, consistency is always good. I'm fine with the PRI macros, but either
way is fine as long as we compile without warnings on all architectures.
