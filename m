From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 26 Oct 2016 11:32:59 +0300
Subject: [PATCH v4 0/8] connect reject event helpers
In-Reply-To: <cover.1477426743.git.swise@opengridcomputing.com>
References: <cover.1477426743.git.swise@opengridcomputing.com>
Message-ID: <9b6484f3-7f8a-dc6f-0959-0d38044dd983@grimberg.me>

So where should this be sent from?

We have rdma_cm/iser/isert that usually go from
the rdma tree and nvme-rdma/nvmet-rdma that usually
go from nvmf tree to Jens.

Doug are you picking this up or should I?
