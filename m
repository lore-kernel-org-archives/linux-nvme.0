From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 18 Dec 2018 02:36:46 +0000
Subject: [PATCH][next] nvmet: fix comparison of a u16 with -1
In-Reply-To: <20181216162638.GB12651@lst.de>
References: <20181214183121.17445-1-colin.king@canonical.com>
 <20181216162638.GB12651@lst.de>
Message-ID: <9D4BC577-9C08-4D19-A33C-050131E2D133@wdc.com>

Sent out the cleanup patch.

?On 12/16/18, 8:26 AM, "Christoph Hellwig" <hch@lst.de> wrote:

    Thanks, applied.
    
    Maybe it might be worth adding a NVME_NO_ERR_LOC defintion to clean
    this up a bit more.  Chaitanya, can you look into that?
    
