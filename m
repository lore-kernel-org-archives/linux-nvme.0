From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 21 Nov 2016 23:41:53 -0800
Subject: [PATCH] Use rsps_lock in nvmet_rdma_free_rsp
In-Reply-To: <781668ff60b040b3a56e104f489c3ea9@TGXML382.toshiba.local>
References: <781668ff60b040b3a56e104f489c3ea9@TGXML382.toshiba.local>
Message-ID: <20161122074153.GC5497@infradead.org>

Hi Tomita,

what are you trying to protect against during device teardown?
