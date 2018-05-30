From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 00:24:21 +0300
Subject: [PATCH 04/12] nvmet: add a new nvmet_zero_sgl helper
In-Reply-To: <20180530164600.26856-5-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-5-hch@lst.de>
Message-ID: <5f65f72b-682d-e08b-6bbb-4863b868313c@grimberg.me>


> +u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)

Would personally prefer nvmet_clear_sgl, but not hard headed on it,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
