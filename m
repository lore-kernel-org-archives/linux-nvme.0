From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 May 2019 08:26:15 +0200
Subject: [PATCH] nvme-pci: fix single segment detection
In-Reply-To: <20190509133120.GA22059@ming.t460p>
References: <20190509110409.19647-1-hch@lst.de>
 <20190509112410.GA20711@ming.t460p> <20190509123406.GB21483@lst.de>
 <20190509133120.GA22059@ming.t460p>
Message-ID: <20190513062615.GA18152@lst.de>

So actually, after running out ways to make any of my complex block
layer fix ideas work I have a simple fix for the block layer now.

Lets see if is acceptable..
