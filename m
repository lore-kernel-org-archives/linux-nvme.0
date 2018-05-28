From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 09:22:44 +0200
Subject: [PATCH 05/17] nvme: Fix extended data LBA supported setting
In-Reply-To: <1527436222-15494-6-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-6-git-send-email-maxg@mellanox.com>
Message-ID: <20180528072244.GF5618@lst.de>

On Sun, May 27, 2018@06:50:10PM +0300, Max Gurtovoy wrote:
> This value depands on the metadata support value.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>

Looks fine, I'll pull this into the nvme tree ASAP.
