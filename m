From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 29 Apr 2019 15:58:43 +0000
Subject: [PATCH 1/2] nvme: improve logging
In-Reply-To: <20190429115027.GA25365@infradead.org>
References: <20190425024041.17657-1-chaitanya.kulkarni@wdc.com>
 <20190425024041.17657-2-chaitanya.kulkarni@wdc.com>
 <20190428120546.GB9759@infradead.org>
 <SN6PR04MB452781752A97CA874A973C7186380@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190429115027.GA25365@infradead.org>
Message-ID: <41639D1A-D6E4-46D3-9070-53E22197E48E@wdc.com>

Okay, that works too.

?On 4/29/19, 4:50 AM, "Christoph Hellwig" <hch@infradead.org> wrote:

    On Sun, Apr 28, 2019@07:32:32PM +0000, Chaitanya Kulkarni wrote:
    > I've actually suggested that in my review but then it is static 
    > afterall. I'll move it to header near NVME_CTRL_XXX definitions.
    > Let me know if you prefer any other place.
    
    Just keep it near the top of multipath.c..  But I can fix that up
    if it is the last remanining issue in the new version.
    
