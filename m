From: minwoo.im@samsung.com (Minwoo Im)
Date: Mon, 20 May 2019 09:28:05 +0900
Subject: [PATCH] nvme-cli: close fd before return
In-Reply-To: <BN8PR04MB57474B1D9FD8DC489487336986060@BN8PR04MB5747.namprd04.prod.outlook.com>
References: <BN8PR04MB57474B1D9FD8DC489487336986060@BN8PR04MB5747.namprd04.prod.outlook.com>
 <20190519175642.31815-1-chaitanya.kulkarni@wdc.com>
 <20190519184553.GC10876@minwooim-desktop>
 <CGME20190520002113epcas4p345b92c6d82619b92478af81e81392266@epcms2p7>
Message-ID: <20190520002805epcms2p747debe2606f1a42a2b27a6d665f5612d@epcms2p7>

> This only covers the code path for nvme commands failure and not the
> errno codes ans thi ps mainly to make all the nvme error and return
> codes consistent.

I think I don't agree with that.  If you want to fix the leaked fd before
returning directly, then it should make it go to close_fd for the EINVAL
cases without adding -(negative) on it.

I think the PR can be merged regardless to errno update now, though.
