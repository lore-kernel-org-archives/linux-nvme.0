From: hch@lst.de (Christoph Hellwig)
Date: Tue, 23 Jan 2018 13:46:16 +0100
Subject: [PATCH v5 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180123105641.24930-2-jthumshirn@suse.de>
References: <20180123105641.24930-1-jthumshirn@suse.de>
 <20180123105641.24930-2-jthumshirn@suse.de>
Message-ID: <20180123124616.GA20827@lst.de>

Seems like this is still missing the qid in the tracepoint, as it only
got added to the completion side.
