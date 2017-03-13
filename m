From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Mar 2017 17:10:50 -0600
Subject: nvme-cli: finish the move of vendor specific commands to plugins
Message-ID: <20170313231054.30400-1-hch@lst.de>

Move the remaining Intel specific support code from the core to the
Intel plugin.
