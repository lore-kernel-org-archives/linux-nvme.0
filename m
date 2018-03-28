From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Mar 2018 10:10:15 +0200
Subject: [PATCH 1/1] nvme-rdma: Add IB event handling support
In-Reply-To: <1521647315-10011-1-git-send-email-maxg@mellanox.com>
References: <1521647315-10011-1-git-send-email-maxg@mellanox.com>
Message-ID: <20180328081015.GE20373@lst.de>

Eww.  I guess something like this is required, but we really need
one coherent rdma event model instead of this mix between rdms/cm,
struct ib_client and ib_event.
