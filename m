From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 09:25:57 +0200
Subject: [PATCH 11/17] nvme-rdma: Introduce cqe for local invalidation
In-Reply-To: <1527436222-15494-12-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-12-git-send-email-maxg@mellanox.com>
Message-ID: <20180528072557.GJ5618@lst.de>

On Sun, May 27, 2018@06:50:16PM +0300, Max Gurtovoy wrote:
> Using the same cqe object for registration and invalidation completions
> is not safe.

Is not safe why?
