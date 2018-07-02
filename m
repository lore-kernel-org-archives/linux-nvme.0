From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Jul 2018 14:16:41 +0200
Subject: [PATCH V4 0/2] nvmet: implement flush all support
In-Reply-To: <BYAPR04MB4502F79155D2D089E041CD1086430@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180628144206.GA17432@lst.de>
 <BYAPR04MB4502F79155D2D089E041CD1086430@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <20180702121641.GA630@lst.de>

On Mon, Jul 02, 2018@05:43:14AM +0000, Chaitanya Kulkarni wrote:
> Hi Christoph,
> 
> It allows NVMeOF host to just send one command and complete the flush per-ctrl
> basis as opposed to per-ns basis.

Yes, but why would you ever do that?  Even when we discussed the issue
in the working group no one could actually come up with a practical use
case.
