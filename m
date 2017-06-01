From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 08:34:50 +0200
Subject: [PATCH v1 2/7] nvmet: add uuid field to nvme_ns and populate
 via configfs
In-Reply-To: <a82a2dd9214084ef9bb51b541cf609e22e17dd1d.1496237370.git.jthumshirn@suse.de>
References: <cover.1496237370.git.jthumshirn@suse.de>
 <a82a2dd9214084ef9bb51b541cf609e22e17dd1d.1496237370.git.jthumshirn@suse.de>
Message-ID: <20170601063450.GB16778@lst.de>

This code looks fine, but I'd rather move it past adding CNS 3h support
so that it can add all the uuid-related bits in one go.
