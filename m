From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 30 Nov 2018 08:26:33 -0800
Subject: [GIT PULL] nvme fixes for 4.20
In-Reply-To: <01b6314c-903e-6787-ccf6-e93aa789199a@kernel.dk>
References: <20181130152430.GA3107@infradead.org>
 <01b6314c-903e-6787-ccf6-e93aa789199a@kernel.dk>
Message-ID: <20181130162633.GA16933@infradead.org>

On Fri, Nov 30, 2018@08:26:24AM -0700, Jens Axboe wrote:
> On 11/30/18 8:24 AM, Christoph Hellwig wrote:
> > Various fixlets all over, including throwing in a 'default y' for the
> > multipath code, given that we want people to actually enable it for full
> > functionality.
> 
> Why enable it by default? 99.9% of users aren't going to care. That
> seems like an odd choice.

Because its small, and if you don't have it you are going to run into
problems pretty soon.

Anyway, to get the fixes out ASAP here is the updated request without
it:

The following changes since commit 14b04063cc994effc86f976625bf8f806d8d44cb:

  Merge branch 'nvme-4.20' of git://git.infradead.org/nvme into for-linus (2018-11-21 05:56:28 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.20

for you to fetch changes up to 6344d02dc8f886b6bbcd922ae1a17e4a41500f2d:

  nvme-rdma: fix double freeing of async event data (2018-11-30 17:23:23 +0100)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: warn when finding multi-port subsystems without multipathing enabled

Ewan D. Milne (1):
      nvme-fc: initialize nvme_req(rq)->ctrl after calling __nvme_fc_init_request()

Igor Konopko (1):
      nvme-pci: fix surprise removal

Keith Busch (1):
      nvme: Free ctrl device name on init failure

Prabhath Sajeepa (1):
      nvme-rdma: fix double freeing of async event data

Sagi Grimberg (1):
      nvme: flush namespace scanning work just before removing namespaces

 drivers/nvme/host/core.c | 8 +++++---
 drivers/nvme/host/fc.c   | 2 +-
 drivers/nvme/host/nvme.h | 3 +++
 drivers/nvme/host/rdma.c | 2 ++
 4 files changed, 11 insertions(+), 4 deletions(-)
