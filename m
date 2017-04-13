From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Apr 2017 09:07:23 +0200
Subject: [PATCH 2/2] nvme-rdma: add support for arbitrary sg lists mapping
In-Reply-To: <62d3a9be-58c8-4b24-8f6a-4a4d70b8fe9f@mellanox.com>
References: <1491948109-9224-1-git-send-email-maxg@mellanox.com>
 <1491948109-9224-2-git-send-email-maxg@mellanox.com>
 <20170412171759.GC8639@lst.de>
 <62d3a9be-58c8-4b24-8f6a-4a4d70b8fe9f@mellanox.com>
Message-ID: <20170413070723.GA24944@lst.de>

On Thu, Apr 13, 2017@01:58:22AM +0300, Max Gurtovoy wrote:
> I guess we can. Is it better to use an helper func to avoid code 
> duplication ? if so, maybe we can do a general fuctions in verbs.h so iser 
> can use it too ?

Sure, that sounds useful to me.
