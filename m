From: hch@lst.de (Christoph Hellwig)
Date: Sun, 16 Dec 2018 17:26:38 +0100
Subject: [PATCH][next] nvmet: fix comparison of a u16 with -1
In-Reply-To: <20181214183121.17445-1-colin.king@canonical.com>
References: <20181214183121.17445-1-colin.king@canonical.com>
Message-ID: <20181216162638.GB12651@lst.de>

Thanks, applied.

Maybe it might be worth adding a NVME_NO_ERR_LOC defintion to clean
this up a bit more.  Chaitanya, can you look into that?
