From: hch@lst.de (Christoph Hellwig)
Date: Thu,  1 Jun 2017 13:27:25 +0200
Subject: host memory buffer support V2
Message-ID: <20170601112729.9726-1-hch@lst.de>

This series adds support for the NVMe host memory buffer feature, which
is a way resource contstrained devices can use some host computer
memory for its own purposes.

Changes since V1:
 - properly unwind on allocation failures
 - minor cleanups
