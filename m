From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 31 Jul 2017 09:30:46 +0300
Subject: [PATCH V3] nvme-pci: add sgl support
In-Reply-To: <20170726181931.21150-2-chaitanya.kulkarni@hgst.com>
References: <20170726181931.21150-1-chaitanya.kulkarni@hgst.com>
 <20170726181931.21150-2-chaitanya.kulkarni@hgst.com>
Message-ID: <20df339b-17c6-17dc-5051-410d83f1dcbd@grimberg.me>


> +static void nvme_sgl_set_data(struct nvme_sgl_desc *sge, struct scatterlist *sg)

Please rename new functions with nvme_pci_ prefix
