From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 17 Dec 2018 18:04:44 +0000
Subject: [PATCH][next] nvmet: fix comparison of a u16 with -1
In-Reply-To: <20181216162638.GB12651@lst.de>
References: <20181214183121.17445-1-colin.king@canonical.com>
 <20181216162638.GB12651@lst.de>
Message-ID: <178EFF23-A96E-4DB3-B8E8-8EBF906030F1@wdc.com>


Will send out a path.

?On 12/16/18, 8:26 AM, "Christoph Hellwig" <hch@lst.de> wrote:

    Thanks, applied.
    
    Maybe it might be worth adding a NVME_NO_ERR_LOC defintion to clean
    this up a bit more.  Chaitanya, can you look into that?
    
