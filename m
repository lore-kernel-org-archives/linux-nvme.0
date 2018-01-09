From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Jan 2018 17:42:15 +0100
Subject: [PATCH] nvme: initialize hostid uuid in nvmf_host_default to
 not leak kernel memory
In-Reply-To: <20180109164252.GD15154@localhost.localdomain>
References: <20180109152043.30422-1-jthumshirn@suse.de>
 <20180109164252.GD15154@localhost.localdomain>
Message-ID: <20180109164215.GB12001@lst.de>

I've already got the equivalent fix from Ewan queued up in nvme-4.15.
