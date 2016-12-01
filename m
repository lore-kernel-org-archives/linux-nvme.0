From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Dec 2016 10:53:12 +0100
Subject: [PATCH] fs: configfs: don't return anything from drop_link
In-Reply-To: <1480335762-26408-1-git-send-email-andrzej.p@samsung.com>
References: <CGME20161128122258eucas1p2c3543f6795fe54c07175a5f5fbae0765@eucas1p2.samsung.com>
 <1480335762-26408-1-git-send-email-andrzej.p@samsung.com>
Message-ID: <20161201095312.GA26366@lst.de>

Thanks a lot Andrzej!

I've applied the patch, but I undid the reformatting of the nvmet
code to keep the patch as simple as possible.
