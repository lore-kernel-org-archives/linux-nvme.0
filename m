From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Feb 2018 07:24:07 -0800
Subject: small fixes for 4.16 and -stable
Message-ID: <20180222152410.19222-1-hch@lst.de>

Fix a regression when using built-in transport drivers, and fix special
payload commands on rdma and loop.
