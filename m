From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 29 Apr 2019 04:50:27 -0700
Subject: [PATCH 1/2] nvme: improve logging
In-Reply-To: <SN6PR04MB452781752A97CA874A973C7186380@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190425024041.17657-1-chaitanya.kulkarni@wdc.com>
 <20190425024041.17657-2-chaitanya.kulkarni@wdc.com>
 <20190428120546.GB9759@infradead.org>
 <SN6PR04MB452781752A97CA874A973C7186380@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190429115027.GA25365@infradead.org>

On Sun, Apr 28, 2019@07:32:32PM +0000, Chaitanya Kulkarni wrote:
> I've actually suggested that in my review but then it is static 
> afterall. I'll move it to header near NVME_CTRL_XXX definitions.
> Let me know if you prefer any other place.

Just keep it near the top of multipath.c..  But I can fix that up
if it is the last remanining issue in the new version.
