From: hch@lst.de (Christoph Hellwig)
Date: Thu, 16 May 2019 08:26:22 +0200
Subject: [PATCH 5/6] nvme: Export get and set features
In-Reply-To: <20190515163625.21776-5-keith.busch@intel.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-5-keith.busch@intel.com>
Message-ID: <20190516062622.GB29930@lst.de>

> +static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned fid,
> +		unsigned dword11, void *buffer, size_t buflen, u32 *result)

Nitpick:  an we call this something like
__nvme_getset_features?
