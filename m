From: hch@lst.de (Christoph Hellwig)
Date: Wed, 25 Jul 2018 07:05:13 +0200
Subject: Q: Status of ANA patches
In-Reply-To: <BYAPR04MB4502EBE68BD64FE76FF3BB8086540@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180719142827.GA19339@lst.de>
 <BYAPR04MB4502EBE68BD64FE76FF3BB8086540@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <20180725050513.GA11152@lst.de>

On Wed, Jul 25, 2018@12:50:31AM +0000, Chaitanya Kulkarni wrote:
> Hi,
> 
> I just posted the patch read the ANA log page for name-cli,
> maybe we can use that command to show the ANA related
> information such as ANA state of the namespace or do we
> need to add a new command to nvme-cli? 

We need some way to see the status of namespaces in a given subsystem
(and maybe also per controller).

I think Johannes has done some preliminary work in this area, adding
him to Cc.
