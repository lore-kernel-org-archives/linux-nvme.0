From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Oct 2015 15:51:42 +0000 (UTC)
Subject: [PATCH] NVMe: Prevent bogus synchronous IO command timeouts.
In-Reply-To: <BL2PR04MB16324D2BC07BFAA67D0D12E924B0@BL2PR04MB163.namprd04.prod.outlook.com>
References: <BL2PR04MB163B7D4ED51C81B2A964344924E0@BL2PR04MB163.namprd04.prod.outlook.com>
 <alpine.LNX.2.00.1509291952040.23840@localhost.lm.intel.com>
 <BL2PR04MB163C7FAAC14DFE4779DD203924D0@BL2PR04MB163.namprd04.prod.outlook.com>
 <BL2PR04MB16324D2BC07BFAA67D0D12E924B0@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <alpine.LNX.2.00.1510021551120.23840@localhost.lm.intel.com>

On Fri, 2 Oct 2015, Jeffrey Lien wrote:
> Keith,
> I wasn't able to recreate the original failure with your version of the fix so I'd say it's good to go.  Are you going to push your modified fix into the legacy tree then?

Great, thanks! Will apply to the legacy repo today.
