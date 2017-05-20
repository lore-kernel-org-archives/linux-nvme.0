From: hch@lst.de (Christoph Hellwig)
Date: Sat, 20 May 2017 15:13:53 +0200
Subject: host memory buffer support
Message-ID: <20170520131357.15929-1-hch@lst.de>

This series adds support for the NVMe host memory buffer feature, which
is a way resource contstrained devices can use some host computer
memory for its own purposes.
