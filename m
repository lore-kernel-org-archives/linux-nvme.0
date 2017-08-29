From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 Aug 2017 23:22:50 +0200
Subject: [PATCH] nvme-fabrics: Convert nvmf_transports_mutex to an rwsem
In-Reply-To: <20170829173344.3402-1-roland@kernel.org>
References: <20170829173344.3402-1-roland@kernel.org>
Message-ID: <20170829212250.GA8608@lst.de>

Looks fine (except for the over long lines in the patch description..):

Reviewed-by: Christoph Hellwig <hch at lst.de>
