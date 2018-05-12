From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 12 May 2018 06:35:27 -0700
Subject: [PATCH v2 4/7] nvme_fc: remove reinit_request routine
In-Reply-To: <20180512005028.29661-5-jsmart2021@gmail.com>
References: <20180512005028.29661-1-jsmart2021@gmail.com>
 <20180512005028.29661-5-jsmart2021@gmail.com>
Message-ID: <20180512133527.GC14317@infradead.org>

After this the reinit_request callbacks in the nvme core and block
layer should also be removed.
