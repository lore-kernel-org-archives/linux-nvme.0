From: hch@lst.de (Christoph Hellwig)
Date: Thu, 23 May 2019 17:36:26 +0200
Subject: [PATCHv3 1/2] nvme: Export get and set features
In-Reply-To: <20190523152735.15052-1-keith.busch@intel.com>
References: <20190523152735.15052-1-keith.busch@intel.com>
Message-ID: <20190523153626.GA21238@lst.de>

> Change since v2: Use 'unsigned int' instead of just 'unsiged'

Those are equivalent in C, why bother changing it?

> +int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid, unsigned int dword11,

Especially as this now creates lines > 80 characters in various places.
