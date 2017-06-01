From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 08:50:29 +0200
Subject: [PATCH v1 6/7] nvme: change magic 4096 to SZ_4K
In-Reply-To: <9d231ec2f7b34221685a305ecb02d9da884b9c08.1496237370.git.jthumshirn@suse.de>
References: <cover.1496237370.git.jthumshirn@suse.de>
 <9d231ec2f7b34221685a305ecb02d9da884b9c08.1496237370.git.jthumshirn@suse.de>
Message-ID: <20170601065029.GF16778@lst.de>

As mentioned before I'd prefer a menaingful name that indicates the
purpose of the constant.  In fact 4096 is a lot more obvious than SZ_4K,
and shortet as well :)
