From: hch@lst.de (Christoph Hellwig)
Date: Wed, 1 May 2019 15:18:21 +0200
Subject: [PATCH 1/2] nvme: move command size checks to the core
In-Reply-To: <SN6PR04MB45274A0053D67600108FA903863A0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190430153833.9011-1-hch@lst.de>
 <SN6PR04MB45274A0053D67600108FA903863A0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190501131821.GA1402@lst.de>

On Tue, Apr 30, 2019@09:30:26PM +0000, Chaitanya Kulkarni wrote:
> Looks good. Just one question about _nvme_check_size(), is there any 
> significance for one _ over __ ?

None.  I have just copied over what we had before.
